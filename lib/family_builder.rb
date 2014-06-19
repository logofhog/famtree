require_relative 'relationship_manager.rb'
require_relative 'person_manager.rb'

class FamilyBuilder
  attr_reader :tree
  
  def initialize(family)
    @family = family
    @family_size = family.people.count
    @head_of_family = PersonManager.new(family.people.first).
                                    furthest_ancestor
    @tree = make_tree
  end

  private

  def make_tree
    if @head_of_family
      f = make_branch(@head_of_family, 0)
      tree_to_list(f, @family.people)
    end
  end

  def tree_to_list(placed_people, all_people)
      list = placed_people.map { |p| p[:person] }
      list = all_people - list
      placed_people += list.map { |p| {:person => p, :generation => 0 }}
  end

  def make_branch(person, generation)
    children = PersonManager.new(person).children
    if children
      p = [{:person => person, :generation => generation}]
      children.each do |child|
        p += make_branch(child, generation + 1)
      end
      p
    else
      [{:person => person, :generation => generation}]
    end
  end


end
