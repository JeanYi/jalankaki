class CreateActivities < ActiveRecord::Migration[5.2]
  def change
    create_table :activities do |t|
      t.integer :activity, default:0
      t.string :location 
      t.string :studio	
      t.text :description
      t.date :activity_date 
      t.time :start_time 
      t.time :end_time  
      t.string :hosted_by 
      t.json :images 
      t.references :user, foreign_key: true 
      t.timestamps
    end
  end
end
