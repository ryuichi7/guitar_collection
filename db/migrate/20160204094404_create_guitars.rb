class CreateGuitars < ActiveRecord::Migration
  def change
  	create_table :guitars do |t|
  		t.string :make
  		t.string :model
  		t.integer :year
  		t.integer :user_id
  	end
  end
end
