DELIMITER //
create function getTournamentStatus(tournamentID INT) RETURNS VARCHAR(20)
DETERMINISTIC
begin
    declare tournamentStart date;
    declare tournamentEnd date;
    DECLARE status VARCHAR(20);

    -- Get tournament start date
    SELECT start_date INTO tournamentStart FROM tournaments WHERE tournament_id = tournamentID;

    -- If no matches have been played, it's "upcoming"
    IF tournamentStart > CURDATE() THEN
        SET status = 'upcoming';
    -- If there are matches but no winner for all matches, it's "ongoing"
    ELSEIF EXISTS (SELECT 1 FROM matches WHERE tournament_id = tournamentID AND winner_id IS NULL) THEN
        SET status = 'ongoing';
    ELSE
        SET status = 'completed';
    END IF;

    RETURN status;
END //
DELIMITER ;
