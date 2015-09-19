class AddIndexToReadings < ActiveRecord::Migration
  def change
    add_index :readings, :timestamp
  end
end
