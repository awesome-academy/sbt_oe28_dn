class Tours < ActiveRecord::Migration[5.0]
  def change
    create_table :tours do |t|
      t.string :title
      t.string :description
      t.string :content
      t.string :image
      t.float :price
      t.date :date_in
      t.date :date_out
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :tours, [:title, :created_at]
    add_index :tours, :rating
  end
end
