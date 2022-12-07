-- Lua Script
-- Actualizacion de iniciativas de quests

------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------- GLOBALS -----------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------

-- Tabla de iniciativas function pointers
requerimientos_quests = {[TR_RIQUEZA_COMIDA]            = { calcular_satisfaccion = calcular_satisfaccion_requerimiento_comida,
                                                            generar_ordenes       = generar_ordenes_requerimiento_comida,
                                                            generar_cobro         = generar_cobro_requerimiento_nulo},
                         [TR_RIQUEZA_POBLACION]         = { calcular_satisfaccion = calcular_satisfaccion_requerimiento_poblacion,
                                                            generar_ordenes       = generar_ordenes_requerimiento_poblacion,
                                                            generar_cobro         = generar_cobro_requerimiento_nulo},
                         [TR_RIQUEZA_MAT_PRIMAS]        = { calcular_satisfaccion = calcular_satisfaccion_requerimiento_mat_primas,
                                                            generar_ordenes       = generar_ordenes_requerimiento_mat_primas,
                                                            generar_cobro         = generar_cobro_requerimiento_nulo},
                         [TR_RIQUEZA_DINERO]            = { calcular_satisfaccion = calcular_satisfaccion_requerimiento_dinero,
                                                            generar_ordenes       = generar_ordenes_requerimiento_dinero,
                                                            generar_cobro         = generar_cobro_requerimiento_nulo},
                         [TR_EDIFICIO]                  = { calcular_satisfaccion = calcular_satisfaccion_requerimiento_edificio,
                                                            generar_ordenes       = generar_ordenes_requerimiento_edificio,
                                                            generar_cobro         = generar_cobro_requerimiento_nulo},
                         [TR_EFECTIVO_TERRESTRE]        = { calcular_satisfaccion = calcular_satisfaccion_requerimiento_efectivo_terrestre,
                                                            generar_ordenes       = generar_ordenes_requerimiento_efectivo_terrestre,
                                                            generar_cobro         = generar_cobro_requerimiento_efectivo_terrestre},
                         [TR_EFECTIVO_MARITIMO]         = { calcular_satisfaccion = calcular_satisfaccion_requerimiento_efectivo_maritimo,
                                                            generar_ordenes       = generar_ordenes_requerimiento_efectivo_maritimo,
                                                            generar_cobro         = generar_cobro_requerimiento_efectivo_maritimo},
                         [TR_CANTIDAD_RUTAS_TERRESTRES] = { calcular_satisfaccion = calcular_satisfaccion_requerimiento_cantidad_rutas_terrestres,
                                                            generar_ordenes       = generar_ordenes_requerimiento_cantidad_rutas_terrestres,
                                                            generar_cobro         = generar_cobro_requerimiento_nulo},
                         [TR_CANTIDAD_RUTAS_MARITIMAS]  = { calcular_satisfaccion = calcular_satisfaccion_requerimiento_cantidad_rutas_maritimas,
                                                            generar_ordenes       = generar_ordenes_requerimiento_cantidad_rutas_maritimas,
                                                            generar_cobro         = generar_cobro_requerimiento_nulo},
                         [TR_ENLACE_RUTA_TERRESTRE]     = { calcular_satisfaccion = calcular_satisfaccion_requerimiento_enlace_ruta_terrestre,
                                                            generar_ordenes       = generar_ordenes_requerimiento_enlace_ruta_terrestre,
                                                            generar_cobro         = generar_cobro_requerimiento_nulo},
                         [TR_ENLACE_RUTA_MARITIMA]      = { calcular_satisfaccion = calcular_satisfaccion_requerimiento_enlace_ruta_maritima,
                                                            generar_ordenes       = generar_ordenes_requerimiento_enlace_ruta_maritima,
                                                            generar_cobro         = generar_cobro_requerimiento_nulo}}

------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------- FUNCTIONS ----------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------

function update_quest_cartografia()
  local enabled = false

  iniciativas[TINI_QUEST_CARTOGRAFIA].prioridad = 0

  if es_jugador_imperial(MY_PLAYER_ID) then
    -- local
    _uqc_prioridad = get_prioridad_quest(TINI_QUEST_CARTOGRAFIA)
    -- TODO: Valoración específica de este quest
    -- local
    _uqc_valoracion_especifica = 0
    -- local 
    _uqc_prioridad_quest = _uqc_prioridad - _uqc_valoracion_especifica

    enabled = _uqc_prioridad_quest > 0
  end

  iniciativas[TINI_QUEST_CARTOGRAFIA].enabled   = enabled
	iniciativas[TINI_QUEST_CARTOGRAFIA].prioridad = _uqc_prioridad_quest
end


function update_quest_bloqueo_continental()
  local enabled = false

	iniciativas[TINI_QUEST_BLOQUEO_CONTINENTAL].prioridad = 0

  if es_jugador_imperial(MY_PLAYER_ID) then
    -- local
    _uqgb_prioridad = get_prioridad_quest(TINI_QUEST_BLOQUEO_CONTINENTAL)
    -- El documento de diseño dice que la IA debería dejar la iniciativa al jugador para este quest.
    -- Damos una valoración de 1 para evitar por tanto que la IA haga el quest.
    -- local
    _uqgb_valoracion_especifica = 1
    -- local 
    _uqgb_prioridad_quest = _uqgb_prioridad - _uqgb_valoracion_especifica

    enabled = _uqgb_prioridad_quest > 0
  end

  iniciativas[TINI_QUEST_BLOQUEO_CONTINENTAL].enabled   = enabled
	iniciativas[TINI_QUEST_BLOQUEO_CONTINENTAL].prioridad = _uqgb_prioridad_quest
end


function update_quest_piedra_roseta()
  local enabled = false

	iniciativas[TINI_QUEST_PIEDRA_ROSETA].prioridad = 0

  if es_jugador_imperial(MY_PLAYER_ID) then
    -- local
    _uqpr_prioridad = get_prioridad_quest(TINI_QUEST_PIEDRA_ROSETA)
    -- TODO: Valoración específica de este quest
    -- local
    _uqpr_valoracion_especifica = 0
    -- local 
    _uqpr_prioridad_quest = _uqpr_prioridad - _uqpr_valoracion_especifica

    enabled = _uqpr_prioridad_quest > 0
  end

	iniciativas[TINI_QUEST_PIEDRA_ROSETA].enabled   = enabled
	iniciativas[TINI_QUEST_PIEDRA_ROSETA].prioridad = _uqpr_prioridad_quest
end


function update_quest_simon_bolivar()
  local enabled = false

	iniciativas[TINI_QUEST_SIMON_BOLIVAR].prioridad = 0

  if es_jugador_imperial(MY_PLAYER_ID) then
    -- local
    _uqsb_prioridad = get_prioridad_quest(TINI_QUEST_SIMON_BOLIVAR)
    -- TODO: Valoración específica de este quest
    -- local
    _uqsb_valoracion_especifica = 0
    -- local 
    _uqsb_prioridad_quest = _uqsb_prioridad - _uqsb_valoracion_especifica

    enabled = _uqsb_prioridad_quest > 0
  end

	iniciativas[TINI_QUEST_SIMON_BOLIVAR].enabled   = enabled
	iniciativas[TINI_QUEST_SIMON_BOLIVAR].prioridad = _uqsb_prioridad_quest
end


function update_quest_sistema_metrico()
  local enabled = false

  iniciativas[TINI_QUEST_SISTEMA_METRICO].prioridad = 0

  if es_jugador_imperial(MY_PLAYER_ID) then
    -- local
    _uqsm_prioridad = get_prioridad_quest(TINI_QUEST_SISTEMA_METRICO)
    -- TODO: Valoración específica de este quest
    -- local
    _uqsm_valoracion_especifica = 0
    -- local 
    _uqsm_prioridad_quest = _uqsm_prioridad - _uqsm_valoracion_especifica

    enabled = _uqsm_prioridad_quest > 0
  end

  iniciativas[TINI_QUEST_SISTEMA_METRICO].enabled   = enabled
  iniciativas[TINI_QUEST_SISTEMA_METRICO].prioridad = _uqsm_prioridad_quest
end


function update_quest_paz_amiens()
  local enabled = false

	iniciativas[TINI_QUEST_PAZ_AMIENS].prioridad = 0

  if es_jugador_imperial(MY_PLAYER_ID) then
    -- local
    _uqpa_prioridad = get_prioridad_quest(TINI_QUEST_PAZ_AMIENS)
    -- TODO: Valoración específica de este quest
    -- local
    _uqpa_valoracion_especifica = 0
    -- local 
    _uqpa_prioridad_quest = _uqpa_prioridad - _uqpa_valoracion_especifica

    enabled = _uqpa_prioridad_quest > 0
  end

	iniciativas[TINI_QUEST_PAZ_AMIENS].enabled   = enabled
	iniciativas[TINI_QUEST_PAZ_AMIENS].prioridad = _uqpa_prioridad_quest
end


function update_quest_enciclopedia()
  local enabled = false

	iniciativas[TINI_QUEST_ENCICLOPEDIA].prioridad = 0

  if es_jugador_imperial(MY_PLAYER_ID) then
    -- local
    _uqe_prioridad = get_prioridad_quest(TINI_QUEST_ENCICLOPEDIA)
    -- TODO: Valoración específica de este quest
    -- local
    _uqe_valoracion_especifica = 0
    -- local 
    _uqe_prioridad_quest = _uqe_prioridad - _uqe_valoracion_especifica

    enabled = _uqe_prioridad_quest > 0
  end

	iniciativas[TINI_QUEST_ENCICLOPEDIA].enabled   = enabled
	iniciativas[TINI_QUEST_ENCICLOPEDIA].prioridad = _uqe_prioridad_quest
end


function update_quest_derechos_humanos()
  local enabled = false

	iniciativas[TINI_QUEST_DERECHOS_HUMANOS].prioridad = 0

  if es_jugador_imperial(MY_PLAYER_ID) then
    -- local
    _uqdh_prioridad = get_prioridad_quest(TINI_QUEST_DERECHOS_HUMANOS)
    -- TODO: Valoración específica de este quest
    -- local
    _uqdh_valoracion_especifica = 0
    -- local 
    _uqdh_prioridad_quest = _uqdh_prioridad - _uqdh_valoracion_especifica

    enabled = _uqdh_prioridad_quest > 0
  end

	iniciativas[TINI_QUEST_DERECHOS_HUMANOS].enabled   = enabled
	iniciativas[TINI_QUEST_DERECHOS_HUMANOS].prioridad = _uqdh_prioridad_quest
end


function update_quest_100000hijos()
  local enabled = false

	iniciativas[TINI_QUEST_100000HIJOS].prioridad = 0

  if es_jugador_imperial(MY_PLAYER_ID) then
    -- local
    _uq100000_prioridad = get_prioridad_quest(TINI_QUEST_100000HIJOS)
    -- TODO: Valoración específica de este quest
    -- local
    _uq100000_valoracion_especifica = 0
    -- local 
    _uq100000_prioridad_quest = _uq100000_prioridad - _uq100000_valoracion_especifica

    enabled = _uq100000_prioridad_quest > 0
  end

	iniciativas[TINI_QUEST_100000HIJOS].enabled   = enabled
	iniciativas[TINI_QUEST_100000HIJOS].prioridad = _uq100000_prioridad_quest
end


function update_quest_proclamarse_sisi_emperatriz()
  local enabled = false

	iniciativas[TINI_QUEST_PROCLAMARSE_SISI_EMPERATRIZ].prioridad = 0

  if es_jugador_imperial(MY_PLAYER_ID) then
    -- local
    _sisi_prioridad = get_prioridad_quest(TINI_QUEST_PROCLAMARSE_SISI_EMPERATRIZ)
    -- TODO: Valoración específica de este quest
    -- local
    _sisi_valoracion_especifica = 0
    -- local 
    _sisi_prioridad_quest = _sisi_prioridad - _sisi_valoracion_especifica

    enabled = _sisi_prioridad_quest > 0
  end

	iniciativas[TINI_QUEST_PROCLAMARSE_SISI_EMPERATRIZ].enabled   = enabled
	iniciativas[TINI_QUEST_PROCLAMARSE_SISI_EMPERATRIZ].prioridad = _sisi_prioridad_quest
end


function update_quest_constitucion()
  local enabled = false

	iniciativas[TINI_QUEST_CONSTITUCION].prioridad = 0

  if es_jugador_imperial(MY_PLAYER_ID) then
    -- local
    _uqcon_prioridad = get_prioridad_quest(TINI_QUEST_CONSTITUCION)
    -- TODO: Valoración específica de este quest
    -- local
    _uqcon_valoracion_especifica = 0
    -- local 
    _uqcon_prioridad_quest = _uqcon_prioridad - _uqcon_valoracion_especifica

    enabled = _uqcon_prioridad_quest > 0
  end

	iniciativas[TINI_QUEST_CONSTITUCION].enabled   = enabled
	iniciativas[TINI_QUEST_CONSTITUCION].prioridad = _uqcon_prioridad_quest
end


function update_quest_ferrocarril()
  local enabled = false

	iniciativas[TINI_QUEST_FERROCARRIL].prioridad = 0

  if es_jugador_imperial(MY_PLAYER_ID) then
    -- local
    _uqf_prioridad = get_prioridad_quest(TINI_QUEST_FERROCARRIL)
    -- TODO: Valoración específica de este quest
    -- local
    _uqf_valoracion_especifica = 0
    -- local 
    _uqf_prioridad_quest = _uqf_prioridad - _uqf_valoracion_especifica

    enabled = _uqf_prioridad_quest > 0
  end

	iniciativas[TINI_QUEST_FERROCARRIL].enabled   = enabled
	iniciativas[TINI_QUEST_FERROCARRIL].prioridad = _uqf_prioridad_quest
end


function update_quest_revolucion_medica()
  local enabled = false

	iniciativas[TINI_QUEST_REVOLUCION_MEDICA].prioridad = 0

  if es_jugador_imperial(MY_PLAYER_ID) then
    -- local
    _uqrm_prioridad = get_prioridad_quest(TINI_QUEST_REVOLUCION_MEDICA)
    -- TODO: Valoración específica de este quest
    -- local
    _uqrm_valoracion_especifica = 0
    -- local 
    _uqrm_prioridad_quest = _uqrm_prioridad - _uqrm_valoracion_especifica

    enabled = _uqrm_prioridad_quest > 0
  end

	iniciativas[TINI_QUEST_REVOLUCION_MEDICA].enabled   = enabled
	iniciativas[TINI_QUEST_REVOLUCION_MEDICA].prioridad = _uqrm_prioridad_quest
end


function update_quest_revolucion_agraria()
  local enabled = false

	iniciativas[TINI_QUEST_REVOLUCION_AGRARIA].prioridad = 0

  if es_jugador_imperial(MY_PLAYER_ID) then
    -- local
    _uqra_prioridad = get_prioridad_quest(TINI_QUEST_REVOLUCION_AGRARIA)
    -- local
    _uqra_valoracion_especifica = 0
    -- local 
    _uqra_prioridad_quest = _uqra_prioridad - _uqra_valoracion_especifica

    enabled = _uqra_prioridad_quest > 0
  end

	iniciativas[TINI_QUEST_REVOLUCION_AGRARIA].enabled   = enabled
	iniciativas[TINI_QUEST_REVOLUCION_AGRARIA].prioridad = _uqra_prioridad_quest
end


function update_quest_exposicion_universal()
  local enabled = false

	iniciativas[TINI_QUEST_EXPOSICION_UNIVERSAL].prioridad = 0

  if es_jugador_imperial(MY_PLAYER_ID) then
    -- local
    _uqeu_prioridad = get_prioridad_quest(TINI_QUEST_EXPOSICION_UNIVERSAL)
    -- TODO: Valoración específica de este quest
    -- local
    _uqeu_valoracion_especifica = 0
    -- local 
    _uqeu_prioridad_quest = _uqeu_prioridad - _uqeu_valoracion_especifica

    enabled = _uqeu_prioridad_quest > 0
  end

	iniciativas[TINI_QUEST_EXPOSICION_UNIVERSAL].enabled   = enabled
	iniciativas[TINI_QUEST_EXPOSICION_UNIVERSAL].prioridad = _uqeu_prioridad_quest
end


function update_quest_senyor_mares()
  local enabled = false

	iniciativas[TINI_QUEST_SENYOR_MARES].prioridad = 0

  if es_jugador_imperial(MY_PLAYER_ID) then
    -- local
    _uqsmar_prioridad = get_prioridad_quest(TINI_QUEST_SENYOR_MARES)
    -- TODO
    -- local
    _uqsmar_valoracion_especifica = 0
    -- local 
    _uqsmar_prioridad_quest = _uqsmar_prioridad - _uqsmar_valoracion_especifica

    enabled = _uqsmar_prioridad_quest > 0
  end

	iniciativas[TINI_QUEST_SENYOR_MARES].enabled   = enabled
	iniciativas[TINI_QUEST_SENYOR_MARES].prioridad = _uqsmar_prioridad_quest
end


function get_prioridad_quest(quest)
  -- aux
  _gpq_quest = quest

  -- local
  _gpq_prioridad = 0
  -- local
  _gpq_quest_habilitado = tiene_quest_habilitado(MY_PLAYER_ID, quest)
  -- local
  _gpq_no_esta_ganado = get_jugador_ganador_quest(quest) == 0
  -- local
  _gpq_puede_cobrar_recompensa = puede_cobrar_recompensa_quest(MY_PLAYER_ID, quest)

  if _gpq_quest_habilitado and _gpq_no_esta_ganado and _gpq_puede_cobrar_recompensa then
    -- local
    _gpq_prioridad_recompensa  = get_prioridad_quest_por_recompensa(quest)

    -- local
    _gpq_nivel_satisfaccion_requerimientos = get_nivel_satisfaccion_requerimientos(quest, MY_PLAYER_ID)

    if _gpq_nivel_satisfaccion_requerimientos == 1 then
      -- Ponemos prioridad a 1 porque el quest puede ser cobrado ya
      _gpq_prioridad = _gpq_nivel_satisfaccion_requerimientos
    else
      -- local
      _gpq_nivel_satisfaccion_requerimientos_por_enemigos = 0

      -- local
      _gpq_enemigos = table_filter_one(get_jugadores(), es_jugador_imperial)
      _gpq_enemigos = table_filter_two(_gpq_enemigos, tiene_quest_habilitado, quest)
      
      -- aux
      _gpq_it_enemigos = 0
      for _gpq_it_enemigos in _gpq_enemigos do
        -- local
        _gpq_enemigo = _gpq_enemigos[_gpq_it_enemigos]

        _gpq_nivel_satisfaccion_requerimientos_por_enemigos = _gpq_nivel_satisfaccion_requerimientos_por_enemigos + 
                                                              get_nivel_satisfaccion_requerimientos(quest, _gpq_enemigo)
      end

      if table.getn(_gpq_enemigos) > 0 then
        _gpq_nivel_satisfaccion_requerimientos_por_enemigos = _gpq_nivel_satisfaccion_requerimientos_por_enemigos / table.getn(_gpq_enemigos)
      end

      _gpq_prioridad = (_gpq_prioridad_recompensa + 
                        _gpq_nivel_satisfaccion_requerimientos + 
                        (1 - _gpq_nivel_satisfaccion_requerimientos_por_enemigos)) / 3
    end
  end

  return _gpq_prioridad
end


function get_nivel_satisfaccion_requerimientos(quest, jugador)
  -- aux
  _gnsr_quest = quest
  -- aux
  _gnsr_jugador = jugador
  -- local
  _gnsr_numero_requerimientos = get_numero_requerimientos_quest(quest)

  -- local&
  _gnsr_nivel_satisfaccion_requerimientos = 0

  -- aux
  _gnsr_i = 0
  for _gnsr_i = 0, _gnsr_numero_requerimientos-1, 1 do
    -- local
    _gnsr_tipo_requerimiento = get_tipo_requerimiento_quest(quest, _gnsr_i)
    -- local
    _gnsr_requerimiento      = get_requerimiento_quest(quest, _gnsr_i)

    _gnsr_nivel_satisfaccion_requerimientos = _gnsr_nivel_satisfaccion_requerimientos +
                                              requerimientos_quests[_gnsr_tipo_requerimiento].calcular_satisfaccion(_gnsr_requerimiento, jugador)
  end
  -- Calculamos la media del nivel de satisfacción de los requerimientos
  _gnsr_nivel_satisfaccion_requerimientos = _gnsr_nivel_satisfaccion_requerimientos / _gnsr_numero_requerimientos

  return _gnsr_nivel_satisfaccion_requerimientos
end