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
GROUP BY InvoiceId

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
