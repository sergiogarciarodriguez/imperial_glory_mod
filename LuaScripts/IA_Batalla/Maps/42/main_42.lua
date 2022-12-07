-- Sólo queremos ponerle comportamiento específico si estamos en la batalla histórica:

if(is_historic_battle())then
  log("Cargando batalla histórica de Pirámides");

  include_script(MAIN_DIR.."Maps/42/piramides.lua");
end