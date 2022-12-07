function calcular_satisfaccion_requerimiento_comida(requerimiento, jugador)
  -- aux
  _csrc_requerimiento = requerimiento
  -- aux
  _csrc_jugador = jugador
  -- local
  _csrc_prioridad = get_presupuesto_riqueza(TR_COMIDA, TH_QUESTS, false) / requerimiento
  _csrc_prioridad = math.min(1.0, math.max(0.0, _csrc_prioridad))

  return _csrc_prioridad
end


function calcular_satisfaccion_requerimiento_mat_primas(requerimiento, jugador)
  -- aux
  _csrmp_requerimiento = requerimiento
  -- aux
  _csrmp_jugador = jugador
  -- local
  _csrmp_prioridad = get_presupuesto_riqueza(TR_MAT_PRIMAS, TH_QUESTS, false) / requerimiento
  _csrmp_prioridad = math.min(1.0, math.max(0.0, _csrmp_prioridad))

  return _csrmp_prioridad
end


function calcular_satisfaccion_requerimiento_poblacion(requerimiento, jugador)
  -- aux
  _csrp_requerimiento = requerimiento
  -- aux
  _csrp_jugador = jugador
  -- local
  _csrp_prioridad = get_presupuesto_riqueza(TR_POBLACION, TH_QUESTS, false) / requerimiento
  _csrp_prioridad = math.min(1.0, math.max(0.0, _csrp_prioridad))

  return _csrp_prioridad
end


function calcular_satisfaccion_requerimiento_dinero(requerimiento, jugador)
  -- aux
  _csrd_requerimiento = requerimiento
  -- aux
  _csrd_jugador = jugador
  -- local
  _csrd_prioridad = get_presupuesto_riqueza(TR_DINERO, TH_QUESTS, false) / requerimiento
  _csrd_prioridad = math.min(1.0, math.max(0.0, _csrd_prioridad))

  return _csrd_prioridad
end


function calcular_satisfaccion_requerimiento_edificio(requerimiento, jugador)
  -- aux
  _csre_requerimiento = requerimiento
  -- aux
  _csre_jugador = jugador
  -- local
  _csre_prioridad = 0

  -- aux
  if table_exist(edificios.construidos, requerimiento) then
    _csre_prioridad = 1
  elseif table_exist(edificios.construibles, requerimiento) then
    _csre_prioridad = 0.75
  else
    -- local
    _csre_tecnologia_requerida = get_idx_tecnologia_requerida_por_edificio(requerimiento)

    if table_exist(tecnologias.investigadas, _csre_tecnologia_requerida) then
      _csre_prioridad = 0.5
    elseif table_exist(tecnologias.investigables, _csre_tecnologia_requerida) then
      _csre_prioridad = 0.25
    end
  end

  return _csre_prioridad
end


function calcular_satisfaccion_requerimiento_efectivo_terrestre(requerimiento, jugador)
  -- aux
  _csret_requerimiento = requerimiento
  -- aux
  _csret_jugador = jugador

  _csret_numero_efectivos = requerimiento[1]
  _csret_tipo_efectivos   = requerimiento[2]

  -- local
  _csret_prioridad = math.min(1, get_numero_efectivos_terrestres_of_tipo(_csret_tipo_efectivos, jugador, true) / _csret_numero_efectivos)

  return _csret_prioridad
end


function calcular_satisfaccion_requerimiento_efectivo_maritimo(requerimiento, jugador)
  -- aux
  _csrem_requerimiento = requerimiento
  -- aux
  _csrem_jugador = jugador

  _csrem_numero_efectivos = requerimiento[1]
  _csrem_tipo_efectivos   = requerimiento[2]

  -- local
  _csrem_prioridad = math.min(1, get_numero_efectivos_maritimos_of_tipo(_csrem_tipo_efectivos, jugador, true) / _csrem_numero_efectivos)

  return _csrem_prioridad
end


function calcular_satisfaccion_requerimiento_cantidad_rutas_terrestres(requerimiento, jugador)
  -- aux
  _csrcrt_requerimiento = requerimiento
  -- aux
  _csrcrt_jugador = jugador
  -- local
  _csrcrt_prioridad = math.min(1, get_numero_rutas_terrestres(jugador) / requerimiento)

  return _csrcrt_prioridad
end


function calcular_satisfaccion_requerimiento_cantidad_rutas_maritimas(requerimiento, jugador)
  -- aux
  _csrcrm_requerimiento = requerimiento
  -- aux
  _csrcrm_jugador = jugador
  -- local
  _csrcrm_prioridad = math.min(1, get_numero_rutas_maritimas(jugador) / requerimiento)

  return _csrcrm_prioridad
end



function calcular_satisfaccion_requerimiento_enlace_ruta_terrestre(requerimiento, jugador)
  -- aux
  _csrert_requerimiento = requerimiento
  -- aux
  _csrert_jugador = jugador
  -- local
  _csrert_prioridad = 0

  if tiene_ruta_terrestre(jugador, requerimiento) then
    _csrert_prioridad = 1  
  end

  return _csrert_prioridad
end


function calcular_satisfaccion_requerimiento_enlace_ruta_maritima(requerimiento, jugador)
  -- aux
  _csrerm_requerimiento = requerimiento
  -- aux
  _csrerm_jugador = jugador
  -- local
  _csrerm_prioridad = 0

  if tiene_ruta_maritima(jugador, requerimiento) then
    _csrerm_prioridad = 1  
  end

  return _csrerm_prioridad
end


function generar_ordenes_requerimiento_comida(requerimiento, quest)
  -- aux
  _gorc_requerimiento = requerimiento
  
  if get_presupuesto_riqueza(TR_COMIDA, TH_QUESTS, false) < requerimiento then
    -- local
    _gorc_recursos = 
    {
      0,
      0,
      requerimiento,
      0,
      0
    }

    ahorrar_recursos(quest, 1.0, 1.0, true, _gorc_recursos)
  end
  
end


function generar_ordenes_requerimiento_poblacion(requerimiento, quest)
  -- aux
  _gorp_requerimiento = requerimiento

  if get_presupuesto_riqueza(TR_POBLACION, TH_QUESTS, false) < requerimiento then
    -- local
    _gorp_recursos = 
    {
      0,
      0,
      0,
      requerimiento,
      0
    }

    ahorrar_recursos(quest, 1.0, 1.0, true, _gorp_recursos)
  end

end


function generar_ordenes_requerimiento_mat_primas(requerimiento, quest)
  -- aux
  _gormp_requerimiento = requerimiento

  if get_presupuesto_riqueza(TR_MAT_PRIMAS, TH_QUESTS, false) < requerimiento then
    -- local
    _gormp_recursos = 
    {
      0,
      requerimiento,
      0,
      0,
      0
    }

    ahorrar_recursos(quest, 1.0, 1.0, true, _gormp_recursos)
  end

end


function generar_ordenes_requerimiento_dinero(requerimiento, quest)
  -- aux
  _gord_requerimiento = requerimiento

  if get_presupuesto_riqueza(TR_DINERO, TH_QUESTS, false) < requerimiento then
    -- local
    _gord_recursos = 
    {
      requerimiento,
      0,
      0,
      0,
      0
    }

    ahorrar_recursos(quest, 1.0, 1.0, true, _gord_recursos)
  end

end


function generar_ordenes_requerimiento_edificio(requerimiento, quest)
  -- aux
  _gore_quest = quest
  -- local
  _gore_tipo_edificio = requerimiento
  
  if not table_exist(edificios.construidos, _gore_tipo_edificio) and 
     not table_exist(edificios.construyendose, _gore_tipo_edificio) 
  then
    if table_exist(edificios.construibles, _gore_tipo_edificio) then
      -- local
      _gore_paises = get_paises_para_construccion(_gore_tipo_edificio)

      if table.getn(_gore_paises) > 0 then
        CONSTRUIR_EDIFICIO(quest, 1.0, 1.0, true, _gore_tipo_edificio, _gore_paises[1], 0, false) 
      end
    else
      -- local 
      _gore_tecnologia = get_idx_tecnologia_requerida_por_edificio(_gore_tipo_edificio)

      if _gore_tecnologia ~= 0 and
         not table_exist(tecnologias.investigadas, _gore_tecnologia) and 
         not table_exist(tecnologias.investigandose, _gore_tecnologia)
      then
        INVESTIGAR_TECNOLOGIA(quest, 1.0, 1.0, true, _gore_tecnologia, false)    
      end
    end
  end
end


function generar_ordenes_requerimiento_efectivo_terrestre(requerimiento, quest)
  -- aux
  _goret_requerimiento = requerimiento
  -- aux
  _goret_quest = quest

  -- local
  _goret_numero_efectivos = requerimiento[1]
  -- local
  _goret_tipo_efectivos   = requerimiento[2]
  -- local
  _goret_numero_efectivos_necesarios = _goret_numero_efectivos - get_numero_efectivos_terrestres_of_tipo(_goret_tipo_efectivos, MY_PLAYER_ID, true)

  if _goret_numero_efectivos_necesarios > 0 then
    -- local
    _goret_numero_batallones_generados = 0
    -- local 
    _goret_cuarteles = get_cuarteles()

    -- aux
    _goret_it_cuartel = 0
    for _goret_it_cuartel in _goret_cuarteles do
      -- local 
      _goret_cuartel = _goret_cuarteles[_goret_it_cuartel]
      -- local 
      _goret_pais    = get_pais_of_cuartel(_goret_cuartel)

	    if es_tropa_construible_en_pais(_goret_tipo_efectivos, _goret_pais) then  		
		    FORMAR_BATALLON(quest, 1.0, 1.0, true, _goret_tipo_efectivos, _goret_pais, false, false)            
        _goret_numero_batallones_generados = _goret_numero_batallones_generados + 1

        if _goret_numero_batallones_generados >= _goret_numero_efectivos_necesarios then
          break
        end
	    end
    end
  end
end


function generar_ordenes_requerimiento_efectivo_maritimo(requerimiento, quest)
  -- aux
  _gorem_requerimiento = requerimiento
  -- aux
  _gorem_quest = quest

  -- local
  _gorem_numero_efectivos = requerimiento[1]
  -- local
  _gorem_tipo_efectivos   = requerimiento[2]
  -- local
  _gorem_numero_efectivos_necesarios = _gorem_numero_efectivos - get_numero_efectivos_maritimos_of_tipo(_gorem_tipo_efectivos, MY_PLAYER_ID, true)

  if _gorem_numero_efectivos_necesarios > 0 then
    -- local
    _gorem_numero_barcos_generados = 0
    -- local 
    _gorem_puertos_militares = get_puertos_militares()

    -- aux
    _gorem_it_puerto = 0
    for _gorem_it_puerto in _gorem_puertos_militares do
      -- local 
      _gorem_puerto = _gorem_puertos_militares[_gorem_it_puerto]

	    if es_barco_construible_en_puerto(_gorem_tipo_efectivos, _gorem_puerto) then  		
		    FORMAR_BARCO(quest, 1.0, 1.0, true, _gorem_tipo_efectivos, _gorem_puerto, false, false)            
        _gorem_numero_barcos_generados = _gorem_numero_barcos_generados + 1

        if _gorem_numero_barcos_generados >= _gorem_numero_efectivos_necesarios then
          break
        end
	    end
    end
  end
end


function generar_ordenes_requerimiento_cantidad_rutas_terrestres(requerimiento, quest)
  -- aux
  _gorcrt_requerimiento = requerimiento

  if get_numero_rutas_terrestres(MY_PLAYER_ID) < requerimiento then
    generar_rutas_terrestres(quest, 1.0, true)
  end
end


function generar_ordenes_requerimiento_cantidad_rutas_maritimas(requerimiento, quest)
  -- aux
  _gorcrm_requerimiento = requerimiento

  if get_numero_rutas_maritimas(MY_PLAYER_ID) < requerimiento then
    generar_rutas_maritimas(quest, 1.0, true)
  end
end


function generar_ordenes_requerimiento_enlace_ruta_terrestre(requerimiento, quest)
  -- aux
  _gorert_requerimiento = requerimiento

  if not tiene_ruta_terrestre(MY_PLAYER_ID, requerimiento) then
    -- local
    _gorert_destinos_posibles = {}

    calcular_rutas_terrestres(_gorert_destinos_posibles)

    -- aux
    _gorert_it = 0
    for _gorert_it in _gorert_destinos_posibles do
      -- local
      _gorert_destino = _gorert_destinos_posibles[_gorert_it]
      -- local
      _gorert_idx_capital = get_capital_idx_of_pais(_gorert_destino.pais)
      
      if _gorert_idx_capital == requerimiento then
        -- TODO: Mandar orden de construir ruta a país con recálculo de prioridad
        -- generar_auto_mejora_en_pais(_gorert_destino.pais, quest, MEJORA_PRODUCCION_DINERO, 1.0, 1.0, 1.0)
        break
      end
    end
  end
end


function generar_ordenes_requerimiento_enlace_ruta_maritima(requerimiento, quest)
  -- aux
  _gorerm_requerimiento = requerimiento

  if not tiene_ruta_maritima(MY_PLAYER_ID, requerimiento) then
    -- local
    _gorerm_destinos_posibles = {}

    calcular_rutas_maritimas(_gorerm_destinos_posibles)
    
    -- local
    _gorerm_ruta_generada = false

    -- aux
    _gorerm_it = 0
    for _gorerm_it in _gorerm_destinos_posibles do
      -- local
      _gorerm_destino = _gorerm_destinos_posibles[_gorerm_it]
      -- local
      _gorerm_idx_puerto = _gorerm_destino.destino
      
      if _gorerm_idx_puerto == requerimiento then
        GENERAR_RUTA_MARITIMA(quest, 1.0, 1.0, true, _gorerm_destino.flota, _gorerm_idx_puerto)
        _gorerm_ruta_generada = true
        break
      end
    end

    if not _gorerm_ruta_generada then
      generar_flotas_comerciales(quest, 1.0, true)
    end
  end
end


function generar_cobro_requerimiento_nulo(requerimiento, quest, batallones, barcos)
  -- No hacemos nada  
end


function generar_cobro_requerimiento_efectivo_terrestre(requerimiento, quest, batallones, barcos)
  -- TODO: Añadir al set de batallones los IDs de batallones acuartelados que requiere el quest
end


function generar_cobro_requerimiento_efectivo_maritimo(requerimiento, quest, batallones, barcos)
  -- TODO: Añadir al set de barcos los IDs de barcos acuartelados que requiere el quest
end
