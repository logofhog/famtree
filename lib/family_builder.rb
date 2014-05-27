require_relative 'relationship_manager.rb'

class FamilyBuilder
  
  def initialize(family)
    @family = family
  end

  def self.head_of_family(person)
    has_parents = true
    while has_parents
      parent = RelationshipManager.get_parents(person)
      if !parent
        has_parents = false
      else
        person = parent
      end
    end
    person
  end

end
