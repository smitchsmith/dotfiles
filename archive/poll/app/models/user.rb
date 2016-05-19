class User < ActiveRecord::Base
  attr_accessible :name

  validates :name, :uniqueness => true, :presence => true

  has_many(
    :authored_polls,
    class_name: "Poll",
    foreign_key: :author_id,
    primary_key: :id
  )

  has_many(
    :responses,
    class_name: "Response",
    foreign_key: :user_id,
    primary_key: :id
  )


  def questions_answered_by_poll_id
  self.responses.joins(:answer_choice)
    .joins("JOIN questions ON questions.id = answer_choices.question_id")
    .group("questions.poll_id").count
  end

  def completed_polls
    sql = <<-SQL
    SELECT polls.*
    FROM polls
    JOIN
      (SELECT questions.poll_id poll_id, count(responses.id) responses
      FROM users
      JOIN responses ON responses.user_id = users.id
      JOIN answer_choices ON answer_choices.id = responses.answer_choice_id
      JOIN questions ON questions.id = answer_choices.question_id
      WHERE responses.user_id = ?
      GROUP BY questions.poll_id) u
    ON polls.id = u.poll_id
    JOIN
      (SELECT questions.poll_id poll_id, count(questions.id) questions
      FROM questions
      GROUP BY questions.poll_id) a
    ON polls.id = a.poll_id
    WHERE responses = questions
    SQL

    Poll.find_by_sql [sql, id]
  end

  def uncompleted_polls
    sql = <<-SQL
    SELECT polls.*
    FROM polls
    JOIN
      (SELECT questions.poll_id poll_id, count(responses.id) responses
      FROM users
      JOIN responses ON responses.user_id = users.id
      JOIN answer_choices ON answer_choices.id = responses.answer_choice_id
      JOIN questions ON questions.id = answer_choices.question_id
      WHERE responses.user_id = ?
      GROUP BY questions.poll_id) u
    ON polls.id = u.poll_id
    JOIN
      (SELECT questions.poll_id poll_id, count(questions.id) questions
      FROM questions
      GROUP BY questions.poll_id) a
    ON polls.id = a.poll_id
    WHERE responses != questions
    SQL

    Poll.find_by_sql [sql, id]
  end

end
