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


CREATE TABLE owners (
 id INT GENERATED ALWAYS AS IDENTITY,
 full_name varchar(100) NOT NULL,
 age SMALLINT NOT NULL,
 PRIMARY KEY (id)
);

CREATE TABLE species (
 id INT GENERATED ALWAYS AS IDENTITY,
 name varchar(100) NOT NULL,
 PRIMARY KEY (id)
);

ALTER TABLE animal
DROP COLUMN species;

ALTER TABLE animals
ADD COLUMN species_id INT,
ADD FOREIGN KEY (species_id) REFERENCES species (id)
ON DELETE CASCADE;

ALTER TABLE animals
ADD COLUMN owner_id INT,
ADD FOREIGN KEY (owner_id) REFERENCES owners (id)
ON DELETE CASCADE;

