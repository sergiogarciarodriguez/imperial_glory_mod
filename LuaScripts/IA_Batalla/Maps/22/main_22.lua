-- Sólo queremos ponerle comportamiento específico si estamos en la batalla histórica:

if(is_historic_battle())then
  log("Cargando batalla histórica de Arapiles");

  include_script(MAIN_DIR.."Maps/22/arapiles.lua");
  
else

set_ZI_ZI_params_default = set_ZI_ZI_params;
function set_ZI_ZI_params()

  set_ZI_ZI_params_default();
  
  zizi_factor_casas = 2;
  zizi_factor_bosques = 0.5;
  zizi_factor_alturas = 0.2;
  zizi_factor_combo = 0;
  zizi_factor_dist  = 3;
  zizi_max_casas = 2;
  zizi_factor_map_border = 0;
end

  
end