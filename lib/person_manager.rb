class PersonManager
  
  def initialize(person)
    @person = person
  end

  def spouse
    rel = Relationship.where(:person => @person)
                      .where(:rel_type => 'Spouse')
                      .first
    if rel
      rel.relative
    else
      nil
    end
  end

  def parents
    rel = Relationship.where(:person => @person).
                       where(:rel_type => 'Child')
    if @person && @person.spouse
      rel += Relationship.where(:person => @person.spouse)
                         .where(:rel_type => 'Child')
    end
    relative_mapper(rel)
  end

  def children
    rel = Relationship.where(:person => @person).
                       where(:rel_type => 'Parent')
    if @person && @person.spouse
      rel += Relationship.where(:person => @person.spouse)
                         .where(:rel_type => 'Parent')
    end
    relative_mapper(rel)
  end

  def furthest_ancestor
    has_parents = true
    while has_parents
      parent = PersonManager.new(@person).parents
      if !parent
        has_parents = false
      else
        @person = parent
      end
    end
    @person
  end

  private

  def relative_mapper(rel)
    if rel.size > 0
      rel.map{|p| p.relative}
    end
  end

end


