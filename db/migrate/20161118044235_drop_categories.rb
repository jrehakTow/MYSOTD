class DropCategories < ActiveRecord::Migration
  def change
    remove_column :items, :category_id
  end
  def up
    drop_table :categories
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
