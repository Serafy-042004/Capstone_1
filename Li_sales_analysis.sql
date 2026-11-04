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