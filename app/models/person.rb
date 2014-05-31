class Person < ActiveRecord::Base
  belongs_to :family
  has_many :relationships, :foreign_key => 'person'

  def name 
    "#{first_name} #{last_name}"
  end
end
