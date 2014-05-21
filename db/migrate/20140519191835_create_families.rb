class CreateFamilies < ActiveRecord::Migration
  def change
    create_table :families do |t|
      t.string :family_name
      t.text :description
      t.timestamps
    end
  end
end
