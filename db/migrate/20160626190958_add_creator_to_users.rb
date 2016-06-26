class AddCreatorToUsers < ActiveRecord::Migration
  def change
    add_column :users, :creater, :boolean
  end
end
