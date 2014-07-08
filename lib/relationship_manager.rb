class RelationshipManager
  RELATION_TYPES = %w[Parent Child Spouse]

  def initialize(person)
    @first_person = person
  end

  def make_relation(relative, relationship_type)
    rels = check_for_relatives(relative)

    if rels.size == 0 && valid_relationship?(relative, relationship_type)
      rel = Relationship.create(:person => @first_person, 
                                :relative => relative, 
                                :rel_type => relationship_type)

      rel = Relationship.create(:person => relative, 
                                :relative => @first_person, 
                                :rel_type => inverse_relationship(relationship_type))
    else
      return false
    end
  end

  def delete_relationship(relative)
    check_for_relatives(relative).each do |r|
      r.destroy
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

  def check_for_relatives(relative)
    rels = Relationship.where(:person=>@first_person).
                        where(:relative => relative)
    rels += Relationship.where(:person=> relative).
                        where(:relative => @first_person)
  end

  def self.relatives(person)
    rels = Relationship.where(:person => person) 
    if person.spouse
      rels += Relationship.where(:person => person.spouse)
    end
    rels
  end

  def valid_relationship?(relative, rel_type)
    if @first_person == relative 
      return false
    end

    unless RELATION_TYPES.include?(rel_type) && relative
      return false
    end

    method = rel_to_method(rel_type, true)
    people_to_check = PersonManager.new(relative).send(method) || []
    valid = true
    not_checked_all = true
    while not_checked_all
      person = people_to_check[0]
      people_to_check += PersonManager.new(person).send(method) || []
      if people_to_check.include? @first_person
        return false
      end
      people_to_check.delete(person)
      if people_to_check.size == 0 
        not_checked_all = false
      end
    end
    valid
  end

  def rel_to_method(rel_type, inverse = false)
    if inverse
      rel_type = inverse_relationship(rel_type)
    end
    if rel_type == 'Parent'
      method = 'parents'
    else
      method = 'children'
    end
  end
end
