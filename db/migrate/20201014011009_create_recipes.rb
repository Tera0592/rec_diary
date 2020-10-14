class CreateRecipes < ActiveRecord::Migration[6.0]
  def change
    create_table :recipes do |t|
      
      t.integer :user_id,       foreign_key: true
      t.string  :name,          null: false
      t.integer :genre_id,      null: false
      t.text    :food,          null: false
      t.text    :seasoning,     null: false
      t.text    :procedure,     null: false
      t.timestamps
    end
  end
end
