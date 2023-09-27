RSpec.describe TelegramWebhooksController, telegram_bot: :rails, type: :request do
  # for old RSpec:
  # include_context 'telegram/bot/integration/rails'

  # Main method is #dispatch(update). Some helpers are:
  #   dispatch_message(text, options = {})
  #   dispatch_command(cmd, *args)

  # Available matchers can be found in Telegram::Bot::RSpec::ClientMatchers.

  describe '#start!' do
    subject { -> { dispatch_command :start } }
    it { should respond_with_message 'Добро пожаловать в бот.' }
  end
  
  describe 'message' do
    let!(:dish) { create(:dish) }
    subject { -> { dispatch_message('any') } }
    it { should respond_with_message dish.name }
  end

  # There is context for callback queries with related matchers,
  # use :callback_query tag to include it.
  describe '#callback_query', :callback_query do
    let!(:data) { 'one_dish' }
    let!(:dish) { create(:dish) }

    it { should respond_with_message dish.name }
  end
end
