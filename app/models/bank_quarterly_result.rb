class   BankQuarterlyResult < QuarterlyResult
    def column_association
        super.column_associations.merge({
                "Operating Income" => :operating_income,
                "Total Interest" => :total_interest,
                "Gross Profit" => :pbdit,

                "Less: Provisions Made" => :interest,
                "Government Share" => :government_share,
                "Capital Adequacy Ratio" => :capital_adequacy_ratio
        })
    end
end
