# frozen_string_literal: true

RSpec.describe MUD::Game do
  before do
    allow(described_class).to receive(:sleep)
    allow($stdin).to receive(:gets)
  end

  describe '.setup' do
    it 'displays the welcome message for new players' do
      expect(described_class).to receive(:display_welcome_message)

      described_class.setup
    end

    it 'creates a new player' do
      expect(described_class).to receive(:player)

      described_class.setup
    end

    it "crashes if it detects the game hasn't been seeded correctly" do
      allow(described_class).to receive(:seed_incorrect?).and_return(true)

      expect { described_class.setup }.to raise_error(RuntimeError)
    end
  end

  describe '.player' do
    it 'creates a new fighter (for now)' do
      expect(described_class.player).to be_a(MUD::Classes::Fighter)
    end
  end

  describe '.reset' do
    it 'wipes all traces of the player' do
      expect { described_class.reset }.to change(described_class, :player)
    end

    it 'recreates the game' do
      expect(described_class).to receive(:setup)

      described_class.reset
    end
  end
end
