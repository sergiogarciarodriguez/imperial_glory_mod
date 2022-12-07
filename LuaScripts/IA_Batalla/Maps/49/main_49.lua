-- Sólo queremos ponerle comportamiento específico si estamos en la batalla histórica:

if(is_historic_battle())then
  log("Cargando batalla histórica de Waterloo");

  include_script(MAIN_DIR.."Maps/49/waterloo.lua");
end

iam_attacker_default = iam_attacker;

function iam_attacker()

  local desperado = iam_desperate();
  
  return (desperado or iam_attacker_default());

end