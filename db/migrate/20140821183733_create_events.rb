class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.references :event_type
      t.string :name
      t.boolean :is_public
      t.string :hosting_type
      t.integer :host
      t.string :location_type
      t.string :address1
      t.string :address2
      t.string :country
      t.string :state
      t.string :city
      t.string :zipcode
      t.string :affiliate_code
      t.string :start_date
      t.string :start_time
      t.string :end_date
      t.string :end_time

      t.timestamps
    end
  end
end
