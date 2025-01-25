class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :nick_name
      t.string :email
      t.integer :is_deleted
      t.integer :status

      t.timestamps
    end
  end
end
