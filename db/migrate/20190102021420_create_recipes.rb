class CreateRecipes < ActiveRecord::Migration[5.2]
  def change
    create_table :recipes do |t|
      t.string :name
      t.jsonb :body
    end

    add_index :recipes, :name
  end
end
