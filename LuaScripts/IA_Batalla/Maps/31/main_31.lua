--------------------------------------------------------------------
-- Mapa de Balcanes
--------------------------------------------------------------------

log("Script de Balcanes");

evaluate_resources_ZI_default = evaluate_resources_ZI;

function evaluate_resources_ZI(interest, free_res, extra_res, busy_res)

  -- Prohibimos los objetivos de las montañas pegadas al borde
  local id = interest_GetId(interest);
  if(id==534 or id==535 or id==533 or id==532 or id==536)then
    return false;
  end

  return evaluate_resources_ZI_default(interest, free_res, extra_res, busy_res);
  
end


set_ZI_ZI_params_default = set_ZI_ZI_params;
function set_ZI_ZI_params()

  set_ZI_ZI_params_default();
  
  zizi_factor_combo = 0;
  zizi_max_casas   = 1;
  zizi_max_alturas = 40;
end
