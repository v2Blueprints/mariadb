CREATE USER 'rma'@'localhost';  grant all ON *.* TO  'rma'@'localhost'  WITH GRANT OPTION;
CREATE USER 'root'@'localhost' identified by '^^root_password^^';  grant all ON *.* TO  'root'@'localhost'  WITH GRANT OPTION;
CREATE USER 'root'@'%' identified by '^^root_password^^';  grant all ON *.* TO  'root'@'%'  WITH GRANT OPTION;
