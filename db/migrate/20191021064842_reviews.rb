class Reviews < ActiveRecord::Migration[5.0]
  def change
    create_table :reviews do |t|
      t.integer :category
      t.string :title
      t.string :description
      t.string :content
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :reviews, [:user_id, :updated_at]
  end
end
