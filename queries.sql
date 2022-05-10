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

-- What animals belong to Melody Pond?
SELECT name FROM owners JOIN animals ON owners.id= animals.owner_id WHERE full_name='Melody Pond';

-- List of all animals that are pokemon (their type is Pokemon).
SELECT animals.name FROM species JOIN animals ON  species.id = animals.species_id WHERE species.name = 'Pokemon';

-- List all owners and their animals, remember to include those that don't own any animal.
SELECT full_name,name FROM owners LEFT JOIN animals ON owners.id= animals.owner_id;

-- How many animals are there per species?
SELECT species.name, COUNT(animals.name) FROM species 
JOIN animals ON  species.id = animals.species_id GROUP BY species.name;

-- List all Digimon owned by Jennifer Orwell.
SELECT animals.name FROM owners JOIN animals ON owners.id= animals.owner_id 
JOIN species ON species.id = animals.species_id WHERE full_name='Jennifer Orwell' AND species.name = 'Digimon';

-- List all animals owned by Dean Winchester that haven't tried to escape.
SELECT name FROM owners JOIN animals ON owners.id= animals.owner_id WHERE full_name='Dean Winchester'
AND animals.escape_attempts = 0;

-- Who owns the most animals?
SELECT full_name FROM owners 
JOIN animals ON  owners.id = animals.owner_id GROUP BY full_name ORDER BY COUNT(name) DESC LIMIT 1; 

/*join tables*/

-- Who was the last animal seen by William Tatcher?
SELECT animals.name FROM animals JOIN visits ON animals.id = visits.animal_id 
JOIN vets ON vets.id = visits.vet_id WHERE vets.name = 'William Tatcher' 
ORDER BY visits.visit_date DESC LIMIT 1;

-- How many different animals did Stephanie Mendez see?
SELECT COUNT(animals.name) FROM animals JOIN visits ON animals.id = visits.animal_id 
JOIN vets ON vets.id = visits.vet_id WHERE vets.name = 'Stephanie Mendez';

-- List all vets and their specialties, including vets with no specialties.
SELECT vets.name,species.name FROM vets 
LEFT JOIN specializations ON vets.id = specializations.vet_id 
LEFT JOIN species ON species.id = specializations.species_id ORDER BY vets.id;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT animals.name FROM animals JOIN visits ON animals.id = visits.animal_id 
JOIN vets ON vets.id = visits.vet_id WHERE vets.name = 'Stephanie Mendez' 
AND visits.visit_date >= '2020-4-1' AND visits.visit_date <= '2020-8-30';

-- What animal has the most visits to vets?
SELECT animals.name FROM animals JOIN visits ON animals.id = visits.animal_id 
JOIN vets ON vets.id = visits.vet_id GROUP BY animals.name ORDER BY COUNT(vets.name) DESC LIMIT 1;

-- Who was Maisy Smith's first visit?
SELECT animals.name FROM animals JOIN visits ON animals.id = visits.animal_id 
JOIN vets ON vets.id = visits.vet_id WHERE vets.name = 'Maisy Smith' 
ORDER BY visits.visit_date LIMIT 1;

-- Details for most recent visit: animal information, vet information, and date of visit.
SELECT animals.*, visits.visit_date, vets.* FROM animals JOIN visits ON animals.id = visits.animal_id 
JOIN vets ON vets.id = visits.vet_id ORDER BY visits.visit_date DESC LIMIT 1;

-- How many visits were with a vet that did not specialize in that animal's species?
SELECT vets.name,COUNT(vets.name) AS num_of_visits FROM vets 
LEFT JOIN specializations ON vets.id = specializations.vet_id JOIN visits ON vets.id = visits.vet_id 
WHERE specializations.species_id IS NULL 
GROUP BY vets.name ORDER BY COUNT(vets.name) DESC;

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT species.name AS expected_specialty FROM animals JOIN visits ON animals.id = visits.animal_id 
JOIN vets ON vets.id = visits.vet_id JOIN species ON species.id = animals.species_id 
WHERE vets.name = 'Maisy Smith' GROUP BY species.name 
ORDER BY COUNT(DISTINCT animals.name) DESC LIMIT 1; 

SELECT COUNT(*) FROM visits where animal_id = 4;
SELECT * FROM visits where vet_id = 2;
SELECT * FROM owners where email = 'owner_18327@mail.com';

EXPLAIN ANALYZE SELECT COUNT(*) FROM visits WHERE animal_id = 4;
EXPLAIN ANALYZE SELECT * FROM visits WHERE vet_id = 2;
EXPLAIN ANALYZE SELECT * FROM owners WHERE email = 'owner_18327@mail.com';

\d visits;

EXPLAIN ANALYZE SELECT COUNT(*) FROM visits WHERE animal_id = 4;

\d visits;

EXPLAIN ANALYZE SELECT * FROM visits where vet_id = 2;

\d owners;

EXPLAIN ANALYZE SELECT * FROM owners where email = 'owner_18327@mail.com';