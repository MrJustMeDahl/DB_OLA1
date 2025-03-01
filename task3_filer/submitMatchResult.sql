DELIMITER //

CREATE PROCEDURE submitMatchResult(
    IN p_match_id INT,
    IN p_winner_id INT
)
BEGIN
    DECLARE p_loser_id INT;
    
    SELECT 
        CASE 
            WHEN player1_id = p_winner_id THEN player2_id 
            ELSE player1_id 
        END 
    INTO p_loser_id
    FROM matches
    WHERE match_id = p_match_id;

    -- Vinderen får 10 ranking
    UPDATE players
    SET ranking = ranking + 10
    WHERE player_id = p_winner_id;

    -- Taberen mister 10 ranking
    UPDATE players
    SET ranking = ranking - 10
    WHERE player_id = p_loser_id;

    UPDATE matches
    SET winner_id = p_winner_id
    WHERE match_id = p_match_id;

END //

DELIMITER ;
