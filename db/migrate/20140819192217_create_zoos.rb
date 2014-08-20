class CreateZoos < ActiveRecord::Migration
  
  def change
  	create_table :zoos do |t|
  		t.string :name
  		t.string :location
  		t.integer :zookeeper_id
  	end
  end
  
end
