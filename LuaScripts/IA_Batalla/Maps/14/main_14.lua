-- Sólo queremos ponerle comportamiento específico si estamos en la batalla histórica:

if(is_historic_battle())then
  log("Cargando batalla histórica de Austerlitz");

  include_script(MAIN_DIR.."Maps/14/austerlitz.lua");
end

evaluate_resources_ZI_default = evaluate_resources_ZI;

function evaluate_resources_ZI(interest, free_res, extra_res, busy_res)

  -- Prohibimos los objetivos de las montañas de arriba del todo
  local id = interest_GetId(interest);
  if(id==421 or id==422)then
    return false;
  end

  return evaluate_resources_ZI_default(interest, free_res, extra_res, busy_res);
  
end
