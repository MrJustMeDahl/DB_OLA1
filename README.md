# DB_OLA1
First OLA of Software development.

TASK 1: Databasedesign og oprettelse af databasen

Script til oprettelse af database: 
```sql
CREATE DATABASE  IF NOT EXISTS `esport`;
USE `esport`;

DROP TABLE IF EXISTS `players`;
CREATE TABLE `players` (
  `player_id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(45) NOT NULL,
  `email` varchar(45) NOT NULL,
  `ranking` int DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`player_id`),
  UNIQUE KEY `username_UNIQUE` (`username`),
  UNIQUE KEY `email_UNIQUE` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `tournaments`;
CREATE TABLE `tournaments` (
  `tournament_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `game` varchar(45) NOT NULL,
  `max_players` int NOT NULL,
  `start_date` datetime NOT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`tournament_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `matches`;
CREATE TABLE `matches` (
  `match_id` int NOT NULL AUTO_INCREMENT,
  `tournament_id` int NOT NULL,
  `player1_id` int NOT NULL,
  `player2_id` int NOT NULL,
  `winner_id` int DEFAULT NULL,
  `match_date` datetime DEFAULT NULL,
  PRIMARY KEY (`match_id`),
  KEY `tournament_id_idx` (`tournament_id`),
  KEY `player_id_idx` (`player1_id`),
  KEY `player2_id_idx` (`player2_id`),
  KEY `winnder_id_idx` (`winner_id`),
  CONSTRAINT `match_tournament_id` FOREIGN KEY (`tournament_id`) REFERENCES `tournaments` (`tournament_id`),
  CONSTRAINT `player1_id` FOREIGN KEY (`player1_id`) REFERENCES `players` (`player_id`),
  CONSTRAINT `player2_id` FOREIGN KEY (`player2_id`) REFERENCES `players` (`player_id`),
  CONSTRAINT `winnder_id` FOREIGN KEY (`winner_id`) REFERENCES `players` (`player_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci AUTO_INCREMENT=1;


DROP TABLE IF EXISTS `tournament_registrations`;
CREATE TABLE `tournament_registrations` (
  `registration_id` int NOT NULL AUTO_INCREMENT,
  `registered_at` datetime NOT NULL,
  `tournament_id` int NOT NULL,
  `player_id` int NOT NULL,
  PRIMARY KEY (`registration_id`),
  KEY `tournament_id_idx` (`tournament_id`),
  KEY `player_id_idx` (`player_id`),
  CONSTRAINT `player_id` FOREIGN KEY (`player_id`) REFERENCES `players` (`player_id`),
  CONSTRAINT `tournament_id` FOREIGN KEY (`tournament_id`) REFERENCES `tournaments` (`tournament_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci AUTO_INCREMENT=1;

DELIMITER $$

CREATE TRIGGER set_created_at
BEFORE INSERT ON players
FOR EACH ROW 
BEGIN
    IF NEW.created_at IS NULL THEN
		SET NEW.created_at = NOW();
	END IF;
END $$

DELIMITER ; 

DELIMITER $$

CREATE TRIGGER set_created_at_tournaments
BEFORE INSERT ON tournaments
FOR EACH ROW 
BEGIN
    IF NEW.created_at IS NULL THEN
		SET NEW.created_at = NOW();
	END IF;
END $$

DELIMITER ; 

INSERT INTO esport.players(username, email, ranking) 
VALUES 
('maverick', 'm@test.dk', 0), 
('gobsmacked', 'g@test.dk', 100), 
('flume', 'f@test.dk', 200), 
('ranivorous', 'r@test.dk', 150), 
('phalange', 'p@test.dk', 2000), 
('sprout','s@test.dk', 175), 
('bulbous', 'b@test.dk', 50),
('drizzle', 'd@test.dk', 0),
('wharf', 'w@test.dk', 80),
('Jackster', 'j@test.dk', 1250);

INSERT INTO esport.tournaments(name, game, max_players, start_date) 
VALUES
('Free Fire', 'CS', 100, '2025-03-10 12:00:00'),
('COBX Masters', 'LOL', 325, '2025-06-20 20:00:00'),
('PUBG Championships', 'PUBG', 120, '2025-04-15 08:00:00'),
('Cybergamer', 'DOTA', 50,'2026-04-09 15:00:00'),
('Evolution Championships','CS', 80,'2026-01-01 08:00:00'),
('Hero Pro League', 'HON', 30, '2024-12-24 18:00:00'),
('League Gaming', 'LOL', 50, '2024-11-06 14:00:00');

INSERT esport.tournament_registrations(registered_at, tournament_id, player_id)
VALUES
('2024-11-05 14:00:00', 7, 1),
('2024-11-04 14:00:00', 7, 2),
('2025-03-02 12:00:00', 1, 1),
('2025-03-02 12:00:00', 2, 1),
('2025-03-02 12:00:00', 4, 7),
('2025-03-02 12:00:00', 4, 10),
('2025-03-02 12:00:00', 1, 7),
('2025-03-02 12:00:00', 1, 8),
('2025-03-02 12:00:00', 2, 9),
('2025-03-02 12:00:00', 3, 2);

INSERT INTO esport.matches(tournament_id, player1_id, player2_id, match_date)
VALUES
(7, 1, 2, '2024-11-06 14:00:00'),
(1, 1, 7, '2025-03-10 12:00:00'),
(1, 1, 8, '2025-03-10 13:00:00'),
(1, 7, 8, '2025-03-10 14:00:00');
```

Task 2: SQL-Forespørgsler

2.1 Hent alle turneringer, der starter inden for de næste 30 dage.
```sql
select * from tournaments WHERE start_date BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 30 DAY);
```
Resultat:
![img.png](task2/2.1_result.png)

2.2 Find det antal turneringer, en spiller har deltaget i.
```sql
select count(*) from tournament_registrations where player_id = 1;
```
Resultat:
![img.png](task2/2.2_result.png)
2.3 Vis en liste over spillere registreret i en bestemt turnering.
```sql

```

2.4 Find spillere med flest sejre i en bestemt turnering.
```sql

```

2.5 Hent alle kampe, hvor en bestemt spiller har deltaget.
```sql

```

2.6 Hent en spillers tilmeldte turneringer.
```sql

```

2.7 Find de 5 bedst rangerede spillere.
```sql

```

2.8 Beregn gennemsnitlig ranking for alle spillere.
```sql

```

2.9 Vis turneringer med mindst 5 deltagere.
```sql

```

2.10 Find det samlede antal spillere i systemet.
```sql

```

2.11 Find alle kampe, der mangler en vinder.
```sql

```

2.12 Vis de mest populære spil baseret på turneringsantal.
```sql

```

2.13 Find de 5 nyeste oprettede turneringer.
```sql

```

2.14 Find spillere, der har registreret sig i flere end 3 turneringer.
```sql

```

2.15 Hent alle kampe i en turnering sorteret efter dato.
```sql

```

