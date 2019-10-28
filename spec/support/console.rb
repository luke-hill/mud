# frozen_string_literal: true

module SpecSupport
  module Console
    def swallow_console_spam
      allow($stdout).to receive(:write).and_return nil
    end
  end
end
