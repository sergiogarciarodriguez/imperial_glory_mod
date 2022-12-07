-- Lua Script
-- Actualizacion de iniciativas del presidente

------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------- FUNCTIONS ----------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------

-----------------------------------------------
-- actualiza la iniciativa de dinero
-----------------------------------------------
function update_iniciativa_dinero()
	local valor_real = get_vr()[RC_INDEX_DINERO]
	iniciativas[TINI_INGRESO_DINERO_BAJO].enabled = true
	iniciativas[TINI_INGRESO_DINERO_BAJO].prioridad = 1.0
end

-----------------------------------------------
-- actualiza la iniciativa de comida
-----------------------------------------------
function update_iniciativa_comida()
	local valor_real = get_vr()[RC_INDEX_COMIDA]
	iniciativas[TINI_INGRESO_COMIDA_BAJO].enabled = true
	iniciativas[TINI_INGRESO_COMIDA_BAJO].prioridad = 1.0
end

-----------------------------------------------
-- actualiza la iniciativa de matprimas
-----------------------------------------------
function update_iniciativa_matprimas()
	local valor_real = get_vr()[RC_INDEX_MATPRIMAS]
	iniciativas[TINI_INGRESO_MATPRIMAS_BAJO].enabled = true
	iniciativas[TINI_INGRESO_MATPRIMAS_BAJO].prioridad = 1.0
end

-----------------------------------------------
-- actualiza la iniciativa de ciencia
-----------------------------------------------
function update_iniciativa_ciencia()
	iniciativas[TINI_INGRESO_MATPRIMAS_BAJO].enabled = false
	iniciativas[TINI_INGRESO_MATPRIMAS_BAJO].prioridad = 0.0
end

-----------------------------------------------
-- actualiza la iniciativa de poblacion
-----------------------------------------------
function update_iniciativa_poblacion()
	local valor_real = get_vr()[RC_INDEX_POBLACION]
	iniciativas[TINI_INGRESO_POBLACION_BAJO].enabled = true
	iniciativas[TINI_INGRESO_POBLACION_BAJO].prioridad = 1.0
end

-----------------------------------------------
-- actualiza la iniciativa de asimilar
-----------------------------------------------
function update_iniciativa_asimilar()
  -- Esta iniciativa estará siempre activa
 	iniciativas[TINI_ASIMILAR].enabled   = true
	iniciativas[TINI_ASIMILAR].prioridad = 1.0
end

function update_iniciativa_mejora_militar()
	iniciativas[TINI_MEJORA_MILITAR].enabled = incidencias[TINC_NUMERO_CONFLICTOS_ELEVADO].enviados == 0
	iniciativas[TINI_MEJORA_MILITAR].prioridad = 1.0
end

function update_iniciativa_permiso_paso()
	iniciativas[TINI_PERMISO_PASO].enabled = true
	iniciativas[TINI_PERMISO_PASO].prioridad = 1.0
end

function update_iniciativa_enviar_efectivos()
  -- local
  _uiee_enabled = false

  -- local
  _uiee_aliados           = table_filter_one(get_jugadores(), es_jugador_aliado)
  -- local
  _uiee_aliados_asediados = table_filter_one(_uiee_aliados, esta_jugador_asediado)

  -- La iniciativa estará activa si alguno de nuestros aliados está siendo asediado
  _uiee_enabled = table.getn(_uiee_aliados_asediados) > 0

  if not _uiee_enabled then
    -- local
    _uiee_jugadores_peticion = {}
    _uiee_jugadores_peticion = get_jugadores_peticion_ayuda()

    -- La iniciativa estará activa si algún jugador nos ha pedido ayuda militar
    _uiee_enabled = table.getn(_uiee_jugadores_peticion) > 0
  end
  
	iniciativas[TINI_ENVIAR_EFECTIVOS].enabled   = _uiee_enabled
	iniciativas[TINI_ENVIAR_EFECTIVOS].prioridad = 1.0
end

-----------------------------------------------
-- Actualiza la iniciativa de subvencionar una
-- rebelion mediante una celula de resistencia.
-----------------------------------------------
function update_iniciativa_subvencionar_celula_resistencia()	
    -- En caso de que exista una o mas tecnologias asociadas a la mejora de subvencionar
    -- una celula de resistencia permitiremos realizar la iniciativa

	-- local
	_uisc_tabla_tecnologias = get_tecnologias_investigadas_con_mejora(MEJORA_SABOTAJE)
	
	-- local
	_uisc_enable = table.getn(_uisc_tabla_tecnologias) > 0
	
	iniciativas[TINI_SUBVENCIONAR_CELULA_RESISTENCIA].enabled   = _uisc_enable
	iniciativas[TINI_SUBVENCIONAR_CELULA_RESISTENCIA].prioridad = 1.0
end

-----------------------------------------------
-- Actualiza la iniciativa de realizar un 
-- matrimonio con otro jugador.
-----------------------------------------------
function update_iniciativa_matrimonio()	
 -- Solo consideraremos la iniciativa si:
 -- * Jugador actual es imperial.
 -- * Puede activar la opcion de matrimonio.
 
 -- local
 _uim_es_jugador_imperial      = es_jugador_imperial(MY_PLAYER_ID)
 _uim_puede_activar_matrimonio = puede_activar_matrimonio(MY_PLAYER_ID) 

  iniciativas[TINI_MATRIMONIO].enabled   = _uim_es_jugador_imperial and _uim_puede_activar_matrimonio
  iniciativas[TINI_MATRIMONIO].prioridad = 1.0
end


function update_iniciativa_comprar_territorios()
  -- local
  _uict_provincias_perdidas = table_filter_two(get_provincias_perdidas(MY_PLAYER_ID, true), es_provincia_inicial, MY_PLAYER_ID)

  iniciativas[TINI_COMPRAR_TERRITORIOS].enabled   = table.getn(_uict_provincias_perdidas) > 0
  iniciativas[TINI_COMPRAR_TERRITORIOS].prioridad = 1.0
end


function update_iniciativa_vender_territorios()
  -- local
  _uivt_provincias_ampliadas           = get_provincias_ampliadas(MY_PLAYER_ID)
  -- local
  _uivt_provincias_ampliadas_inconexas = table_filter_two(_uivt_provincias_ampliadas, es_provincia_inconexa, MY_PLAYER_ID)

  iniciativas[TINI_VENDER_TERRITORIOS].enabled   = table.getn(_uivt_provincias_ampliadas_inconexas) > 0
  iniciativas[TINI_VENDER_TERRITORIOS].prioridad = 1.0
end
