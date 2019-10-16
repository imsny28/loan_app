module LoanFinancialStateMachine
  extend ActiveSupport::Concern

  included do
    include AASM

    aasm(:financial_status) do
      state :pending,  initial: true
			state :process
      state :approved
			state :rejected
      #state :refunded
      #state :voided
      #state :freetrial

			event :request do
				transitions from: :pending, to: :process
			end

      event :approve do
        transitions from: :process, to: :approved
        # transitions from: :freetrial, to: :paid
      end

      event :reject do
        transitions from: :process, to: :rejected
      end

      # event :void do
      #   transitions from: :paid, to: :voided
      # end

      # event :start_freetrial do
      #   transitions from: :pending, to: :freetrial
      # end
    end
  end
end
