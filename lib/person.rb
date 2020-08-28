require 'date'
require './lib/account.rb'
require './lib/atm.rb'

class Person
  attr_accessor :name, :cash, :account

  def initialize(attrs = {})
    @name = set_name(attrs[:name])
    @cash = set_cash(attrs[:cash])
    @account = set_account(attrs[:account])
  end

  def create_account
    @account = Account.new(owner: self)
  end

  def deposit(amount)
    @account.nil? ? missing_account : deposit_funds(amount)
  end

  def withdraw(args = {})
    @account.nil? ? missing_account : withdraw_funds(args)
  end

  private

  def set_name(name)
    name.nil? ? missing_name : name
  end

  def set_cash(amount)
    @cash = amount
  end

  def set_account(status)
    status.nil? ? missing_account : @account = status
  end

  def missing_name
    raise 'A name is required'
  end

  def deposit_funds(amount)
    @cash -= amount
    @account.balance += amount
  end

  def missing_account
    raise 'No account present'
  end

  def withdraw_funds(args)
    args[:atm].nil? ? missing_atm : atm = args[:atm]
    account = @account
    amount = args[:amount]
    pin = args[:pin]
    response = atm.withdraw(amount, pin, account)
    response[:status] == true ? increase_cash(response) : response
  end

  def increase_cash(response)
    @cash += response[:amount]
  end

  def missing_atm
    raise 'An ATM is required'
  end
end
