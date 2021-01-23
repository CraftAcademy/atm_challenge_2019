require 'date'
require './lib/person.rb'

describe Person do

    subject { described_class.new(name: 'Noel') }

    it 'takes an argument of name and adds it as attribute on initialize' do
        expect(subject.name).not_to be nil
    end

    it 'raises an error if no name is given' do
        expect { described_class.new }.to raise_error 'A name is required'
    end

    it 'is expected to have a :cash attribute with the value of 0 on initialize' do
        expect(subject.cash).to eq 0
    end

    it 'is expected to have an :account attribute with no value' do
        expect(subject.account).to be nil
    end

    describe 'can create an Account' do
        before {subject.open_account }
        
        it 'that is an instance of the Account class' do
            expect(subject.account).to be_an_instance_of Account
        end

        it 'with himself as the owner lol' do
            expect(subject.account.owner).to be subject.name
        end

    end

    describe 'can manage funds if an account been created' do
        
        it 'can deposit funds' do
            subject.open_account
            subject.cash = 100
            expect(subject.deposit(100)).to be_truthy
        end

        it 'but raises error if theres not enough cash to deposit' do
            subject.open_account
            expect { subject.deposit(100) }.to raise_error 'Not enough cash'
        end

        it 'but raises error if no account has been created on deposit' do
            subject.cash = 100
            expect { subject.deposit(100) }.to raise_error 'No account present'
        end

    end

end