class AddNextQuestionToUsers < ActiveRecord::Migration
  def change
    add_column :users, :next_question, :datetime
  end
end
