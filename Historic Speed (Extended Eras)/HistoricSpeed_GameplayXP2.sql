--========================================================================
-- SQL by p0kiehl, with much credit to Oleus
--========================================================================	
-- CivicRandomCosts: Multiply by 3.
--------------------------------------------------------------------------	
UPDATE CivicRandomCosts SET Cost=Cost*3;
--------------------------------------------------------------------------
-- TechnologyRandomCosts: Multiply by 3.
--------------------------------------------------------------------------	
UPDATE TechnologyRandomCosts SET Cost=Cost*3;
--------------------------------------------------------------------------
-- EraIncreasesXP2: Increase by era.
--------------------------------------------------------------------------	
CREATE TABLE EraIncreasesXP2
	(
	EraType TEXT NOT NULL,
	Increase INT
	);

INSERT INTO EraIncreasesXP2
	VALUES	("ERA_ANCIENT",0),
			("ERA_CLASSICAL", 32),
			("ERA_MEDIEVAL", 55), --changed from 50
			("ERA_RENAISSANCE", 85), --changed from 80
			("ERA_INDUSTRIAL", 130), --changed from 125
			("ERA_MODERN", 170), --changed from 165
			("ERA_ATOMIC", 220), --changed from 215
			("ERA_INFORMATION", 265), --changed from 265
			("ERA_FUTURE", 325);

UPDATE TechnologyRandomCosts
    SET Cost = ROUND(Cost + Cost*(SELECT EraIncreasesXP2.Increase
        FROM EraIncreasesXP2 
        WHERE EraIncreasesXP2.EraType = (SELECT Technologies.EraType FROM Technologies WHERE Technologies.TechnologyType = TechnologyRandomCosts.TechnologyType))/100);

UPDATE CivicRandomCosts
    SET Cost = ROUND(Cost + Cost*(SELECT EraIncreasesXP2.Increase
        FROM EraIncreasesXP2 
        WHERE EraIncreasesXP2.EraType = (SELECT Civics.EraType FROM Civics WHERE Civics.CivicType = CivicRandomCosts.CivicType))/100);

-- Drop the temporary table created
DROP TABLE EraIncreasesXP2;

--------------------------------------------------------------------------
-- Maps_XP2: Increase CO2 thresholds to compensate for longer eras.
--------------------------------------------------------------------------	
UPDATE Maps_XP2 SET CO2For1DegreeTempRise=CO2For1DegreeTempRise*3;
--------------------------------------------------------------------------
-- Resource_Consumption: Decrease CO2 output by a factor of 3 to
-- compensate for the longer eras and higher unit numbers.
--------------------------------------------------------------------------	
UPDATE Resource_Consumption SET CO2perkWh = CO2perkWh * .5;