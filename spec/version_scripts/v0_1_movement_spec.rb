RSpec.describe 'V0.1 Movement' do
  subject(:game) { MUD::Game.instance }

  before do
    allow($stdout).to receive(:write).and_return nil
  end

  before(:each) do
    game.reset!
    ENV['TEST_LOG_NAME'] = SecureRandom.uuid
    MUD::Screen.logger.reopen("log/#{ENV['TEST_LOG_NAME']}.log")
  end

  after(:each) { remove_test_screen_logs }

  describe 'Moving around the v0.1 map' do
    it 'can move one square North' do
      expect do
        game.move('north')
      end.not_to raise_error
    end

    it 'can move a few squares without hitting a wall' do
      game.move('north')
      game.move('south')
      game.move('east')
      game.move('west')

      expect(read_test_screen_logs).not_to include('You cannot go')
    end
  end
end
