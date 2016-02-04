class CreateAmps < ActiveRecord::Migration
  def change
  	create_table :amps do |t|
  		t.string :make
  		t.string :model
  		t.integer :year
  		t.integer :user_id
  	end
  end
end
