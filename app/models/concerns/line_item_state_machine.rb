module LineItemStateMachine
  extend ActiveSupport::Concern

  included do
    include AASM

    aasm(:status) do
      state :cart, initial: true
      state :placed
      state :cancelled
      # state :returned
      # state :failed

      event :place do
        transitions from: :cart, to: :placed
      end

      event :cancel do
        transitions from: :placed, to: :cancelled
      end

      # event :return do
      #   transitions from: :placed, to: :returned
      # end
			#
      # event :fail do
      #   transitions from: :placed, to: :failed
      #   transitions from: :cart, to: :failed
      # end
    end
  end
end
