class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.integer :person
      t.integer :relative
      t.string :rel_type
      t.timestamps
    end
  end
end
