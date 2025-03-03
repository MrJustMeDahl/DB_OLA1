-- 2.1 Hent alle turneringer, der starter inden for de næste 30 dage.
select * from tournaments WHERE start_date BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 30 DAY);
-- 2.2 Find det antal turneringer, en spiller har deltaget i.
select count(*) from tournament_registrations where player_id = 1;
-- 2.3 Vis en liste over spillere registreret i en bestemt turnering.
SELECT p.player_id, p.username from players p JOIN tournament_registrations tr on p.player_id = tr.player_id where tr.tournament_id = 1;
-- 2.4 Find spillere med flest sejre i en bestemt turnering.
select player_id, username, sum(case when players.player_id = matches.winner_id then 1 else 0 end) as w
from players
left join matches
on players.player_id = matches.player1_id or players.player_id = matches.player2_id
where matches.tournament_id = 7
group by players.player_id order by w DESC;
-- 2.5 Hent alle kampe, hvor en bestemt spiller har deltaget.
select * from matches where player1_id = 1 or player2_id = 1;
-- 2.6 Hent en spillers tilmeldte turneringer.
Select t.tournament_id, t.name from tournaments as t
JOIN tournament_registrations as tr
ON t.tournament_id = tr.tournament_id
where tr.player_id = 1;
-- 2.7 Find de 5 bedst rangerede spillere.
select username, ranking from players order by ranking DESC limit 5;
-- 2.8 Beregn gennemsnitlig ranking for alle spillere.
select avg(ranking) from players;
-- 2.9 Vis turneringer med mindst 5 deltagere.
SELECT t.tournament_id, t.name, t.game, COUNT(tr.player_id) AS num_players
FROM tournaments t
JOIN tournament_registrations tr ON t.tournament_id = tr.tournament_id
GROUP BY t.tournament_id
HAVING num_players >= 5;
-- 2.10 Find det samlede antal spillere i systemet.
select count(*) from players;
-- 2.11 Find alle kampe, der mangler en vinder.
select * from matches where winner_id IS NULL;
-- 2.12 Vis de mest populære spil baseret på turneringsantal.
select game, count(tournament_id) as numOfTourneys from tournaments 
group by game order by numOfTourneys DESC;
-- 2.13 Find de 5 nyeste oprettede turneringer.
select * from tournaments order by created_at limit 5;
-- 2.14 Find spillere, der har registreret sig i flere end 3 turneringer.
select p.player_id, p.username, COUNT(tr.tournament_id) as registrations
from tournament_registrations as tr
join players p on tr.player_id = p.player_id
group by p.player_id
having registrations > 3;
-- 2.15 Hent alle kampe i en turnering sorteret efter dato.
select * from matches where tournament_id = 6 order by match_date;