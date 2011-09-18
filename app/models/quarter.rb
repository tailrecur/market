class Quarter
    attr_reader :to
    @@quarters = []

    def initialize from, to
        @from = Date.parse from
        @to = Date.parse to
        @@quarters << self
    end

    First = Quarter.new("01-Apr", "30-Jun")
    Second = Quarter.new("01-Jul", "30-Sep")
    Third = Quarter.new("01-Oct", "31-Dec")
    Fourth = Quarter.new("01-Jan", "31-Mar")

    def self.get_quarter date
        @@quarters.find do |quarter|
            quarter.contains date
        end
    end

    def self.current_quarter
        get_quarter Date.today
    end

    def contains date
        @from <= date and @to >= date
    end

    def to_s
        "end_date: " + @to.to_s
    end
end