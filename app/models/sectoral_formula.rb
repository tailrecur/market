class SectoralFormula < Formula
    def evaluate?(company)
        sector = company.sector
        begin
            result = eval(value)
        rescue
            result = false
        end
    end
end
