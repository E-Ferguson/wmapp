class CreateWorkorders < ActiveRecord::Migration
  def change
    create_table :workorders do |t|
      t.string :description
      t.string :building
      t.string :room
      t.string :worker
      t.string :state#, :default => "Pending"

      t.timestamps
    end
    
  end
end
