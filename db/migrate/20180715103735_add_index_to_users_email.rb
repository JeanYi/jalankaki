class AddIndexToUsersEmail < ActiveRecord::Migration[5.2]
  def change
  	add_index :users, :email, unique: true
  end
end

# Add an index on the email column of the users table. 
# The index by itself doesn’t enforce uniqueness, but the option unique: true does.
