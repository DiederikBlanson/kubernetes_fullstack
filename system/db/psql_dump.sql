GRANT ALL PRIVILEGES ON DATABASE postgres TO postgresadmin;
CREATE TABLE Product (
  id INT NOT NULL UNIQUE,
  name VARCHAR(200) NOT NULL,
  PRIMARY KEY (id)
);

INSERT INTO Product VALUES (1,'iPhone X');
INSERT INTO Product VALUES (2,'iPhone 12');