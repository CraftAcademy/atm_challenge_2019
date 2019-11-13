require 'date'


class Account
    STANDARD_VALIDITY_YRS = 5

        attr_accessor :exp_date, :account_status, :owner
        

    def initialize(attrs = {})
        @exp_date = set_expire_date 
        @account_status = :active
        set_owner(attrs[:owner])
    end

    def set_expire_date
        Date.today.next_year(Account::STANDARD_VALIDITY_YRS).strftime('%m/%y')
    end

    def deactivate
        @account_status = :deactivated
    end 

    private 
      def set_owner(obj)
        obj == nil ? missing_owner : @owner = obj
      end

      def missing_owner
        raise "An Account owner is required"
      end
end

    

