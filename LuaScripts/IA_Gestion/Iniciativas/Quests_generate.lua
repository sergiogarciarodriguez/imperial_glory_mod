-- Lua Script
-- Generacion de las acciones derivadas de las iniciativas de quests


function generate_quest_cartografia()
  generate_quest(TINI_QUEST_CARTOGRAFIA)
end


function generate_quest_bloqueo_continental()
  generate_quest(TINI_QUEST_BLOQUEO_CONTINENTAL)
end


function generate_quest_piedra_roseta()
  generate_quest(TINI_QUEST_PIEDRA_ROSETA)
end


function generate_quest_simon_bolivar()
  generate_quest(TINI_QUEST_SIMON_BOLIVAR)
end


function generate_quest_sistema_metrico()
  generate_quest(TINI_QUEST_SISTEMA_METRICO)
end


function generate_quest_paz_amiens()
  generate_quest(TINI_QUEST_PAZ_AMIENS)
end


function generate_quest_enciclopedia()
  generate_quest(TINI_QUEST_ENCICLOPEDIA)
end


function generate_quest_derechos_humanos()
  generate_quest(TINI_QUEST_DERECHOS_HUMANOS)
end


function generate_quest_100000hijos()
  generate_quest(TINI_QUEST_100000HIJOS)
end


function generate_quest_proclamarse_sisi_emperatriz()
  generate_quest(TINI_QUEST_PROCLAMARSE_SISI_EMPERATRIZ)
end


function generate_quest_constitucion()
  generate_quest(TINI_QUEST_CONSTITUCION)
end


function generate_quest_ferrocarril()
  generate_quest(TINI_QUEST_FERROCARRIL)
end


function generate_quest_revolucion_medica()
  generate_quest(TINI_QUEST_REVOLUCION_MEDICA)
end


function generate_quest_revolucion_agraria()
  generate_quest(TINI_QUEST_REVOLUCION_AGRARIA)
end


function generate_quest_exposicion_universal()
  generate_quest(TINI_QUEST_EXPOSICION_UNIVERSAL)
end


function generate_quest_senyor_mares()
  generate_quest(TINI_QUEST_SENYOR_MARES)
end


function generate_quest(quest)
  -- Eliminamos las órdenes anteriores
  clear_orders(quest)

  -- aux
  _gq_quest = quest
  -- local
  _gq_cobrar_quest = iniciativas[quest].prioridad == 1

  if _gq_cobrar_quest then
    generate_cobro_quest(quest)
  else
    generate_ordenes_quest(quest)
  end
end


function generate_cobro_quest(quest)
  -- aux
  _gcq_quest = quest
  -- local
  _gcq_numero_requerimientos = get_numero_requerimientos_quest(quest)
  -- local
  _gcq_batallones = {}
  -- local
  _gcq_barcos = {}

  -- aux
  _gcq_i = 0
  for _gcq_i = 0, _gcq_numero_requerimientos - 1, 1 do
    -- local
    _gcq_tipo_requerimiento = get_tipo_requerimiento_quest(quest, _gcq_i)
    -- local
    _gcq_requerimiento      = get_requerimiento_quest(quest, _gcq_i)

    requerimientos_quests[_gcq_tipo_requerimiento].generar_cobro(_gcq_requerimiento, quest, _gcq_batallones, _gcq_barcos)
  end

  -- local
  _gcq_cumple_requerimientos = cumple_requerimientos_quest(MY_PLAYER_ID, quest, _gcq_batallones, _gcq_barcos)

  --assert(_gcq_cumple_requerimientos, "El jugador " .. get_name(MY_PLAYER_ID) .. " ha intentado cobrar la recompensa del quest " .. quest .. " sin cumplir los requerimientos.")
  cobrar_quest(quest, 1.0, 1.0, true, _gcq_batallones, _gcq_barcos)
end


function generate_ordenes_quest(quest)
  -- aux
  _goq_quest = quest
  -- local
  _goq_numero_requerimientos = get_numero_requerimientos_quest(quest)

  -- aux
  _goq_i = 0
  for _goq_i = 0, _goq_numero_requerimientos - 1, 1 do
    -- local
    _goq_tipo_requerimiento = get_tipo_requerimiento_quest(quest, _goq_i)
    -- local
    _goq_requerimiento      = get_requerimiento_quest(quest, _goq_i)

    requerimientos_quests[_goq_tipo_requerimiento].generar_ordenes(_goq_requerimiento, quest)
  end  
end