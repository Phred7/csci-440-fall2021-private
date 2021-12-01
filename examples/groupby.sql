

-- Select all AlbumID FKs from the tracks table
SELECT AlbumID
FROM tracks
GROUP BY AlbumID;

-- Select all AlbumID FKs from the tracks table
SELECT DISTINCT AlbumID
FROM tracks;

-- Select all AlbumID FKs from the tracks table
SELECT AlbumID, COUNT(*)
FROM tracks
GROUP BY AlbumID;

-- Select all AlbumID FKs from the tracks table
SELECT AlbumID, COUNT(*) as TrackCount
FROM tracks
GROUP BY AlbumID;

-- Select all AlbumID FKs from the tracks table
SELECT tracks.AlbumID, Title, COUNT(*) as TrackCount
FROM tracks
JOIN albums on tracks.AlbumId = albums.AlbumId
GROUP BY tracks.AlbumID;

-- Calculate run time of albums by summing the tracks
SELECT tracks.AlbumID, Title,
       SUM(tracks.Milliseconds) as Milliseconds
FROM tracks
JOIN albums on tracks.AlbumId = albums.AlbumId
GROUP BY tracks.AlbumID;

-- Calculate run time of artists by summing the tracks
SELECT artists.Name,
       SUM(tracks.Milliseconds) as Milliseconds
FROM tracks
JOIN albums on tracks.AlbumId = albums.AlbumId
JOIN artists on albums.ArtistId = artists.ArtistId
GROUP BY albums.ArtistId;


-- Calculate run time of artists by summing the tracks
SELECT artists.Name,
       COUNT(tracks.TrackId) as Tracks,
       COUNT(albums.AlbumId) as Albums,
       SUM(tracks.Milliseconds) as Milliseconds
FROM tracks
JOIN albums on tracks.AlbumId = albums.AlbumId
JOIN artists on albums.ArtistId = artists.ArtistId
GROUP BY albums.ArtistId;


-- Simple Join to show the rows
SELECT TrackId, albums.AlbumId, artists.ArtistId
FROM tracks
         JOIN albums on tracks.AlbumId = albums.AlbumId
         JOIN artists on albums.ArtistId = artists.ArtistId;

-- Calculate run time of artists by summing the tracks
SELECT artists.Name,
       COUNT(tracks.TrackId) as Tracks,
       COUNT(DISTINCT albums.AlbumId) as Albums,
       SUM(tracks.Milliseconds) as Milliseconds
FROM tracks
         JOIN albums on tracks.AlbumId = albums.AlbumId
         JOIN artists on albums.ArtistId = artists.ArtistId
GROUP BY albums.ArtistId;

SELECT artists.Name,
       COUNT(tracks.TrackId) as Tracks,
       COUNT(DISTINCT albums.AlbumId) as Albums,
       SUM(tracks.Milliseconds) as Milliseconds
FROM tracks
         JOIN albums on tracks.AlbumId = albums.AlbumId
         JOIN artists on albums.ArtistId = artists.ArtistId
GROUP BY albums.ArtistId
HAVING Tracks >= 10;

SELECT artists.Name,
       COUNT(tracks.TrackId) as Tracks,
       COUNT(DISTINCT albums.AlbumId) as Albums,
       SUM(tracks.Milliseconds) as Milliseconds
FROM tracks
         JOIN albums on tracks.AlbumId = albums.AlbumId
         JOIN artists on albums.ArtistId = artists.ArtistId
GROUP BY albums.ArtistId
HAVING Tracks >= 10 AND tracks.Name LIKE "A%";

SELECT artists.Name,
       COUNT(tracks.TrackId) as Tracks,
       COUNT(DISTINCT albums.AlbumId) as Albums,
       SUM(tracks.Milliseconds) as Milliseconds   
FROM tracks
         JOIN albums on tracks.AlbumId = albums.AlbumId
         JOIN artists on albums.ArtistId = artists.ArtistId
WHERE tracks.Name LIKE "A%"
GROUP BY albums.ArtistId
HAVING Tracks > 2;

SELECT SUM(invoices.Total) as SalesTotal, COUNT(InvoiceId) as SalesCount, e.FirstName, e.LastName ,e.Email
FROM invoices
        JOIN customers c on invoices.CustomerId = c.CustomerId
        JOIN employees e on c.SupportRepId = e.EmployeeId
GROUP BY EmployeeId;

SELECT COUNT(InvoiceId) as NumberSales, e.Email
FROM invoices
         JOIN customers c on invoices.CustomerId = c.CustomerId
         JOIN employees e on c.SupportRepId = e.EmployeeId
GROUP BY EmployeeId;


-- Calculate run time of artists by summing the tracks
SELECT artists.Name,
       SUM(tracks.Milliseconds) as Milliseconds
FROM tracks
         JOIN albums on tracks.AlbumId = albums.AlbumId
         JOIN artists on albums.ArtistId = artists.ArtistId
GROUP BY albums.ArtistId;

-- Select tracks that have been sold more than once (> 1)
SELECT tracks.TrackId
FROM tracks
    JOIN invoice_items ii on tracks.TrackId = ii.TrackId
GROUP BY ii.TrackId
HAVING count(ii.InvoiceId) > 1;


-- Select the albums that have tracks that have been sold more than once (> 1)




