SELECT name FROM tracks
WHERE AlbumId=(SELECT AlbumId from albums WHERE Title="Machine Head");

SELECT AlbumId, Title from albums WHERE Title LIKE "A%";

SELECT name FROM tracks
WHERE AlbumId=(SELECT AlbumId from albums WHERE Title LIKE "A%");


SELECT name FROM tracks
WHERE AlbumId IN (SELECT AlbumId from albums WHERE Title LIKE "A%");

-- Select all albums with a total size over 1Mb
SELECT title
FROM albums
WHERE 10000000 > (SELECT SUM(bytes)
    FROM tracks
WHERE tracks.AlbumId = albums.AlbumId) ;

SELECT SUM(bytes)
FROM tracks
WHERE tracks.AlbumId = 1;

-- Denormalized query
SELECT title
FROM albums
WHERE 10000000 > albums.bytes;

-- Move condition into subquery
SELECT Name from artists where
ArtistId IN
(SELECT albums.ArtistId
FROM albums
WHERE albums.AlbumId IN
      (SELECT AlbumId FROM tracks
       GROUP BY AlbumId
    HAVING  10000000 > SUM(tracks.Bytes)));


-- Gets all first album where artist has more than one album
SELECT *
FROM albums
GROUP BY ArtistId
HAVING COUNT(*) > 1;

-- returns all artists that have more than one album
SELECT Name
FROM albums
JOIN artists on artists.ArtistId = albums.ArtistId
GROUP BY albums.ArtistId
HAVING COUNT(*) > 1;

-- returns all tracks longer than six minutes along with the album and artist name
SELECT tracks.Name as TrackName, albums.Title as AlbumTitle, artists.Name as ArtistsName
FROM tracks
JOIN albums ON tracks.AlbumId = albums.AlbumId
JOIN artists ON albums.ArtistId = artists.ArtistId
WHERE tracks.Milliseconds > 6 * 60 * 1000;

-- Inserts these new artists into the artists table with Name
INSERT INTO artists (Name)
VALUES
("Ricky Skagg's"),
("-Steve''n''Seagulls"),
("Earl Skruggs");

-- Deletes all rows from artists
DELETE FROM artists
WHERE 1=1;


-- returns all artists that have more than 2 albums
SELECT artists.Name, COUNT(DISTINCT tracks.TrackID) as tracks
FROM albums
JOIN artists on artists.ArtistId = albums.ArtistId
JOIN tracks on tracks.AlbumId = albums.AlbumId
GROUP BY albums.ArtistId
HAVING COUNT(*) > 2;

-- Return second page of 10 results form the tracks table, in descending order by price then ascending by track name
SELECT *
FROM tracks
ORDER BY tracks.UnitPrice DESC,
         tracks.Name ASC
LIMIT 10
OFFSET 10;

--
SELECT employees.FirstName, employees.LastName, employees.Title, bosses.FirstName
FROM employees
JOIN employees AS bosses ON employees.ReportsTo = bosses.EmployeeId
WHERE bosses.FirstName = "Andrew" and bosses.LastName = "Adams";

SELECT e.FirstName, e.LastName, e.Title, e.ReportsTo, COUNT(CustomerId) as number_of_customers
FROM customers
JOIN employees e on e.EmployeeId = customers.SupportRepId
GROUP BY e.EmployeeId
HAVING ;

SELECT e.FirstName, e.LastName, e.Title, COUNT(distinct CustomerId) AS NumberOfCustomers
FROM (customers
         INNER JOIN Employees as e ON customers.SupportRepId = e.EmployeeID)
GROUP BY e.ReportsTo;

SELECT tracks.Name, g.Name
FROM tracks
JOIN genres g on g.GenreId = tracks.GenreId
WHERE g.Name LIKE "Ro%";

