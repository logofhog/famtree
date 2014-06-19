class User < ActiveRecord::Base
  belongs_to :family

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def join_family(family_name, password)
    if family_to_join = Family.authenticate(family_name, password)
      update_attribute(:family, family_to_join)
    end
  end

end
