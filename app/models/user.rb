class User < ActiveRecord::Base
  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true
  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  has_many :memberships, dependent: :destroy
  has_many :projects, through: :memberships
  has_many :comments

  def project_owner(project)
    self.memberships.find_by(project_id: project.id).role == 'owner'
  end

end
