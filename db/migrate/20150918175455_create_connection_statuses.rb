class CreateConnectionStatuses < ActiveRecord::Migration
  def change
    create_table :connection_statuses do |t|
      t.boolean :is_connect
      t.boolean :is_disconnect
      t.text :info

      t.timestamps null: false
    end
  end
end
