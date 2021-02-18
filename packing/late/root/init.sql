
UPDATE mysql.user SET Password=PASSWORD('^^configuration.root_password^^') WHERE User='root';
DELETE FROM mysql.user WHERE User='';


#user with rights to create
CREATE USER 'root'@'localhost';  grant all ON *.* TO  'root'@'localhost'  WITH GRANT OPTION;
FLUSH PRIVILEGES;
