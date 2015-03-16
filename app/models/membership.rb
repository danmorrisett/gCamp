class Membership < ActiveRecord::Base

  belongs_to :user
  belongs_to :project

  ROLE = ['Member', 'Owner']

end
