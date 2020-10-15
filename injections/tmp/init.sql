#Taken from secure_installation in distribution
UPDATE mysql.user SET Password=PASSWORD('^^root_password^^') WHERE User='root';
DELETE FROM mysql.user WHERE User='';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
FLUSH PRIVILEGES;