/*WHO ARE THE TOP EARNING ARTIST IN EACH GENRE?*/
WITH t1 AS (SELECT	a.Name artist_name, 
					g.Name genre_name, 
					SUM(il.UnitPrice*il.Quantity) total_earning
				FROM Artist AS a 
				JOIN Album AS ab ON (a.ArtistId = ab.ArtistId)
				JOIN Track AS t ON (t.AlbumId = ab.AlbumId)
				JOIN Genre AS g ON (g.GenreId = t.GenreId)
				JOIN InvoiceLine AS il ON (t.UnitPrice = il.UnitPrice)
				GROUP BY 1, 2),
	t2 AS (SELECT	genre_name, 
					MAX(total_earning) total_earning
				FROM t1
           GROUP BY 1)
		   
SELECT	t1.artist_name,
		t2.genre_name,
		t2.total_earning
FROM t2 
JOIN t1 
ON t1.genre_name = t2.genre_name AND t1.total_earning = t2.total_earning
ORDER BY 3 DESC;
		

