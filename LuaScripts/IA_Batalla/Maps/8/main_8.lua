log("Now loading Paris Map");

--------------------------------------------------------------------------

local iObjMapID = 0;
if is_total_victory() then
  iObjMapID = 1638;
end;

-- Enfrente de la Madeleine
create_StrategicZoneInterest(1, 22619, 49211, 180, false, false, true, iObjMapID);

change_ConquestZone_MinTroopPercentEsperando( -1.0 );

-- No queremos que salga a por el enemigo
change_ConquestZone_DetectOpportunities( false );
log("Disabling ConquestZone_DetectOpportunities Feature");

-----------------------------------------------
--
-----------------------------------------------
function actions_with_objective(objective)
  local interest = objective_GetInterest(objective);
  if interest ~= nil and interest_GetId(interest) == iObjMapID then
    objective_setCZ_IFCenter(objective, 22439, 51713);
  end
end

-----------------------------------------------
--
-----------------------------------------------
--function actions_with_objective(objective)

  -- esto es una prueba, se se descomenta la linea de código le digo
  -- que vayan el 30% de las tropas a por el objetivo por el flanco
--  objective_setATFlankTroopsPer(objective, 0.3);
--end

evaluate_resources_OM_default = evaluate_resources_OM;
-----------------------------------------------
--
-----------------------------------------------
function evaluate_resources_OM(interest, free_res, extra_res, busy_res)
  return evaluate_resources_OM_default(interest, free_res, extra_res, busy_res);
end

-----------------------------------------------
--
-----------------------------------------------
function evaluate_resources_EE(interest, free_res, extra_res, busy_res)

  log("*EVALRES:  COGE TODO " .. get_interest_text(interest));
  interest_TakeResources(interest, free_res);
  interest_TakeResources(interest, extra_res);
  interest_TakeResources(interest, busy_res);
  
  return true;

end



find_winner_interest_default = find_winner_interest;
-----------------------------------------------
--
-----------------------------------------------
function find_winner_interest(interests)

  local retInterest = nil;
  
  if iam_attacker() then
    -- Atacar por la plaza o directamente a la Madeleine?
    return find_winner_interest_default(interests);
  else
    for i = 1,table.getn(interests) do
      local interest = interests[i];
      if interest_GetId(interest)==iObjMapID then
        retInterest = interest;
      end
    end
  end
  
  return retInterest;
end