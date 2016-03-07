class Goal < ActiveRecord::Base
  validates :description, :user_id, presence: true
  validates :share_goal, :completed, inclusion: { in: [true, false] }

  belongs_to :user


end
