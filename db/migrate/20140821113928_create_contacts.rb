class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :first_name
      t.string :last_name
      t.string :email, null: false
      t.string :company
      t.string :address1
      t.string :address2
      t.string :country
      t.string :state
      t.string :city
      t.string :zipcode
      t.string :mobile_phone
      t.string :alternate_phone
      
      t.timestamps
    end
  end
end
