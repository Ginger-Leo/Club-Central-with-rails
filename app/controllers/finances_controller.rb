# frozen_string_literal: true

# app/controllers/finances_controller.rb
class FinancesController < ApplicationController
  before_action :require_admin, only: [:index]

  def index
    @all_roster_players = User.all
    @recent_transactions = Finance.order(created_at: :desc).limit(20)
    @total_balance = User.sum(:balance)
  end

  def add_payment
    @payer = User.find(params[:user_id])

    if params[:payee_id] == 'external'
      @payee = nil
      payee_name = 'External'
    else
      @payee = User.find(params[:payee_id] || User.find_by(access_level: 'admin')&.id)
      payee_name = @payee.username
    end

    amount = params[:amount].to_f
    notes = params[:notes]
    redirect_path = params[:redirect_to] || finances_path

    if @payee
      @payer.make_payment!(amount, @payee, notes)
    else
      @payer.update!(balance: @payer.balance - amount)
      Finance.create!(
        user_id: @payer.id,
        payer_id: @payer.id,
        payee_id: nil,
        amount: -amount,
        transaction_type: 'external',
        notes: notes
      )
    end

    flash[:notice] = "Payment of #{amount} transferred from #{@payer.username} to #{payee_name}"
    redirect_to redirect_path
  rescue StandardError => e
    flash[:alert] = "Error processing payment: #{e.message}"
    redirect_to redirect_path
  end

  def deduct_payment
    @payer = User.find(params[:payee_id] || User.find_by(access_level: 'admin')&.id)
    @payee = User.find(params[:user_id])
    amount = params[:amount].to_f
    notes = params[:notes]
    redirect_path = params[:redirect_to] || finances_path

    @payer.make_payment!(amount, @payee, notes)

    flash[:notice] = "Payment of #{amount} transferred from #{@payer.username} to #{@payee.username}"
    redirect_to redirect_path
  rescue StandardError => e
    flash[:alert] = "Error processing payment: #{e.message}"
    redirect_to redirect_path
  end
end
