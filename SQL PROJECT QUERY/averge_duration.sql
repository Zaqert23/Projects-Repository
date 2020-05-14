/* What is the avegare duration in minutes for each album.*/
SELECT ab.AlbumId Album_ID, ab.Title Album_title, AVG(t.Milliseconds/60000) Avg_length
FROM album ab
JOIN Track t 
ON t.AlbumId = ab.AlbumId
GROUP BY 1, 2 
ORDER BY 3 DESC
LIMIT 20;