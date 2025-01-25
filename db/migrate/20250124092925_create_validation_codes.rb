class CreateValidationCodes < ActiveRecord::Migration[7.1]
  def change
    create_table :validation_codes do |t|
      t.string :email
      t.string :code, limit: 128 
      t.integer :kind, default: 1, null: false
      t.datetime :used_at
      t.bigint :user_id
      t.integer :is_deleted
     
      t.timestamps
    end
  end
end
