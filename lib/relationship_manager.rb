class RelationshipManager
  RELATION_TYPES = ['Father', 'Mother', 'Brother', 'Sister', 'Daughter', 'Son']

  def initialize(first_person, second_person, rel)
    if RELATION_TYPES.include? rel
      @first_person = first_person
      @second_person = second_person
      @relationship_type = rel
      make_relation
    end
  end

  def make_relation
    rels = Relationship.where(:person=>@first_person).where(:relative=>@second_person).first
    if !rels
      rel = Relationship.create(:person => @first_person, :relative => @second_person, :rel_type => @relationship_type)
    else
      raise MakeRelationError
    end
  end

  def self.relatives(person)
    person.relationships
  end

end

class MakeRelationError < StandardError
end
