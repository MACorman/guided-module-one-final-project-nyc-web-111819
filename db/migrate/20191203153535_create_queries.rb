class CreateQueries < ActiveRecord::Migration[6.0]
  def change
    create_table :queries do |t|
      t.integer :food_id
      t.integer :user_id

      t.timestamps
    end
  end
end
