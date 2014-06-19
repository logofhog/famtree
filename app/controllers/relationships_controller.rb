require_relative '../../lib/relationship_manager.rb'

class RelationshipsController < ApplicationController

  attr_reader :person

  before_filter :authenticate_user!

  def new
    @title = 'Make a new relationship'
    @person = Person.find_by_id(params[:id])
    @relationship = Relationship.new(:person => person)
    @rel_choices = current_user.family.people 
  end

  def create
    relative = Person.find_by_id(params[:relationship][:relative])
    person = Person.find_by_id(params[:relationship][:person])
    relationship = RelationshipManager.new(person).
                   make_relation(relative, 
                                 params[:relationship][:rel_type])
    redirect_to root_path, :flash => {:success => 'Relationship created!'}
  end

  def destroy
    rel = Relationship.find(params[:id])
    RelationshipManager.new(rel.person).delete_relationship(rel.relative)
    redirect_to root_path, :flash => {:success => 'Relationship deleted!'}
  end

  private
  def rel_params
    params.require(:relationship).permit(:person, :relative, :rel_type)
  end
end
