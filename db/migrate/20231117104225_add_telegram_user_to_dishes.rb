class AddTelegramUserToDishes < ActiveRecord::Migration[7.0]
  def change
    add_reference :dishes, :telegram_user, index: true
  end
end
