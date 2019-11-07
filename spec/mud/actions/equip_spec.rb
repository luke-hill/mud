# frozen_string_literal: true

RSpec.describe MUD::Actions::Equip do
  let(:hero) { MUD::Classes::Fighter.new }
  let(:weapon) { 'knife' }
  let(:armor) { 'vest' }
  let(:not_a_weapon) { 'unknown' }

  before do
    swallow_console_spam
    hero.inventory << weapon
    hero.inventory << armor
  end

  describe '#equip' do
    it 'can equip an armor' do
      expect { hero.equip(armor) }.to change(hero, :armor).to(armor)
    end

    it 'can equip a weapon' do
      expect { hero.equip(weapon) }.to change(hero, :weapon).to(weapon)
    end

    it 'cannot equip an invalid item' do
      expect { hero.equip(not_a_weapon) }
        .to raise_error(RuntimeError)
        .with_message("Cannot classify #{not_a_weapon}.")
    end
  end

  describe 'delegated methods' do
    it { is_expected.to delegate(:inventory).to(:@hero) }
    it { is_expected.to delegate(:equipment).to(:@hero) }
  end
end
