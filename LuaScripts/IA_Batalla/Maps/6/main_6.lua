--------------------------------------------------------------------
-- Mapa de Burdeos (Aquitania)
--------------------------------------------------------------------

evaluate_resources_ZI_default = evaluate_resources_ZI;

function evaluate_resources_ZI(interest, free_res, extra_res, busy_res)

  local id = interest_GetId(interest);
  if(id==281)then
    return false;
  end

  return evaluate_resources_ZI_default(interest, free_res, extra_res, busy_res);
  
end