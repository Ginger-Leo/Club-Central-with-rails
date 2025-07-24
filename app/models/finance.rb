class Finance < ApplicationRecord
  belongs_to :user
  belongs_to :payer, class_name: "User", optional: true
  belongs_to :payee, class_name: "User", optional: true
  validates :amount, presence: true
  validates :transaction_type, presence: true

  scope :transfer_pair, ->(payer, payee, amount) {
    where(payer: payer, payee: payee)
    .where("amount = ? OR amount = ?", amount, -amount)
    .where(transaction_type: [ "payment_sent", "payment_received" ])
  }

  def payment?
    transaction_type == "payment" || transaction_type == "payment_received" || transaction_type == "external"
  end

  def deduction?
    transaction_type == "deduction" || transaction_type == "payment_sent" || transaction_type == "external"
  end

  def transfer?
    transaction_type == "payment_sent" || transaction_type == "payment_received" || transaction_type == "external"
  end

  def payer_name
    payer&.username || "Unknown"
  end

  def payee_name
    payee&.username || "Unknown"
  end

  def transaction_description
    case transaction_type
    when "payment_sent"
      "#{payer_name} → #{payee_name}"
    when "payment_received"
      "#{payer_name} → #{payee_name}"
    when "payment"
      "Payment to #{user.username}"
    when "deduction"
      "Deduction from #{user.username}"
    else
      transaction_type.humanize
    end
  end
end
