/* Top 5 countries with highest purchases in their popular genre.*/
WITH t1 AS (SELECT	c.Country Country_name,
					g.Name Genre_name, 
					COUNT(InvoiceLineId) Purchases 
				FROM Customer c 
				JOIN Invoice i ON (i.CustomerId = c.CustomerId)
				JOIN InvoiceLine il ON (il.InvoiceId = i.InvoiceId)
				JOIN Track t ON (t.TrackId = il.TrackId)
				JOIN Genre g ON (g.GenreId = t.GenreId)
			GROUP BY 1, 2),
	t2 AS (SELECT	Country_name, 
					MAX(Purchases) Purchases 
				FROM t1 
		    GROUP BY 1)		
SELECT t2.Country_name, t1.Genre_name, t2.Purchases 
FROM t2 
JOIN t1 
ON t1.Country_name = t2.Country_name AND t1.Purchases = t2.Purchases 
ORDER BY 3 DESC
LIMIT 5; 