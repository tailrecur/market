class Formula < ActiveRecord::Base
    validates_uniqueness_of :value

    def evaluate?(company)
        begin
            return eval(value)
        rescue
            false
        end
    end
end
