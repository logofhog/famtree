require_relative '../../lib/relationship_manager.rb'

class RelationshipsController < ApplicationController

  attr_reader :person

  before_filter :authenticate_user!

  def new
    @title = 'Make a new relationship'
    @person = Person.find_by_id(params[:id])
    @relationship = Relationship.new(:person => person)
    @rel_choices = Person.all
  end

  def create
    relative = Person.find_by_id(params[:relationship][:relative])
    person = Person.find_by_id(params[:relationship][:person])
    relationship = RelationshipManager.new(person, relative, params[:relationship][:rel_type])
    redirect_to root_path, :flash => {:success => 'Relationship created!'}
  end

  def destroy
  end

  private
  def rel_params
    params.require(:relationship).permit(:person, :relative, :rel_type)
  end
end
