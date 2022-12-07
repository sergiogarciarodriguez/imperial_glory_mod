-- "Moscu" map

log("Loading Moscu map ...")

-------------------------------------------------------------------------

evaluate_resources_ZI_default = evaluate_resources_ZI;

function evaluate_resources_ZI(interest, free_res, extra_res, busy_res)

  -- Prohibimos los objetivos de las montañas de arriba del todo
  local id = interest_GetId(interest);
  if(id==237 or id==244 or id==246)then
    return false;
  end

  return evaluate_resources_ZI_default(interest, free_res, extra_res, busy_res);
  
end
