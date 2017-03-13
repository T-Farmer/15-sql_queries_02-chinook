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

SELECT Employee.FirstName, Employee.LastName, Invoice
FROM Invoice
LEFT JOIN Customer ON Customer.CustomerId = Invoice.CustomerId
LEFT JOIN Employee ON Employee.EmployeeId = Customer.SupportRepId;

-- Provide a query that shows the Invoice Total, Customer name,
-- Country and Sale Agent name for all invoices and customers.
SELECT Invoice.Total, Invoice.CustomerId, Invoice.BillingCountry,
       Customer.FirstName, Customer.LastName, Customer.SupportRepId
FROM Invoice, Customer;
