class AddEmailToUser < ActiveRecord::Migration
  def change
    add_column :users, :country_id, :integer
    add_column :users, :username, :string
  end
end
