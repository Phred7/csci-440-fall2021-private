
-- Inner join
SELECT tracks.name as TrackName, albums.title as AlbumTitle
FROM tracks
JOIN albums on tracks.AlbumId = albums.AlbumId
WHERE albums.Title = "Machine Head";


-- Outer join
SELECT name as ArtistName, Title as AlbumTitle
FROM artists
         LEFT OUTER JOIN albums on artists.ArtistId = albums.ArtistId;


-- Self join
SELECT employees.FirstName as FirstName,
       employees.EmployeeId as EmployeeId,
       bosses.FirstName as BossFirstName,
       bosses.EmployeeId as BossEmployeeId
FROM employees
JOIN employees AS bosses ON employees.ReportsTo = bosses.EmployeeId;


SELECT *
FROM albums
    CROSS JOIN artists;

SELECT
    tracks.Name as TrackName, Title, artists.Name as ArtistsName
FROM
     tracks
    JOIN albums
     ON tracks.AlbumId = albums.AlbumId
    JOIN artists
     ON albums.ArtistId = artists.ArtistId
WHERE artists.name = "AC/DC";

CREATE VIEW tracksPlus AS SELECT tracks.*, genres.Name as GenreName, artists.Name as ArtistName FROM tracks JOIN genres ON genres.GenreId = tracks.GenreId JOIN albums ON tracks.AlbumId = albums.AlbumId JOIN artists ON albums.ArtistId = artists.ArtistId;

create table grammy_categories(GrammyCategoryId INTEGER, Name NVARCHAR(160));
create table grammy_infos(ArtistId INTEGER, AlbumId INTEGER, TrackId INTEGER, GrammyCategoryId INTEGER, Status NVARCHAR(160));
INSERT INTO grammy_categories(Name) VALUES ('Greatest Ever');
INSERT INTO grammy_infos(ArtistId, AlbumId, TrackId, GrammyCategoryId, Status) VALUES (1, 1, 1, (SELECT GrammyCategoryId FROM grammy_categories),'Won');

SELECT customers.* FROM customers WHERE (CustomerId + SupportRepId) > 10;

BEGIN TRANSACTION;
ALTER TABLE customers
ADD COLUMN TotalFruit INTEGER;
UPDATE customers
SET TotalFruit=(SupportRepId + customers.CustomerId);
COMMIT;