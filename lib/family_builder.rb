require_relative 'relationship_manager.rb'

class FamilyBuilder
  
  def initialize(family)
    @family = family
  end

  def self.head_of_family family
    person = Person.where(:family_id => family.id).last
  end

end
