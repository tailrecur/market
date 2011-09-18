class CompanyWrapper
    def initialize company
        @company = company
    end

    def balance_sheet
        balance_sheets.first       
    end

    def balance_sheets sort_order="DESC"
        sort @company.balance_sheets, sort_order
    end

    def profit_and_loss_statements sort_order="DESC"
        sort @company.profit_and_loss_statements, sort_order
    end

    def method_missing symbol, *args
        @company.send(symbol, *args)
    end

    def sort array, sort_order
        array.sort{|x, y| sort_order == "DESC"? y <=> x: x <=> y}
    end
end