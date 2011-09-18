class Utility
    def self.sales_growth_rate(company)
        calculate_growth_rate quarterly_results(company), :sales
    end

    def self.expenses_growth_rate(company)
        calculate_growth_rate quarterly_results(company), :total_expenses
    end

    def self.quarterly_growth_rate(company)
        calculate_growth_rate quarterly_results(company), :pbt
    end

    def self.trailing_eps(company)
        quarterly_results(company, "DESC").slice(0, 4).sum(&:eps)
    end

    def self.pe_ratio(company)
        pe_ratio = company.closing_price / company.eps if (company.eps != 0 and !company.closing_price.nil?)
        return pe_ratio.nil? ? 0 : pe_ratio
    end

    def self.sort array, sort_order="DESC"
        array.sort{|x, y| sort_order == "DESC"? y <=> x: x <=> y}
    end

    def self.avg(array, attribute)
        compacted_array = array.collect {|item| item.send(attribute)}.compact
        return if compacted_array.size == 0
        (compacted_array.inject(0){|sum,item| sum + item}) / compacted_array.size
    end

    private

    def self.quarterly_results(company, sort_order="ASC")
        sort company.quarterly_results, sort_order
    end

    def self.calculate_growth_rate array, attribute
        total_growth = 0
        return 0 if array.size < 2

        val_array = []
        begin
            for index in 0..array.size-2
                current = array[index + 1]
                previous = array[index]
                val_array << (current.send(attribute) - previous.send(attribute))/previous.send(attribute) if previous.send(attribute) != 0
            end
        rescue
        end
        if(val_array.size >= 4)
            val_array.delete(val_array.min)
            val_array.delete(val_array.max)
        end
#                pp (array.size - 1)
        #        return growth_rate.isNAN? ? 0 : growth_rate
        return (val_array.sum/(val_array.size)) * 100 if val_array.size != 0
    end
end