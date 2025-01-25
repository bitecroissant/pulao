class CreateEventDates < ActiveRecord::Migration[7.1]
  def change
    create_table :event_dates do |t|
      t.string :name
      t.bigint :group_id
      t.string :icon_name
      t.string :icon_color
      t.string :emoji_icon
      t.bigint :user_id
      t.integer :is_deleted
      t.integer :status
      t.datetime :happened_at

      t.timestamps
    end
  end
end
