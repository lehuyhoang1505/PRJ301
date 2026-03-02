-- =====================================================
-- Database setup script for PRJ301
-- Replace YOUR_DB with your actual database name
-- =====================================================

USE master;
GO

CREATE DATABASE PRJ301_ASSIGNMENT;
GO

USE PRJ301_ASSIGNMENT;
GO

-- ====== Users Table ======
CREATE TABLE Users
(
    userId      INT IDENTITY(1,1) PRIMARY KEY,
    username    NVARCHAR(50)  NOT NULL UNIQUE,
    password    NVARCHAR(50)  NOT NULL,
    role        NVARCHAR(10)  NOT NULL CHECK (role IN (N'admin', N'user')),
    name        NVARCHAR(100) NOT NULL,
    gender      NVARCHAR(10)  NOT NULL CHECK (gender IN (N'male', N'female', N'other')),
    dateOfBirth DATE          NOT NULL,
    phone       NVARCHAR(20)  NULL,
    email       NVARCHAR(100) NOT NULL UNIQUE
);
GO

-- ====== Sample Data ======
INSERT INTO Users (username, password, role, name, gender, dateOfBirth, phone, email) VALUES
    (N'admin', N'admin123', N'admin', N'Administrator', N'other', '2000-01-01', NULL,        N'admin@example.com'),
    (N'user1', N'user123',  N'user',  N'User One',      N'male',  '1995-05-15', N'0901000001', N'user1@example.com'),
    (N'user2', N'user123',  N'user',  N'User Two',      N'female','1998-09-20', N'0901000002', N'user2@example.com');
GO
