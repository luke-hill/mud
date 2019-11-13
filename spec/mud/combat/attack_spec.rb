# frozen_string_literal: true

RSpec.describe MUD::Combat::Attack do
  subject(:attack_instance) { described_class.new(hero, enemy) }

  let(:hero) { MUD::Classes::Fighter.new }
  let(:weapon_name) { MUD::Weapon.new(weapon_id).name }
  let(:weapon_id) { 'knife' }
  let(:enemy) { create(:enemy, enemy_data) }
  let(:enemy_name) { 'Enemy' }
  let(:enemy_data) do
    {
      name: enemy_name,
      description: 'A Description',
      weapon_id: 'fists',
      armor_id: 'unarmored',
      lower_hp_limit: 5,
      upper_hp_limit: 13,
      accuracy: 0.7,
      lower_gold_limit: 0,
      upper_gold_limit: 3,
      xp: 2,
      xp_killshot: 10,
      stamina: 1
    }
  end

  describe '#attack' do
    subject(:attack_attempt) { attack_instance.attack }

    let(:damage_dealt) { 2 }
    let(:missed?) { false }

    before do
      swallow_console_spam
      allow(hero).to receive(:weapon).and_return(weapon_id)
      allow(attack_instance).to receive(:damage_dealt).and_return(damage_dealt)
      allow(attack_instance).to receive(:missed?).and_return(missed?)
      switch_logging_to_temp_file
    end

    context "when the hero's attack misses" do
      let(:missed?) { true }

      it "informs the player that the attack attempt missed" do
        expect(attack_attempt)
          .to eq("You tried to attack the #{enemy_name} with your #{weapon_name}... but missed.".yellow)
      end
    end

    context "when the weapon deals no damage" do
      let(:damage_dealt) { 0 }

      it "informs the player that the attack attempt missed" do
        expect(attack_attempt)
          .to eq("You tried to attack the #{enemy_name} with your #{weapon_name}... but missed.".yellow)
      end
    end

    it "informs the player that the attack dealt damage" do
      attack_attempt

      expect(log_lines).to include(/You hit the #{enemy_name} with your #{weapon_name} for #{damage_dealt} damage./)
    end

    it "reduces the enemies hp by the amount of damage dealt" do
      expect{ attack_attempt }.to change{ enemy.hp }.by(-2)
    end

    it "sends a debug statement with the enemies new hp value" do
      attack_attempt

      expect(log_lines).to include(/DEBUG --> ENEMY HP:\d+hp./)
    end

    context "when the attack kills the enemy" do
      let(:damage_dealt) { 13 }

      it "does not send a debug statement with the enemies new hp value" do
        attack_attempt

        expect(log_lines).not_to include(/DEBUG --> ENEMY HP:\d+hp./)
      end

      it "deletes the enemy from the room" do
        attack_attempt

        expect(attack_instance.enemy).to be_nil
      end
    end
  end
end
