--========================================================================
-- SQL by p0kiehl
--========================================================================
--------------------------------------------------------------------------	
-- Types
--------------------------------------------------------------------------	
INSERT INTO Types
		(Type,								Kind)
VALUES	('POK_PROJECT_LOCAL_FESTIVITIES',	'KIND_PROJECT');
--------------------------------------------------------------------------	
-- Projects
--------------------------------------------------------------------------	
INSERT INTO Projects
	   (ProjectType,
       Name,
       ShortName,
       Description,
       PopupText,
       Cost,
       CostProgressionModel,
       CostProgressionParam1,
       PrereqTech,
       PrereqCivic,
       PrereqDistrict,
       VisualBuildingType,
       SpaceRace,
       OuterDefenseRepair,
       MaxPlayerInstances,
       AmenitiesWhileActive,
       PrereqResource,
       AdvisorType)
SELECT 'POK_PROJECT_LOCAL_FESTIVITIES', --project
       'LOC_POK_PROJECT_LOCAL_FESTIVITIES_NAME', --name
       'LOC_POK_PROJECT_LOCAL_FESTIVITIES_SHORT_NAME', --short name
       'LOC_POK_PROJECT_LOCAL_FESTIVITIES_DESCRIPTION', --description
       PopupText,
       Cost,
       CostProgressionModel,
       CostProgressionParam1,
       'TECH_POTTERY', --prereq tech
       PrereqCivic,
       'DISTRICT_CITY_CENTER', --prereq district
       VisualBuildingType,
       SpaceRace,
       OuterDefenseRepair,
       MaxPlayerInstances,
       '1', --amenities while active
       PrereqResource,
       AdvisorType
  FROM Projects WHERE ProjectType='PROJECT_CARNIVAL';
--------------------------------------------------------------------------	
-- Project_YieldConversions
--------------------------------------------------------------------------	
INSERT INTO Project_YieldConversions
		(ProjectType,						YieldType,		PercentOfProductionRate)
VALUES	('POK_PROJECT_LOCAL_FESTIVITIES',	'YIELD_GOLD',	'15');
