--------------------------------------------------------------
-- Ajuste de parametros segun dificultad
--------------------------------------------------------------
local gameDif = get_GameDifficulty();
if( get_GameDifficulty() == 0.0 ) then
    -- FACIL
    log("Aplicando parametros de dificultad FACIL");
    change_ConquestZone_MinTroopPercentEsperando( 0.9 );
    change_ConquestZone_DetectOpportunities( false );
    change_ConquestZone_DetectCliffOffset( false );
    change_ConquestZone_MaxRadius( 5000.0 );
    change_ConquestZone_UseElevatedCannons( false );

elseif ( get_GameDifficulty() == 1.0 ) then
    -- MEDIO
    log("Aplicando parametros de dificultad MEDIA");

elseif ( get_GameDifficulty() == 2.0 ) then
    -- DIFICIL
    log("Aplicando parametros de dificultad DIFICIL");

elseif ( get_GameDifficulty() == 3.0 ) then
    -- MUY DIFICIL
    log("Aplicando parametros de dificultad MUY DIFICIL");

else
    -- ERROR!
    log("Game Difficulty devolvio: "..gameDif..", un valor de dificultad incorrecto o desconocido!!");
end

--------------------------------------------------------------
-- Funcion llamada tras crear cada objetivo
-- Permite realizar acciones concretas con el objetivo. De esta
-- forma, se pueden "personalizar" los objetivos por mapa, etc
--------------------------------------------------------------
function actions_with_objective(objective)

  -- No hacemos nada, esta función está sobre todo, para reescribirla para mapas concretos

end
