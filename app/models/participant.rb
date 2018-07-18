class Participant < ApplicationRecord
  belongs_to :user
  belongs_to :activity
  validates_uniqueness_of   :activity_id, scope: :user_id
end
