# frozen_string_literal: true

RSpec.describe MUD::Game do
  before do
    allow(described_class).to receive(:sleep)
    allow($stdin).to receive(:gets)
  end

  describe '.setup' do
    after { described_class.setup }

    it 'displays the welcome message for new players' do
      expect(described_class).to receive(:display_welcome_message)
    end

    it 'creates a new player' do
      expect(described_class).to receive(:player)
    end
  end

  describe '.player' do
    it 'creates a new player' do
      expect(described_class.player).to be_a(MUD::Classes::Base)
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
