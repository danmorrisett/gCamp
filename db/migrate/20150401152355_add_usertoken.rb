class AddUsertoken < ActiveRecord::Migration
  def change
    add_column :users, :trackertoken, :string    
  end
end
