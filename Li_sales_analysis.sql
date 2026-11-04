-- Analysing Data for South Carolina 
Use sample_sales;
-- Need to figure do online orders being sent to south carolina count, if not just physical orders will suffice
Select 
    store_locations.state,
    sum(store_sales.sale_amount) as TotalSale,
    min(store_sales.Transaction_Date) as Oldest_Transcation,
    max(store_sales.Transaction_Date) as Latest_transation
    from store_locations 
    join  store_sales
		on store_sales.store_id = store_locations.storeid 
	where store_locations.state = 'South Carolina'
    group by state;
    -- Need to group by date now
Select 
    store_locations.state,
    sum(store_sales.sale_amount) as TotalSale,
	Month(store_sales.Transaction_Date) As SaleMonth,
    Year(store_sales.Transaction_Date) As SaleYear
    from store_locations 
    join  store_sales
		on store_sales.store_id = store_locations.storeid 
	where store_locations.state = 'South Carolina'
    group by store_locations.state,
   SaleYear,
   SaleMonth;
   -- I need to dermine what regions are a part of east, I can use that information to select the specifc stores.
Select
	store_locations.state,
	sum(store_sales.sale_amount) as TotalSale
	from store_locations
	join store_sales
		on store_sales.store_id = store_locations.storeid
	where store_locations.state in (select state from management where region = 'South')
	group by store_locations.state;
	-- Number of transations per month and average transation amount by product category for the sales territory
Select
	count(store_sales.id) as NumberOfSales,
    round(avg(store_sales.sale_amount),2) as AverageSale,
	Month(store_sales.Transaction_Date) As SaleMonth,
    Year(store_sales.Transaction_Date) As SaleYear,
    inventory_categories.category
    from store_sales
    join store_locations
		on store_sales.store_id = store_locations.storeid 
	JOIN products
		ON store_sales.Prod_Num = products.ProdNum
	JOIN inventory_categories
		ON products.Categoryid = inventory_categories.Categoryid
	where store_locations.state = 'South Carolina'
	group by SaleYear,
	SaleMonth,
    inventory_categories.Category
    ORDER BY
    SaleYear,
    SaleMonth,
    inventory_categories.Category;