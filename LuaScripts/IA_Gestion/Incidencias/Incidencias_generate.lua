-- Lua Script
-- Generacion de las acciones derivadas de las incidencias


------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------- FUNCTIONS ----------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------


-------------------------------------------------------
-- Genera acciones de incidencia de nivel militar
-------------------------------------------------------
function generate_incidencia_nivel_militar()
	if(incidencias[TINC_NIVEL_MILITAR_DEFENSIVO_TERRESTRE_BAJO].enabled) then
    -- local
    _ginm_regenerar = g_ultima_orden == nil or
                      g_ultima_orden[1] == TO_ATACAR_JUGADOR or
                      g_ultima_orden[1] == TO_FORMAR_BATALLON or
                      g_ultima_orden[1] == TO_CURAR_EFECTIVO or
                      g_ultima_orden[1] == TO_ENVIAR_MENSAJE_DIPLOMATICO or
                      g_ultima_orden[1] == TO_COBRAR_QUEST or
                      g_ultima_orden[1] == TO_FORMAR_BARCO_MILITAR or
                      g_ultima_orden[1] == TO_LICENCIAR_EFECTIVO
                      
    _ginm_regenerar_mensajes =  g_ultima_orden == nil or
                                g_ultima_orden[1] == TO_ATACAR_JUGADOR or
                                g_ultima_orden[1] == TO_ENVIAR_MENSAJE_DIPLOMATICO or
                                g_ultima_orden[1] == TO_COBRAR_QUEST 
                      

    if not _ginm_regenerar then
      return
    end
 
    -- Eliminamos las órdenes anteriores
    clear_orders(TINC_NIVEL_MILITAR_DEFENSIVO_TERRESTRE_BAJO, TO_ENVIAR_MENSAJE_DIPLOMATICO)

		if(table.getn(nivel_militar.enemigos) == 0) then
			generar_mejora_militar(TINC_NIVEL_MILITAR_DEFENSIVO_TERRESTRE_BAJO, incidencias[TINC_NIVEL_MILITAR_DEFENSIVO_TERRESTRE_BAJO].prioridad, true)
			if(_ginm_regenerar_mensajes) then
			  generar_proteccion(TINC_NIVEL_MILITAR_DEFENSIVO_TERRESTRE_BAJO, incidencias[TINC_NIVEL_MILITAR_DEFENSIVO_TERRESTRE_BAJO].prioridad)
			end
		else
			generar_mejora_militar(TINC_NIVEL_MILITAR_DEFENSIVO_TERRESTRE_BAJO, incidencias[TINC_NIVEL_MILITAR_DEFENSIVO_TERRESTRE_BAJO].prioridad, true)
			if(_ginm_regenerar_mensajes) then
			  generar_alianzas(TINC_NIVEL_MILITAR_DEFENSIVO_TERRESTRE_BAJO, incidencias[TINC_NIVEL_MILITAR_DEFENSIVO_TERRESTRE_BAJO].prioridad)
			  generar_proteccion(TINC_NIVEL_MILITAR_DEFENSIVO_TERRESTRE_BAJO, incidencias[TINC_NIVEL_MILITAR_DEFENSIVO_TERRESTRE_BAJO].prioridad)
			end
		end

    generar_peticion_ayuda(TINC_NIVEL_MILITAR_DEFENSIVO_TERRESTRE_BAJO, incidencias[TINC_NIVEL_MILITAR_DEFENSIVO_TERRESTRE_BAJO].prioridad)
	end
end

-----------------------------------------------
-- genera la incidencia de dinero
-----------------------------------------------
function generate_incidencia_dinero()
  -- Eliminamos las órdenes anteriores
  clear_orders(TINC_INGRESO_DINERO_BAJO)

	local prioridad = incidencias[TINC_INGRESO_DINERO_BAJO].prioridad
	local equivalencia = get_equivalencia_ciencia_riqueza() -- 1 unidad ciencia == equivalencia unidades oro
	local produccion = get_produccion()[RC_INDEX_CIENCIA]
	local dinero_maximo_ciencia = produccion*equivalencia
	local cantidad_necesaria = incidencias[TINC_INGRESO_DINERO_BAJO].cantidad_necesaria	
	if(cantidad_necesaria <= dinero_maximo_ciencia) then
		set_min_barra_ciencia(TINC_INGRESO_DINERO_BAJO, prioridad, 1.0, true, cantidad_necesaria/dinero_maximo_ciencia)
	else
		set_min_barra_ciencia(TINC_INGRESO_DINERO_BAJO, prioridad, 1.0, true, 1.0)
		-- todo: Hacer tratos comerciales		
	end
end

-----------------------------------------------
-- genera la incidencia de comida
-----------------------------------------------
function generate_incidencia_comida()
  -- Eliminamos las órdenes anteriores
  clear_orders(TINC_INGRESO_COMIDA_BAJO)

	-- todo: Hacer tratos comerciales	
end

-----------------------------------------------
-- genera la incidencia de matprimas
-----------------------------------------------
function generate_incidencia_matprimas()
  -- Eliminamos las órdenes anteriores
  clear_orders(TINC_INGRESO_MATPRIMAS_BAJO)
end

-----------------------------------------------
-- genera la incidencia de ciencia
-----------------------------------------------
function generate_incidencia_ciencia()
  -- Eliminamos las órdenes anteriores
  clear_orders(TINC_INGRESO_CIENCIA_BAJO)
end

-----------------------------------------------
-- genera la incidencia de poblacion
-----------------------------------------------
function generate_incidencia_poblacion()
  -- Eliminamos las órdenes anteriores
  clear_orders(TINC_INGRESO_POBLACION_BAJO)
end


-------------------------------------------------------
-- Genera acciones de incidencia de nivel militar
-------------------------------------------------------
function generate_incidencia_numero_conflictos()
  -- Eliminamos las órdenes anteriores
  clear_orders(TINC_NUMERO_CONFLICTOS_ELEVADO)

  for it_jugador in nivel_militar.enemigos do
    _ginc_jugador = nivel_militar.enemigos[it_jugador]
    _ginc_mensaje = generar_mensaje_paz(_ginc_jugador, {})
    
    if not puede_enviar_mensaje_diplomatico(_ginc_mensaje, TINC_NUMERO_CONFLICTOS_ELEVADO) then
      generar_auto_mejora_tratado(_ginc_mensaje, TINC_NUMERO_CONFLICTOS_ELEVADO)
    else
      _ginc_pref_militar      = get_preferencia_orden(TO_ENVIAR_MENSAJE_DIPLOMATICO, MINISTER_MILITAR, TINC_NUMERO_CONFLICTOS_ELEVADO, 0, 0, true, _ginc_mensaje)
      _ginc_pref_economico    = get_preferencia_orden(TO_ENVIAR_MENSAJE_DIPLOMATICO, MINISTER_ECONOMIC, TINC_NUMERO_CONFLICTOS_ELEVADO, 0, 0, true, _ginc_mensaje)
      _ginc_pref_diplomatico  = get_preferencia_orden(TO_ENVIAR_MENSAJE_DIPLOMATICO, MINISTER_DIPLOMATIC, TINC_NUMERO_CONFLICTOS_ELEVADO, 0, 0, true, _ginc_mensaje)
      _ginc_preferencia = get_prioridad_ponderada(_ginc_pref_militar, _ginc_pref_economico, _ginc_pref_diplomatico)
      
      if(_ginc_preferencia > 0.0 and _ginc_pref_militar > 0.0) then
        ENVIAR_MENSAJE_DIPLOMATICO(TINC_NUMERO_CONFLICTOS_ELEVADO, incidencias[TINC_NUMERO_CONFLICTOS_ELEVADO].prioridad, _ginc_preferencia, false, _ginc_mensaje)
        incidencias[TINC_NUMERO_CONFLICTOS_ELEVADO].enviados = incidencias[TINC_NUMERO_CONFLICTOS_ELEVADO].enviados + 1
      end
    end
  end
end

-------------------------------------------------------
-- Genera acciones de incidencia de nivel militar
-------------------------------------------------------
function generate_incidencia_visibilidad_geografica()
  -- Eliminamos las órdenes anteriores
  clear_orders(TINC_NIVEL_VISIBILIDAD_BAJO)
end

-------------------------------------------------------
-- Genera acciones de incidencia de nivel militar
-------------------------------------------------------
function generate_incidencia_visibilidad_militar()
	if(incidencias[TINC_NIVEL_VISIBILIDAD_MILITAR_BAJO].enabled) then
    -- Eliminamos las órdenes anteriores
    clear_orders(TINC_NIVEL_VISIBILIDAD_MILITAR_BAJO)

		generar_auto_mejora_influencia(TINC_NIVEL_VISIBILIDAD_MILITAR_BAJO, MEJORA_INFLUENCIA_MILITAR, incidencias[TINC_NIVEL_VISIBILIDAD_MILITAR_BAJO].prioridad, 0.0)
	end
end


function generate_incidencia_construccion_edificios_basicos()
  -- Eliminamos las órdenes anteriores
  clear_orders(TINC_CONSTRUCCION_EDIFICIOS_BASICOS)

  for it_edificio in edificios_basicos do
    local edificio = edificios_basicos[it_edificio]

    if(not table_exist(edificios.construidos, edificio) and  not table_exist(edificios.construyendose, edificio)) then
      if table_exist(edificios.construibles, edificio) then
        CONSTRUIR_EDIFICIO(TINC_CONSTRUCCION_EDIFICIOS_BASICOS, 1, 1, false, edificio, get_pais_inicial(MY_PLAYER_ID), 0, false)
      else
        local tecnologia = get_idx_tecnologia_requerida_por_edificio(edificio)

        if not table_exist(tecnologias.investigandose, tecnologia) and 
          not table_exist(tecnologias.investigadas,   tecnologia)
        then
          INVESTIGAR_TECNOLOGIA(TINC_CONSTRUCCION_EDIFICIOS_BASICOS, 1, 1, false, tecnologia, false)
        end
      end
    end
  end
end
