module LoanStateMachine
  extend ActiveSupport::Concern

  included do
    include AASM

    aasm(:status) do
      state :cart, initial: true
			state :placed, after_enter: :placed_line_item!

			event :loan_placed do
				transitions from: :cart, to: :placed
				transitions from: :placed, to: :placed
			end
    end
  end
end
