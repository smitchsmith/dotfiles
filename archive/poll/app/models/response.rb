class Response < ActiveRecord::Base
  attr_accessible :respondent, :answer_choice
  validates :respondent, presence: true
  validates :answer_choice, presence: true
  validate :respondent_has_not_already_answered_question
  validate :author_cannot_respond_to_own_poll

  belongs_to(
    :respondent,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id
  )

  belongs_to(
    :answer_choice,
    class_name: "AnswerChoice",
    foreign_key: :answer_choice_id,
    primary_key: :id
  )

  def respondent_has_not_already_answered_question
    sql = <<-SQL
            SELECT responses.* FROM
            responses
            JOIN answer_choices ON responses.answer_choice_id = answer_choices.id
            WHERE answer_choices.question_id
            IN (SELECT questions.id
                FROM answer_choices
                JOIN questions ON answer_choices.question_id = questions.id
                WHERE answer_choices.id = ?
            )
            AND responses.user_id = ?
          SQL

    response = Response.find_by_sql [sql, self.answer_choice_id, self.respondent]

    if self.id
      if response.count > 1 || response.first.id != self.id
        errors[:respondent] << "has already answered question."
      end
    else
      if response.count > 0
        errors[:respondent] << "has already answered question."
      end
    end
  end

  def author_cannot_respond_to_own_poll
    x = self.respondent.authored_polls.joins(:questions)
    .joins("JOIN answer_choices ON questions.id = answer_choices.question_id")
    .where("answer_choices.id = ?", self.answer_choice_id).count

    if x > 0
      errors[:respondent] << "cannot answer own poll"
    end
  end

end