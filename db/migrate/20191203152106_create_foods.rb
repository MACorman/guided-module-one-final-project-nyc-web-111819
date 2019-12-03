class CreateFoods < ActiveRecord::Migration[6.0]
  def change
    create_table :foods do |t|
      t.string :name
      t.string :serving_size
      t.integer :calories
      t.string :total_fat
      t.string :cholesterol
      t.string :sodium
      t.string :total_carbohydrate
      t.string :sugar
      t.string :protein
    end
  end
end
