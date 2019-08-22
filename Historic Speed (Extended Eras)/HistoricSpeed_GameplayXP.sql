--========================================================================
-- SQL by p0kiehl
--========================================================================
--------------------------------------------------------------------------	
-- GlobalParameters: Adjust Era score and other factors.
--------------------------------------------------------------------------	
UPDATE GlobalParameters SET Value='54' WHERE Name='GOLDEN_AGE_SCORE_BASE_THRESHOLD'; --was 60
UPDATE GlobalParameters SET Value='27' WHERE Name='DARK_AGE_SCORE_BASE_THRESHOLD'; --was 30
UPDATE GlobalParameters SET Value='-13' WHERE Name='THRESHOLD_SHIFT_PER_PAST_DARK_AGE';
UPDATE GlobalParameters SET Value='12' WHERE Name='THRESHOLD_SHIFT_PER_PAST_GOLDEN_AGE';
UPDATE GlobalParameters SET Value='1000' WHERE Name='EMERGENCY_GOLD_PER_MEMBER_PER_ERA';
UPDATE GlobalParameters SET Value='50' WHERE Name='CIVIC_COST_PERCENT_CHANGE_AFTER_GAME_ERA';
UPDATE GlobalParameters SET Value='50' WHERE Name='TECH_COST_PERCENT_CHANGE_AFTER_GAME_ERA';
--------------------------------------------------------------------------	
-- Moments: Remove moment obsoletion for more Moment opportunities.
--------------------------------------------------------------------------	
UPDATE Moments SET ObsoleteEra=NULL;
UPDATE Moments SET MaximumGameEra=NULL;
--------------------------------------------------------------------------	
-- Eras_XP1: Adjust Era duration.
--------------------------------------------------------------------------	
UPDATE Eras_XP1 SET GameEraMinimumTurns='85' WHERE EraType='ERA_ANCIENT';
UPDATE Eras_XP1 SET GameEraMaximumTurns='125' WHERE EraType='ERA_ANCIENT';
UPDATE Eras_XP1 SET GameEraMinimumTurns='75' WHERE EraType<>'ERA_ANCIENT';
UPDATE Eras_XP1 SET GameEraMaximumTurns='115' WHERE EraType<>'ERA_ANCIENT'; 