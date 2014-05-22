class Relationship < ActiveRecord::Base
  belongs_to :person, :foreign_key => 'person'
  belongs_to :relative, :class_name => 'Person', :foreign_key => 'relative'
end
