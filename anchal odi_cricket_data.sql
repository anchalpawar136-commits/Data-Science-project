create database odi_cricket_data_set;
show databases;
use odi_cricket_data_set;

create table odi_cricket_data_set(
player_name varchar(50),
role varchar(50),
total_runs int,
strike_rate varchar(50),
total_balls_faced int,
total_wickets_taken int,
total_runs_conceded int,
total_over_bowled int,
total_matches_played int,
matches_played_as_batter int,
matches_played_as_bowler int,
matches_won int,
matche_lost int,
player_of_match_awards int,
team varchar(100),
average varchar(50),
percentage varchar(255)
);



select*from odi_cricket_data_set;
desc table odi_cricket_data_set;

show variables like 'local_infile';

set global local_infile = 1;

load data infile "C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\ODI_data.csv"
into table odi_cricket_data_set
fields terminated by ','
lines terminated by '\n'
ignore 1 rows;

select player_name, role,
case
when role = 'Batter' then 'Batsman'
when role = 'Bowler' then 'Bowler'
else 'All Rounded'
end as player_category
from odi_cricket_data_set;

select player_name, total_runs,
case 
when total_runs >=10000 then 'Legend'
when total_runs between 5000 and 9999 then 'Great  Player'
when total_runs between 1000 and 4999 then 'Average Player'
else 'Newcomer'
end as player_class
from odi_cricket_data_set;

select player_name,total_wickets_taken,
case
when total_wickets_taken >= 300 then 'Elite Bowler'
when total_wickets_taken between 100 and 299 then 'Experienced Bowler'
when total_wickets_taken between 50 and 99 then 'Developing Bowler'
else 'Part-Time Bowler'
end as bowling_category
from odi_cricket_data_set;

select player_name, matches_won,
case 
when matches_won >=300 then 'Match Winner'
when matches_won between 200 and 299 then 'Consistent Performer'
when matches_won between 100 and 199 then 'Contributor'
else 'Less Impactful'
end as match_impact
from odi_cricket_data_set;

select player_name, player_of_match_awards,
case
when player_of_match_awards >=30 then 'Superstar'
when player_of_match_awards between 15 and 29 then 'Key Player'
when player_of_match_awards between 5 and 14 then 'Occasional Star'
else 'Rare Winner'
end as award_category
from odi_cricket_data_set;

update odi_cricket_data_set set strike_rate=substring_index(strike_rate," ",2);

update odi_cricket_data_set set average=substring_index(average ,",",2);

select player_name,team,total_runs,strike_rate from odi_cricket_data_set where role='Batter' order by total_runs desc limit 10;

select player_name,team,total_wickets_taken,total_runs_conceded,total_over_bowled from odi_cricket_data_set where total_wickets_taken>0 order by total_wickets_taken desc limit 10;

insert into odi_cricket_data_set(player_name,role,total_runs,strike_rate,total_balls_faced,total_wickets_taken,total_runs_conceded,total_over_bowled,total_matches_played,matches_played_as_batter,matches_played_as_bowler,matches_won,matche_lost,player_of_match_awards,team,average,percentage)
values('New Player','Batter',5000,85.50,6000,0,0,0,200,200,0,120,80,15,'India',45.5,50.75);

update odi_cricket_data_set set strike_rate=90.25 where player_name='V Kohli';

delete from odi_cricket_data_set where total_matches_played < 50;

update odi_cricket_data_set set strike_rate= NULL, average = NULL where strike_rate < 0 or average < 0;

delete from odi_cricket_data_set where matches_won=0;

update odi_cricket_data_set set average = 0 where total_matches_played = 0;

update odi_cricket_data_set set total_wickets_taken = total_wickets_taken + 5 where role = 'Bowler' and team= 'Australia';




