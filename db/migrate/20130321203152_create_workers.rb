class CreateWorkers < ActiveRecord::Migration
  def change
    create_table :workers do |t|
      t.string :name
      t.string :phone
      t.string :email, :null => false
      t.string :crypted_password, :null => false

      t.timestamps
    end
  end
end
