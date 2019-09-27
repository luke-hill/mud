RSpec.describe 'V0.1 Movement' do
  subject(:game) { MUD::Game.instance }

  describe 'Moving around the v0.1 map' do
    it 'can move one square North' do
      expect do
        m = game
        p m.connected_rooms
        m.move('north')
      end.not_to raise_error
    end

    it 'can move a few squares' do
      expect do
        m = game
        p m.connected_rooms
        m.move('south')
        p m.connected_rooms
        m.move('south')
        p m.connected_rooms
        m.move('east')
        p m.connected_rooms
        m.move('west')
        p m.connected_rooms
      end.not_to raise_error
    end
  end
end
