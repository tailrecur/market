require 'calculation/company_wrapper'

class Calculator
    def initialize company
        @company = CompanyWrapper.new company

    end

    def apply_formulae(formulae)
        @score = 0
        pp "Company - #{@company.name}"

        formulae.each do |formula|
            result = formula.evaluate?(@company)
            @score += formula.weightage if result
        end

        @company.score = @score
        @company.save
    end

    def extrapolate_score
        failing_price_formulae = []
        Formula.find(:all).each do |formula|
            passed = formula.evaluate?(@company)
            failing_price_formulae << formula if !passed and formula.price_dependent?
        end

        @extrapolated_scores = {}

        if (failing_price_formulae.any? and @company.closing_price > 0)
            low = 1
            high = @company.closing_price
            @company.closing_price = low
            @company.update_calculations
            passable_formulae = evaluate_formulae(failing_price_formulae)

            for formula in passable_formulae
                binary_search(formula, low, high)
            end
        end

        return @extrapolated_scores
    end

    def binary_search(formula, low, high)
        avg = (low + high)/2
        if ((high - low) <= 1)
            @extrapolated_scores[formula] = avg
            return
        end

        @company.closing_price = avg
        @company.update_calculations

        if (formula.evaluate?(@company))
            binary_search(formula, avg, high)
        else
            binary_search(formula, low, avg)
        end
    end

    def evaluate_formulae(formulae)
        passing_formulae = []
        for formula in formulae do
            passing_formulae << formula if formula.evaluate?(@company)
        end

        return passing_formulae
    end
end
