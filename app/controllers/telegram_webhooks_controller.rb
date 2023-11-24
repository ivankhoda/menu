class TelegramWebhooksController < Telegram::Bot::UpdatesController
  include Telegram::Bot::UpdatesController::Session
  include Telegram::Bot::UpdatesController::MessageContext

  def start!
    reply_with :message, text: 'Добро пожаловать в бот. Чтобы начать используйте команды', reply_markup: {
      inline_keyboard: [
        [
          { text: 'Блюдо на день - случайное блюдо', callback_data: 'one_dish' }
        ],
        [
          { text: '/new название блюда -  для создания нового блюда', callback_data: 'new_dish' }
        ]
      ]
    }
  end

  def message(_message)
    response = Dish.user_dish(user).sample.name || 'Ничего не найдено'
    respond_with :message, text: response
  end

  def new!(*args)
    if args.present?
      name = args.join(' ')
      d = Dish.new(name: name, telegram_user: user)
      if d.save
        reply_with :message, text: "Блюдо #{d.name} сохранено"
      else
        reply_with :message, text: 'Что-то пошло не так'
      end

    else
      save_context(:new!)
      respond_with :message, text: 'Введите название'
    end
  end

  def callback_query(data)
    callback_query_answer_handler(data)
  end

  def callback_query_answer_handler(data, _username = nil)
    case data
    when 'one_dish'
      reply_with :message, text: Dish.all.sample.name
    when 'new_dish'
      save_context :new!
      respond_with :message, text: 'Введите название'
    else
      reply_with :message, text: 'Not found command'
    end
  end

  private

  def user
    TelegramUser.find_or_create_by(telegram_id: from['id'])
  end

  def username
    upd = HashWithIndifferentAccess.new(update)
    upd[:message][:from][:username]
  end

  def session_key
    "#{bot.username}:#{chat['id']}:#{from['id']}" if chat && from
  end
end
