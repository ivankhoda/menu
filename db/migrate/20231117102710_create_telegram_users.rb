class CreateTelegramUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :telegram_users do |t|
      t.integer :telegram_id, :null => false
      t.string :telegram_username
      

      t.timestamps
    end
  end
end
