-- Create BDD theater_bdd
CREATE DATABASE IF NOT EXISTS kgb_bdd CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

-- Use the newly create BDD
USE kgb_bdd;

-- Create tables
CREATE TABLE admin (
    id_admin INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
    admin_first_name VARCHAR(30) NOT NULL,
    admin_last_name VARCHAR(30) NOT NULL,
    admin_email VARCHAR(254) NOT NULL,
    admin_password VARCHAR(60) NOT NULL,
    admin_creation DATE NOT NULL
)engine=INNODB;

CREATE TABLE specialty (
    id_specialty INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
    specialty_code_name VARCHAR(20) NOT NULL,
    specialty_type VARCHAR(20) NOT NULL
)engine=INNODB;

CREATE TABLE mission (
    id_mission INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
    mission_title VARCHAR(100) NOT NULL,
    mission_code_name VARCHAR(20) NOT NULL,
    mission_description VARCHAR(255) NOT NULL,
    mission_country VARCHAR(20) NOT NULL,
    mission_type VARCHAR(20) NOT NULL,
    mission_statut VARCHAR(20) NOT NULL,
    mission_start_date DATE NOT NULL,
    mission_end_date DATE NOT NULL,
    mission_specialty_id_fk INT(11) NOT NULL,
    CONSTRAINT fk_mission_specialty FOREIGN KEY (mission_specialty_id_fk) REFERENCES specialty(id_specialty) ON DELETE CASCADE
)engine=INNODB;

CREATE TABLE agent (
    id_agent INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
    agent_first_name VARCHAR(30) NOT NULL,
    agent_last_name VARCHAR(30) NOT NULL,
    agent_birth_date DATE NOT NULL,
    agent_code_name VARCHAR(20) NOT NULL,
    agent_nationality VARCHAR(40) NOT NULL
)engine=INNODB;

CREATE TABLE target (
    id_target INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
    target_first_name VARCHAR(30) NOT NULL,
    target_last_name VARCHAR(30) NOT NULL,
    target_birth_date DATE NOT NULL,
    target_code_name VARCHAR(20) NOT NULL,
    target_nationality VARCHAR(40) NOT NULL
)engine=INNODB;

CREATE TABLE contact (
    id_contact INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
    contact_first_name VARCHAR(30) NOT NULL,
    contact_last_name VARCHAR(30) NOT NULL,
    contact_birth_date DATE NOT NULL,
    contact_code_name VARCHAR(20) NOT NULL,
    contact_nationality VARCHAR(40) NOT NULL
)engine=INNODB;

CREATE TABLE hideout (
    id_hideout INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
    hideout_code_name VARCHAR(20) NOT NULL,
    hideout_country VARCHAR(40),
    hideout_address VARCHAR(100),
    hideout_city VARCHAR(20),
    hideout_type VARCHAR(20)
)engine=INNODB;


CREATE TABLE agent_mission (
    id_agent_mission INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
    agent_id_fk INT(11) NOT NULL,
    mission_agent_id_fk INT(11) NOT NULL,
    CONSTRAINT fk_agent FOREIGN KEY (agent_id_fk) REFERENCES agent(id_agent) ON DELETE CASCADE,
    CONSTRAINT fk_mission_agent FOREIGN KEY (mission_agent_id_fk) REFERENCES mission(id_mission) ON DELETE CASCADE
) ENGINE=INNODB;

CREATE TABLE agent_specialty (
    id_agent_specialty INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
    agent_specialty_id_fk INT(11) NOT NULL,
    specialty_agent_id_fk INT(11) NOT NULL,
    CONSTRAINT fk_agent_specialty FOREIGN KEY (agent_specialty_id_fk) REFERENCES agent(id_agent) ON DELETE CASCADE,
    CONSTRAINT fk_specialty_agent FOREIGN KEY (specialty_agent_id_fk) REFERENCES specialty(id_specialty) ON DELETE CASCADE
) ENGINE=INNODB;

CREATE TABLE contact_mission (
    id_contact_mission INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
    contact_id_fk INT(11) NOT NULL,
    mission_contact_id_fk INT(11) NOT NULL,
    CONSTRAINT fk_contact FOREIGN KEY (contact_id_fk) REFERENCES contact(id_contact) ON DELETE CASCADE,
    CONSTRAINT fk_mission_contact FOREIGN KEY (mission_contact_id_fk) REFERENCES mission(id_mission) ON DELETE CASCADE
) ENGINE=INNODB;

CREATE TABLE target_mission (
    id_target_mission INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
    target_id_fk INT(11) NOT NULL,
    mission_target_id_fk INT(11) NOT NULL,
    CONSTRAINT fk_target FOREIGN KEY (target_id_fk) REFERENCES target(id_target) ON DELETE CASCADE,
    CONSTRAINT fk_mission_target FOREIGN KEY (mission_target_id_fk) REFERENCES mission(id_mission) ON DELETE CASCADE
) ENGINE=INNODB;

CREATE TABLE hideout_mission (
    id_hideout_mission INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
    hideout_id_fk INT(11) NOT NULL,
    mission_hideout_id_fk INT(11) NOT NULL,
    CONSTRAINT fk_hideout FOREIGN KEY (hideout_id_fk) REFERENCES hideout(id_hideout) ON DELETE CASCADE,
    CONSTRAINT fk_mission_hideout FOREIGN KEY (mission_hideout_id_fk) REFERENCES mission(id_mission) ON DELETE CASCADE
) ENGINE=INNODB;

-- Create users
CREATE USER 'admin_kgb_bdd'@'localhost' IDENTIFIED BY '$2y$10$Nxj0Dpon5jaeIxYToqaGIOr2UQlCQGADmuc0p24CIe2ulYNESQvP.';
CREATE USER 'user_kgb_bdd'@'localhost' IDENTIFIED BY '$2y$10$CQvG3NQXdnRRbX36qPAY3OVcguSyh9diyyqSAbo4tmH/vd1X/bUY.';
/* adminKGB */
/* userKGB */

-- Grant privilieges admin (all privileges) & user (select only)
GRANT ALL PRIVILEGES ON kgb_bdd.* TO 'admin_kgb_bdd'@'localhost';
GRANT SELECT ON kgb_bdd.* TO 'user_kgb_bdd'@'localhost';


-- Insert data in admin table
INSERT INTO admin (admin_first_name, admin_last_name, admin_email, admin_password, admin_creation) values 
('Mathias', 'Crewdson', 'mcrewdson0@slate.com', '$2y$10$LbvrTF3GZdmv1AwhL/OCF.XpHg2gueoAmhToI4J5buJUGnCPJ.jAG', now()),
('Ekaterina', 'Espinosa', 'eespinosa1@wsj.com', '$2y$10$oLrgCm92hhy6hPieIrLSGeZ6WrfLVFt8m0FgwyXf6h0swMGUleDia', now()),
('Ondrea', 'Mitroshinov', 'omitroshinov2@google.de', '$2y$10$7VeR7hY4IV9i61.TVAOmJe1Xjr1DEEdg8ZD41CEfwcU5LpJkclZj.', now()),
('Bevin', 'Simonutti', 'bsimonutti3@freewebs.com', '$2y$10$wue9/Ls7Lv/zCP/MTIOxMOY9SNNPb0k9XS4pEVKQmMuff3ZoHI2ua', now()),
('Sadye', 'Dolle', 'sdolle4@bbb.org', '$2y$10$CpdiuuzqEs8SC.ND2eKOPeeXECj5QaZrGPgtnmg7HzWYajHEzK9.G', now());

/* adminMathias */
/* adminEkaterina */
/* adminOndrea */
/* adminBevin */
/* adminSadye */

-- Insert data in specialty table
INSERT INTO specialty (specialty_type, specialty_code_name) values 
('Cameleon', 'S-001'),
('Hacking','S-002'),
('Science','S-003'),
('Mechanics','S-004'),
('Sniper','S-005');


-- Insert data in mission table
INSERT INTO mission (mission_title, mission_code_name, mission_description, mission_country, mission_type, mission_statut, mission_start_date,mission_end_date, mission_specialty_id_fk) values 
('Operation Righteous Dragon', 'R-DRAGON', 'Closely monitor the activities of a drug smuggling group operating in remote regions of Mexico. The objective is to gather crucial information to disrupt their illegal operations while avoiding detection.', 'Mexico', 'Surveillance', 'Progress', '2022/02/12', '2024/10/10', 1),
('Project Dark Hope', 'D-HOPE', 'Infiltrating the sensitive computer networks of a paramilitary group in Albania. Agents attempt to collect evidence of their illicit activities and disrupt their online operations.', 'Albania', 'Cyber Espionage', 'Preparation', '2024/01/23', '2024/04/15', 2),
('Operation Defense Titan', 'D-TITAN', 'Locate and neutralize an imminent threat of a nuclear attack in China. Agents work to disarm potentially devastating missiles while maintaining discretion.', 'China', 'Nuclear Attack', 'Preparation', '2023/03/15', '2023/12/31', 3),
('Mission Desert Claw', 'D-CLAW', 'Extracting a group of researchers working on a secret project in an unstable area of Iraq. Agents must ensure the safety of these researchers while evading hostile forces.', 'Iraq', 'Point Extraction', 'Completed', '2000/04/12', '2000/04/30', 4),
('Project Black Water', 'B-WATER', 'Discreet elimination of highly sought-after terrorist targets in Afghanistan. Agents operate in the shadows to neutralize these threats and protect national security.', 'Afghanistan', 'Elimination', 'Failure', '1988/01/11', '1989/12/18', 5);


insert into agent (agent_first_name, agent_last_name, agent_birth_date, agent_code_name, agent_nationality) values 
('Meghan', 'Whyborn', '1973-08-25', 'A-065', 'Russian'),
('Gustie', 'Franzelini', '1965-01-11', 'A-063', 'Russian'),
('Quentin', 'Everall', '1966-08-14', 'A-016', 'French'),
('Greta', 'Ivashintsov', '1973-11-04', 'A-036', 'Russian'),
('Leo', 'Denekamp', '1966-06-08', 'A-083', 'Albanian'),
('Caddric', 'Arnholdt', '2003-02-22', 'A-079', 'Chinese'),
('Fawne', 'Hawksworth', '2001-05-14', 'A-056', 'Chinese'),
('Elvira', 'Pomphrey', '1965-09-07', 'A-034', 'Russian'),
('Fidole', 'Dowles', '1982-11-11', 'A-077', 'Canadian'),
('Edy', 'Hames', '1985-04-23', 'A-085', 'Russian');

insert into target (target_first_name, target_last_name, target_birth_date, target_code_name, target_nationality) values 
('Amil', 'Rouby', '1973-10-05', 'T-048', 'Colombian'),
('Tonye', 'Yeats', '1999-02-17', 'T-015', 'Colombian'),
('Orel', 'Meo', '1968-10-15', 'T-013', 'American'),
('Hynda', 'Hurdle', '1967-01-14', 'T-029', 'Israeli'),
('Grier', 'Grinsted', '1990-01-16', 'T-032', 'Iraqi'),
('Simonne', 'Glentz', '1973-01-23', 'T-081', 'Jordanian'),
('Madeline', 'Kimbrey', '1961-02-11', 'T-040', 'Japanese'),
('Hildegaard', 'Degoey', '1968-10-26', 'T-002', 'American'),
('Ancell', 'Roskelly', '1979-01-20', 'T-074', 'Russian'),
('Giovanni', 'Shapiro', '1996-02-18', 'T-044', 'Brazilian');

insert into contact (contact_first_name, contact_last_name, contact_birth_date, contact_code_name, contact_nationality) values 
('Hollyanne', 'Burdell', '1988-06-19', 'C-070', 'Mexican'),
('Kristina', 'Pietrowicz', '1955-04-05', 'C-030', 'Albanian'),
('Mandie', 'Drakers', '1955-09-28', 'C-088', 'Chinese'),
('Carol-jean', 'Quenby', '2001-02-23', 'C-072', 'Iraqi'),
('Denis', 'Nitto', '1953-05-06', 'C-089', 'Afghan'),
('Diandra', 'Champe', '1986-01-04', 'C-079', 'Afghan'),
('Datha', 'Enright', '1962-05-02', 'C-032', 'Iraqi'),
('Hall', 'Reightley', '1952-05-17', 'C-032', 'Chinese'),
('Becky', 'O''Cullen', '1967-04-29', 'C-043', 'Albanian'),
('Brittani', 'Oldcote', '2002-03-06', 'C-064', 'Mexican');

insert into hideout (hideout_code_name, hideout_country, hideout_address, hideout_city, hideout_type) values 
('H-089', 'Mexico', '5257 Iowa Pass', 'Ejidal', 'Appartment'),
('H-014', 'Albania', '59 Sunbrook Trail', 'Gradishtë', 'House'),
('H-077', 'China', '91491 Hallows Junction', 'Sanjie', 'Boat'),
('H-028', 'Iraq', '2 Everett Junction', 'Koysinceq', 'Restaurant'),
('H-092', 'Afghanistan', '61404 Burrows Avenue', 'Mehtar Lām', 'Bar'),
('H-037', 'Afghanistan', '53 Morrow Way', 'Shahr-e Şafā', 'Warehouse'),
('H-093', 'Iraq', '7225 Hanson Junction', 'Nāḩiyat Baḩār', 'Van'),
('H-043', 'China', '66584 High Crossing Lane', 'Yunmenling', 'Club'),
('H-001', 'Albania', '4 Pond Pass', 'Berat', 'Hotel Room'),
('H-007', 'Mexico', '421 Schmedeman Park', 'Buenos Aires', 'Villa');

INSERT INTO agent_mission (agent_id_fk, mission_agent_id_fk)
VALUES (1, 1), (2, 2), (3, 3), (4, 4), (5, 5), (6, 5), (7, 4), (8, 3), (9, 2), (10, 1);

INSERT INTO agent_specialty (agent_specialty_id_fk, specialty_agent_id_fk)
VALUES (1, 1), (2, 2), (3, 3), (4, 4), (5, 5), (6, 1), (7, 2), (8, 3), (9, 4), (10, 5);

INSERT INTO contact_mission (contact_id_fk, mission_contact_id_fk)
VALUES (1, 1), (2, 2), (3, 3), (4, 4), (5, 5), (6, 5), (7, 4), (8, 3), (9, 2), (10, 1);

INSERT INTO target_mission (target_id_fk, mission_target_id_fk)
VALUES (1, 1), (2, 2), (3, 3), (4, 4), (5, 5), (6, 4), (7, 3), (8, 2), (9, 5), (10, 1);

INSERT INTO hideout_mission (hideout_id_fk, mission_hideout_id_fk)
VALUES (1, 1), (2, 2), (3, 3), (4, 4), (5, 5), (6, 5), (7, 4), (8, 3), (9, 2), (10, 1);