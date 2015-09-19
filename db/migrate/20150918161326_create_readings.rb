class CreateReadings < ActiveRecord::Migration
  def change
    create_table :readings do |t|
      t.float :value1
      t.float :value2
      t.datetime :timestamp, null: false
    end
  end
end
