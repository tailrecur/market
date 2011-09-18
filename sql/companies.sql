select * from companies where id = 1088
select * from companies where stockhive_code = "list" or stockhive_code = "about_us"
SELECT * FROM companies WHERE (stockhive_code = 'about_us' or stockhive_code = 'about_us')
select * from quarterly_results
select * from profit_and_loss_statements
select * from balance_sheets
select * from schema_info

delete from companies where name like '%fund%'

select * from companies
where companies.id not in
(
SELECT companies.id FROM companies  inner join quarterly_results on companies.id = quarterly_results.company_id  
GROUP BY companies.id)

SELECT * FROM companies WHERE (stockhive_code != 'not_present' and companies.id not in (SELECT companies.id FROM companies inner join quarterly_results on companies.id = quarterly_results.company_id GROUP BY companies.id))

insert into market_development.quarterly_results select * from quarterly_results

select distinct company_id from balance_sheets

SELECT * FROM companies WHERE (companies.stockhive_code != 'not_present' and companies.id not in (SELECT companies.id FROM companies  inner join profit_and_loss_statements on companies.id = profit_and_loss_statements.company_id GROUP BY companies.id)) 

INSERT INTO profit_and_loss_statements (`cost_of_sales`, `material_consumed`, `pbdit`, `tax`, `depreciation`, `equity_dividend`, `operating_profit`, `pbt`, `year_ended`, `pat`, `selling_expenses`, `other_recurring_income`, `adjusted_eps`, `administrative_expenses`, `non_recurring_items`, `manufacturing_expenses`, `net_profit`, `pbdt`, `company_id`, `operating_income`, `face_value`, `no_of_shares`, `personnel_expenses`, `preference_dividend`, `write_offs`, `other_non_cash_adjustments`, `financial_expenses`, `reported_eps`) VALUES('0.0', '0.0', '0.0', '0.0', '0.0', '0.0', '0.0', '0.0', '2006-03-01', '0.0', '0.0', '0.0', '-66.0', '0.0', '0.0', '0.0', '0.0', '0.0', 907, '0.0', '1000.0', '0.0', '0.0', '0.0', '0.0', '0.0', '0.0', '-66.0')

commit