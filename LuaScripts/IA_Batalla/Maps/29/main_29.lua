-- "Algarve" map

log("Loading Algarve map ...")

-------------------------------------------------------------------------

evaluate_resources_ZI_default = evaluate_resources_ZI;

function evaluate_resources_ZI(interest, free_res, extra_res, busy_res)

  -- Prohibimos los objetivos de las montañas de arriba del todo
  local id = interest_GetId(interest);
  if(id==316 or id==317 or id==319 or id==321 or id==318 or id==320 or id==314)then
    return false;
  end

  return evaluate_resources_ZI_default(interest, free_res, extra_res, busy_res);
  
end
