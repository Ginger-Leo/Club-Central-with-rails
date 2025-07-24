class User < ApplicationRecord
  has_secure_password
  has_many :finances, dependent: :destroy
  has_many :sent_payments, class_name: "Finance", foreign_key: "payer_id", dependent: :nullify
  has_many :received_payments, class_name: "Finance", foreign_key: "payee_id", dependent: :nullify

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :password, length: { minimum: 6 }, if: :password_required?
  validates :access_level, presence: true

  def admin?
    access_level == "admin"
  end

  def player?
    access_level == "player"
  end

  def add_payment!(amount, notes = nil, payer = nil)
    increment!(:balance, amount)
    finances.create!(
      amount: amount,
      transaction_type: "payment",
      notes: notes,
      payer: payer,
      payee: self
    )
  end

  def deduct_payment!(amount, notes = nil, payee = nil)
    decrement!(:balance, amount)
    finances.create!(
      amount: -amount,
      transaction_type: "deduction",
      notes: notes,
      payer: self,
      payee: payee
    )
  end

  def make_payment!(amount, payee, notes = nil)
    User.transaction do
      decrement!(:balance, amount)
      finances.create!(
        amount: -amount,
        transaction_type: "payment_sent",
        notes: "Payment to #{payee.username}: #{notes}",
        payer: self,
        payee: payee
      )

      payee.increment!(:balance, amount)
      payee.finances.create!(
        amount: amount,
        transaction_type: "payment_received",
        notes: "Payment from #{username}: #{notes}",
        payer: self,
        payee: payee
      )
    end
  end

  private

  def password_required?
    password_digest.blank? || password.present?
  end
end
