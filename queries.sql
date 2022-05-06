/*Queries that provide answers to the questions from all projects.*/

-- Find all animals whose name ends in "mon".
SELECT * FROM animals WHERE name LIKE '%mon%';

-- List the name of all animals born between 2016 and 2019.
SELECT * FROM animals WHERE date_of_birth BETWEEN '2016-1-1' AND '2019-12-31';

-- List the name of all animals that are neutered and have less than 3 escape attempts.
SELECT * FROM animals WHERE neutered = true AND escape_attempts < 3;

-- List date of birth of all animals named either "Agumon" or "Pikachu".
SELECT * FROM animals WHERE name IN ('Agumon', 'Pikachu');

-- List name and escape attempts of animals that weigh more than 10.5kg
SELECT name,escape_attempts FROM animals WHERE weight_kg > 10.5;

-- Find all animals that are neutered.
SELECT * FROM animals WHERE neutered = true;

-- Find all animals not named Gabumon.
SELECT * FROM animals WHERE NOT name  = 'Gabumon';

-- Find all animals with a weight between 10.4kg and 17.3kg (including the animals with the weights that equals precisely 10.4kg or 17.3kg)
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

-- How many animals are there?
SELECT COUNT(*) FROM animals;

-- How many animals have never tried to escape?
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0; 

-- What is the average weight of animals?
SELECT AVG(weight_kg) AS average FROM animals;

-- Who escapes the most, neutered or not neutered animals?
SELECT neutered, COUNT(escape_attempts) AS count FROM animals WHERE escape_attempts > 0 GROUP BY neutered;

-- What is the minimum and maximum weight of each type of animal?
SELECT species,MIN(weight_kg),MAX(weight_kg) FROM animals GROUP BY species;

-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT species, AVG(escape_attempts) FROM animals WHERE date_of_birth >= '1990-1-1' 
AND date_of_birth <= '2000-12-31' GROUP BY species; 

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