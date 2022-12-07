-- Lua Script
-- Actualizacion de incidencias del presidente

------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------- FUNCTIONS ----------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------

-----------------------------------------------
-- actualiza la incidencia de nivel miitar
-----------------------------------------------
function update_incidencia_nivel_militar()

  nivel_militar.defensivo_enemigo = 1.0 - get_nivel_atacante(get_my_id())
  nivel_militar.defensivo_todos = get_nivel_defensivo(get_my_id())
  nivel_militar.enemigos = table_filter_one(jugadores.all, es_jugador_enemigo)
   
  if(nivel_militar.defensivo_enemigo < MIN_NIVEL_DEFENSIVO) then
	incidencias[TINC_NIVEL_MILITAR_DEFENSIVO_TERRESTRE_BAJO].enabled = true
	incidencias[TINC_NIVEL_MILITAR_DEFENSIVO_TERRESTRE_BAJO].prioridad = 0.5 + 0.5*(MIN_NIVEL_DEFENSIVO-nivel_militar.defensivo_enemigo)/MIN_NIVEL_DEFENSIVO
  elseif(nivel_militar.defensivo_todos < MIN_NIVEL_DEFENSIVO) then  
	incidencias[TINC_NIVEL_MILITAR_DEFENSIVO_TERRESTRE_BAJO].enabled = true
	incidencias[TINC_NIVEL_MILITAR_DEFENSIVO_TERRESTRE_BAJO].prioridad = 0.5*(MIN_NIVEL_DEFENSIVO- nivel_militar.defensivo_todos)/MIN_NIVEL_DEFENSIVO
  elseif(table.getn(nivel_militar.enemigos) > 0) then
	incidencias[TINC_NIVEL_MILITAR_DEFENSIVO_TERRESTRE_BAJO].enabled = true
	incidencias[TINC_NIVEL_MILITAR_DEFENSIVO_TERRESTRE_BAJO].prioridad = 0.0
  else  
	incidencias[TINC_NIVEL_MILITAR_DEFENSIVO_TERRESTRE_BAJO].enabled = false
	incidencias[TINC_NIVEL_MILITAR_DEFENSIVO_TERRESTRE_BAJO].prioridad = 0.0
  end
end

-----------------------------------------------
-- actualiza la incidencia de dinero
-----------------------------------------------
function update_incidencia_dinero()
	
	incidencias[TINC_INGRESO_DINERO_BAJO].enabled = false
	incidencias[TINC_INGRESO_DINERO_BAJO].prioridad = 0.0
	local saldo = get_saldo()[RC_INDEX_DINERO]
	local equivalencia = get_equivalencia_ciencia_riqueza()
	local dinero_por_ciencia = get_min_barra_ciencia()*get_produccion()[RC_INDEX_CIENCIA]*equivalencia
	if(saldo < 0.0) then
		local produccion = get_produccion()[RC_INDEX_DINERO]
		local turnos_rebelion = get_turnos_rebelion_deuda()
		local turnos_recuperacion = -saldo / produccion
		if(-saldo-turnos_rebelion*(produccion+dinero_por_ciencia) > 0) then
			incidencias[TINC_INGRESO_DINERO_BAJO].enabled = true
			incidencias[TINC_INGRESO_DINERO_BAJO].prioridad = 1.0			
			incidencias[TINC_INGRESO_DINERO_BAJO].cantidad_necesaria = -saldo-turnos_rebelion*produccion
		end
	end
end

-----------------------------------------------
-- actualiza la incidencia de comida
-----------------------------------------------
function update_incidencia_comida()
	incidencias[TINC_INGRESO_COMIDA_BAJO].enabled = false
	incidencias[TINC_INGRESO_COMIDA_BAJO].prioridad = 0.0
	local saldo = get_saldo()[RC_INDEX_COMIDA]
	local produccion = get_produccion()[RC_INDEX_COMIDA]
	local mantenimiento = get_coste_mantenimiento()[RC_INDEX_COMIDA]
	if(saldo+produccion-mantenimiento < 0.0) then
		incidencias[TINC_INGRESO_COMIDA_BAJO].enabled = true
		incidencias[TINC_INGRESO_COMIDA_BAJO].prioridad = 1.0	
	end
end

-----------------------------------------------
-- actualiza la incidencia de matprimas
-----------------------------------------------
function update_incidencia_matprimas()
	incidencias[TINC_INGRESO_MATPRIMAS_BAJO].enabled = false
	incidencias[TINC_INGRESO_MATPRIMAS_BAJO].prioridad = 0.0
end

-----------------------------------------------
-- actualiza la incidencia de ciencia
-----------------------------------------------
function update_incidencia_ciencia()
	incidencias[TINC_INGRESO_CIENCIA_BAJO].enabled = false
	incidencias[TINC_INGRESO_CIENCIA_BAJO].prioridad = 0.0
end

-----------------------------------------------
-- actualiza la incidencia de poblacion
-----------------------------------------------
function update_incidencia_poblacion()
	incidencias[TINC_INGRESO_POBLACION_BAJO].enabled = false
	incidencias[TINC_INGRESO_POBLACION_BAJO].prioridad = 0.0
end
----------------------------------------------------
-- actualiza la incidencia de numero de conflictos
----------------------------------------------------
function update_incidencia_numero_conflictos()

	incidencias[TINC_NUMERO_CONFLICTOS_ELEVADO].enabled = table.getn(nivel_militar.enemigos) > 0 and nivel_militar.defensivo_enemigo < 1
	incidencias[TINC_NUMERO_CONFLICTOS_ELEVADO].prioridad = 1.0 - nivel_militar.defensivo_enemigo
  incidencias[TINC_NUMERO_CONFLICTOS_ELEVADO].enviados = 0
	--local nivel_atacante = get_nivel_atacante(MY_PLAYER_ID)
	--local nivel_defensivo = get_nivel_defensivo(MY_PLAYER_ID)
	--incidencias[TINC_NUMERO_CONFLICTOS_ELEVADO].enemigos = {}
	--for it_enemigo in nivel_militar.enemigos do
		--local enemigo = nivel_militar.enemigos[it_enemigo]
		--local es_insostenible, prioridad = es_guerra_insostenible(enemigo)
		--if(es_insostenible) then
			--table.insert(incidencias[TINC_NUMERO_CONFLICTOS_ELEVADO].enemigos, enemigo)
			--incidencias[TINC_NUMERO_CONFLICTOS_ELEVADO].enabled = true
			--incidencias[TINC_NUMERO_CONFLICTOS_ELEVADO].prioridad = math.max(incidencias[TINC_NUMERO_CONFLICTOS_ELEVADO].prioridad, prioridad)
		--end		
	--end	
end

-----------------------------------------------
-- actualiza la incidencia de visibilidad_geografica
-----------------------------------------------
function update_incidencia_visibilidad_geografica()
	incidencias[TINC_NIVEL_VISIBILIDAD_BAJO].enabled = false
	incidencias[TINC_NIVEL_VISIBILIDAD_BAJO].prioridad = 0.0
end

-----------------------------------------------
-- actualiza la incidencia de visibilidad militar
-----------------------------------------------
function update_incidencia_visibilidad_militar()
	local tecno = table_filter_two(tecnologias.investigandose, tiene_tecnologia_mejora, MEJORA_INFLUENCIA_MILITAR)  
	local edificio = table_filter_two(edificios.construyendose, tiene_edificio_mejora, MEJORA_INFLUENCIA_MILITAR)
	if(table.getn(tecno) == 0 and table.getn(edificio) == 0) then
		incidencias[TINC_NIVEL_VISIBILIDAD_MILITAR_BAJO].enabled = true
		incidencias[TINC_NIVEL_VISIBILIDAD_MILITAR_BAJO].prioridad = get_necesidad_mejorar_visibilidad_militar()
	else
		incidencias[TINC_NIVEL_VISIBILIDAD_MILITAR_BAJO].enabled = false
		incidencias[TINC_NIVEL_VISIBILIDAD_MILITAR_BAJO].prioridad = 0.0
	end
end

function update_incidencia_construccion_edificios_basicos()
  _uieb_num_construidos = table.getn(table_filter_one(edificios_basicos, esta_edificio_construido))
  _uieb_num_construyendose = table.getn(table_filter_one(edificios_basicos, esta_edificio_construyendose))
  _uieb_num_basicos = table.getn(edificios_basicos)
  incidencias[TINC_CONSTRUCCION_EDIFICIOS_BASICOS].enabled = _uieb_num_basicos > _uieb_num_construidos + _uieb_num_construyendose
  incidencias[TINC_CONSTRUCCION_EDIFICIOS_BASICOS].prioridad = 1.0
end