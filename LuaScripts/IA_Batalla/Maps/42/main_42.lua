-- S�lo queremos ponerle comportamiento espec�fico si estamos en la batalla hist�rica:

if(is_historic_battle())then
  log("Cargando batalla hist�rica de Pir�mides");

  include_script(MAIN_DIR.."Maps/42/piramides.lua");
end