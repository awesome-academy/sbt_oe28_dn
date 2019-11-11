class Ratings < ActiveRecord::Migration[5.0]
  def change
    create_table :ratings do |t|
      t.references :user, foreign_key: true
      t.references :tour, foreign_key: true
      t.integer :rating_value

      t.timestamps
    end
    add_index :ratings, [:user_id, :tour_id], unique: true
  end
end
