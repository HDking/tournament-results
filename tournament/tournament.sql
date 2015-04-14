-- Table definitions for the tournament project.
--
-- Put your SQL 'create table' statements in this file; also 'create view'
-- statements if you choose to use it.
--
-- You can write comments in this file by starting them with two dashes, like
-- these lines here.

CREATE TABLE players (name TEXT,
					  player_id SERIAL primary key);

CREATE TABLE matches (match_id SERIAL primary key,
						winner INT references players(player_id),
						loser INT references players(player_id)
						);


CREATE VIEW numWins AS
	SELECT players.player_id as player, count(matches.match_id) as wins
	FROM players
		LEFT JOIN matches
		ON players.player_id = matches.winner
	GROUP BY players.player_id; 

CREATE VIEW numLosses AS
	SELECT players.player_id as player, count(matches.match_id) as losses
	FROM players
		LEFT JOIN matches
		ON players.player_id = matches.loser
	GROUP BY players.player_id; 


CREATE VIEW standings AS
	SELECT players.player_id as id, players.name as player, SUM(numWins.wins) as wins, SUM(numWins.wins + numLosses.losses) as matches
	FROM players
		LEFT JOIN numWins
		ON players.player_id = numWins.player
		LEFT JOIN numLosses
		ON players.player_id = numLosses.player
	GROUP BY players.player_id
	ORDER BY wins DESC;

CREATE VIEW ranking AS
	SELECT row_number() OVER (ORDER BY wins) as ranking, id, player
	FROM standings;

CREATE VIEW pairings AS
	SELECT a.ranking as P1_rank, a.id as P1_id, a.player as P1_name, b.ranking as P2_rank, b.id as P2_id, b.player as P2_name
		FROM ranking as a,
			ranking as b
		WHERE a.ranking < b.ranking
			AND a.ranking % 2 <> 0
			AND b.ranking - a.ranking = 1;

