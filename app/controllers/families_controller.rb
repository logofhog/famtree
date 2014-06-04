
class FamiliesController < ApplicationController

  def new
    @family = Family.new
  end

  def create
    if passwords_match(params)
      @family = Family.new(:family_name=>params[:family][:family_name],
                           :description=> params[:family][:description],
                           :new_password => params[:family][:password])
      if @family.save
        redirect_to root_path, :flash => {:success => 'Created new family'}
      end
    else
      redirect_to new_family_path, :flash => {:error => 'Passwords must match'}
    end
  end

  def join
    @family = Family.new
  end

  def joined
    if FamilyBuilder.join_family(current_user,
                              params[:family][:family_name], 
                              params[:family][:password])
      redirect_to root_path, :flash => {:success => 'You joined the family!'}
    else
      redirect_to family_join_path, :flash => {:error => 'That family/password combination is invalid'}
    end

  end

  private
  def family_params
    params.require(:family).permit(:family_name, :description, :password, 
                                   :password_comfirmation)
  end

  def passwords_match(params)
    params[:family][:password] == params[:family][:password_comfirmation]
  end

end
