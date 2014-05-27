require_relative '../lib/relationship_manager.rb'

class WholeFamilyMaker
  def initialize
    patriarch = Person.create(:first_name => 'gramps', :last_name => 'jones',
                         :birthday=> '01/01/1920')
    @family = Family.create(:family_name => 'jones', :new_password => 'password')
    patriarch.update_attribute(:family_id, @family.id)
    @generation = 1
    add_children(patriarch)
  end

  def add_children(parent)
    @generation += 1
    (1..3).each do |u|
      child = Person.create(:first_name => "person#{rand(100)}",
                    :last_name => 'jones')
      child.update_attribute(:family_id, @family.id)
      RelationshipManager.new(child, parent, 'Child')

      if @generation < 4
        add_children(child)
      end
    end
  end
end

Person.delete_all
Family.delete_all
Relationship.delete_all

WholeFamilyMaker.new
