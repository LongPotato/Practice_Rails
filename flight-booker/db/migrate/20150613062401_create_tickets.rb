class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.references :booking, index: true
      t.references :passenger, index: true

      t.timestamps null: false
    end
    add_foreign_key :tickets, :bookings
    add_foreign_key :tickets, :passengers
  end
end
