INSERT INTO petEvent VALUES
    ('Fluffy', '2020-10-15', 'vet', 'antibiotics');

INSERT INTO petPet VALUES
    ('Hammy', 'Diane', 'hamster', 'M', '2010-10-30', NULL);

INSERT INTO petEvent VALUES
    ('Hammy', '2020-10-15', 'vet', 'antibiotics');

UPDATE petEvent
SET remark = '5 kittens, 2 male, 3 female'
WHERE petname = 'Fluffy' AND eventdate = '1995-05-15' AND eventtype = 'litter';

UPDATE petEvent
SET petname = 'Claws'
WHERE petname = 'Slim' AND eventdate = '1997-08-03' AND eventtype = 'vet';

UPDATE petPet
SET death = '2020-09-01'
WHERE petname = 'Puffball';

DELETE FROM petPet
WHERE owner = 'Harold' AND species = 'dog';