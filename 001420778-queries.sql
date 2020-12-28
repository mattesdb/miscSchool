CONNECT TO SE3DB3;
--Kevin Mattes
--001420778
--I. SQL 

--1
SELECT player_id AS TOTALRECORDS
FROM player_mast;

--2
SELECT player_id, team_id, jersey_no, player_name, posi_to_play, dt_of_bir, age, playing_club AS ALLPLAYERRECORDS
FROM player_mast;

--3i)
SELECT country_id AS TOTALCOUNTRIES
FROM soccer_country;

--3ii)
SELECT goal_id AS TOTALETGOALS
FROM goal_details
WHERE (goal_schedule='ET');

--3iii)
SELECT goal_id AS TOTALSTGOALS
FROM goal_details
WHERE (goal_schedule='ST');

--3iv)
SELECT goal_id AS TOTALNTGOALS
FROM goal_details
WHERE (goal_schedule='NT');

--3v)
SELECT match_no AS TOTALSTBOOKS
FROM player_booked
WHERE (play_schedule='ST');

--3vi)
SELECT match_no AS TOTALETBOOKS
FROM player_booked
WHERE (play_schedule='ET');

--4i)
SELECT play_date AS FIRSTMATCH
FROM match_mast;

--4ii)
SELECT play_date AS LASTMATCH
FROM match_mast;

--5i)
SELECT country_name AS FIRSTMATCHTEAMS
FROM soccer_country, soccer_team, match_details
WHERE match_details.match_no='1'
	AND match_details.team_id = soccer_team.team_id
	AND soccer_country.country_id = soccer_team.country_id;

--5ii)
SELECT country_name AS LASTMATCHWINNER
FROM soccer_country, soccer_team, match_details
WHERE match_details.match_no = '51'
	AND match_details.win_lose = 'W'
	AND match_details.team_id = soccer_team.team_id
	AND soccer_country.country_id = soccer_team.country_id;

--6i)

SELECT soccer_country.country_name, COUNT(*) AS PENALTIESPERCOUNTRY
FROM penalty_shootout, soccer_team, soccer_country
WHERE penalty_shootout.team_id IN (SELECT DISTINCT team_id 
                    FROM penalty_shootout)
AND penalty_shootout.team_id = soccer_team.team_id
AND soccer_team.country_id = soccer_country.country_id
GROUP BY soccer_country.country_name;

--6ii)
SELECT country_name AS LASTMATCHTEAMS
FROM soccer_country, soccer_team, match_details
WHERE match_details.match_no = '51'
	AND match_details.team_id = soccer_team.team_id
	AND soccer_country.country_id = soccer_team.country_id;

---6iii)
SELECT play_date AS DATESWITHPENALTYSHOOTOUTS
FROM match_mast
WHERE match_no IN (SELECT DISTINCT penalty_shootout.match_no
                    FROM penalty_shootout);

---6iv)
SELECT venue_name AS VENUESOFPENALTYSHOOTOUTS
FROM match_mast, soccer_venue
WHERE match_no IN (SELECT DISTINCT penalty_shootout.match_no
                    FROM penalty_shootout)
AND match_mast.venue_id = soccer_venue.venue_id;

---6v)
SELECT COUNT(*) + 11 AS FRANCELASTMATCHNUMBEROFPLAYERS
FROM soccer_team, match_details, player_in_out
WHERE match_details.match_no = '51'
	AND match_details.win_lose = 'L'
	AND match_details.team_id = soccer_team.team_id
	AND match_details.team_id  = player_in_out.team_id
	AND in_out = 'I'
	AND match_details.match_no = player_in_out.match_no;
	
TERMINATE;