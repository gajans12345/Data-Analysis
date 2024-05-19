-- TOP PERFORMERS IN VARIOUS STATS along with season they occured in
SELECT TOP 1 Player,SeasonType,YEARR, MAX(PTS)
FROM NBA
WHERE PTS = (SELECT MAX(PTS) FROM NBA)
GROUP BY Player,SeasonType,YEARR
Order By MAX(PTS) DESC


SELECT TOP 1 Player,SeasonType,YEARR,max(REB)
FROM NBA
WHERE REB = (SELECT MAX(REB) FROM NBA)
GROUP BY Player,SeasonType,YEARR
Order By MAX(REB) DESC


SELECT TOP 1 Player,SeasonType,YEARR, max(AST)
FROM NBA
WHERE AST = (SELECT MAX(AST) FROM NBA)
GROUP BY Player,SeasonType,YEARR
Order By MAX(AST) DESC


SELECT TOP 1 Player,SeasonType,YEARR, max(STL)
FROM NBA
WHERE STL = (SELECT MAX(STL) FROM NBA)
GROUP BY Player,SeasonType,YEARR
Order By MAX(STL) DESC


SELECT TOP 1 Player,SeasonType,YEARR,max(BLK)
FROM NBA
WHERE BLK = (SELECT MAX(BLK) FROM NBA)
GROUP BY Player,SeasonType,YEARR
Order By MAX(BLK) DESC

-- Player Averages

SELECT Player,AVG(PTS)[Points],AVG(REB)[Rebounds],AVG(AST)[Assists],AVG(STL)[Steals], AVG(BLK)[Blocks]
FROM NBA
WHERE SeasonType = 'Regular Season'
GROUP BY Player

--Changing column name

EXEC sp_rename 'NBA.Year', 'YEARR', 'COLUMN';

--Adding info on 2 pointers
ALTER TABLE NBA
ADD FG2M FLOAT; 

UPDATE NBA
SET FG2M = FGM - FG3M;
-- Bar graph on the 3 pointers attempted of championship team
SELECT TOP 4 Team, SUM(FG3A) [Three Pointers Attempted]
FROM NBA
WHERE SeasonType = 'Playoffs' AND Team IN ('GSW','TOR','LAL','MIL','DEN')
GROUP BY Team, YEARR
ORDER BY YEARR DESC;

-- Line graph or smtng of 3 pointers mader per season over time
SELECT YEARR,SUM(FG3M) [3 Pointers Made]
FROM NBA
GROUP BY YEARR
ORDER BY YEARR ASC;

--Pie chart comparing players based on where they get their poins from
SELECT Player, (SUM(FTM) / SUM(pts)) * 100 AS FT_Percentage,((SUM(FG3M) * 3) / SUM(PTS)) * 100 AS Three_Point_Percentage, ((SUM(FG2M) * 2) / SUM(PTS)) * 100 AS Two_Point_Percentage
FROM NBA
WHERE YEARR = '2016-17'
GROUP BY Player;

--Line graph comparing points of giannis, lebron and kyle lowry
SELECT Player, AVG(PTS),YEARR
FROM NBA
WHERE Player IN ('Lebron James', 'Kyle Lowry','Giannis Antetokounmpo')
GROUP BY Player,YEARR

