-------------------------------------------------------------
-- Archivo LUA que carga todas las funciones de IA de Batalla
-------------------------------------------------------------

-- Start ----------------------------------------------------
log("Start loading script data")

-- Loading default definitions ------------------------------
MAIN_DIR = "IA_Batalla/"
include_script(MAIN_DIR.."definitions.lua")
include_script(MAIN_DIR.."objectives.lua")

-- Loading map default file ---------------------------------
map_id = get_map()[MAP_ID]
MAP_FILE = MAIN_DIR.."Maps/"..map_id.."/main_"..map_id..".lua"

if( file_exists(MAP_FILE) == true ) then
  include_script(MAP_FILE)
else
  log("MAP file not found: "..MAP_FILE)
end

-- End ------------------------------------------------------
log("Script data loaded OK!")