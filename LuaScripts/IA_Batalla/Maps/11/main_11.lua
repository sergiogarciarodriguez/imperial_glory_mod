--------------------------------------------------------------------
-- Mapa de Silesia
--------------------------------------------------------------------

log("Script de Silesia");

evaluate_resources_ZI_default = evaluate_resources_ZI;

function evaluate_resources_ZI(interest, free_res, extra_res, busy_res)

  -- Prohibimos los objetivos de las montañas pegadas al borde
  local id = interest_GetId(interest);
  if(id==347 or id==348 or id==345 or id==346)then
    return false;
  end

  return evaluate_resources_ZI_default(interest, free_res, extra_res, busy_res);
  
end


set_ZI_ZI_params_default = set_ZI_ZI_params;
function set_ZI_ZI_params()

  set_ZI_ZI_params_default();
  
  zizi_factor_casas = 0;
  zizi_factor_bosques = 0;
  zizi_factor_combo = 0;
  zizi_factor_dist  = 1;
  zizi_max_alturas = 30;
  zizi_factor_alturas = 1;
end
