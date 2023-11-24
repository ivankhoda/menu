RSpec.describe TelegramWebhooksController, telegram_bot: :rails, type: :request do
  # for old RSpec:
  # include_context 'telegram/bot/integration/rails'

  # Main method is #dispatch(update). Some helpers are:
  #   dispatch_message(text, options = {})
  #   dispatch_command(cmd, *args)

  # Available matchers can be found in Telegram::Bot::RSpec::ClientMatchers.

  describe '#start!' do
    let!(:telegram_user) { create(:telegram_user) }
    subject { -> { dispatch_command :start } }
    it { should respond_with_message 'Добро пожаловать в бот. Чтобы начать используйте команды' }
  end

  describe '#new!' do
    context 'when arguments were passed' do
      let!(:telegram_user) { create(:telegram_user) }
      let!(:dish_name) { 'Сырок суфле' }
      subject { -> { dispatch_command :new, dish_name } }
      it { should respond_with_message "Блюдо #{dish_name} сохранено" }
    end

    context 'when arguments were not passed' do
      let!(:telegram_user) { create(:telegram_user) }
      subject { -> { dispatch_command :new } }
      it do
        should respond_with_message 'Введите название'
      end
    end
  end

  describe 'message' do
    let!(:telegram_user) { create(:telegram_user) }
    let!(:dish) { create(:dish, telegram_user: telegram_user) }
    subject { -> { dispatch_message('any', from: { id: telegram_user.telegram_id.to_s }) } }
    it { should respond_with_message dish.name }
  end

  # There is context for callback queries with related matchers,
  # use :callback_query tag to include it.
  describe '#callback_query', :callback_query do
    context 'when choose one dish option' do
      let!(:data) { 'one_dish' }
      let!(:telegram_user) { create(:telegram_user) }
      let!(:dish) { create(:dish, telegram_user: telegram_user) }

      it { should respond_with_message dish.name }
    end

    context 'when choose new! option' do
      let!(:data) { 'new_dish' }
      let!(:telegram_user) { create(:telegram_user) }
      let!(:dish) { create(:dish, telegram_user: telegram_user) }

      it { should respond_with_message 'Введите название' }
    end
  end
end
