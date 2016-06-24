class AddBasicProfileToUsers < ActiveRecord::Migration
  def change
    add_column :users, :basic_profile, :boolean, :default => false
    add_column :users, :gender, :string
    add_column :users, :birth_year, :integer
  end
end
