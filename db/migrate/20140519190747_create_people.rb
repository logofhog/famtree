class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.string :email
      t.date :birthday
      t.date :wedding_day
      t.integer :family_id
      t.timestamps
    end
  end
end
