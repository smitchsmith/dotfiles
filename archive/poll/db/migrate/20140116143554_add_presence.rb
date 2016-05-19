class AddPresence < ActiveRecord::Migration
  def up
    change_column(:users, :name, :string, null: false)
    change_column(:polls, :author, :integer, null: false)
    change_column(:questions, :poll_id, :integer, null: false)
    change_column(:questions, :text, :text, null: false)
    change_column(:answer_choices, :question_id, :integer, null: false)
    change_column(:answer_choices, :text, :text, null: false)
    change_column(:responses, :user_id, :integer, null: false)
    change_column(:responses, :answer_choice_id, :integer, null: false)
  end

  def down
    change_column(:users, :name, :string, null: true)
    change_column(:polls, :author, :integer, null: true)
    change_column(:questions, :poll_id, :integer, null: true)
    change_column(:questions, :text, :text, null: true)
    change_column(:answer_choices, :question_id, :integer, null: true)
    change_column(:answer_choices, :text, :text, null: true)
    change_column(:responses, :user_id, :integer, null: true)
    change_column(:responses, :answer_choice_id, :integer, null: true)
  end
end
