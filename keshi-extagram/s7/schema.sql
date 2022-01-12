-- CREATE DATABASE extagram_db;
-- CREATE USER 'extagram_admin'@% IDENTIFIED BY 'pass123';
-- GRANT ALL PRIVILEGES ON extagram_db.* TO 'extagram_admin'@'%';
-- FLUSH PRIVILEGES;
CREATE TABLE IF NOT EXISTS posts(post TEXT, photourl TEXT);
