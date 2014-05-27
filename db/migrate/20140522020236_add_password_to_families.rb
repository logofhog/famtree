class AddPasswordToFamilies < ActiveRecord::Migration
  def change
    add_column :families, :password, :string
  end
end
