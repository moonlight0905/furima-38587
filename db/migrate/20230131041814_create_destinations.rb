class CreateDestinations < ActiveRecord::Migration[6.0]
  def change
    create_table :destinations do |t|                  
     t.string          :postal_code,     null: false     
     t.integer         :prefecture_id,   null: false
     t.string          :locality,        null: false
     t.string          :address,         null: false
     t.string          :building_name
     t.string          :phone,           null: false
     t.references      :purchase,        null: false, foreign_key: true  
     t.timestamps
    end
  end
end
