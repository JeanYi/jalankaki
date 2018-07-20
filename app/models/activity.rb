class Activity < ApplicationRecord
	has_many :participants 
  	has_many :users, through: :participants 
	enum activity: [:nil, :fitness_walking, :running, :circuit_training]
	validates :activity, presence: true 
	validates :location, presence: true 
 	mount_uploaders :images, ImageUploader
 	acts_as_votable 
end



