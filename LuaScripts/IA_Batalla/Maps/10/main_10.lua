-- "Bradengurg" Map

log("Now loading Bradenburg Map");

change_ConquestZone_FeaturesRadius(21000);
log("ConquesZone Features Radius changed to 21000");

-- No queremos que salga a por el enemigo
change_ConquestZone_DetectOpportunities( false );
log("Disabling ConquestZone_DetectOpportunities Feature");

-- Creamos algún interés de zona estratégica y eso...
log("Creating strategic zone interests:");

create_StrategicZoneInterest(1.0, 24961.0, 31161.0, 180.0, false, false, true, 53);
log("  - strategic zone: pos = (24961.0, 31161.0), pri = 1.0, inf = false, cav = false, art = true");

create_StrategicZoneInterest(2.0, 21291.0, 31167.0, 180.0, false, false, true, 53);
log("  - strategic zone: pos = (21291.0, 31167.0), pri = 2.0, inf = false, cav = false, art = true");

create_StrategicZoneInterest(3.0, 28588.0, 30856.0, 180.0, false, false, true, 53);
log("  - strategic zone: pos = (28588.0, 30856.0), pri = 3.0, inf = false, cav = false, art = true");

-- Creamos dos zonas estrategicas grandes para absorber exceso de tropas
create_StrategicZoneInterest(4.0, 18450.0, 32323.0, 180.0, true, false, false, 53);
log("  - strategic zone: pos = (18450.0, 32323.0), pri = 3.0, inf = true, cav = false, art = false");

create_StrategicZoneInterest(5.0, 32000.0, 32323.0, 180.0, true, false, false, 53);
log("  - strategic zone: pos = (32000.0, 32323.0), pri = 3.0, inf = true, cav = false, art = false");

-- Nos saltamos la fase de acercarnos para que la gente vaya directamente a sus puestos
change_ConquestZone_MinTroopPercentEsperando( -1.0 );

--------------------------------------------------------------------------

-----------------------------------------------
--
-----------------------------------------------
function actions_with_objective(objective)
  local interest = objective_GetInterest(objective);
  local iPalaceID = 0;
  if is_total_victory() then
	iPalaceID = 53;
  end;
  if interest ~= nil and interest_GetId(interest) == iPalaceID then
    objective_setCZ_IFCenter(objective, 26470.936, 32242.580);
  end
end

-----------------------------------------------
-- Reescribo la función para evaluar recursos en los objetivos de mapa
-- para evitar problemas con los 3 objetivos 
-----------------------------------------------
--function evaluate_resources_OM(interest, free_res, extra_res, busy_res)
--
--  return false;
--  
--end

-----------------------------------------------
--
-----------------------------------------------
--function evaluate_resource_EE(interest, free_res, extra_res, busy_res)
--
--  return false;
--
--end

-----------------------------------------------
--
-----------------------------------------------
function evaluate_resources_ZI(interest, free_res, extra_res, busy_res)

--  local bRet = false;
--  if(interest_GetId(interest)==54)then
    interest_TakeResources(interest, free_res);
    interest_TakeResources(interest, extra_res);
    interest_TakeResources(interest, busy_res);
    bRet = true;
--  end

  return bRet;
  
end

-----------------------------------------------
--
-----------------------------------------------
find_winner_interest_default = find_winner_interest;

function find_winner_interest(interests)

  local retInterest = nil;
  local iPalaceID = 0;

  if iam_attacker() then
    return find_winner_interest_default(interests);
  else
    if is_total_victory() then
      iPalaceID = 53;
    end;    
	for i = 1,table.getn(interests) do
      local interest = interests[i];
      if(interest_GetId(interest)==iPalaceID) then
        retInterest = interest;
      end
    end
  end
  
  return retInterest;
end