#production like
CREATE USER 'devday'@'%.devday_default' IDENTIFIED BY 'devday';
GRANT ALL PRIVILEGES ON devday_development.* TO 'devday'@'%.devday_default';
GRANT ALL PRIVILEGES ON devday_test.* TO 'devday'@'%.devday_default';
#support host connections (insecure on production)
CREATE USER 'devday'@'%' IDENTIFIED BY 'devday';
GRANT ALL PRIVILEGES ON devday_development.* TO 'devday'@'%';
GRANT ALL PRIVILEGES ON devday_test.* TO 'devday'@'%';
FLUSH PRIVILEGES;
