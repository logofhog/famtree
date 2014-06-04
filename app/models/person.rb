class Person < ActiveRecord::Base
  belongs_to :family
  has_many :relationships, :foreign_key => 'person'

  validates :first_name, presence: true
  validates :last_name, presence: true

  scope :by_user, -> (user) {where(:family_id => user.family_id)}

  def name 
    "#{first_name} #{last_name}"
  end
end
