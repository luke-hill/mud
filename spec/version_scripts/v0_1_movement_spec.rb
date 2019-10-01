RSpec.describe 'V0.1 Movement' do
  subject(:game) { MUD::Game.instance }

  before do
    allow($stdout).to receive(:write).and_return nil
  end

  before(:each) do
    game.reset!
  end

  describe 'Moving around the v0.1 map' do
    it 'can move one square North' do
      expect do
        game.move('north')
      end.not_to raise_error
    end

    it 'can move a few squares' do
      expect(script).not_to eq(/west/)
    end

    def script
      game.move('south')
      game.move('south')
      game.move('east')
      game.move('west')
    end
  end
end
