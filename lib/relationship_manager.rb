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
    Relation.create(:person => @first_person, :relative => @second_person, :rel_type => @relationship_type)
  end

  def self.relatives(person)
    person.relations
  end

end
