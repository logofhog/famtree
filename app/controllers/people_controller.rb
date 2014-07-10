require_relative '../../lib/relationship_manager.rb'

class PeopleController < ApplicationController
  before_action :authenticate_user!
  before_action :belongs_to_any_family, only: [:new, :create]
  before_action :belongs_to_correct_family, only: [:show, :edit, :update, :destroy]
  
  def index
    @title = 'Your Family'
    if current_user.family
      @people = FamilyBuilder.new(current_user.family).tree
    else
      flash.notice = 'please make or join a family'
    end
  end

  def show
    @person = Person.find(params[:id])
    @relatives = RelationshipManager.relatives(@person)
  end

  def new
    @title = 'Enter New Person'
    @person = Person.new
  end

  def create
    params[:person][:family_id] = current_user.family_id
    @person = Person.new(person_params)
    if @person.save
      redirect_to root_path, :flash => {:success => 'Created new person'}
    else
      flash[:alert] = @person.errors.full_messages.join(', ')
      render 'new'
    end
  end

  def edit
    @person = Person.find(params[:id])
  end

  def update
    @person = Person.find_by_id(params[:id])
    if @person.update_attributes(person_params)
      redirect_to root_path, :flash => {:success => 'Successfully updated person'}
    else
      render 'edit'
    end
  end

  def destroy
  end

  private

  def person_params
    params.require(:person).permit(:first_name, :middle_name, :last_name,
                                   :email, :birthday, :family_id)
  end

  def belongs_to_any_family
    unless current_user.family_id
      redirect_to root_path
    end
  end

  def belongs_to_correct_family
    unless current_user.family == Person.find(params[:id]).family
      redirect_to root_path
    end
  end

end
