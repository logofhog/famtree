class AddFamilyRefToUser < ActiveRecord::Migration
  def change
    add_reference :users, :family, index: true
  end
end
