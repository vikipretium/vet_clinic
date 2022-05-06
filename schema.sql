/* Database schema to keep the structure of entire database. */

CREATE TABLE animals(id INT GENERATED ALWAYS AS IDENTITY,
 name varchar(100) NOT NULL,
 data_of_birth DATE NOT NULL,
 escape_attempts INT NOT NULL,
 neutered BOOLEAN NOT NULL,
 weight_kg DECIMAL NOT NULL,
 PRIMARY KEY (id)
 );

ALTER TABLE animals
ADD COLUMN species varchar(20);