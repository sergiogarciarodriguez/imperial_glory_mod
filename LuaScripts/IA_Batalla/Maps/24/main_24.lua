-------------------------------------------------------------------------------
-- Mapa de la batalla histórica de Fritzburg
-------------------------------------------------------------------------------

if(is_historic_battle())then
  log("Cargando batalla histórica de Friedland");

  include_script(MAIN_DIR.."Maps/24/fritzburg.lua");
  
else

-- QUICK GAME

evaluate_resources_ZI_default = evaluate_resources_ZI;

function evaluate_resources_ZI(interest, free_res, extra_res, busy_res)

  -- Prohibimos los objetivos de las montañas pegadas al borde
  local id = interest_GetId(interest);
  if(id==412 or id==415 or id==416 or id==413 or id==414 or id==401 or id==417 or id==411 or id==405)then
    return false;
  end

  return evaluate_resources_ZI_default(interest, free_res, extra_res, busy_res);
  
end

set_ZI_ZI_params_default = set_ZI_ZI_params;
function set_ZI_ZI_params()

  set_ZI_ZI_params_default();
  
  zizi_factor_map_border = 2;
  zizi_factor_bosques = 0;
end

  
end

-- Deshabilitamos esta feature porque en este mapa queda rara.
change_ConquestZone_UseElevatedCannons( false );