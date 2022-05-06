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

BEGIN;
UPDATE animals
SET species = 'unspecified';
SELECT * FROM animal;
ROLLBACK;

BEGIN;

UPDATE animals
SET species = 'digimon'
WHERE name LIKE '%mon%';
SELECT * FROM animal;


UPDATE animals
SET species = 'pokemon'
WHERE species IS NULL;
SELECT * FROM animal;


COMMIT;

BEGIN;

DELETE FROM animals;
SELECT * FROM animal;


ROLLBACK;

BEGIN;

DELETE FROM animals
WHERE date_of_birth >= '2022-1-1';
SELECT * FROM animal;

SAVEPOINT backup;

UPDATE animals
SET weight_kg = weight_kg * -1;
SELECT * FROM animal;

ROLLBACK TO backup;

UPDATE animals
SET weight_kg = weight_kg * -1;
WHERE weight_kg < 0 ;
SELECT * FROM animal;

COMMIT;

UPDATE animals
SET owner_id = 1
WHERE name ='Agumon';

UPDATE animals
SET owner_id = 2
WHERE name IN ('Gabumon','Pikachu');

UPDATE animals
SET owner_id = 3
WHERE name IN ('Devimon','Plantmon');

UPDATE animals
SET owner_id = 4
WHERE name IN ('Charmander','Squirtle','Blossom');

UPDATE animals
SET owner_id = 5
WHERE name IN ('Angemon','Boarmon');

UPDATE animals
SET species_id = 2
WHERE name LIKE '%mon';

UPDATE animals
SET species_id = 1
WHERE species_id IS NULL;