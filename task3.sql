/*

-- 3.1 registerPlayer Procedure
DELIMITER //

CREATE PROCEDURE registerPlayer(
    IN p_username VARCHAR(45),
    IN p_email VARCHAR(45),
    IN p_ranking INT(10)
)
BEGIN
    INSERT INTO players (username, email, ranking, created_at)
    VALUES (p_username, p_email, p_ranking, NOW());
END //

DELIMITER ;


-- 3.2 joinTournament Procedure

DELIMITER //

CREATE PROCEDURE joinTournament(
    IN p_player_id INT,
    IN p_tournament_id INT
)
BEGIN
    DECLARE player_count INT;

    -- Hent antallet af spillere, der allerede er registreret i turneringen
    SELECT COUNT(*) INTO player_count
    FROM tournament_registrations
    WHERE tournament_id = p_tournament_id;

    -- Hvis der er plads, tilmeld spilleren
    IF player_count < (SELECT max_players FROM tournaments where tournament_id = p_tournament_id) THEN
        insert into tournament_registrations (player_id, tournament_id, registered_at)
        values (p_player_id, p_tournament_id, NOW());
    END IF;
END //

DELIMITER ;


*/