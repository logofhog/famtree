require_relative 'relationship_manager.rb'

class FamilyBuilder
  
  def initialize(family)
    @family = family
  end

  def self.join_family(user, family_name, password)
    family_to_join = Family.authenticate(family_name, password)
    if family_to_join
      user.update_attribute(:family, family_to_join)
      true
    else
      false
    end
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
