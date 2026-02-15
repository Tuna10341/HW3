SELECT ar.Name AS Artist,
       ROUND(SUM(ii.UnitPrice * ii.Quantity), 2) AS Revenue
FROM artists ar
JOIN albums al ON al.ArtistId = ar.ArtistId
JOIN tracks t ON t.AlbumId = al.AlbumId
JOIN invoice_items ii ON ii.TrackId = t.TrackId
GROUP BY ar.ArtistId
ORDER BY Revenue DESC
LIMIT 10;
