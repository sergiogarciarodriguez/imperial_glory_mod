--------------------------------------------------------------------
-- Mapa de Champagne
--------------------------------------------------------------------

-- Creamos una nueva zona interesante
local newID = IM_CreateNewZonaInteresante();

-- Si sale bien, metemos las dos casas en la zona nueva
if newID ~= -1 then
  IM_AddInteresToZonaInteresante( newID, 199 );
  IM_AddInteresToZonaInteresante( newID, 200 );
end

evaluate_resources_ZI_default = evaluate_resources_ZI;
function evaluate_resources_ZI(interest, free_res, extra_res, busy_res)

  -- Prohibimos los objetivos que no molan
  local id = interest_GetId(interest);
  if(id==411 or id==409 or id==410)then
    return false;
  end

  return evaluate_resources_ZI_default(interest, free_res, extra_res, busy_res);
  
end

