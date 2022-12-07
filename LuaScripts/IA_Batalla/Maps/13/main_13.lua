-- "Viena" Map

log("Now loading Viena Map");

local iObjMapID = 0;
if is_total_victory() then
  iObjMapID = 1179;
end;

change_ConquestZone_FeaturesRadius(20000);
log("ConquesZone Features Radius changed to 20000");

change_ConquestZone_MinTroopPercentEsperando( -1.0 );

-- No queremos que salga a por el enemigo
change_ConquestZone_DetectOpportunities( false );
log("Disabling ConquestZone_DetectOpportunities Feature");

-- PARAMS: Prioridad, x, y, angulo, infanteria, caballeria, artilleria

-- Cubriendo rampa izquierda
create_StrategicZoneInterest(1, 22744, 49691, 180, false, false, true, iObjMapID);

-- Cubriendo rampa derecha
create_StrategicZoneInterest(1, 52421, 50150, 180, false, false, true, iObjMapID);

-- Centro del patio
create_StrategicZoneInterest(1234, 33324, 52909, 180, true, false, false, iObjMapID);

-- Parte de atras, despliegue por defecto
create_StrategicZoneInterest(2, 34935, 60159, 180, true, true, true, iObjMapID);


--------------------------------------------------------------------------

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


find_winner_interest_default = find_winner_interest;

-----------------------------------------------
--
-----------------------------------------------
function find_winner_interest(interests)

  local retInterest = nil;
  
  if iam_attacker() then
    return find_winner_interest_default(interests);
  else
    for i = 1,table.getn(interests) do
      local interest = interests[i];
--      if interest_GetType(interest)==TI_OBJETIVO_MAPA then
      if(interest_GetId(interest)==iObjMapID) then
        retInterest = interest;
      end
    end
  end
  
  return retInterest;
end