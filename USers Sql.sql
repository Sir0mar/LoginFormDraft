
IF OBJECT_ID('dbo.Users', 'U') IS NOT NULL
    DROP TABLE dbo.Users;
GO

-- Create the Users table
CREATE TABLE dbo.Users
(
    UserId INT IDENTITY(1,1) PRIMARY KEY,
    UserName NVARCHAR(50) NOT NULL,
    Email NVARCHAR(100) NOT NULL,
    Password NVARCHAR(50) NOT NULL,
    Role NVARCHAR(50) NOT NULL
);
GO

-- Insert sample data into the Users table
INSERT INTO dbo.Users (UserName, Email, Password, Role)
VALUES 
('admin', 'admin@example.com', 'Admin123!', 'Admin'),
('manager', 'manager@example.com', 'Manager123!', 'Manager'),
('chef', 'chef@example.com', 'Chef123!', 'Chef'),
('coordinator', 'coordinator@example.com', 'Coordinator123!', 'Reservation Coordinator'),
('customer', 'customer@example.com', 'Customer123!', 'Customer');
GO

-- Create a stored procedure for login
CREATE PROCEDURE dbo.LoginUser
    @UserName NVARCHAR(50),
    @Password NVARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (SELECT 1 FROM dbo.Users WHERE UserName = @UserName AND Password = @Password)
    BEGIN
        SELECT UserId, UserName, Email, Role 
        FROM dbo.Users
        WHERE UserName = @UserName AND Password = @Password;
    END
    ELSE
    BEGIN
        SELECT 'Invalid username or password' AS Message;
    END
END
GO
