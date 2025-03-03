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
('2025-03-02 12:00:00', 1, 4);

INSERT INTO esport.matches(tournament_id, player1_id, player2_id, match_date, winner_id)
VALUES
(7, 1, 2, '2024-11-06 14:00:00', 1),
(1, 1, 7, '2025-03-10 13:00:00', null),
(1, 1, 8, '2025-03-10 12:00:00', null),
(1, 7, 8, '2025-03-10 14:00:00', null);