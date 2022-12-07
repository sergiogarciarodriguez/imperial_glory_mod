--------------------------------------------------------------------
-- Mapa de Irlanda
--------------------------------------------------------------------

log("Script de Irlanda");

evaluate_resources_ZI_default = evaluate_resources_ZI;

function evaluate_resources_ZI(interest, free_res, extra_res, busy_res)

  -- Prohibimos los objetivos de las montañas pegadas al borde
  local id = interest_GetId(interest);
  if(id==126 or id==125 or id==128 or id==127)then
    return false;
  end

  return evaluate_resources_ZI_default(interest, free_res, extra_res, busy_res);
  
end