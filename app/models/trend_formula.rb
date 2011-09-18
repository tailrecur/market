class TrendFormula < Formula

    def evaluate(company)
        array = company.send(trend_array)
        apply_trend array
    end

    private
    
    def apply_trend array
        return false if array.size < 2
        for index in 0..array.size-2
            current = array[index]
            previous = array[index+1]
            begin
                return false if not eval(self.value)
            rescue
                return false
            end
        end
        return true
    end

end
