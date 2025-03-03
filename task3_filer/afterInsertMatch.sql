DELIMITER //
create trigger afterInsertMatch
after insert on matches
for each row
begin

    if new.winner_id = New.player1_id then
		update players set ranking = ranking + 10 where player_id = new.player1_id;
        update players set ranking = ranking - 10 where player_id = new.player2_id;

	elseif new.winner_id = new.player2_id then
		update players set ranking = ranking + 10 where player_id = new.player2_id;
        update players set ranking = ranking - 10 where player_id = new.player1_id;

    end if;
end //

DELIMITER ;