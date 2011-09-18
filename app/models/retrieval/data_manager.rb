require 'mechanize'

class DataManager

    def self.update_stockhive_code
        agent = WWW::Mechanize.new
        home_page = agent.post("http://www.stockhive.com/home/login", "logging_in_user[email]"=>"deepak.lewis@gmail.com", "logging_in_user[password]"=>"dlewis")
        search_form = home_page.forms[0]
        agent.redirect_ok = false
        Company.transaction do
            for company in Company.find(:all, :conditions => "stockhive_code is null")
                retrieve_stockhive_code(company, agent, search_form)
            end
        end
    end

    def self.retrieve_stockhive_code company, agent, search_form
        name_pieces = company.name.gsub("Limited", "Ltd").gsub(" and ", " & ").gsub(" And ", " & ").gsub("The ", "").gsub("(I)", "(India)").gsub(".", "").split(" ")
        name = name_pieces.slice(0, 2).join(" ")
        search_form["company[companyname]"] = name
        redirect_page = agent.submit(search_form)
        company.stockhive_code = redirect_page.links[0].uri.path.split("/").last
        company.save if not (company.stockhive_code.eql?("list") or company.stockhive_code.eql?("about_us"))
    end

    def self.update_quarterly_results url
        companies = Company.find(:all)
#        company = Company.find(:first)
        for company in companies
            latest_result = company.financial_results.find(:first, :order => "period_ended DESC")
            if latest_result.nil? or Quarter.get_quarter(latest_result.period_ended) != Quarter.current_quarter
                company.update_quarterly_results url
            end
        end
    end

    def self.update_company

        def self.test
#        url = URI.parse "http://www.stockhive.com/home/login?logging_in_user[email]=deepak.lewis@gmail.com&logging_in_user[password]=dlewis"
            #        pp url
            #
            agent = WWW::Mechanize.new
            page = agent.post("http://www.stockhive.com/home/login", "logging_in_user[email]"=>"deepak.lewis@gmail.com", "logging_in_user[password]"=>"dlewis")
#        pp page
            search_form = page.forms[0]
            search_form["company[companyname]"] = "GATI Ltd"
            agent.redirect_ok = false
            page2 = agent.submit(search_form)
            pp page2.links[0].uri.path.split("/").last
#        login_form = page1.forms[0]
            #        login_form["logging_in_user[email]"] = "deepak_lewis@gmail.com"
            #        login_form["logging_in_user[password]"] = "dlewis"
            #        page2 = agent.submit(login_form)
            #        pp page2
            #        pp page2.to_s.include?("Please log in")
            #        pp page1.eql?(page2)
            #        pp login_form
            #        pp agent.follow_redirect?
            #        pp agent.get("http://www.google.com/ncr").methods
        end
    end
end

