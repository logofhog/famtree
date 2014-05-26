class RelationshipManager
  RELATION_TYPES = %w[Parent Child Spouse]

  def initialize(first_person, second_person, rel)
    if RELATION_TYPES.include? rel
      @first_person = first_person
      @second_person = second_person
      @relationship_type = rel
      make_relation
    end
  end

  def self.get_parents(person)
    rel = Relationship.where(:person => person).where(:rel_type => 'Parent')
    rel.first.relative
  end

  def make_relation
    rels = check_for_relatives

    if rels.size == 0
      rel = Relationship.create(:person => @first_person, 
                                :relative => @second_person, 
                                :rel_type => @relationship_type)
      

      rel = Relationship.create(:person => @second_person, 
                                :relative => @first_person, 
                                :rel_type => inverse_relationship(@relationship_type))
    else
      raise MakeRelationError
    end
  end

  def inverse_relationship(relationship)
    if relationship == 'Parent'
      inverse = 'Child'
    elsif relationship == 'Child'
      inverse = 'Parent'
    else
      inverse = 'Spouse'
    end
  end

  def check_for_relatives
    rels = Relationship.where(:person=>@first_person).
                        where(:relative=>@second_person)
    rels += Relationship.where(:person=>@second_person).
                         where(:relative => @first_person)
  end

  def self.relatives(person)
    Relationship.where(:person => person) 
  end

end

class MakeRelationError < StandardError
end
