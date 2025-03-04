DELIMITER //

CREATE PROCEDURE submitMatchResult(
    IN p_match_id INT,
    IN p_winner_id INT
)
BEGIN
    IF EXISTS(
        SELECT 1
        FROM matches
        WHERE match_id = p_match_id
        AND (player1_id = p_winner_id OR player2_id = p_winner_id)
    ) THEN
        UPDATE matches
        SET winner_id = p_winner_id
        WHERE match_id = p_match_id;
    ELSE
        signal sqlstate '45000' set message_text = 'Winner is not a participant of this match.';
    END IF;

END //

DELIMITER ;
