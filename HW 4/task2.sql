CREATE TABLE petPet (
    petname VARCHAR(20) PRIMARY KEY,
    owner VARCHAR(45) NOT NULL,
    species CHAR(1) CHECK (species IN ('M', 'F')),
    gender VARCHAR(15),
    birth DATE,
    death DATE
);

CREATE TABLE petEvent (
    petname VARCHAR(20),
    eventdate DATE NOT NULL,
    eventtype VARCHAR(45),
    remark VARCHAR(255),
    PRIMARY KEY (petname, eventdate), -- Composite primary key
    FOREIGN KEY (petname) REFERENCES petPet(petname)
);