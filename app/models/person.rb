class Person < ActiveRecord::Base
  belongs_to :family
  belongs_to :relation
end
