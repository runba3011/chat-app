class CreateRooms < ActiveRecord::Migration[6.0]
  def change
    create_table :rooms do |t|
      t.string   :name , null: false
      t.timestamps

      # has_many :messages
    end
  end
end
