class Membership < ActiveRecord::Base

  validates :user, presence: true
  validates :user, uniqueness: {scope: :project_id, message: "has already been added to this project" }

  belongs_to :user
  belongs_to :project

  ROLE = ['Member', 'Owner']
  enum role: { member: 0, owner: 1 }

end
