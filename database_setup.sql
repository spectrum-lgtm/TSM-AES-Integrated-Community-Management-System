-- ============================================
-- Taman Sinar Mahkota Residential Management System
-- Database Schema and Sample Data
-- ============================================

-- Create Database
CREATE DATABASE IF NOT EXISTS tsm_resident_ms;
USE tsm_resident_ms;

-- ============================================
-- Table: residents
-- Stores resident information and security questions
-- ============================================
CREATE TABLE IF NOT EXISTS residents (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    contact VARCHAR(50) NOT NULL,
    address TEXT NOT NULL,
    spouse VARCHAR(255),
    member1 VARCHAR(255),
    member2 VARCHAR(255),
    member3 VARCHAR(255),
    child1 VARCHAR(255),
    child2 VARCHAR(255),
    child3 VARCHAR(255),
    security_question VARCHAR(500) NOT NULL,
    security_answer VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ============================================
-- Table: admin
-- Stores admin login credentials
-- ============================================
CREATE TABLE IF NOT EXISTS admin (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    full_name VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ============================================
-- Table: events
-- Stores community events
-- ============================================
CREATE TABLE IF NOT EXISTS events (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    event_date VARCHAR(100) NOT NULL,
    venue VARCHAR(255) NOT NULL,
    image_path VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ============================================
-- Table: reports
-- Stores resident reports/complaints
-- ============================================
CREATE TABLE IF NOT EXISTS reports (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    contact VARCHAR(50) NOT NULL,
    address TEXT NOT NULL,
    report TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ============================================
-- Table: access_logs
-- Tracks resident login activity
-- ============================================
CREATE TABLE IF NOT EXISTS access_logs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    resident_name VARCHAR(255) NOT NULL,
    resident_email VARCHAR(255) NOT NULL,
    login_time DATETIME NOT NULL,
    activity VARCHAR(100) NOT NULL DEFAULT 'Login',
    ip_address VARCHAR(45),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ============================================
-- Table: admin_notifications
-- Tracks admin activity for resident transparency
-- ============================================
CREATE TABLE IF NOT EXISTS admin_notifications (
    id INT AUTO_INCREMENT PRIMARY KEY,
    type VARCHAR(50) NOT NULL DEFAULT 'access',
    admin_username VARCHAR(100) NOT NULL,
    resident_id INT DEFAULT NULL,
    message TEXT NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- ============================================
-- Table: admin_access_keys
-- Cross-admin verification keys for dual-control security
-- ============================================
CREATE TABLE IF NOT EXISTS admin_access_keys (
    id INT AUTO_INCREMENT PRIMARY KEY,
    admin_username VARCHAR(100) NOT NULL UNIQUE,
    access_password VARCHAR(255) NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- ============================================
-- Table: data_access_settings
-- Password for admin to decrypt resident data
-- ============================================
CREATE TABLE IF NOT EXISTS data_access_settings (
    id INT AUTO_INCREMENT PRIMARY KEY,
    access_password VARCHAR(255) NOT NULL,
    created_by VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Default data access password: DataAccess2026!
INSERT INTO data_access_settings (access_password, created_by) VALUES
('$2y$10$vI8aWBnW3fID.ZQ4/zo1G.q1lRps.9cGLcZEiGDMVr5yUP1KUOYTa', 'system');

-- ============================================
-- SAMPLE DATA
-- ============================================

-- Sample Residents (3 residents with security questions)
-- NOTE: Security answers are stored in lowercase for case-insensitive matching
INSERT INTO residents (name, email, contact, address, spouse, member1, member2, member3, child1, child2, child3, security_question, security_answer) VALUES
('Ahmad Hafiz bin Rahman', 'ahmad.hafiz@email.com', '012-3456789', 'No. 12, Jalan Sinar 1, Taman Sinar Mahkota', 'Siti Aishah binti Abdullah', 'Ahmad Faiz bin Ahmad Hafiz', '', '', 'Nurul Aina binti Ahmad Hafiz', '', '', 'What is your mother''s maiden name?', 'abdullah'),
('Lee Wei Ming', 'lee.weiming@email.com', '013-9876543', 'No. 25, Jalan Sinar 3, Taman Sinar Mahkota', 'Tan Mei Ling', '', '', '', 'Lee Xiao Wei', 'Lee Xiao Ming', '', 'What is your favourite colour?', 'blue'),
('Raj Kumar a/l Suresh', 'raj.kumar@email.com', '014-5551234', 'No. 38, Jalan Sinar 5, Taman Sinar Mahkota', 'Priya Devi', 'Kumar a/l Raj Kumar', '', '', '', '', '', 'What town/city were you born in?', 'kuala lumpur');

-- Sample Admin Accounts (2 admins)
-- NOTE: In production, passwords should be hashed. These are plain text for testing.
-- Password for both: admin123
INSERT INTO admin (username, password, full_name) VALUES
('admin1', 'admin123', 'Ahmad Fazril Bin Ghazalli'),
('admin2', 'admin123', 'Ahmad Danial Bin Ahmad Fazril');

-- Sample Events
INSERT INTO events (title, event_date, venue, image_path) VALUES
('Family Day', 'Tuesday, 12/12/2023', 'Pulau Pangkor, Perak', '../../images/familyday.jpg'),
('Maulidur Rasul', 'Wed & Thu, 27-28/12/2023', 'BMC Mall', '../../images/maulidurrasul.jpeg'),
('Happy New Year', 'Sunday, 1/01/2024', 'BMC Mall', '../../images/happynewyear.jpeg'),
('Malaysia Day', '16/09/2023', 'BMC Mall', '../../images/malaysiaday.jpg'),
('Open House', 'Saturday, 09/09/2023', 'Chairman''s House', '../../images/openhouse.jpeg');

-- Sample Reports
INSERT INTO reports (name, contact, address, report) VALUES
('Ahmad Hafiz bin Rahman', '012-3456789', 'No. 12, Jalan Sinar 1', 'Street light near house is not working. Please fix as soon as possible.'),
('Lee Wei Ming', '013-9876543', 'No. 25, Jalan Sinar 3', 'Rubbish collection was missed last week. Please arrange for collection.');

-- ============================================
-- NOTES
-- ============================================
-- Security Questions Available:
-- 1. What is your mother's maiden name?
-- 2. What is your favourite colour?
-- 3. What is your favourite food?
-- 4. When is your birthday?
-- 5. What town/city were you born in?
--
-- Sample Resident Credentials:
-- Resident 1: ahmad.hafiz@email.com | Security Q: What is your mother's maiden name? | A: abdullah
-- Resident 2: lee.weiming@email.com | Security Q: What is your favourite colour? | A: blue
-- Resident 3: raj.kumar@email.com | Security Q: What town/city were you born in? | A: kuala lumpur
--
-- Admin Credentials:
-- Admin 1: username=admin1 | password=admin123
-- Admin 2: username=admin2 | password=admin123
--
-- Data Access Password: DataAccess2026!

