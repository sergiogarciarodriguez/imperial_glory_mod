-- Lua Script
-- Gestión de incidencias del presidente


------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------- INCLUDES ----------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------
include_script(INCIDENCIAS_DIR.."Incidencias_update.lua")
include_script(INCIDENCIAS_DIR.."Incidencias_generate.lua")

------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------- GLOBALS ----------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------
total_incidencias = 0;
puede_generar_iniciativas = true
MIN_NIVEL_DEFENSIVO = 1

-- Enumerados de tipos de incidencia
incidencias_enum = {TINC_NIVEL_MILITAR_DEFENSIVO_TERRESTRE_BAJO,
					TINC_INGRESO_DINERO_BAJO,
					TINC_INGRESO_COMIDA_BAJO,
					TINC_INGRESO_MATPRIMAS_BAJO,
					TINC_INGRESO_CIENCIA_BAJO,
					TINC_INGRESO_POBLACION_BAJO,
					TINC_NUMERO_CONFLICTOS_ELEVADO,
					TINC_NIVEL_VISIBILIDAD_BAJO,
					TINC_NIVEL_VISIBILIDAD_MILITAR_BAJO,
          TINC_CONSTRUCCION_EDIFICIOS_BASICOS}

-- tabla de incidencias function pointers
update_incidencia_func = {[TINC_NIVEL_MILITAR_DEFENSIVO_TERRESTRE_BAJO] = update_incidencia_nivel_militar, 
						  [TINC_INGRESO_DINERO_BAJO] = update_incidencia_dinero,
						  [TINC_INGRESO_COMIDA_BAJO] = update_incidencia_comida,
						  [TINC_INGRESO_MATPRIMAS_BAJO] = update_incidencia_matprimas,
						  [TINC_INGRESO_CIENCIA_BAJO] = update_incidencia_ciencia,
						  [TINC_INGRESO_POBLACION_BAJO] = update_incidencia_poblacion,
						  [TINC_NUMERO_CONFLICTOS_ELEVADO] = update_incidencia_numero_conflictos,
						  [TINC_NIVEL_VISIBILIDAD_BAJO] = update_incidencia_visibilidad_geografica,
						  [TINC_NIVEL_VISIBILIDAD_MILITAR_BAJO] = update_incidencia_visibilidad_militar,
						  [TINC_CONSTRUCCION_EDIFICIOS_BASICOS] = update_incidencia_construccion_edificios_basicos}
						  
generate_incidencia_func = {[TINC_NIVEL_MILITAR_DEFENSIVO_TERRESTRE_BAJO] = generate_incidencia_nivel_militar, 
						  [TINC_INGRESO_DINERO_BAJO] = generate_incidencia_dinero,
						  [TINC_INGRESO_COMIDA_BAJO] = generate_incidencia_comida,
						  [TINC_INGRESO_MATPRIMAS_BAJO] = generate_incidencia_matprimas,
						  [TINC_INGRESO_CIENCIA_BAJO] = generate_incidencia_ciencia,
						  [TINC_INGRESO_POBLACION_BAJO] = generate_incidencia_poblacion,
						  [TINC_NUMERO_CONFLICTOS_ELEVADO] = generate_incidencia_numero_conflictos,
						  [TINC_NIVEL_VISIBILIDAD_BAJO] = generate_incidencia_visibilidad_geografica,
						  [TINC_NIVEL_VISIBILIDAD_MILITAR_BAJO] = generate_incidencia_visibilidad_militar,
						  [TINC_CONSTRUCCION_EDIFICIOS_BASICOS] = generate_incidencia_construccion_edificios_basicos}
					
	
-- tabla de incidencias						  
incidencias = { [TINC_NIVEL_MILITAR_DEFENSIVO_TERRESTRE_BAJO] = {enabled = true, prioridad = 0.0 },
				[TINC_INGRESO_DINERO_BAJO] = {enabled = true, prioridad = 0.0, cantidad_necesaria = 0.0},
				[TINC_INGRESO_COMIDA_BAJO] = {enabled = true, prioridad = 0.0, cantidad_necesaria = 0.0},
				[TINC_INGRESO_MATPRIMAS_BAJO] = {enabled = true, prioridad = 0.0},
				[TINC_INGRESO_CIENCIA_BAJO] = {enabled = true, prioridad = 0.0},
				[TINC_INGRESO_POBLACION_BAJO] = {enabled = true, prioridad = 0.0},
				[TINC_NUMERO_CONFLICTOS_ELEVADO] = {enabled = true, prioridad = 0.0, enemigos = {}, enviados = 0},
				[TINC_NIVEL_VISIBILIDAD_BAJO] = { enabled  = true, prioridad = 0.0},
				[TINC_NIVEL_VISIBILIDAD_MILITAR_BAJO] = { enabled = true, prioridad = 0.0},
				[TINC_CONSTRUCCION_EDIFICIOS_BASICOS] = { enabled = true, prioridad = 0.0}
			  }					
			  
incidencias_modificadores_preferencia = { [TINC_NIVEL_MILITAR_DEFENSIVO_TERRESTRE_BAJO] = 0.0,
				[TINC_INGRESO_DINERO_BAJO] = 0.0,
				[TINC_INGRESO_COMIDA_BAJO] = 0.0,
				[TINC_INGRESO_MATPRIMAS_BAJO] = 0.0,
				[TINC_INGRESO_CIENCIA_BAJO] = 0.0,
				[TINC_INGRESO_POBLACION_BAJO] = 0.0,
				[TINC_NUMERO_CONFLICTOS_ELEVADO] = 0.0,
				[TINC_NIVEL_VISIBILIDAD_BAJO] = 0.0,
				[TINC_NIVEL_VISIBILIDAD_MILITAR_BAJO] = 0.0,
				[TINC_CONSTRUCCION_EDIFICIOS_BASICOS] = 0.0
			  }					

edificios_basicos = { IDX_CUARTEL_BASICO, IDX_ALMACEN_VIVERES }


g_ultima_orden = nil

------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------- FUNCTIONS ----------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------

-----------------------------------------
--  genera las incidencias del presidente
-----------------------------------------
function generar_incidencias()

  LOG("")
  LOG("")
  LOG("")
  LOG("")
  LOG(".............GENERACIÓN DE INCIDENCIAS.............")
  LOG(get_name(get_my_id()))
  
  -- 1. Coger el perfil del jugador actual
  g_perfil = get_perfil()
  MIN_NIVEL_DEFENSIVO = 1 

  init_mejoras()
  init_mejoras_defensivas()
  --update_incidencias(true)
  --generate_incidencias()
  local num_incidencias = 0
  --num_incidencias = num_incidencias + generar_incidencias_militares()
  --num_incidencias = num_incidencias + generar_incidencias_paz()	
  --num_incidencias = num_incidencias + generar_incidencias_permiso_paso()
  --num_incidencias = num_incidencias + generar_incidencias_economicas()
  
  puede_generar_iniciativas = nivel_militar.defensivo_todos > MIN_NIVEL_DEFENSIVO
  return num_incidencias    

end

-----------------------------------------------
-- actualiza el estado de todas las incidencias
-----------------------------------------------
function update_incidencias(force_regenerar)

	for it_incidencia in incidencias_enum do
		local incidencia_enum = incidencias_enum[it_incidencia]
		if(incidencias[incidencia_enum].enabled or force_regenerar) then
		  update_incidencia_func[incidencia_enum]()
		  notify_incidencia(incidencia_enum, incidencias[incidencia_enum].enabled,incidencias[incidencia_enum].prioridad+incidencias_modificadores_preferencia[incidencia_enum])
		end
	end	
	
end

-----------------------------------------------
-- genera todas las incidencias
-----------------------------------------------
function generate_incidencias()
  -- Cogemos la información sobre la última orden ejecutada.
  g_ultima_orden = get_ultima_orden_ejecutada()

	for it_incidencia in incidencias_enum do
		local incidencia_enum = incidencias_enum[it_incidencia]
		if(incidencias[incidencia_enum].enabled) then
			generate_incidencia_func[incidencia_enum]()
		end
	end	
end


----------------------------------------
-- generación de incidencias militares
----------------------------------------
function generar_incidencias_militares()
	local num_incidencias = 0	
	if(nivel_militar.defensivo_enemigo <  (1 - get_perfil()[PF_TEMERIDAD]) ) then
		generar_mejora_militar(TINC_NIVEL_MILITAR_DEFENSIVO_TERRESTRE_BAJO, 1.0, true, false)
		--if(table.getn(incidencias_economicas) == 0) then   
		generar_alianzas(TINC_NIVEL_MILITAR_DEFENSIVO_TERRESTRE_BAJO, 1.0)
		--end		
		num_incidencias = num_incidencias + 1
	elseif(nivel_militar.defensivo_todos < 1.0) then  
		generar_mejora_militar(TINC_NIVEL_MILITAR_DEFENSIVO_TERRESTRE_BAJO, 1.0, true,true)   	
		num_incidencias = num_incidencias + 1
	else
		if(table.getn(nivel_militar.enemigos) > 0) then
			generar_mejora_militar(TINC_NIVEL_MILITAR_DEFENSIVO_TERRESTRE_BAJO, 1.0, true, false)
			num_incidencias = num_incidencias + 1
		end
	end
	return num_incidencias
end



function generar_incidencias_permiso_paso()
	return 0
end

-------------------------------------------------------------------------
-- calcula si la guerra con el enemigo es insostenible
-------------------------------------------------------------------------
function es_guerra_insostenible(enemigo)
	local nivel_defensivo = 1.0 - get_nivel_atacante(enemigo)
	local porcentaje_turnos = get_porcentaje_turnos_sin_atacar(enemigo)
	local insostenible = false
	local prioridad = 0.0
	
	if( esta_jugador_eliminado(enemigo) ) then
		return false
	end
	
	if( nivel_defensivo >= nivel_militar.defensivo_enemigo) then
		insostenible = true
		prioridad = math.max(prioridad, (nivel_defensivo-nivel_militar.defensivo_enemigo)/nivel_defensivo )
	end
	
	--if(nivel_militar.defensivo_todos < MIN_NIVEL_DEFENSIVO) then
		--insostenible = true
		--prioridad = math.max(prioridad, (MIN_NIVEL_DEFENSIVO-nivel_militar.defensivo_todos)/MIN_NIVEL_DEFENSIVO)
	--end
	local asediado = esta_jugador_asediado(enemigo)
	local asediado_por_mi = get_jugador_asediando(enemigo) == MY_PLAYER_ID
	
	if( (porcentaje_turnos >= 1.0 and not asediado_por_mi) or (asediado and not asediado_por_mi) ) then
		insostenible = true
		prioridad = math.max(prioridad, 1.0)
	end
	
	return insostenible, prioridad
end

