Physical Database Design
--create tables/views/procedures/functions in repeatable form
-- create drops

--drop procedures

IF OBJECT_ID('dbo.LosingTeams') IS NOT NULL
	DROP PROCEDURE dbo.LosingTeams

GO

IF OBJECT_ID('dbo.UpdatePassingTDS') IS NOT NULL
	DROP PROCEDURE UpdatePassingTDS


--drop views
IF OBJECT_ID('dbo.WinLossRatio') IS NOT NULL
	DROP VIEW dbo.WinLossRatio


--drop tables
IF OBJECT_ID('Game_Stats') IS NOT NULL
	DROP TABLE dbo.Game_Stats

GO

IF OBJECT_ID('dbo.Games') IS NOT NULL
	DROP TABLE dbo.Games

GO

IF OBJECT_ID('dbo.Stadium') IS NOT NULL
	DROP TABLE dbo.Stadium 

GO

IF OBJECT_ID('dbo.Teams') IS NOT NULL
	DROP TABLE dbo.Teams

GO
---------------------------------------------------------------------------------
--create database tables

CREATE TABLE Teams(
	--create columns
	Team_ID int identity
	, Team_Name varchar(50) NOT NULL unique
	--place constraints
	, CONSTRAINT PK_Team_ID PRIMARY KEY (Team_ID)
	)
GO

CREATE TABLE Stadium(
	--create columns
	Stadium_ID int identity
	,Stadium_Name varchar(50)
	--place constraints
	, CONSTRAINT PK_Stadium PRIMARY KEY (Stadium_ID)
	)

GO

CREATE TABLE Games(
	--create columns
	Game_ID int identity
	, Home_Team_ID int
	, Away_Team_ID int
	, Stadium_ID int
	,Game_Date datetime
	--place constraints
	, CONSTRAINT PF_Games Primary KEY(Game_ID)
	, CONSTRAINT FK_Games FOREIGN KEY(Home_Team_ID) REFERENCES Teams(Team_ID)
	, CONSTRAINT FK2_Games FOREIGN KEY(Away_Team_ID) REFERENCES Teams(Team_ID)
	, CONSTRAINT FK3_Games FOREIGN KEY(Stadium_ID) REFERENCES Stadium(Stadium_ID)
	)
GO

CREATE TABLE Game_Stats(
	--create columns
	Game_ID int
	, Team_ID int 
	, Rushing_Touchdowns int
	, Passing_Touchdowns int
	, Total_Points_Scored int
	, Total_Points_Allowed int
	, Win int
	-- place constraints
	, CONSTRAINT PF1_Games Foreign KEY(Game_ID) REFERENCES Games(Game_ID)
	, CONSTRAINT FK1_Teams Foreign KEY(Team_ID) REFERENCES Teams(Team_ID)
	, CONSTRAINT NonNegativeRushingTD Check (Rushing_Touchdowns > -1)
	, CONSTRAINT NonNegativePassingTD Check (Passing_Touchdowns > -1)
	, CONSTRAINT NonNegativeTotalPtsScored Check (Total_Points_Scored > -1)
	, CONSTRAINT NonNegativeTotalPtsAllowed Check (Total_Points_Allowed > -1)
	)

 
--Select * from Stadium
--Select * from Teams
--Select * from Games
--Select * from Game_Stats

 GO


--insert Teams into Teams table
INSERT INTO Teams(Team_Name)
VALUES 
('Eagles'),
('Blue Devils'),
 ('Black Hawks'),
 ('Dodgers'),
 ('Dogs'),
('Tigers'),
 ('Indians'),
 ('Lions'),
 ('Kilos'),
 ('Deltas'),
 ('Steelers'),
 ('Birds')

GO
 
--insert stadium info
INSERT INTO Stadium(Stadium_Name)
VALUES 
('mastercard Stadium'),
('maestro Stadium'),
('visa Stadium'),
('diners-club-enroute Stadium'),
('china-unionpay Stadium'),
('visa-electron Stadium'),
('americanexpress Stadium'),
('diners-club-international Stadium'),
('solo Stadium'),
('laser Stadium'),
('instapayment Stadium'),
('bankcard Stadium')
 
GO

--insert Game info
INSERT INTO Games(Home_Team_ID, Away_Team_ID, Stadium_ID, Game_Date) 
VALUES   
((SELECT Team_id FROM Teams where Team_Name = 'Birds'), (SELECT Team_id FROM Teams where Team_Name ='Blue Devils'),
			(SELECT Stadium_ID FROM Stadium where Stadium_Name = 'instapayment Stadium'),'11/10/2019'),
((SELECT Team_id FROM Teams where Team_Name = 'Dogs'), (SELECT Team_id FROM Teams where Team_Name ='Eagles'),
			(SELECT Stadium_ID FROM Stadium where Stadium_Name = 'bankcard Stadium'),'11/10/2019'),
((SELECT Team_id FROM Teams where Team_Name = 'Tigers'), (SELECT Team_id FROM Teams where Team_Name ='Indians'),
			(SELECT Stadium_ID FROM Stadium where Stadium_Name = 'laser Stadium'),'11/10/2019'),
((SELECT Team_id FROM Teams where Team_Name = 'Deltas'), (SELECT Team_id FROM Teams where Team_Name ='Dodgers'),
			(SELECT Stadium_ID FROM Stadium where Stadium_Name = 'solo Stadium'),'11/10/2019'),
((SELECT Team_id FROM Teams where Team_Name = 'Steelers'), (SELECT Team_id FROM Teams where Team_Name ='Black Hawks'),
			(SELECT Stadium_ID FROM Stadium where Stadium_Name = 'diners-club-international Stadium'),'11/10/2019'),
((SELECT Team_id FROM Teams where Team_Name = 'Kilos'), (SELECT Team_id FROM Teams where Team_Name ='Lions'),
			(SELECT Stadium_ID FROM Stadium where Stadium_Name = 'americanexpress Stadium'),'11/10/2019'),

((SELECT Team_id FROM Teams where Team_Name = 'Blue Devils'), (SELECT Team_id FROM Teams where Team_Name ='Dogs'),
			(SELECT Stadium_ID FROM Stadium where Stadium_Name = 'visa-electron Stadium'),'11/17/2019'),
((SELECT Team_id FROM Teams where Team_Name = 'Eagles'), (SELECT Team_id FROM Teams where Team_Name ='Tigers'),
			(SELECT Stadium_ID FROM Stadium where Stadium_Name = 'china-unionpay Stadium'),'11/17/2019'),
((SELECT Team_id FROM Teams where Team_Name = 'Indians'), (SELECT Team_id FROM Teams where Team_Name ='Deltas'),
			(SELECT Stadium_ID FROM Stadium where Stadium_Name = 'diners-club-enroute Stadium'),'11/17/2019'),
((SELECT Team_id FROM Teams where Team_Name = 'Dodgers'), (SELECT Team_id FROM Teams where Team_Name ='Steelers'),
			(SELECT Stadium_ID FROM Stadium where Stadium_Name = 'visa Stadium'),'11/17/2019'),
((SELECT Team_id FROM Teams where Team_Name = 'Black Hawks'), (SELECT Team_id FROM Teams where Team_Name ='Kilos'),
			(SELECT Stadium_ID FROM Stadium where Stadium_Name = 'maestro Stadium'),'11/17/2019'),
((SELECT Team_id FROM Teams where Team_Name = 'Lions'), (SELECT Team_id FROM Teams where Team_Name ='Birds'),
			(SELECT Stadium_ID FROM Stadium where Stadium_Name = 'mastercard Stadium'),'11/17/2019'),

((SELECT Team_id FROM Teams where Team_Name = 'Dogs'), (SELECT Team_id FROM Teams where Team_Name ='Indians'),
			(SELECT Stadium_ID FROM Stadium where Stadium_Name = 'bankcard Stadium'),'11/24/2019'),
((SELECT Team_id FROM Teams where Team_Name = 'Tigers'), (SELECT Team_id FROM Teams where Team_Name ='Dodgers'),
			(SELECT Stadium_ID FROM Stadium where Stadium_Name = 'laser Stadium'),'11/24/2019'),
((SELECT Team_id FROM Teams where Team_Name = 'Deltas'), (SELECT Team_id FROM Teams where Team_Name ='Black Hawks'),
			(SELECT Stadium_ID FROM Stadium where Stadium_Name = 'solo Stadium'),'11/24/2019'),
((SELECT Team_id FROM Teams where Team_Name = 'Steelers'), (SELECT Team_id FROM Teams where Team_Name ='Lions'),
			(SELECT Stadium_ID FROM Stadium where Stadium_Name = 'diners-club-international Stadium'),'11/24/2019'),
((SELECT Team_id FROM Teams where Team_Name = 'Kilos'), (SELECT Team_id FROM Teams where Team_Name ='Blue Devils'),
			(SELECT Stadium_ID FROM Stadium where Stadium_Name = 'americanexpress Stadium'),'11/24/2019'),
((SELECT Team_id FROM Teams where Team_Name = 'Birds'), (SELECT Team_id FROM Teams where Team_Name ='Eagles'),
			(SELECT Stadium_ID FROM Stadium where Stadium_Name = 'instapayment Stadium'),'11/24/2019'),

((SELECT Team_id FROM Teams where Team_Name = 'Black Hawks'), (SELECT Team_id FROM Teams where Team_Name ='Dogs'),
			(SELECT Stadium_ID FROM Stadium where Stadium_Name = 'maestro Stadium'),'11/30/2019'),
((SELECT Team_id FROM Teams where Team_Name = 'Indians'), (SELECT Team_id FROM Teams where Team_Name ='Steelers'),
			(SELECT Stadium_ID FROM Stadium where Stadium_Name = 'diners-club-enroute Stadium'),'11/30/2019'),
((SELECT Team_id FROM Teams where Team_Name = 'Lions'), (SELECT Team_id FROM Teams where Team_Name ='Tigers'),
			(SELECT Stadium_ID FROM Stadium where Stadium_Name = 'mastercard Stadium'),'11/30/2019'),
((SELECT Team_id FROM Teams where Team_Name = 'Dodgers'), (SELECT Team_id FROM Teams where Team_Name ='Birds'),
			(SELECT Stadium_ID FROM Stadium where Stadium_Name = 'visa Stadium'),'11/30/2019'),
((SELECT Team_id FROM Teams where Team_Name = 'Eagles'), (SELECT Team_id FROM Teams where Team_Name ='Kilos'),
			(SELECT Stadium_ID FROM Stadium where Stadium_Name = 'china-unionpay Stadium'),'11/30/2019'),
((SELECT Team_id FROM Teams where Team_Name = 'Blue Devils'), (SELECT Team_id FROM Teams where Team_Name ='Deltas'),
			(SELECT Stadium_ID FROM Stadium where Stadium_Name = 'visa-electron Stadium'),'11/30/2019')

GO

--insert Game Stats info
INSERT INTO Game_Stats(Game_ID,Team_ID, Rushing_Touchdowns, Passing_Touchdowns, Total_Points_Scored, Total_Points_Allowed, Win) 
VALUES   
((SELECT Game_id From Games where (Home_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Birds') OR Away_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Birds')) 
AND Game_Date = '11/10/2019') ,(SELECT Team_id FROM Teams where Team_Name = 'Birds'), 4,0, 32, 45,0),
((SELECT Game_id From Games where (Home_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Blue Devils') OR Away_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Blue Devils')) 
AND Game_Date = '11/10/2019') ,(SELECT Team_id FROM Teams where Team_Name = 'Blue Devils'), 3,3, 45, 32,1),
((SELECT Game_id From Games where (Home_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Dogs') OR Away_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Dogs')) 
AND Game_Date = '11/10/2019') ,(SELECT Team_id FROM Teams where Team_Name = 'Dogs'), 1,1, 14, 7,1),
((SELECT Game_id From Games where (Home_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Eagles') OR Away_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Eagles')) 
AND Game_Date = '11/10/2019') ,(SELECT Team_id FROM Teams where Team_Name = 'Eagles'), 0,1, 7, 14,0),
((SELECT Game_id From Games where (Home_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Tigers') OR Away_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Tigers')) 
AND Game_Date = '11/10/2019') ,(SELECT Team_id FROM Teams where Team_Name = 'Tigers'), 2,2, 27, 24,1),
((SELECT Game_id From Games where (Home_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Indians') OR Away_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Indians')) 
AND Game_Date = '11/10/2019') ,(SELECT Team_id FROM Teams where Team_Name = 'Indians'), 1,2, 24, 27,0),
((SELECT Game_id From Games where (Home_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Deltas') OR Away_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Deltas')) 
AND Game_Date = '11/10/2019') ,(SELECT Team_id FROM Teams where Team_Name = 'Deltas'), 2,3, 42, 45,0),
((SELECT Game_id From Games where (Home_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Dodgers') OR Away_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Dodgers')) 
AND Game_Date = '11/10/2019') ,(SELECT Team_id FROM Teams where Team_Name = 'Dodgers'), 4,1, 45, 42,1),
((SELECT Game_id From Games where (Home_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Steelers') OR Away_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Steelers')) 
AND Game_Date = '11/10/2019') ,(SELECT Team_id FROM Teams where Team_Name = 'Steelers'), 1,0, 10, 0,1),
((SELECT Game_id From Games where (Home_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Black Hawks') OR Away_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Black Hawks')) 
AND Game_Date = '11/10/2019') ,(SELECT Team_id FROM Teams where Team_Name = 'Black Hawks'), 0,1, 0, 10,0),
((SELECT Game_id From Games where (Home_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Kilos') OR Away_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Kilos')) 
AND Game_Date = '11/10/2019') ,(SELECT Team_id FROM Teams where Team_Name = 'Kilos'), 3,2, 38, 35,1),
((SELECT Game_id From Games where (Home_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Lions') OR Away_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Lions')) 
AND Game_Date = '11/10/2019') ,(SELECT Team_id FROM Teams where Team_Name = 'Lions'), 0,5, 35, 38,0),

((SELECT Game_id From Games where (Home_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Blue Devils') OR Away_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Blue Devils')) 
AND Game_Date = '11/17/2019'),(SELECT Team_id FROM Teams where Team_Name = 'Blue Devils'), 1,0, 10, 17,0),
((SELECT Game_id From Games where (Home_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Dogs') OR Away_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Dogs')) 
AND Game_Date = '11/17/2019'),(SELECT Team_id FROM Teams where Team_Name = 'Dogs'), 2,0, 17, 10,1),
((SELECT Game_id From Games where (Home_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Eagles') OR Away_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Eagles')) 
AND Game_Date = '11/17/2019'),(SELECT Team_id FROM Teams where Team_Name = 'Eagles'), 1,2, 23, 26,0),
((SELECT Game_id From Games where (Home_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Tigers') OR Away_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Tigers')) 
AND Game_Date = '11/17/2019'),(SELECT Team_id FROM Teams where Team_Name = 'Tigers'), 3,1, 26, 23,1),
((SELECT Game_id From Games where (Home_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Indians') OR Away_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Indians')) 
AND Game_Date = '11/17/2019'),(SELECT Team_id FROM Teams where Team_Name = 'Indians'), 1,1, 14, 0,1),
((SELECT Game_id From Games where (Home_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Deltas') OR Away_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Deltas')) 
AND Game_Date = '11/17/2019'),(SELECT Team_id FROM Teams where Team_Name = 'Deltas'), 0,0, 0, 14,0),
((SELECT Game_id From Games where (Home_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Dodgers') OR Away_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Dodgers')) 
AND Game_Date = '11/17/2019'),(SELECT Team_id FROM Teams where Team_Name = 'Dodgers'), 0,1, 6, 42,0),
((SELECT Game_id From Games where (Home_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Steelers') OR Away_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Steelers')) 
AND Game_Date = '11/17/2019'),(SELECT Team_id FROM Teams where Team_Name = 'Steelers'), 6,0, 42, 6,1),
((SELECT Game_id From Games where (Home_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Black Hawks') OR Away_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Black Hawks')) 
AND Game_Date = '11/17/2019'),(SELECT Team_id FROM Teams where Team_Name = 'Black Hawks'), 1,3, 24, 27,0),
((SELECT Game_id From Games where (Home_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Kilos') OR Away_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Kilos')) 
AND Game_Date = '11/17/2019'),(SELECT Team_id FROM Teams where Team_Name = 'Kilos'), 2,2, 27, 24,1),
((SELECT Game_id From Games where (Home_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Lions') OR Away_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Lions')) 
AND Game_Date = '11/17/2019'),(SELECT Team_id FROM Teams where Team_Name = 'Lions'), 2,0, 14, 3,1),
((SELECT Game_id From Games where (Home_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Birds') OR Away_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Birds')) 
AND Game_Date = '11/17/2019'),(SELECT Team_id FROM Teams where Team_Name = 'Birds'), 0,0, 3, 14,0),

((SELECT Game_id From Games where (Home_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Dogs') OR Away_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Dogs')) 
AND Game_Date = '11/24/2019'),(SELECT Team_id FROM Teams where Team_Name = 'Dogs'), 1,0, 7, 16,0),
((SELECT Game_id From Games where (Home_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Indians') OR Away_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Indians')) 
AND Game_Date = '11/24/2019'),(SELECT Team_id FROM Teams where Team_Name = 'Indians'), 2,0, 16, 7,1),
((SELECT Game_id From Games where (Home_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Tigers') OR Away_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Tigers')) 
AND Game_Date = '11/24/2019'),(SELECT Team_id FROM Teams where Team_Name = 'Tigers'), 1,2, 20, 21,0),
((SELECT Game_id From Games where (Home_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Dodgers') OR Away_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Dodgers')) 
AND Game_Date = '11/24/2019'),(SELECT Team_id FROM Teams where Team_Name = 'Dodgers'), 3,1, 21, 20,1),
((SELECT Game_id From Games where (Home_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Deltas') OR Away_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Deltas')) 
AND Game_Date = '11/24/2019'),(SELECT Team_id FROM Teams where Team_Name = 'Deltas'), 1,1, 18, 0,1),
((SELECT Game_id From Games where (Home_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Black Hawks') OR Away_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Black Hawks')) 
AND Game_Date = '11/24/2019'),(SELECT Team_id FROM Teams where Team_Name = 'Black Hawks'), 0,0, 0, 18,0),
((SELECT Game_id From Games where (Home_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Steelers') OR Away_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Steelers')) 
AND Game_Date = '11/24/2019'),(SELECT Team_id FROM Teams where Team_Name = 'Steelers'), 0,1, 12, 46,0),
((SELECT Game_id From Games where (Home_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Lions') OR Away_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Lions')) 
AND Game_Date = '11/24/2019'),(SELECT Team_id FROM Teams where Team_Name = 'Lions'), 6,0, 46, 12,1),
((SELECT Game_id From Games where (Home_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Kilos') OR Away_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Kilos')) 
AND Game_Date = '11/24/2019'),(SELECT Team_id FROM Teams where Team_Name = 'Kilos'), 1,3, 26, 31,0),
((SELECT Game_id From Games where (Home_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Blue Devils') OR Away_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Blue Devils')) 
AND Game_Date = '11/24/2019'),(SELECT Team_id FROM Teams where Team_Name = 'Blue Devils'), 2,2, 26, 31,1),
((SELECT Game_id From Games where (Home_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Birds') OR Away_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Birds')) 
AND Game_Date = '11/24/2019'),(SELECT Team_id FROM Teams where Team_Name = 'Birds'), 2,0, 12, 9,1),
((SELECT Game_id From Games where (Home_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Eagles') OR Away_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Eagles')) 
AND Game_Date = '11/24/2019'),(SELECT Team_id FROM Teams where Team_Name = 'Eagles'), 0,0, 9, 12,0),

((SELECT Game_id From Games where (Home_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Black Hawks') OR Away_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Black Hawks')) 
AND Game_Date = '11/30/2019'),(SELECT Team_id FROM Teams where Team_Name = 'Black Hawks'), 1,0, 8, 20,0),
((SELECT Game_id From Games where (Home_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Dogs') OR Away_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Dogs')) 
AND Game_Date = '11/30/2019'),(SELECT Team_id FROM Teams where Team_Name = 'Dogs'), 2,0, 20, 8,1),
((SELECT Game_id From Games where (Home_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Indians') OR Away_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Indians')) 
AND Game_Date = '11/30/2019'),(SELECT Team_id FROM Teams where Team_Name = 'Indians'), 1,2, 22, 27,0),
((SELECT Game_id From Games where (Home_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Steelers') OR Away_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Steelers')) 
AND Game_Date = '11/30/2019'),(SELECT Team_id FROM Teams where Team_Name = 'Steelers'), 3,1, 27, 22,1),
((SELECT Game_id From Games where (Home_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Lions') OR Away_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Lions')) 
AND Game_Date = '11/30/2019'),(SELECT Team_id FROM Teams where Team_Name = 'Lions'), 1,1, 15, 0,1),
((SELECT Game_id From Games where (Home_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Tigers') OR Away_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Tigers')) 
AND Game_Date = '11/30/2019'),(SELECT Team_id FROM Teams where Team_Name = 'Tigers'), 0,0, 0, 15,0),
((SELECT Game_id From Games where (Home_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Dodgers') OR Away_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Dodgers')) 
AND Game_Date = '11/30/2019'),(SELECT Team_id FROM Teams where Team_Name = 'Dodgers'), 0,1, 15, 43,0),
((SELECT Game_id From Games where (Home_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Birds') OR Away_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Birds')) 
AND Game_Date = '11/30/2019'),(SELECT Team_id FROM Teams where Team_Name = 'Birds'), 6,0, 43, 15,1),
((SELECT Game_id From Games where (Home_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Eagles') OR Away_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Eagles')) 
AND Game_Date = '11/30/2019'),(SELECT Team_id FROM Teams where Team_Name = 'Eagles'), 1,3, 26, 30,0),
((SELECT Game_id From Games where (Home_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Kilos') OR Away_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Kilos')) 
AND Game_Date = '11/30/2019'),(SELECT Team_id FROM Teams where Team_Name = 'Kilos'), 2,2, 30, 26,1),
((SELECT Game_id From Games where (Home_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Blue Devils') OR Away_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Blue Devils')) 
AND Game_Date = '11/30/2019'),(SELECT Team_id FROM Teams where Team_Name = 'Blue Devils'), 2,0, 19, 6,1),
((SELECT Game_id From Games where (Home_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Deltas') OR Away_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Deltas')) 
AND Game_Date = '11/30/2019'),(SELECT Team_id FROM Teams where Team_Name = 'Deltas'), 0,0, 6, 19,0)

GO

--Create view to see Win Loss Ratio for each team
CREATE VIEW WinLossRatio
AS
select Team_Name,cast(sum(win)as float)/COUNT(win) as WinRatio from Game_stats 
inner join Teams on Game_stats.Team_ID=Teams.Team_ID
group by Team_Name

GO

--Create Procedure to show losing teams that have lost to the Blue Devils & Steelers
CREATE PROCEDURE LosingTeams(@Team_Name varchar(100))
AS
BEGIN with LoserIDs as 
	(Select case when g2.Home_Team_ID =WinTeam.Team_ID then g2.away_team_id 
			when g2.away_team_id =WinTeam.Team_ID then g2.home_team_id
			end  as Loser 
		from Teams as WinTeam, Games as g2 inner join Game_stats on g2.Game_ID = Game_Stats.Game_ID
				 where 
					game_stats.team_id = WinTeam.Team_ID and (g2.home_team_id =WinTeam.Team_ID or g2.away_team_id =WinTeam.Team_ID)
					and Game_stats.win = 1 and WinTeam.Team_Name= @Team_Name)
select Teams.Team_Name from LoserIDs
inner join Teams ON Teams.Team_ID=LoserIDs.Loser
END

GO
Declare @Team_Name varchar(100)
SET @Team_Name = 'Blue Devils'
exec LoserTeams @Team_Name

GO
Declare @Team_Name varchar(100)
SET @Team_Name = 'Steelers'
exec LoserTeams @Team_Name

GO

--Procedure to update incorrect Passing TD's for the Birds for their game on 11/10/2019
CREATE PROCEDURE UpdatePassingTDS(@Team_Name varchar(100), @Game_Date datetime, @Passing_Touchdowns int)
AS
BEGIN
UPDATE Game_Stats SET Passing_Touchdowns=@Passing_Touchdowns where Team_ID in (select Team_ID from Teams where Team_Name=@Team_Name) AND
Game_ID in (select Game_ID from Games where Game_Date=@Game_Date AND
(Home_Team_ID in(select Team_ID from Teams where Team_Name=@Team_Name)OR Away_Team_ID in(select Team_ID from Teams where Team_Name=@Team_Name)))
END

GO

Declare @Team_Name varchar(100)
SET @Team_Name = 'Birds'

Declare @Game_Date datetime
SET @Game_Date = '2019-11-10'

Declare @Passing_Touchdowns int
SET @Passing_Touchdowns = '1'
exec UpdatePassingTDS @Team_Name, @Game_Date, @Passing_Touchdowns



--Which teams have the best Total Points Scored to Total Points Allowed Ratio?
select Team_Name, cast(SUM(Total_Points_Scored)as float)/SUM(Total_Points_Allowed) as PointsScoredPointsAllowedRatio from Game_Stats
inner Join Teams on Game_Stats.Team_ID=Teams.Team_ID
group by Team_Name
Order by PointsScoredPointsAllowedRatio DESC

--Which teams have the most Passing Touchdowns?
select Team_Name, cast(SUM(Passing_Touchdowns)as float) as PassingTouchdowns from Game_Stats
inner Join Teams on Game_Stats.Team_ID=Teams.Team_ID
group by Team_Name
Order by PassingTouchdowns DESC

--Which teams have the most Rushing Touchdowns?
select Team_Name, cast(SUM(Rushing_Touchdowns)as float) as RushingTouchdowns from Game_Stats
inner Join Teams on Game_Stats.Team_ID=Teams.Team_ID
group by Team_Name
Order by RushingTouchdowns DESC

--Which Stadium has the most points scored in it?
select Stadium_Name, SUM(Total_Points_Scored) as TotalPoints from Game_Stats
inner join Games on Game_Stats.Game_ID=Games.Game_ID
inner join Stadium on Games.Stadium_ID=Stadium.Stadium_ID
group by Stadium_Name
Order by TotalPoints DESC


--Calculate Points scored when a team is Home VS. Away
with IDHome as (
select Team_ID, sum(TOtal_points_scored) as HomepointsScored from Game_Stats
inner join Games ON Game_Stats.Game_ID=games.Game_ID
where Games.Home_Team_ID=game_stats.Team_ID
group by Team_ID),
IDAway as (select Team_ID, sum(TOtal_points_scored) as AwaypointsScored from Game_Stats
inner join Games ON Game_Stats.Game_ID=games.Game_ID
where Games.Away_Team_ID=game_stats.Team_ID
group by Team_ID)

select Teams.Team_Name, IDHome.HomepointsScored, IDAway.AwaypointsScored from IDHOME
inner join IDAway ON IDHome.Team_ID=IDAway.Team_ID
inner join Teams ON Teams.Team_ID=IDAway.Team_ID










--Physical Database Design
----create tables/views/procedures/functions in repeatable form
---- create drops

----drop procedures

--IF OBJECT_ID('dbo.LosingTeams') IS NOT NULL
--	DROP PROCEDURE dbo.LosingTeams

--GO

--IF OBJECT_ID('dbo.UpdatePassingTDS') IS NOT NULL
--	DROP PROCEDURE UpdatePassingTDS


----drop views
--IF OBJECT_ID('dbo.WinLossRatio') IS NOT NULL
--	DROP VIEW dbo.WinLossRatio


----drop tables
--IF OBJECT_ID('Game_Stats') IS NOT NULL
--	DROP TABLE dbo.Game_Stats

--GO

--IF OBJECT_ID('dbo.Games') IS NOT NULL
--	DROP TABLE dbo.Games

--GO

--IF OBJECT_ID('dbo.Stadium') IS NOT NULL
--	DROP TABLE dbo.Stadium 

--GO

--IF OBJECT_ID('dbo.Teams') IS NOT NULL
--	DROP TABLE dbo.Teams

--GO
-----------------------------------------------------------------------------------
----create database tables

--CREATE TABLE Teams(
--	--create columns
--	Team_ID int identity
--	, Team_Name varchar(50) NOT NULL unique
--	--place constraints
--	, CONSTRAINT PK_Team_ID PRIMARY KEY (Team_ID)
--	)
--GO

--CREATE TABLE Stadium(
--	--create columns
--	Stadium_ID int identity
--	,Stadium_Name varchar(50)
--	--place constraints
--	, CONSTRAINT PK_Stadium PRIMARY KEY (Stadium_ID)
--	)

--GO

--CREATE TABLE Games(
--	--create columns
--	Game_ID int identity
--	, Home_Team_ID int
--	, Away_Team_ID int
--	, Stadium_ID int
--	,Game_Date datetime
--	--place constraints
--	, CONSTRAINT PF_Games Primary KEY(Game_ID)
--	, CONSTRAINT FK_Games FOREIGN KEY(Home_Team_ID) REFERENCES Teams(Team_ID)
--	, CONSTRAINT FK2_Games FOREIGN KEY(Away_Team_ID) REFERENCES Teams(Team_ID)
--	, CONSTRAINT FK3_Games FOREIGN KEY(Stadium_ID) REFERENCES Stadium(Stadium_ID)
--	)
--GO

--CREATE TABLE Game_Stats(
--	--create columns
--	Game_ID int
--	, Team_ID int 
--	, Rushing_Touchdowns int
--	, Passing_Touchdowns int
--	, Total_Points_Scored int
--	, Total_Points_Allowed int
--	, Win int
--	-- place constraints
--	, CONSTRAINT PF1_Games Foreign KEY(Game_ID) REFERENCES Games(Game_ID)
--	, CONSTRAINT FK1_Teams Foreign KEY(Team_ID) REFERENCES Teams(Team_ID)
--	, CONSTRAINT NonNegativeRushingTD Check (Rushing_Touchdowns > -1)
--	, CONSTRAINT NonNegativePassingTD Check (Passing_Touchdowns > -1)
--	, CONSTRAINT NonNegativeTotalPtsScored Check (Total_Points_Scored > -1)
--	, CONSTRAINT NonNegativeTotalPtsAllowed Check (Total_Points_Allowed > -1)
--	)

 
----Select * from Stadium
----Select * from Teams
----Select * from Games
----Select * from Game_Stats

-- GO


----insert Teams into Teams table
--INSERT INTO Teams(Team_Name)
--VALUES 
--('Eagles'),
--('Blue Devils'),
-- ('Black Hawks'),
-- ('Dodgers'),
-- ('Dogs'),
--('Tigers'),
-- ('Indians'),
-- ('Lions'),
-- ('Kilos'),
-- ('Deltas'),
-- ('Steelers'),
-- ('Birds')

--GO
 
----insert stadium info
--INSERT INTO Stadium(Stadium_Name)
--VALUES 
--('mastercard Stadium'),
--('maestro Stadium'),
--('visa Stadium'),
--('diners-club-enroute Stadium'),
--('china-unionpay Stadium'),
--('visa-electron Stadium'),
--('americanexpress Stadium'),
--('diners-club-international Stadium'),
--('solo Stadium'),
--('laser Stadium'),
--('instapayment Stadium'),
--('bankcard Stadium')
 
--GO

----insert Game info
--INSERT INTO Games(Home_Team_ID, Away_Team_ID, Stadium_ID, Game_Date) 
--VALUES   
--((SELECT Team_id FROM Teams where Team_Name = 'Birds'), (SELECT Team_id FROM Teams where Team_Name ='Blue Devils'),
--			(SELECT Stadium_ID FROM Stadium where Stadium_Name = 'instapayment Stadium'),'11/10/2019'),
--((SELECT Team_id FROM Teams where Team_Name = 'Dogs'), (SELECT Team_id FROM Teams where Team_Name ='Eagles'),
--			(SELECT Stadium_ID FROM Stadium where Stadium_Name = 'bankcard Stadium'),'11/10/2019'),
--((SELECT Team_id FROM Teams where Team_Name = 'Tigers'), (SELECT Team_id FROM Teams where Team_Name ='Indians'),
--			(SELECT Stadium_ID FROM Stadium where Stadium_Name = 'laser Stadium'),'11/10/2019'),
--((SELECT Team_id FROM Teams where Team_Name = 'Deltas'), (SELECT Team_id FROM Teams where Team_Name ='Dodgers'),
--			(SELECT Stadium_ID FROM Stadium where Stadium_Name = 'solo Stadium'),'11/10/2019'),
--((SELECT Team_id FROM Teams where Team_Name = 'Steelers'), (SELECT Team_id FROM Teams where Team_Name ='Black Hawks'),
--			(SELECT Stadium_ID FROM Stadium where Stadium_Name = 'diners-club-international Stadium'),'11/10/2019'),
--((SELECT Team_id FROM Teams where Team_Name = 'Kilos'), (SELECT Team_id FROM Teams where Team_Name ='Lions'),
--			(SELECT Stadium_ID FROM Stadium where Stadium_Name = 'americanexpress Stadium'),'11/10/2019'),

--((SELECT Team_id FROM Teams where Team_Name = 'Blue Devils'), (SELECT Team_id FROM Teams where Team_Name ='Dogs'),
--			(SELECT Stadium_ID FROM Stadium where Stadium_Name = 'visa-electron Stadium'),'11/17/2019'),
--((SELECT Team_id FROM Teams where Team_Name = 'Eagles'), (SELECT Team_id FROM Teams where Team_Name ='Tigers'),
--			(SELECT Stadium_ID FROM Stadium where Stadium_Name = 'china-unionpay Stadium'),'11/17/2019'),
--((SELECT Team_id FROM Teams where Team_Name = 'Indians'), (SELECT Team_id FROM Teams where Team_Name ='Deltas'),
--			(SELECT Stadium_ID FROM Stadium where Stadium_Name = 'diners-club-enroute Stadium'),'11/17/2019'),
--((SELECT Team_id FROM Teams where Team_Name = 'Dodgers'), (SELECT Team_id FROM Teams where Team_Name ='Steelers'),
--			(SELECT Stadium_ID FROM Stadium where Stadium_Name = 'visa Stadium'),'11/17/2019'),
--((SELECT Team_id FROM Teams where Team_Name = 'Black Hawks'), (SELECT Team_id FROM Teams where Team_Name ='Kilos'),
--			(SELECT Stadium_ID FROM Stadium where Stadium_Name = 'maestro Stadium'),'11/17/2019'),
--((SELECT Team_id FROM Teams where Team_Name = 'Lions'), (SELECT Team_id FROM Teams where Team_Name ='Birds'),
--			(SELECT Stadium_ID FROM Stadium where Stadium_Name = 'mastercard Stadium'),'11/17/2019'),

--((SELECT Team_id FROM Teams where Team_Name = 'Dogs'), (SELECT Team_id FROM Teams where Team_Name ='Indians'),
--			(SELECT Stadium_ID FROM Stadium where Stadium_Name = 'bankcard Stadium'),'11/24/2019'),
--((SELECT Team_id FROM Teams where Team_Name = 'Tigers'), (SELECT Team_id FROM Teams where Team_Name ='Dodgers'),
--			(SELECT Stadium_ID FROM Stadium where Stadium_Name = 'laser Stadium'),'11/24/2019'),
--((SELECT Team_id FROM Teams where Team_Name = 'Deltas'), (SELECT Team_id FROM Teams where Team_Name ='Black Hawks'),
--			(SELECT Stadium_ID FROM Stadium where Stadium_Name = 'solo Stadium'),'11/24/2019'),
--((SELECT Team_id FROM Teams where Team_Name = 'Steelers'), (SELECT Team_id FROM Teams where Team_Name ='Lions'),
--			(SELECT Stadium_ID FROM Stadium where Stadium_Name = 'diners-club-international Stadium'),'11/24/2019'),
--((SELECT Team_id FROM Teams where Team_Name = 'Kilos'), (SELECT Team_id FROM Teams where Team_Name ='Blue Devils'),
--			(SELECT Stadium_ID FROM Stadium where Stadium_Name = 'americanexpress Stadium'),'11/24/2019'),
--((SELECT Team_id FROM Teams where Team_Name = 'Birds'), (SELECT Team_id FROM Teams where Team_Name ='Eagles'),
--			(SELECT Stadium_ID FROM Stadium where Stadium_Name = 'instapayment Stadium'),'11/24/2019'),

--((SELECT Team_id FROM Teams where Team_Name = 'Black Hawks'), (SELECT Team_id FROM Teams where Team_Name ='Dogs'),
--			(SELECT Stadium_ID FROM Stadium where Stadium_Name = 'maestro Stadium'),'11/30/2019'),
--((SELECT Team_id FROM Teams where Team_Name = 'Indians'), (SELECT Team_id FROM Teams where Team_Name ='Steelers'),
--			(SELECT Stadium_ID FROM Stadium where Stadium_Name = 'diners-club-enroute Stadium'),'11/30/2019'),
--((SELECT Team_id FROM Teams where Team_Name = 'Lions'), (SELECT Team_id FROM Teams where Team_Name ='Tigers'),
--			(SELECT Stadium_ID FROM Stadium where Stadium_Name = 'mastercard Stadium'),'11/30/2019'),
--((SELECT Team_id FROM Teams where Team_Name = 'Dodgers'), (SELECT Team_id FROM Teams where Team_Name ='Birds'),
--			(SELECT Stadium_ID FROM Stadium where Stadium_Name = 'visa Stadium'),'11/30/2019'),
--((SELECT Team_id FROM Teams where Team_Name = 'Eagles'), (SELECT Team_id FROM Teams where Team_Name ='Kilos'),
--			(SELECT Stadium_ID FROM Stadium where Stadium_Name = 'china-unionpay Stadium'),'11/30/2019'),
--((SELECT Team_id FROM Teams where Team_Name = 'Blue Devils'), (SELECT Team_id FROM Teams where Team_Name ='Deltas'),
--			(SELECT Stadium_ID FROM Stadium where Stadium_Name = 'visa-electron Stadium'),'11/30/2019')

--GO

----insert Game Stats info
--INSERT INTO Game_Stats(Game_ID,Team_ID, Rushing_Touchdowns, Passing_Touchdowns, Total_Points_Scored, Total_Points_Allowed, Win) 
--VALUES   
--((SELECT Game_id From Games where (Home_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Birds') OR Away_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Birds')) 
--AND Game_Date = '11/10/2019') ,(SELECT Team_id FROM Teams where Team_Name = 'Birds'), 4,0, 32, 45,0),
--((SELECT Game_id From Games where (Home_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Blue Devils') OR Away_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Blue Devils')) 
--AND Game_Date = '11/10/2019') ,(SELECT Team_id FROM Teams where Team_Name = 'Blue Devils'), 3,3, 45, 32,1),
--((SELECT Game_id From Games where (Home_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Dogs') OR Away_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Dogs')) 
--AND Game_Date = '11/10/2019') ,(SELECT Team_id FROM Teams where Team_Name = 'Dogs'), 1,1, 14, 7,1),
--((SELECT Game_id From Games where (Home_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Eagles') OR Away_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Eagles')) 
--AND Game_Date = '11/10/2019') ,(SELECT Team_id FROM Teams where Team_Name = 'Eagles'), 0,1, 7, 14,0),
--((SELECT Game_id From Games where (Home_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Tigers') OR Away_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Tigers')) 
--AND Game_Date = '11/10/2019') ,(SELECT Team_id FROM Teams where Team_Name = 'Tigers'), 2,2, 27, 24,1),
--((SELECT Game_id From Games where (Home_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Indians') OR Away_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Indians')) 
--AND Game_Date = '11/10/2019') ,(SELECT Team_id FROM Teams where Team_Name = 'Indians'), 1,2, 24, 27,0),
--((SELECT Game_id From Games where (Home_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Deltas') OR Away_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Deltas')) 
--AND Game_Date = '11/10/2019') ,(SELECT Team_id FROM Teams where Team_Name = 'Deltas'), 2,3, 42, 45,0),
--((SELECT Game_id From Games where (Home_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Dodgers') OR Away_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Dodgers')) 
--AND Game_Date = '11/10/2019') ,(SELECT Team_id FROM Teams where Team_Name = 'Dodgers'), 4,1, 45, 42,1),
--((SELECT Game_id From Games where (Home_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Steelers') OR Away_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Steelers')) 
--AND Game_Date = '11/10/2019') ,(SELECT Team_id FROM Teams where Team_Name = 'Steelers'), 1,0, 10, 0,1),
--((SELECT Game_id From Games where (Home_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Black Hawks') OR Away_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Black Hawks')) 
--AND Game_Date = '11/10/2019') ,(SELECT Team_id FROM Teams where Team_Name = 'Black Hawks'), 0,1, 0, 10,0),
--((SELECT Game_id From Games where (Home_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Kilos') OR Away_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Kilos')) 
--AND Game_Date = '11/10/2019') ,(SELECT Team_id FROM Teams where Team_Name = 'Kilos'), 3,2, 38, 35,1),
--((SELECT Game_id From Games where (Home_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Lions') OR Away_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Lions')) 
--AND Game_Date = '11/10/2019') ,(SELECT Team_id FROM Teams where Team_Name = 'Lions'), 0,5, 35, 38,0),

--((SELECT Game_id From Games where (Home_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Blue Devils') OR Away_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Blue Devils')) 
--AND Game_Date = '11/17/2019'),(SELECT Team_id FROM Teams where Team_Name = 'Blue Devils'), 1,0, 10, 17,0),
--((SELECT Game_id From Games where (Home_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Dogs') OR Away_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Dogs')) 
--AND Game_Date = '11/17/2019'),(SELECT Team_id FROM Teams where Team_Name = 'Dogs'), 2,0, 17, 10,1),
--((SELECT Game_id From Games where (Home_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Eagles') OR Away_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Eagles')) 
--AND Game_Date = '11/17/2019'),(SELECT Team_id FROM Teams where Team_Name = 'Eagles'), 1,2, 23, 26,0),
--((SELECT Game_id From Games where (Home_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Tigers') OR Away_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Tigers')) 
--AND Game_Date = '11/17/2019'),(SELECT Team_id FROM Teams where Team_Name = 'Tigers'), 3,1, 26, 23,1),
--((SELECT Game_id From Games where (Home_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Indians') OR Away_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Indians')) 
--AND Game_Date = '11/17/2019'),(SELECT Team_id FROM Teams where Team_Name = 'Indians'), 1,1, 14, 0,1),
--((SELECT Game_id From Games where (Home_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Deltas') OR Away_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Deltas')) 
--AND Game_Date = '11/17/2019'),(SELECT Team_id FROM Teams where Team_Name = 'Deltas'), 0,0, 0, 14,0),
--((SELECT Game_id From Games where (Home_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Dodgers') OR Away_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Dodgers')) 
--AND Game_Date = '11/17/2019'),(SELECT Team_id FROM Teams where Team_Name = 'Dodgers'), 0,1, 6, 42,0),
--((SELECT Game_id From Games where (Home_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Steelers') OR Away_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Steelers')) 
--AND Game_Date = '11/17/2019'),(SELECT Team_id FROM Teams where Team_Name = 'Steelers'), 6,0, 42, 6,1),
--((SELECT Game_id From Games where (Home_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Black Hawks') OR Away_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Black Hawks')) 
--AND Game_Date = '11/17/2019'),(SELECT Team_id FROM Teams where Team_Name = 'Black Hawks'), 1,3, 24, 27,0),
--((SELECT Game_id From Games where (Home_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Kilos') OR Away_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Kilos')) 
--AND Game_Date = '11/17/2019'),(SELECT Team_id FROM Teams where Team_Name = 'Kilos'), 2,2, 27, 24,1),
--((SELECT Game_id From Games where (Home_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Lions') OR Away_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Lions')) 
--AND Game_Date = '11/17/2019'),(SELECT Team_id FROM Teams where Team_Name = 'Lions'), 2,0, 14, 3,1),
--((SELECT Game_id From Games where (Home_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Birds') OR Away_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Birds')) 
--AND Game_Date = '11/17/2019'),(SELECT Team_id FROM Teams where Team_Name = 'Birds'), 0,0, 3, 14,0),

--((SELECT Game_id From Games where (Home_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Dogs') OR Away_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Dogs')) 
--AND Game_Date = '11/24/2019'),(SELECT Team_id FROM Teams where Team_Name = 'Dogs'), 1,0, 7, 16,0),
--((SELECT Game_id From Games where (Home_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Indians') OR Away_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Indians')) 
--AND Game_Date = '11/24/2019'),(SELECT Team_id FROM Teams where Team_Name = 'Indians'), 2,0, 16, 7,1),
--((SELECT Game_id From Games where (Home_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Tigers') OR Away_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Tigers')) 
--AND Game_Date = '11/24/2019'),(SELECT Team_id FROM Teams where Team_Name = 'Tigers'), 1,2, 20, 21,0),
--((SELECT Game_id From Games where (Home_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Dodgers') OR Away_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Dodgers')) 
--AND Game_Date = '11/24/2019'),(SELECT Team_id FROM Teams where Team_Name = 'Dodgers'), 3,1, 21, 20,1),
--((SELECT Game_id From Games where (Home_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Deltas') OR Away_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Deltas')) 
--AND Game_Date = '11/24/2019'),(SELECT Team_id FROM Teams where Team_Name = 'Deltas'), 1,1, 18, 0,1),
--((SELECT Game_id From Games where (Home_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Black Hawks') OR Away_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Black Hawks')) 
--AND Game_Date = '11/24/2019'),(SELECT Team_id FROM Teams where Team_Name = 'Black Hawks'), 0,0, 0, 18,0),
--((SELECT Game_id From Games where (Home_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Steelers') OR Away_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Steelers')) 
--AND Game_Date = '11/24/2019'),(SELECT Team_id FROM Teams where Team_Name = 'Steelers'), 0,1, 12, 46,0),
--((SELECT Game_id From Games where (Home_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Lions') OR Away_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Lions')) 
--AND Game_Date = '11/24/2019'),(SELECT Team_id FROM Teams where Team_Name = 'Lions'), 6,0, 46, 12,1),
--((SELECT Game_id From Games where (Home_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Kilos') OR Away_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Kilos')) 
--AND Game_Date = '11/24/2019'),(SELECT Team_id FROM Teams where Team_Name = 'Kilos'), 1,3, 26, 31,0),
--((SELECT Game_id From Games where (Home_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Blue Devils') OR Away_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Blue Devils')) 
--AND Game_Date = '11/24/2019'),(SELECT Team_id FROM Teams where Team_Name = 'Blue Devils'), 2,2, 26, 31,1),
--((SELECT Game_id From Games where (Home_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Birds') OR Away_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Birds')) 
--AND Game_Date = '11/24/2019'),(SELECT Team_id FROM Teams where Team_Name = 'Birds'), 2,0, 12, 9,1),
--((SELECT Game_id From Games where (Home_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Eagles') OR Away_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Eagles')) 
--AND Game_Date = '11/24/2019'),(SELECT Team_id FROM Teams where Team_Name = 'Eagles'), 0,0, 9, 12,0),

--((SELECT Game_id From Games where (Home_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Black Hawks') OR Away_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Black Hawks')) 
--AND Game_Date = '11/30/2019'),(SELECT Team_id FROM Teams where Team_Name = 'Black Hawks'), 1,0, 8, 20,0),
--((SELECT Game_id From Games where (Home_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Dogs') OR Away_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Dogs')) 
--AND Game_Date = '11/30/2019'),(SELECT Team_id FROM Teams where Team_Name = 'Dogs'), 2,0, 20, 8,1),
--((SELECT Game_id From Games where (Home_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Indians') OR Away_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Indians')) 
--AND Game_Date = '11/30/2019'),(SELECT Team_id FROM Teams where Team_Name = 'Indians'), 1,2, 22, 27,0),
--((SELECT Game_id From Games where (Home_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Steelers') OR Away_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Steelers')) 
--AND Game_Date = '11/30/2019'),(SELECT Team_id FROM Teams where Team_Name = 'Steelers'), 3,1, 27, 22,1),
--((SELECT Game_id From Games where (Home_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Lions') OR Away_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Lions')) 
--AND Game_Date = '11/30/2019'),(SELECT Team_id FROM Teams where Team_Name = 'Lions'), 1,1, 15, 0,1),
--((SELECT Game_id From Games where (Home_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Tigers') OR Away_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Tigers')) 
--AND Game_Date = '11/30/2019'),(SELECT Team_id FROM Teams where Team_Name = 'Tigers'), 0,0, 0, 15,0),
--((SELECT Game_id From Games where (Home_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Dodgers') OR Away_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Dodgers')) 
--AND Game_Date = '11/30/2019'),(SELECT Team_id FROM Teams where Team_Name = 'Dodgers'), 0,1, 15, 43,0),
--((SELECT Game_id From Games where (Home_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Birds') OR Away_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Birds')) 
--AND Game_Date = '11/30/2019'),(SELECT Team_id FROM Teams where Team_Name = 'Birds'), 6,0, 43, 15,1),
--((SELECT Game_id From Games where (Home_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Eagles') OR Away_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Eagles')) 
--AND Game_Date = '11/30/2019'),(SELECT Team_id FROM Teams where Team_Name = 'Eagles'), 1,3, 26, 30,0),
--((SELECT Game_id From Games where (Home_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Kilos') OR Away_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Kilos')) 
--AND Game_Date = '11/30/2019'),(SELECT Team_id FROM Teams where Team_Name = 'Kilos'), 2,2, 30, 26,1),
--((SELECT Game_id From Games where (Home_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Blue Devils') OR Away_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Blue Devils')) 
--AND Game_Date = '11/30/2019'),(SELECT Team_id FROM Teams where Team_Name = 'Blue Devils'), 2,0, 19, 6,1),
--((SELECT Game_id From Games where (Home_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Deltas') OR Away_Team_ID = (SELECT Team_id FROM Teams where Team_Name = 'Deltas')) 
--AND Game_Date = '11/30/2019'),(SELECT Team_id FROM Teams where Team_Name = 'Deltas'), 0,0, 6, 19,0)

--GO 

----Create view to see Win Loss Ratio for each team
--CREATE VIEW WinLossRatio
--AS
--select Team_Name,cast(sum(win)as float)/COUNT(win) as WinRatio from Game_stats 
--inner join Teams on Game_stats.Team_ID=Teams.Team_ID
--group by Team_Name

--GO

----Create Procedure to show losing teams that have lost to a specified team
--CREATE PROCEDURE LosingTeams(@Team_Name varchar(100))
--AS
--BEGIN with LoserIDs as 
--	(Select case when g2.Home_Team_ID =WinTeam.Team_ID then g2.away_team_id 
--			when g2.away_team_id =WinTeam.Team_ID then g2.home_team_id
--			end  as Loser 
--		from Teams as WinTeam, Games as g2 inner join Game_stats on g2.Game_ID = Game_Stats.Game_ID
--				 where 
--					game_stats.team_id = WinTeam.Team_ID and (g2.home_team_id =WinTeam.Team_ID or g2.away_team_id =WinTeam.Team_ID)
--					and Game_stats.win = 1 and WinTeam.Team_Name= @Team_Name)
--select Teams.Team_Name from LoserIDs
--inner join Teams ON Teams.Team_ID=LoserIDs.Loser
--END

--GO
--Declare @Team_Name varchar(100)
--SET @Team_Name = 'Blue Devils'
--exec LoserTeams @Team_Name

--GO
--Declare @Team_Name varchar(100)
--SET @Team_Name = 'Steelers'
--exec LoserTeams @Team_Name

----Procedure to update incorrect Passing TD stats.
--CREATE PROCEDURE UpdatePassingTDS(@Team_Name varchar(100), @Game_Date datetime, @Passing_Touchdowns int)
--AS
--BEGIN
--UPDATE Game_Stats SET Passing_Touchdowns=@Passing_Touchdowns where Team_ID in (select Team_ID from Teams where Team_Name=@Team_Name) AND
--Game_ID in (select Game_ID from Games where Game_Date=@Game_Date AND
--(Home_Team_ID in(select Team_ID from Teams where Team_Name=@Team_Name)OR Away_Team_ID in(select Team_ID from Teams where Team_Name=@Team_Name)))
--END

--GO

--Declare @Team_Name varchar(100)
--SET @Team_Name = 'Birds'

--Declare @Game_Date datetime
--SET @Game_Date = '2019-11-10'

--Declare @Passing_Touchdowns int
--SET @Passing_Touchdowns = '1'
--exec UpdatePassingTDS @Team_Name, @Game_Date, @Passing_Touchdowns



----Which teams have the best Total Points Scored to Total Points Allowed Ratio?
--select Team_Name, cast(SUM(Total_Points_Scored)as float)/SUM(Total_Points_Allowed) as PointsScoredPointsAllowedRatio from Game_Stats
--inner Join Teams on Game_Stats.Team_ID=Teams.Team_ID
--group by Team_Name
--Order by PointsScoredPointsAllowedRatio DESC

----Which teams have the most Passing Touchdowns?
--select Team_Name, cast(SUM(Passing_Touchdowns)as float) as PassingTouchdowns from Game_Stats
--inner Join Teams on Game_Stats.Team_ID=Teams.Team_ID
--group by Team_Name
--Order by PassingTouchdowns DESC

----Which teams have the most Rushing Touchdowns?
--select Team_Name, cast(SUM(Rushing_Touchdowns)as float) as RushingTouchdowns from Game_Stats
--inner Join Teams on Game_Stats.Team_ID=Teams.Team_ID
--group by Team_Name
--Order by RushingTouchdowns DESC

----Which Stadium has the most points scored in it?
--select Stadium_Name, SUM(Total_Points_Scored) as TotalPoints from Game_Stats
--inner join Games on Game_Stats.Game_ID=Games.Game_ID
--inner join Stadium on Games.Stadium_ID=Stadium.Stadium_ID
--group by Stadium_Name
--Order by TotalPoints


----Calculate Points scored when a team is Home VS. Away
--with IDHome as (
--select Team_ID, sum(TOtal_points_scored) as Homepoints from Game_Stats
--inner join Games ON Game_Stats.Game_ID=games.Game_ID
--where Games.Home_Team_ID=game_stats.Team_ID
--group by Team_ID),
--IDAway as (select Team_ID, sum(TOtal_points_scored) as Awaypoints from Game_Stats
--inner join Games ON Game_Stats.Game_ID=games.Game_ID
--where Games.Away_Team_ID=game_stats.Team_ID
--group by Team_ID)

--select Teams.Team_Name, IDHome.Homepoints, IDAway.Awaypoints from IDHOME
--inner join IDAway ON IDHome.Team_ID=IDAway.Team_ID
--inner join Teams ON Teams.Team_ID=IDAway.Team_ID