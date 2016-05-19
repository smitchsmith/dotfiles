require 'singleton'
require 'sqlite3'

class QuestionsDatabase < SQLite3::Database
  include Singleton

  def initialize
    super("questions.db")

    self.results_as_hash = true
    self.type_translation = true
  end
end

module SaveObjects

  def save
    if @id.nil?
      QuestionsDatabase.instance.execute(<<-SQL, *variable_list)
      INSERT INTO #{table_name}
        (#{values_string.join(", ")})
      VALUES
        (#{values_string.map{"?"}.join(", ")})
      SQL
      @id = QuestionsDatabase.instance.last_insert_row_id
    else
      QuestionsDatabase.instance.execute(<<-SQL, *variable_list, @id)
      UPDATE #{table_name}
      SET
        #{values_string.join(" = ?,\n") + " = ?"}
      WHERE
        id = ?
      SQL
    end
  end

  # helper methods: could make into "helper class"

  def values_string
    if self.is_a?(Reply)
      ["question_id", "reply_id", "user_id", "body"]
    elsif self.is_a?(Question)
      ["title", "body", "user_id"]
    else
      ["fname", "lname"]
    end
  end

  def variable_list
    if self.is_a?(Reply)
      [@question_id, @reply_id, @user_id, @body]
    elsif self.is_a?(Question)
      [@title, @body, @user_id]
    else
      [@fname, @lname]
    end
  end

  def table_name
    if self.is_a?(Reply)
      "replies"
    else
      self.class.to_s.downcase + "s"
    end
  end

end

class User
  include SaveObjects
  attr_accessor :id, :fname, :lname

  def self.find_by_id(id)
    result = QuestionsDatabase.instance.execute(<<-SQL, id)
    SELECT
      *
    FROM
      users
    WHERE
      id = (?)
    SQL
    raise "User not found." if result.empty?

    User.new(result.first)
  end

  def self.find_by_name(fname, lname)
    result = QuestionsDatabase.instance.execute(<<-SQL, fname, lname)
    SELECT
      *
    FROM
      users
    WHERE
      fname = (?) AND
      lname = (?)
    SQL
    raise "User not found." if result.empty?

    User.new(result.first)
  end

  def initialize(options = {})
    @id = options["id"]
    @fname = options["fname"]
    @lname = options["lname"]
  end

  def authored_questions
      Question.find_by_author_id(self.id)
  end

  def authored_replies
      Reply.find_by_user_id(self.id)
  end

  def followed_questions
    QuestionFollower.followed_questions_for_user_id(self.id)
  end

  def liked_questions
    QuestionLike.liked_questions_for_user_id(self.id)
  end

  def average_karma
    results = QuestionsDatabase.instance.execute(<<-SQL, self.id)
    SELECT
      AVG(a.likes)
    FROM
      (SELECT COUNT(question_id) as likes
      FROM questions
      LEFT OUTER JOIN question_likes
      ON questions.id = question_id
      WHERE questions.user_id = ?
      GROUP BY questions.id) a
    SQL
    raise "Something not found." if results.empty?

    results.first.values.first
  end

end

class Question
  include SaveObjects
  attr_accessor :id, :title, :body, :user_id

  def self.find_by_id(id)
    result = QuestionsDatabase.instance.execute(<<-SQL, id)
    SELECT
      *
    FROM
      questions
    WHERE
      id = (?)
    SQL
    raise "Question not found." if result.empty?

    Question.new(result.first)
  end

  def self.find_by_author_id(author_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, author_id)
    SELECT
      *
    FROM
      questions
    WHERE
      user_id = (?)
    SQL
    raise "Author not found." if results.empty?

    results.map do |result|
      Question.new(result)
    end
  end

  def self.most_followed(n)
    QuestionFollower.most_followed_questions(n)
  end

  def self.most_liked(n)
    QuestionLike.most_liked_questions(n)
  end

  def initialize(options = {})
    @id = options["id"]
    @title = options["title"]
    @body = options["body"]
    @user_id = options["user_id"]
  end

  def author
    User.find_by_id(@user_id)
  end

  def replies
    Reply.find_by_question_id(self.id)
  end

  def followers
    QuestionFollower.followers_for_question_id(self.id)
  end

  def likers
    QuestionLike.likers_for_question_id(self.id)
  end

  def num_likes
    QuestionLike.num_likes_for_question_id(self.id)
  end

end

class QuestionFollower
  attr_accessor :id, :user_id, :question_id

  def self.find_by_id(id)
    result = QuestionsDatabase.instance.execute(<<-SQL, id)
    SELECT
      *
    FROM
      question_followers
    WHERE
      id = (?)
    SQL
    raise "Question Follower not found." if result.empty?

    QuestionFollower.new(result.first)
  end

  def self.followers_for_question_id(question_id)
    # input: question_id
    # QuestionFollowerTable: question_id
    # JOIN USER in order to return User objects
    results = QuestionsDatabase.instance.execute(<<-SQL, question_id)
    SELECT
      users.*
    FROM
      question_followers
    JOIN
     users on user_id = users.id
    WHERE
      question_id = (?)
    SQL
    raise "Question Followers not found." if results.empty?

    results.map do |result|
      User.new(result)
    end
    # return user objects following question
  end

  def self.followed_questions_for_user_id(user_id)
    # input: user_id
    # QuestionFollowerTable: user_id
    # JOIN question table through user_id
    results = QuestionsDatabase.instance.execute(<<-SQL, user_id)
    SELECT
      questions.*
    FROM
      question_followers
    JOIN
      questions ON question_followers.question_id = questions.id
    WHERE
      question_followers.user_id = (?)
    SQL
    raise "Followed Questions not found." if results.empty?

    results.map do |result|
      Question.new(result)
    end

    # return array question object
  end

  def self.most_followed_questions(n)

    results = QuestionsDatabase.instance.execute(<<-SQL, n)
    SELECT
      questions.*
    FROM
      question_followers
    JOIN
      questions ON question_followers.question_id = questions.id
    GROUP BY
      questions.id
    ORDER BY
      COUNT(question_followers.id) DESC
    LIMIT
      ?
    SQL
    raise "Followed Questions not found." if results.empty?

    results.map do |result|
      Question.new(result)
    end
    # fetches n most followed questions
  end

  def initialize(options = {})
    @id = options["id"]
    @user_id = options["user_id"]
    @question_id = options["question_id"]
  end

end

class Reply
  include SaveObjects
  attr_accessor :id, :question_id, :reply_id, :user_id, :body

  def self.find_by_id(id)
    result = QuestionsDatabase.instance.execute(<<-SQL, id)
    SELECT
      *
    FROM
      replies
    WHERE
      id = (?)
    SQL
    raise "Reply not found." if result.empty?

    Reply.new(result.first)
  end

  def self.find_by_user_id(user_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, user_id)
    SELECT
      *
    FROM
      replies
    WHERE
      user_id = (?)
    SQL
    raise "User not found." if results.empty?

    results.map do |result|
      Reply.new(result)
    end
  end

  def self.find_by_question_id(question_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, question_id)
    SELECT
      *
    FROM
      replies
    WHERE
      question_id = (?)
    SQL
    raise "Question not found." if results.empty?

    results.map do |result|
      Reply.new(result)
    end
  end

  def initialize(options = {})
    @id = options["id"]
    @question_id = options["question_id"]
    @reply_id = options["reply_id"]
    @user_id = options["user_id"]
    @body = options["body"]
  end

  def author
    User.find_by_id(@user_id)
  end

  def question
    Question.find_by_id(@question_id)
  end

  def parent_reply
    Reply.find_by_id(@reply_id)
  end

  def child_replies
    results = QuestionsDatabase.instance.execute(<<-SQL, self.id)
    SELECT
      *
    FROM
      replies
    WHERE
      reply_id = (?)
    SQL
    raise "Reply not found." if results.empty?

    results.map do |result|
      Reply.new(result)
    end
  end

end

class QuestionLike
  attr_accessor :id, :user_id, :question_id

  def self.likers_for_question_id(question_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, question_id)
    SELECT
      users.*
    FROM
      question_likes
    JOIN
     users on user_id = users.id
    WHERE
      question_id = (?)
    SQL
    raise "Question Likes not found." if results.empty?

    results.map do |result|
      User.new(result)
    end
  end

  def self.num_likes_for_question_id(question_id)
    result = QuestionsDatabase.instance.execute(<<-SQL, question_id)
    SELECT
      COUNT(*)
    FROM
      question_likes
    WHERE
      question_id = (?)
    SQL
    raise "Question not found." if result.empty?
    result.first["COUNT(*)"]
  end

  def self.liked_questions_for_user_id(user_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, user_id)
    SELECT
      questions.*
    FROM
      question_likes
    JOIN
      questions ON question_likes.question_id = questions.id
    WHERE
      question_likes.user_id = (?)
    SQL
    raise "Question Likes not found." if results.empty?

    results.map do |result|
      Question.new(result)
    end
  end

  def self.find_by_id(id)
    result = QuestionsDatabase.instance.execute(<<-SQL, id)
    SELECT
      *
    FROM
      question_likes
    WHERE
      id = (?)
    SQL
    raise "Question Like not found." if result.empty?

    QuestionLike.new(result.first)
  end

  def self.most_liked_questions(n)
    results = QuestionsDatabase.instance.execute(<<-SQL, n)
    SELECT
      questions.*
    FROM
      question_likes
    JOIN
      questions ON question_likes.question_id = questions.id
    GROUP BY
      questions.id
    ORDER BY
      COUNT(question_likes.id) DESC
    LIMIT
      ?
    SQL
    raise "Likes not found." if results.empty?

    results.map do |result|
      Question.new(result)
    end
  end

  def initialize(options = {})
    @id = options["id"]
    @user_id = options["user_id"]
    @question_id = options["question_id"]
  end

end