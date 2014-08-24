class CreateChildren < ActiveRecord::Migration
  def change
    create_table :children do |t|
      t.integer  :contact_id
      t.string   :name
      t.datetime :birthday
      t.string   :gender
      t.string   :relationship
      
      t.timestamps
    end
  end
end
