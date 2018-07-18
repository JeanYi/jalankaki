class RemoveUserFromActivities < ActiveRecord::Migration[5.2]
  def change
  	remove_reference :activities, :user, index: true, foreign_key: true
  end
end
