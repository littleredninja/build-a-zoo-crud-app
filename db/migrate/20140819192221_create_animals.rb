class CreateAnimals < ActiveRecord::Migration
  def change
  	create_table :animals do |t|
  		t.string :name
  		t.string :species
  		t.string :noise
  		t.string :favorite_food
  		t.integer :zoo_id
  	end
  end
end
