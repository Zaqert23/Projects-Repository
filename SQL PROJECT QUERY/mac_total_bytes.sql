/* What is max total bytes of track sold per genre in each country popular track in each country.*/
WITH t1 AS (SELECT g.Name genre_name, i.BillingCountry billing_country, SUM(t.Bytes) total_bytes 
				FROM Genre g 
				JOIN Track t ON (t.GenreId = g.GenreId)
				JOIN InvoiceLine il ON (il.TrackId = t.TrackId) 
				JOIN Invoice i ON (i.InvoiceId = il.InvoiceId)
			GROUP BY 1, 2),
	 t2 AS (SELECT billing_country, MAX(total_bytes) max_total_bytes
				FROM t1 
			GROUP BY 1)

SELECT t1.genre_name, t2.billing_country, t2.max_total_bytes 
FROM t1 
JOIN t2 
ON t1.billing_country = t2.billing_country AND t1.total_bytes = t2.max_total_bytes 
ORDER BY 3 DESC;