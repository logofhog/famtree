class WholeFamilyMaker
  def initialize
    patriarch = Person.create(:first_name => 'fred', :last_name => 'jones',
                         :birthday=> '01/01/1920')
    @family = Family.create(:family_name => 'jones', :new_password => 'password')
    patriarch.update_attribute(:family_id, @family.id)
    @son_or_daughter = 'Son'
    @generation = 1
    add_children(patriarch)
  end

  def son_or_daughter_toggle
    if @son_or_daughter == 'Son'
      @son_or_daughter = 'Daughter'
    else
      @son_or_daughter = 'Son'
    end
  end

  def add_children(parent)
    @generation += 1
    (1..3).each do |u|
      son_or_daughter_toggle
      child = Person.create(:first_name => "person#{@son_or_daughter}#{rand(100)}",
                    :last_name => 'jones')
      child.update_attribute(:family_id, @family.id)
      Relationship.create(:person => parent, :relative => child,
                          :rel_type => @son_or_daughter)

      if @generation < 4
        add_children(child)
      end
    end
  end
end

WholeFamilyMaker.new
