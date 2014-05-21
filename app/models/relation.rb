class Relation < ActiveRecord::Base
  belongs_to :person, :foreign_key => 'relative'
  belongs_to :person, :foreign_key => 'person'
end
