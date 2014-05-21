class AddRelationTypeToRelation < ActiveRecord::Migration
  def change
    add_column :relations, :rel_type, :string
  end
end
