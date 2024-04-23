CREATE TABLE Banks (
    bank_name VARCHAR(100) NOT NULL,
    city VARCHAR(100) NOT NULL,
    no_accounts INT CHECK (no_accounts > 0),
    sec_level VARCHAR(20) CHECK (sec_level IN ('weak', 'good', 'very good', 'excellent')),
    PRIMARY KEY (bank_name, city)
);

CREATE TABLE Robberies (
    bank_name VARCHAR(20) NOT NULL,
    city VARCHAR(20) NOT NULL,
    date_robbed DATE NOT NULL,
    amount DECIMAL(20, 2),
    PRIMARY KEY (bank_name, city, date_robbed),
    FOREIGN KEY (bank_name, city) REFERENCES Banks(bank_name, city)
);

CREATE TABLE RobberyPlans (
    bank_name VARCHAR(20) NOT NULL,
    city VARCHAR(20) NOT NULL,
    no_robbers INT CHECK (no_robbers >= 1),
    planned_date DATE NOT NULL,
    PRIMARY KEY (bank_name, city, planned_date),
    FOREIGN KEY (bank_name, city) REFERENCES Banks(bank_name, city)
);

CREATE TABLE Robbers (
    robber_id SERIAL PRIMARY KEY,
    nickname VARCHAR(20),
    age INT CHECK (age >= 0),
    no_years INT CHECK (no_years >= 0)
);

CREATE TABLE Skills (
    skill_id SERIAL PRIMARY KEY,
    description VARCHAR(20) NOT NULL UNIQUE
);

CREATE TABLE HasSkills (
    robber_id INT NOT NULL,
    skill_id INT NOT NULL,
    preference INT CHECK (preference >= 1 AND preference <= 3),
    grade CHAR(2) CHECK (grade IN ('A+', 'A', 'A-', 'B+', 'B', 'B-', 'C+', 'C', 'C-', 'D', 'E', 'F', 'K', 'P', 'G', 'J', 'L', 'Z')),
    PRIMARY KEY (robber_id, skill_id),
    FOREIGN KEY (robber_id) REFERENCES Robbers(robber_id),
    FOREIGN KEY (skill_id) REFERENCES Skills(skill_id)
);

CREATE TABLE HasAccounts (
    robber_id INT,
    bank_name VARCHAR(20),
    city VARCHAR(20),
    PRIMARY KEY (robber_id, bank_name, city),
    FOREIGN KEY (robber_id) REFERENCES Robbers(robber_id),
    FOREIGN KEY (bank_name, city) REFERENCES Banks(bank_name, city)
);

CREATE TABLE Accomplices (
    robber_id INT,
    bank_name VARCHAR(20),
    city VARCHAR(20),
    date_robbed DATE,
    robbery_share DECIMAL(10,2) CHECK (robbery_share >= 0),
    PRIMARY KEY (robber_id, bank_name, city, date_robbed),
    FOREIGN KEY (robber_id) REFERENCES Robbers(robber_id),
    FOREIGN KEY (bank_name, city, date_robbed) REFERENCES Robberies(bank_name, city, date_robbed) ON DELETE CASCADE ON UPDATE CASCADE
);
