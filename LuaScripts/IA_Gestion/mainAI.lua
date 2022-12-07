----------------------------------------------------------------------------------------
-- Incluyes los Scripts principales de IA
----------------------------------------------------------------------------------------


UTILS_DIR = "IA_Gestion\\Utils\\"
INICIATIVAS_DIR = "IA_Gestion\\Iniciativas\\"
INCIDENCIAS_DIR = "IA_Gestion\\Incidencias\\"
PBAJA_DIR = "IA_Gestion\\PBaja\\"

include_script(INCIDENCIAS_DIR.."mejoras.lua")
include_script(INCIDENCIAS_DIR.."mejora_defensiva.lua")
include_script(INCIDENCIAS_DIR.."mejora_economica.lua")
include_script(INCIDENCIAS_DIR.."mejora_visibilidad.lua")
include_script(INCIDENCIAS_DIR.."diplomacy.lua")
include_script(UTILS_DIR.."util_functions.lua")
include_script(INCIDENCIAS_DIR.."Incidencias.lua")
include_script(INICIATIVAS_DIR.."Iniciativas.lua")
include_script(PBAJA_DIR.."PBaja.lua")

