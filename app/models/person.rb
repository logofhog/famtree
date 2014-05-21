class Person < ActiveRecord::Base
  belongs_to :family
  has_many :relationships, :foreign_key => 'person'
end
