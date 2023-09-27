class TelegramWebhooksController < Telegram::Bot::UpdatesController
  # include Telegram::Bot::UpdatesController::MessageContext
  TG_API = 'https://api.telegram.org/bot'

  # Every update has one of: message, inline_query, chosen_inline_result,
  # callback_query, etc.
  # Define method with the same name to handle this type of update.

  def start!
    reply_with :message, text: 'Добро пожаловать в бот.', reply_markup: {
      inline_keyboard: [
        [
          { text: 'Блюдо на день', callback_data: 'one_dish' }
        ]
      ]
    }
  end

  def message(_message)
    respond_with :message, text: Dish.all.sample.name, reply_markup: {
      inline_keyboard: [
        [
          { text: 'Registration', callback_data: 'registration' }
        ]
      ]
    }
  end

  def callback_query(data)
    callback_query_answer_handler(data)
  end

  def callback_query_answer_handler(data, _username = nil)
    case data
    when 'one_dish'
      reply_with :message, text: Dish.all.sample.name
    else
      reply_with :message, text: 'Not found command'
    end
  end

  private

  def username
    upd = HashWithIndifferentAccess.new(update)
    upd[:message][:from][:username]
  end

  def session_key
    "#{bot.username}:#{chat['id']}:#{from['id']}" if chat && from
  end
end
