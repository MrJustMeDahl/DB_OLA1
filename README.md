# DB_OLA1
First OLA of Software development.

## TASK 1: Databasedesign og oprettelse af databasen

### Script til oprettelse af database: 
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
('2025-03-02 12:00:00', 3, 2),
('2025-03-02 12:00:00', 1, 6),
('2025-03-02 12:00:00', 1, 5),
('2025-03-02 12:00:00', 4, 1);

INSERT INTO esport.matches(tournament_id, player1_id, player2_id, match_date, winner_id)
VALUES
(7, 1, 2, '2024-11-06 14:00:00', 1),
(1, 1, 7, '2025-03-10 13:00:00', null),
(1, 1, 8, '2025-03-10 12:00:00', null),
(1, 7, 8, '2025-03-10 14:00:00', null);
```

## Task 2: SQL-Forespørgsler

### 2.1 Hent alle turneringer, der starter inden for de næste 30 dage.
```sql
select * from tournaments 
WHERE start_date BETWEEN CURDATE() 
AND DATE_ADD(CURDATE(), INTERVAL 30 DAY);
```
Resultat:

![img.png](task2/2.1_result.png)

### 2.2 Find det antal turneringer, en spiller har deltaget i.
```sql
select count(*) from tournament_registrations 
where player_id = 1;
```
Resultat:

![img.png](task2/2.2_result.png)

### 2.3 Vis en liste over spillere registreret i en bestemt turnering.
```sql
SELECT p.player_id, p.username from players p 
JOIN tournament_registrations tr on p.player_id = tr.player_id 
where tr.tournament_id = 1;
```
Resultat:

![img.png](task2/2.3_result.png)

### 2.4 Find spillere med flest sejre i en bestemt turnering.
```sql
select player_id, username, sum(case when players.player_id = matches.winner_id then 1 else 0 end) as w 
from players
left join matches 
on players.player_id = matches.player1_id or players.player_id = matches.player2_id
where matches.tournament_id = 7
group by players.player_id order by w DESC;
```
Resultat:

![img.png](task2/2.4_result.png)

### 2.5 Hent alle kampe, hvor en bestemt spiller har deltaget.
```sql
select * from matches 
where player1_id = 1 
or player2_id = 1;
```
Resultat:

![img.png](task2/2.5_result.png)

### 2.6 Hent en spillers tilmeldte turneringer.
```sql
Select t.tournament_id, t.name from tournaments as t
JOIN tournament_registrations as tr
ON t.tournament_id = tr.tournament_id
where tr.player_id = 1;
```
Resultat:

![2.6_result.png](task2%2F2.6_result.png)

### 2.7 Find de 5 bedst rangerede spillere.
```sql
select username, ranking from players order by ranking DESC limit 5;
```
Resultat:

![img.png](task2/2.7_result.png)

### 2.8 Beregn gennemsnitlig ranking for alle spillere.
```sql
select avg(ranking) from players;
```
Resultat:

![img.png](task2/2.8_result.png)

### 2.9 Vis turneringer med mindst 5 deltagere.
```sql
SELECT t.tournament_id, t.name, t.game, COUNT(tr.player_id) AS num_players
FROM tournaments t
JOIN tournament_registrations tr ON t.tournament_id = tr.tournament_id
GROUP BY t.tournament_id
HAVING num_players >= 5;
```
Resultat:

![img.png](task2/2.9_result.png)

### 2.10 Find det samlede antal spillere i systemet.
```sql
select count(*) from players;
```
Resultat:

![img.png](task2/2.10_result.png)

### 2.11 Find alle kampe, der mangler en vinder.
```sql
select * from matches where winner_id IS NULL;
```
Resultat:

![img.png](task2/2.11_result.png)

### 2.12 Vis de mest populære spil baseret på turneringsantal.
```sql
select game, count(tournament_id) as numOfTourneys 
from tournaments 
group by game 
order by numOfTourneys DESC;
```
Resultat:

![img.png](task2/2.12_result.png)

### 2.13 Find de 5 nyeste oprettede turneringer.
```sql
select * from tournaments 
order by created_at limit 5;
```
Resultat:

![img.png](task2/2.13_result.png)

### 2.14 Find spillere, der har registreret sig i flere end 3 turneringer.
```sql
select p.player_id, p.username, COUNT(tr.tournament_id) as registrations
from tournament_registrations as tr
join players p on tr.player_id = p.player_id
group by p.player_id
having registrations > 3;
```
Resultat:

![img.png](task2/2.14_result.png)

### 2.15 Hent alle kampe i en turnering sorteret efter dato.
```sql
select * from matches 
where tournament_id = 1 
order by match_date;
```
Resultat:

![img.png](task2/2.15_result.png)

