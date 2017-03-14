-- Provide a query showing Customers
-- (just their full names, customer ID and country) who are not in the US.

SELECT FirstName, LastName, CustomerId, Country
FROM   Customer
WHERE  Country != 'USA';

-- Provide a query only showing the Customers from Brazil.

SELECT FirstName, LastName, CustomerId, Country
FROM   Customer
WHERE  Country = 'Brazil';

-- Provide a query showing the Invoices of customers who are from Brazil.
-- The resultant table should show
-- the customer's full name, Invoice ID, Date of the invoice and billing country.

SELECT Customer.FirstName, Customer.LastName, Invoice.InvoiceId, Invoice.InvoiceDate,
       Invoice.BillingCountry
FROM   Customer, Invoice
ON     Customer.CustomerId = Invoice.CustomerId
WHERE  Customer.Country = 'Brazil';

-- Provide a query showing only the Employees who are Sales Agents.

SELECT Employee.FirstName, Employee.LastName, Employee.Title
FROM Employee
WHERE Title LIKE 'Sales% %Agent';

-- Provide a query showing a unique list of billing countries from the Invoice table

SELECT DISTINCT Invoice.BillingCountry
FROM Invoice;

-- Provide a query showing the invoices of customers who are from Brazil.

SELECT *
FROM Invoice
WHERE BillingCountry = 'Brazil';

-- ?Provide a query that shows the invoices associated with each sales agent.
-- ?The resultant table should include the Sales Agent's full name.

SELECT Employee.FirstName, Employee.LastName
FROM Invoice
LEFT JOIN Customer ON Customer.CustomerId = Invoice.CustomerId
LEFT JOIN Employee ON Employee.EmployeeId = Customer.SupportRepId;

-- Provide a query that shows the Invoice Total, Customer name,
-- Country and Sale Agent name for all invoices and customers.

SELECT Invoice.Total, Invoice.CustomerId, Invoice.BillingCountry,
       Customer.FirstName, Customer.LastName, Customer.SupportRepId
FROM   Invoice, Customer;
LEFT JOIN Customer ON Customer.CustomerId = Invoice.CustomerId
LEFT JOIN Employee ON Employee.EmployeeId = Customer.SupportRepId;

-- How many Invoices were there in 2009 and 2011?
-- What are the respective total sales for each of those years?

SELECT COUNT(InvoiceId) AS 'Total Sales', SUM(Total)
FROM Invoice
WHERE substr (InvoiceDate, 1, 4) = '2009'
OR substr (InvoiceDate, 1, 4) = '2011'
GROUP BY substr (InvoiceDate, 1, 4);

-- Looking at the InvoiceLine table, provide a query that COUNTs
-- the number of line items for each Invoice.
-- HINT: GROUP BY

SELECT COUNT(InvoiceId)
FROM InvoiceLine
GROUP BY InvoiceId;

-- Provide a query that shows the total number of tracks in each playlist.
-- The Playlist name should be included on the resultant table.

SELECT InvoiceLine.InvoiceLineId, Track.Name
FROM InvoiceLine, Track
WHERE InvoiceLine.TrackId = Track.GenreId;

-- Provide a query that includes the purchased track name AND artist name
-- with each invoice line item.

SELECT InvoiceLine.InvoiceLineId, Track.Name, Artist.Name
FROM InvoiceLine
LEFT JOIN Track ON InvoiceLine.TrackId = Track.TrackId
LEFT JOIN Album ON Album.AlbumId = Track.AlbumId
LEFT JOIN Artist ON Artist.ArtistId = Album.ArtistId;

-- Provide a query that shows the # of invoices per country. HINT: GROUP BY

SELECT COUNT(InvoiceId) AS 'Invoices Per Country', BillingCountry
FROM Invoice
GROUP BY BillingCountry;

-- Provide a query that shows the total number of tracks in each playlist.
-- The Playlist name should be included on the resultant table

SELECT Playlist.Name, COUNT(PlaylistTrack.PlaylistId)
FROM PlaylistTrack
LEFT JOIN Playlist ON PlaylistTrack.PlaylistId = Playlist.PlaylistId
GROUP BY PlaylistTrack.PlaylistId;

--Provide a query that shows all the Tracks, but displays no IDs.
-- The resultant table should include the Album name, Media type and Genre

SELECT Track.Name AS "Song Name", Album.Title AS "Album Title", MediaType.Name AS "Media Type", Genre.Name AS Genre
FROM Track
LEFT JOIN Album ON Album.AlbumID = Track.AlbumId
LEFT JOIN MediaType ON MediaType.MediaTypeId = Track.MediaTypeId
LEFT JOIN Genre ON Genre.GenreId = Track.GenreId;

--Provide a query that shows all Invoices but includes the # of invoice line items.

SELECT Invoice.*, COUNT(InvoiceLine.InvoiceId)
FROM Invoice
LEFT JOIN InvoiceLine ON InvoiceLine.InvoiceId = Invoice.InvoiceId
GROUP BY Invoice.InvoiceId;

--Provide a query that shows total sales made by each sales agent

SELECT SUM(Invoice.Total)
FROM Invoice
LEFT JOIN Customer ON Invoice.CustomerId = Customer.CustomerId
LEFT JOIN Employee ON Employee.EmployeeId = Customer.SupportRepId
GROUP BY Employee.EmployeeId;

-- Which sales agent made the most in sales in 2009?

SELECT SUM(Invoice.Total), Employee.FirstName, Employee.LastName
FROM Invoice
LEFT JOIN Customer ON Invoice.CustomerId = Customer.CustomerId
LEFT JOIN Employee ON Employee.EmployeeId = Customer.SupportRepId
WHERE substr (InvoiceDate, 1,4) = "2009"
GROUP BY Employee.EmployeeId
ORDER BY Invoice.Total DESC;

--Which sales agent made the most in sales in 2010?

SELECT SUM(Invoice.Total), Employee.FirstName, Employee.LastName
FROM Invoice
LEFT JOIN Customer ON Invoice.CustomerId = Customer.CustomerId
LEFT JOIN Employee ON Employee.EmployeeId = Customer.SupportRepId
WHERE substr (InvoiceDate, 1,4) = "2010"
GROUP BY Employee.EmployeeId
ORDER BY Invoice.Total DESC;

-- Which sales agent made the most in sales over all?

SELECT SUM(Invoice.Total), Employee.FirstName, Employee.LastName
FROM Invoice
LEFT JOIN Customer ON Invoice.CustomerId = Customer.CustomerId
LEFT JOIN Employee ON Employee.EmployeeId = Customer.SupportRepId
GROUP By Employee.EmployeeId
ORDER BY Invoice.Total;

--Provide a query that shows the # of customers assigned to each sales agent.

SELECT COUNT(Customer.SupportRepId), Employee.FirstName, Employee.LastName
FROM Customer
LEFT JOIN Employee ON Employee.EmployeeId = Customer.SupportRepId
GROUP BY Employee.EmployeeId;

--Provide a query that shows the total sales per country.
-- Which country's customers spent the most?

SELECT SUM(Total) AS TotalSales, BillingCountry
FROM Invoice
GROUP BY BillingCountry
ORDER BY TotalSales DESC;

--Provide a query that shows the most purchased track of 2013.
SELECT COUNT(InvoiceLine.TrackId)
FROM Track, InvoiceLine, Invoice
ON Invoice.InvoiceId = InvoiceLine.InvoiceId
AND Track.TrackId = InvoiceLine.TrackId
WHERE substr(InvoiceDate, 1,4) = "2013"
GROUP BY Track.Name
ORDER BY (COUNT(InvoiceLine.TrackId)) DESC;

--Provide a query that shows the top 5 most purchased tracks over all.
SELECT SUM(Quantity), TrackId
FROM InvoiceLine
GROUP BY TrackId
ORDER BY SUM(Quantity) DESC
LIMIT 5;

--Provide a query that shows the top 3 best selling artists.
SELECT SUM(InvoiceLine.Quantity), InvoiceLine.TrackId, Artist.Name
FROM InvoiceLine
LEFT JOIN Track ON Track.TrackId = InvoiceLine.TrackId
LEFT JOIN Album ON Album.AlbumId = Track.AlbumId
LEFT JOIN Artist ON Artist.ArtistId = Album.ArtistId
GROUP BY Artist.Name
ORDER BY SUM(InvoiceLine.Quantity) DESC
LIMIT 3;

--Provide a query that shows the most purchased Media Type.
SELECT SUM(InvoiceLine.Quantity), MediaType.Name
FROM InvoiceLine
LEFT JOIN Track ON Track.TrackId = InvoiceLine.TrackId
LEFT JOIN MediaType ON MediaType.MediaTypeId = Track.MediaTypeId
GROUP BY MediaType.Name
ORDER BY SUM(InvoiceLine.Quantity) DESC;
