-- 1. Find out the referee's name who is not from England.

SELECT first_name, last_name, nationality
    FROM referees
        WHERE nationality != 'England';

-- +------------+-------------+-------------+
-- | first_name | last_name   | nationality |
-- +------------+-------------+-------------+
-- | Ferdy      | Matei       | Poland      |
-- | Raul       | Torra       | Scotland    |
-- | Mariele    | Wigelsworth | Ukraine     |
-- | Liane      | Blakelock   | Ireland     |
-- | Alfredo    | Whenman     | Philippines |
-- | Vachel     | Garthshore  | Poland      |
-- | Ingemar    | Hukins      | Greece      |
-- | Alena      | Isaac       | Germany     |
-- | Walliw     | Ditts       | Japan       |
-- | Christy    | Bulfit      | Germany     |
-- | Darryl     | Lyster      | Italy       |
-- +------------+-------------+-------------+
-- 11 rows in set (0.000 sec)

       



-- 2. How many players are there whose nationality is England?

 SELECT COUNT(player_id)
    FROM players
        WHERE nationality = 'England'; 
     

--    MariaDB [group7DDL]> SELECT COUNT(player_id)
--    -> FROM players
--    -> WHERE nationality = 'England';
--    +------------------+
--    | COUNT(player_id) |
--    +------------------+
--    |               49 |
--    +------------------+
--    1 row in set (0.009 sec)


-- 3. A referee who produce most yellow cards
-- A match always has 3 referees and we assume that referee1 is a person who is a main referee of that match

SELECT SUM(yellow_card), referee1_id, first_name, last_name
    FROM stats, matches, referees
        WHERE stats.match_id = matches.match_id
            AND matches.referee1_id = referees.referee_id
                GROUP BY referee1_id
                    ORDER BY SUM(yellow_card) DESC LIMIT 1;

-- +------------------+-------------+------------+-----------+
-- | SUM(yellow_card) | referee1_id | first_name | last_name |
-- +------------------+-------------+------------+-----------+
-- |                6 |           4 | Raul       | Torra     |
-- +------------------+-------------+------------+-----------+
-- 1 row in set (0.001 sec)




-- 4. Find out the coaches's details that have the salary more than the average salary 

SELECT first_name, last_name, employer, roles, salary
    FROM contracts, coaches 
        WHERE contracts.contract_id = coaches.contract_id    
        AND salary >= (
            SELECT AVG(salary)
                FROM contracts              
        );


-- +------------+-----------+--------------------+-------------+--------+
-- | first_name | last_name | employer           | roles       | salary |
-- +------------+-----------+--------------------+-------------+--------+
-- | Alasdair   | McGeady   | Liverpool          | Assistant C | 372955 |
-- | Mikel      | Arteta    | Arsenal            | Head Coach  | 351740 |
-- | David      | Moyes     | West Ham           | Head Coach  | 497679 |
-- | Benoite    | Kedward   | West Ham           | Assistant C | 294446 |
-- | Rog        | Rodson    | Manchester United  | Assistant C | 435094 |
-- | Pep        | Guardiola | Manchester City    | Head Coach  | 434722 |
-- | Jessica    | Curnucke  | Manchester City    | Assistant C | 315754 |
-- | Gordon     | McRannell | Chelsea            | Assistant C | 448739 |
-- | Aurora     | Alessio   | Everton            | Assistant C | 485112 |
-- | Lulita     | Keays     | Tottenham Hottspur | Assistant C | 487423 |
-- | Clemmie    | Grieveson | Tottenham Hottspur | Assistant C | 321353 |
-- | Roberto    | Zerbi     | Brighton and Hove  | Head Coach  | 463431 |
-- | Aurel      | Ginnell   | Brighton and Hove  | Assistant C | 438051 |
-- | Doretta    | Windous   | Leeds United       | Assistant C | 483473 |
-- +------------+-----------+--------------------+-------------+--------+
-- 14 rows in set (0.000 sec)


-- 5. Who is having the award "Young Player of the Season"?

SELECT first_name, last_name, nationality, team_name
    FROM awards, players
        WHERE awards.player_id = players.player_id
            AND award_name = "Young Player of the Season";


--  MariaDB [group7DDL]> SELECT player_id
--               -> FROM awards
--               -> WHERE award_name = "Young Player of the Season";
--    +------------+------------+-------------+-------------------+
--| first_name | last_name  | nationality | team_name         |
--+------------+------------+-------------+-------------------+
--| Facundo    | Buonanotte | Argentina   | Brighton and Hove |
--+------------+------------+-------------+-------------------+



-- 6. Find a player's name that have the "M" OR "N" in the first word of the team name

SELECT p.first_name, p.last_name, t.new_team, t.transfer_fee
    FROM transfer_market AS t
    INNER JOIN players AS p
        ON t.player_id = p.player_id
            WHERE new_team LIKE 'M%'
            OR new_team LIKE 'N%';

-- +------------+--------------+-------------------+--------------+
-- | first_name | last_name    | new_team          | transfer_fee |
-- +------------+--------------+-------------------+--------------+
-- | Kepa       | Arrizabalaga | Manchester City   |     75000000 |
-- | Davinson   | Sanchez      | Nottingham Forest |     22000000 |
-- | Reheem     | Sterling     | Manchester United |     80000000 |
-- +------------+--------------+-------------------+--------------+
-- 3 rows in set (0.000 sec)



-- 7. Which team have the most number of gym room and more than 1 recovery center?
SELECT team_name, MAX(gym_room), recovery_center
    FROM facilities
        WHERE recovery_center > 1;


-- +-----------+---------------+-----------------+
-- | team_name | MAX(gym_room) | recovery_center |
-- +-----------+---------------+-----------------+
-- | Liverpool |             5 |               4 |
-- +-----------+---------------+-----------------+
-- 1 row in set (0.000 sec)


-- 8. Find stadium details which have capacity between 50,000 and 70,000 and located in London and Manchester

SELECT *
    FROM stadium
        WHERE capacity BETWEEN 50000 AND 70000 
            AND city IN ("London", "Manchester");


-- +----------------------+----------+------------+
-- | stadium_name         | capacity | city       |
-- +----------------------+----------+------------+
-- | Emirates Stadium     |    60260 | London     |
-- | Etihad Stadium       |    53400 | Manchester |
-- | London Stadium       |    66000 | London     |
-- | Tottenham Hottspur S |    62850 | London     |
-- +----------------------+----------+------------+
-- 4 rows in set (0.000 sec)


-- 9. Leaderboard so far for the league

SELECT team_name, points
    FROM teams
        ORDER BY points DESC;

-- +--------------------+--------+
-- | team_name          | points |
-- +--------------------+--------+
-- | Manchester United  |      6 |
-- | Manchester City    |      4 |
-- | Tottenham Hottspur |      4 |
-- | Chelsea            |      4 |
-- | Nottingham Forest  |      3 |
-- | Newcastle United   |      3 |
-- | West Ham           |      3 |
-- | Liverpool          |      3 |
-- | Brighton and Hove  |      2 |
-- | Leeds United       |      1 |
-- | Everton            |      0 |
-- | Arsenal            |      0 |
-- +--------------------+--------+
-- 12 rows in set (0.000 sec)

--  10.  Top 10 players has the most goals so far

SELECT (normal_goals +  penalty) AS goals, first_name, last_name
    FROM stats, players
        WHERE stats.player_id = players.player_id
            AND (normal_goals + penalty) > 0
                ORDER BY (normal_goals + penalty) DESC LIMIT 10;

-- +-------+------------+--------------+
-- | goals | first_name | last_name    |
-- +-------+------------+--------------+
-- |     2 | Georginio  | Rutter       |
-- |     2 | Bernardo   | Silva        |
-- |     2 | Alex       | Iwobi        |
-- |     2 | Marcus     | Rashford     |
-- |     2 | Armando    |  Broja       |
-- |     2 | Heung-min  | Son          |
-- |     2 | Alexis     | Mac Allister |
-- |     2 | Marcus     | Rashford     |
-- |     2 | Kelvin     | De Bruyne    |
-- |     2 | Wilfried   | Gnonto       |
-- +-------+------------+--------------+
-- 10 rows in set (0.000 sec)





