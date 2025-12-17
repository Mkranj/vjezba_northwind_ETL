IF DB_ID('northwind') IS NULL
BEGIN
    PRINT 'Creating Northwind database'
    :r /opt/sql/instnwnd.sql
END
ELSE
BEGIN
    PRINT 'Northwind already exists, skipping install'
END
GO