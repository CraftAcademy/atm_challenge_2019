require 'date'

class Person 

    attr_accessor :name, :cash, :account

    def initialize(attrs = {})
        @name = set_name(attrs[:name])
        @cash
        @account
    end

    private

    def set_name(name)
        name == nil ? missing_name : name
    end


    
end

