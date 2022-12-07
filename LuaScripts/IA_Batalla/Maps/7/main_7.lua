--------------------------------------------------------------------
-- Mapa de Toulouse / Provence
--------------------------------------------------------------------

log("Script de Provence");

evaluate_resources_ZI_default = evaluate_resources_ZI;

function evaluate_resources_ZI(interest, free_res, extra_res, busy_res)

  -- Prohibimos los objetivos de las montañas pegadas al borde
  local id = interest_GetId(interest);
  if(id==431 or id==430 or id==428 or id==429 or id==427)then
    return false;
  end

  return evaluate_resources_ZI_default(interest, free_res, extra_res, busy_res);
  
end
