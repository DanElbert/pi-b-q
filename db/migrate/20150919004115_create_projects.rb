class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name, null: false
      t.datetime :start, null: false
      t.datetime :end, null: false
      t.string :sensor1_name
      t.string :sensor2_name

      t.timestamps null: false
    end
  end
end
