--========================================================================
-- SQL by p0kiehl, with much credit to Oleus
--========================================================================	
-- Boosts: Reduce boosts to 20%.
--------------------------------------------------------------------------	
UPDATE Boosts SET Boost = '20';
--------------------------------------------------------------------------	
-- GlobalParameters: Various tweaks.
--------------------------------------------------------------------------	
UPDATE GlobalParameters SET Value=26 WHERE Name='CULTURE_PERCENTAGE_YIELD_PER_POP';
UPDATE GlobalParameters SET Value=48 WHERE Name='SCIENCE_PERCENTAGE_YIELD_PER_POP';
UPDATE GlobalParameters SET Value=1.8 WHERE Name='CITY_GROWTH_EXPONENT'; --was 1.5. 
--------------------------------------------------------------------------	
-- Civics: Multiply Civic costs by 3 for a baseline. 
-- Make Code of Laws a bit cheaper so the beginning isn't a slog.
--------------------------------------------------------------------------
UPDATE Civics SET Cost=Cost*3;
UPDATE Civics SET Cost = Cost*0.75 WHERE CivicType='CIVIC_CODE_OF_LAWS';
--------------------------------------------------------------------------	
-- Eras: Increase Great Person costs by 3.
--------------------------------------------------------------------------
UPDATE Eras SET GreatPersonBaseCost=GreatPersonBaseCost*3;
--------------------------------------------------------------------------	
-- Technologies: Increase Tech costs by 3 for a baseline. Make the 
-- beginning Techs a bit cheaper so the beginning isn't a slog.
--------------------------------------------------------------------------
UPDATE Technologies SET Cost=Cost*3;
-- UPDATE Technologies SET Cost= Cost*.85 WHERE TechnologyType='TECH_POTTERY';
-- UPDATE Technologies SET Cost= Cost*.85 WHERE TechnologyType='TECH_MINING';
-- UPDATE Technologies SET Cost= Cost*.85 WHERE TechnologyType='TECH_ANIMAL_HUSBANDRY';
-- UPDATE Technologies SET Cost= Cost*.85 WHERE TechnologyType='TECH_SAILING';
--------------------------------------------------------------------------	
-- EraIncreases: Thanks to Oleus for this table. This will allow us to
-- further increase costs by era.
--------------------------------------------------------------------------
CREATE TABLE EraIncreases
	(
	EraType TEXT NOT NULL,
	Increase INT
	);

INSERT INTO EraIncreases
	VALUES	("ERA_ANCIENT",0),
			("ERA_CLASSICAL", 32),
			("ERA_MEDIEVAL", 55), --changed from 50
			("ERA_RENAISSANCE", 85), --changed from 80
			("ERA_INDUSTRIAL", 130), --changed from 125
			("ERA_MODERN", 170), --changed from 165
			("ERA_ATOMIC", 220), --changed from 215
			("ERA_INFORMATION", 270), --changed from 265
			("ERA_FUTURE", 325);

UPDATE Technologies
	SET Cost = ROUND(Cost + Cost*(SELECT EraIncreases.Increase
		FROM EraIncreases 
		WHERE EraIncreases.EraType = Technologies.EraType)/100);

UPDATE Civics
	SET Cost = ROUND(Cost + Cost*(SELECT EraIncreases.Increase
		FROM EraIncreases 
		WHERE EraIncreases.EraType = Civics.EraType)/100);

UPDATE Eras
	SET GreatPersonBaseCost = ROUND(GreatPersonBaseCost + GreatPersonBaseCost*(SELECT EraIncreases.Increase
		FROM EraIncreases 
		WHERE EraIncreases.EraType = Eras.EraType)/200);

-- Drop the temporary table created
DROP TABLE EraIncreases;
--------------------------------------------------------------------------	
-- Routes: Make roads better. Again, adapted from Oleus.
--------------------------------------------------------------------------	
--Make roads more useful. Industrial roads now become Renaissance roads.
UPDATE Routes SET MovementCost='0.75'	WHERE RouteType='ROUTE_ANCIENT_ROAD'; --was 1
UPDATE Routes SET MovementCost='0.75'	WHERE RouteType='ROUTE_MEDIEVAL_ROAD'; --was 1
UPDATE Routes SET MovementCost='0.5',	PrereqEra='ERA_RENAISSANCE' WHERE RouteType='ROUTE_INDUSTRIAL_ROAD'; --was 0.75
UPDATE Routes SET MovementCost='0.375'	WHERE RouteType='ROUTE_MODERN_ROAD'; --was 0.5
--------------------------------------------------------------------------	
-- Units: Increase maintenance across the board.
--------------------------------------------------------------------------
UPDATE Units SET Maintenance=Maintenance+1 WHERE FormationClass<>'FORMATION_CLASS_CIVILIAN' OR Spy='1';
UPDATE Units SET Cost=Cost*1.1;
--------------------------------------------------------------------------	
-- GameSpeed_Turns: Alter Calendar. 100% thanks Desucrate.
--------------------------------------------------------------------------
DELETE FROM GameSpeed_Turns WHERE GameSpeedType='GAMESPEED_STANDARD';

INSERT INTO GameSpeed_Turns
        (GameSpeedType,			MonthIncrement, TurnsPerIncrement)
VALUES  ('GAMESPEED_STANDARD',	'480',           '70'),
        ('GAMESPEED_STANDARD',  '216',           '34'),
        ('GAMESPEED_STANDARD',  '180',           '16'),
        ('GAMESPEED_STANDARD',  '120',           '79'),
        ('GAMESPEED_STANDARD',  '420',           '10'),
        ('GAMESPEED_STANDARD',  '120',           '53'),
        ('GAMESPEED_STANDARD',  '60',            '38'),
        ('GAMESPEED_STANDARD',  '48',            '50'),
        ('GAMESPEED_STANDARD',  '30',            '50'),
        ('GAMESPEED_STANDARD',  '8',             '113'),
        ('GAMESPEED_STANDARD',  '6',             '150'),
        ('GAMESPEED_STANDARD',  '4',             '120');