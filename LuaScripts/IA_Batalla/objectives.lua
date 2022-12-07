--------------------------------------------------------------------------------
-- HOW IT WORKS
--------------------------------------------------------------------------------
-- Here's how it is.
-- This script is in charge of deciding which objectives will the CPU attempt
-- to accomplish, and with what troops.
-- 
-- It's a two stage process:
-- * First, each potential objective (called interest) evaluates how many and
--   which troops it might need in case the CPU started pursuing it.
--   The choice might range from getting everything (for one concentrated attack)
--   to selecting only troops of a specific kind.
--   The function 'evaluate_necessary_resources' is called and the interest reserves
--   the troops it likes and returns whether it is happy and wants to try and
--   become a full-fledged objective. 
-- 
-- * Second, the available and happy interests enter a competition, to see which
--   one is more worthy. There can be only one.
--   Criteria to select one interest over another include type of interest (it
--   can be a map objective, an enemy army, a mountain, etc), situation of the
--   battle (I am the attacker/defender, I'm winning/losing, etc).
--   The function 'select_winner_interest' receives an array with the remaining
--   interests and must return the winner. Returning 'nil' means that no
--   objective will be created.
-- 
-- This process will keep executing while there are troops and interests available
-- 
-- List of available functions (in no particular order):
-- 
-- bool             fp_Less                (fightpower fp1, fightpower fp2);
-- fightpower       calc_fightpower        (vector<troop> troops);
-- num              fp_get_global          (fightpower fp);
-- bool             iam_attacker           ();
-- bool             bridgeInTheMiddle      (num x_bridge, num y_bridge, num x_other, num y_other);
-- num              num_map_objectives     ();
-- num              get_influence          (num x, num y, bool count_friends, vector<troop> excluded_friends);
-- bool             is_total_victory       ();
-- num              num_enemy_groups       ();
-- vector<interest> get_map_objectives     (interest i); -- Returns all map interests that must be fulfilled together with the arg
-- number           fp_get_reference_global();
-- void             set_AttackTroops_FlankVars(num p, num v, num m)
--
-- string           interest_GetType       (interest i);
-- num              interest_GetId         (interest i);
-- void             interest_TakeResources (interest i, vector<troop> troops);
-- num, num         interest_GetPos        (interest i);
-- num              interest_MyDist        (interest i);
-- num              interest_DistEnemy     (interest i);
-- bool             interest_HasObjective  (interest i);
-- bool             interest_IsEnemyThere  (interest i);
-- bool             accomplished_Objective (interest i);
-- num, num, num    interest_GetTerrain    (interest i);
-- num              interest_DistResource  (interest i, troop t);
-- bool             interest_ObjHasRes     (interest i, troop t);
-- bool             interest_Ratified      (interest i);
-- vector<troop>    interest_GetResoures   (interest i);
--
-- string           res_GetInfo            (troop t);
-- bool             res_IsArtillery        (troop t);
-- bool             res_IsCavalry          (troop t);
-- bool             res_IsInfantry         (troop t);
-- bool             res_IsCannon           (troop t);
-- bool             res_IsObus             (troop t);
-- bool             res_IsShootingInfantry (troop t);
-- bool             res_IsMilitia          (troop t);
--
-- void             objective_setATFlankTroopsPer(objective o, num p)
--
-- void             log                    (string text);
-- num, string      get_map                ();
-- 


--------------------------------------------------------------------------------
-- Declaraciones de las funciones
--------------------------------------------------------------------------------
EVALUATE_NECESSARY_RESOURCES = "evaluate_necessary_resources";
SELECT_WINNER_INTEREST = "select_winner_interest";
ACTIONS_WITH_OBJECTIVE = "actions_with_objective";
FILTER_INTERESTS = "filter_interests";

include_script("IA_Batalla/utils.lua");
include_script("IA_Batalla/resources.lua"); -- Contiene la evaluacion de recursos para cada interes
include_script("IA_Batalla/prioridad.lua"); -- Contiene la seleccion del mejor interes
include_script("IA_Batalla/objective_funcs.lua"); -- Contiene las acciones a realizar con los objetivos recién creados

--------------------------------------------------
-- Esto lo usamos para tener scripts en local
--------------------------------------------------
if file_exists("IA_Batalla/para_mis_cosas_no_subir.lua") then
  include_script("IA_Batalla/para_mis_cosas_no_subir.lua")
end
--------------------------------------------------
--------------------------------------------------
