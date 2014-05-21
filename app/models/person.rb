class Person < ActiveRecord::Base
  belongs_to :family
  has_many :relations, :foreign_key => 'relative'
end
