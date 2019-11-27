class Bookings < ActiveRecord::Migration[5.0]
  def change
    create_table :bookings do |t|
        t.string :name
        t.string :phone
        t.integer :status, default: 2
        t.float :price
        t.datetime :date_in
        t.datetime :date_out
        t.references :user, foreign_key: true
        t.references :tour, foreign_key: true

        t.timestamps
    end
  end
end
