class Relation < ActiveRecord::Migration
  def change
    create_table :relations do |t|
      t.integer :person
      t.integer :relative
      t.timestamps
    end
  end
end
