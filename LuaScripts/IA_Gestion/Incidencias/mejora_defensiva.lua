-- Lua Script
-- Gestión de mejoras defensiva

------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------- GLOBALS ----------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------

nivel_militar = { defensivo_enemigo = 0, defensivo_todos = 0, atacante = 0, enemigos = {}}

------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------- FUNCTIONS ----------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------

---------------------------------
-- inicia las mejoras defensivas
---------------------------------
function init_mejoras_defensivas()
  nivel_militar.defensivo_enemigo = 1.0 - get_nivel_atacante(get_my_id())
  nivel_militar.defensivo_todos = get_nivel_defensivo(get_my_id())
  nivel_militar.enemigos = table_filter_one(jugadores.all, es_jugador_enemigo)  
end


-----------------------------------------
-- generar mejora militar
-----------------------------------------
function generar_mejora_militar(origen, prioridad_base, mantenimiento)
	generar_batallones(origen, prioridad_base, mantenimiento)
	generar_barcos(origen, prioridad_base, mantenimiento)
	local table_mejoras = {MEJORA_HABILITAR_TACTICA_MILITAR, MEJORA_CALIDAD_BATALLONES, MEJORA_PERMITE_CURAR_BATALLONES}
	if(table.getn(get_puertos_militares()) > 0) then
		table_concat(table_mejoras, {MEJORA_CALIDAD_BARCOS_MILITARES, MEJORA_EXPERIENCIA_BATALLONES, MEJORA_EXPERIENCIA_BARCOS_MILITARES} )
	end
	local mejora = union_mejoras( table_mejoras );
	generar_auto_mejora(origen, mejora, prioridad_base, 0, 0.1)
end

------------------------------------------------
-- genera alianzas para protegernos mejor
------------------------------------------------
function generar_alianzas(origen, prioridad_base)
  
  --_gp_jugadores = jugadores.visibles_diplomaticamente
  for it_jugador in jugadores.enemigos do    
    _gp_enemigo = jugadores.enemigos[it_jugador]
    _gp_aliados = get_aliados_factibles(MY_PLAYER_ID, _gp_enemigo)
    for it_jugador_aliado in _gp_aliados do
      _gp_jugador = _gp_aliados[it_jugador_aliado].jugador
      _gp_mensaje = _gp_aliados[it_jugador_aliado].mensaje
      if(_gp_jugador ~= MY_PLAYER_ID) then
        if not puede_enviar_mensaje_diplomatico_por_tipo(_gp_mensaje) then
          generar_auto_mejora_tratado(_gp_mensaje, origen)
        else
          _gp_preferencia_militar     = get_preferencia_orden(TO_ENVIAR_MENSAJE_DIPLOMATICO, MINISTER_MILITAR, origen, 0, 0, true, _gp_mensaje)
          _gp_preferencia_economic    = get_preferencia_orden(TO_ENVIAR_MENSAJE_DIPLOMATICO, MINISTER_ECONOMIC, origen, 0, 0, true, _gp_mensaje)
          _gp_preferencia_diplomatic  = get_preferencia_orden(TO_ENVIAR_MENSAJE_DIPLOMATICO, MINISTER_DIPLOMATIC, origen, 0, 0, true, _gp_mensaje)
          _gp_prioridad = get_prioridad_ponderada(_gp_preferencia_militar, _gp_preferencia_economic, _gp_preferencia_diplomatic)
          if(_gp_preferencia_militar > 0.0 and _gp_prioridad > 0.0) then
            ENVIAR_MENSAJE_DIPLOMATICO(origen, prioridad_base, _gp_prioridad, true, _gp_mensaje)
          end
        end      
      end
    end    
	end

end

function generar_proteccion(origen, prioridad_base)
  _gp_jugadores = jugadores.visibles_diplomaticamente
  for it_jugador in _gp_jugadores do
    _gp_jugador = _gp_jugadores[it_jugador]
    if(_gp_jugador ~= MY_PLAYER_ID) then
      _gp_mensaje = generar_mensaje_alianza_defensiva(_gp_jugador)
      if not puede_enviar_mensaje_diplomatico_por_tipo(_gp_mensaje) then
        generar_auto_mejora_tratado(_gp_mensaje, origen)
      else
        _gp_preferencia_militar     = get_preferencia_orden(TO_ENVIAR_MENSAJE_DIPLOMATICO, MINISTER_MILITAR, origen, 0, 0, true, _gp_mensaje)
        _gp_preferencia_economic    = get_preferencia_orden(TO_ENVIAR_MENSAJE_DIPLOMATICO, MINISTER_ECONOMIC, origen, 0, 0, true, _gp_mensaje)
        _gp_preferencia_diplomatic  = get_preferencia_orden(TO_ENVIAR_MENSAJE_DIPLOMATICO, MINISTER_DIPLOMATIC, origen, 0, 0, true, _gp_mensaje)
        _gp_prioridad = get_prioridad_ponderada(_gp_preferencia_militar, _gp_preferencia_economic, _gp_preferencia_diplomatic)
        if(_gp_prioridad > 0.0) then
          ENVIAR_MENSAJE_DIPLOMATICO(origen, prioridad_base, _gp_prioridad, true, _gp_mensaje)
        end
      end      
    end
  end
end


function generar_peticion_ayuda(origen, prioridad_base)
  -- local
  _gpa_nivel_defensivo = get_nivel_defensivo(MY_PLAYER_ID)
  
  if _gpa_nivel_defensivo == 0 or esta_jugador_asediado(MY_PLAYER_ID) then
    -- local
    _gpa_candidatos = table_filter_one(get_jugadores(), es_jugador_candidato_peticion_ayuda)

    if table.getn(_gpa_candidatos) > 1 then
      table.sort(_gpa_candidatos, compare_candidatos_peticion_ayuda)
    end

    -- Enviamos mensajes a los X primeros
    -- local
    _gpa_numero_mensajes = math.min(table.getn(_gpa_candidatos), 2)

    -- aux
    _gpa_i = 1
    for _gpa_i = 1, _gpa_numero_mensajes, 1 do
      -- local
      _gpa_jugador = _gpa_candidatos[_gpa_i]
      -- local
      _gpa_mensaje = generar_mensaje_ayuda_militar(_gpa_jugador)

			ENVIAR_MENSAJE_DIPLOMATICO(origen, prioridad_base, prioridad_base, false, _gpa_mensaje)
    end
  end
end


function es_jugador_candidato_peticion_ayuda(jugador)
  -- aux
  _ejcpa_jugador = jugador

  -- local
  _ejcpa_ret = table.getn(get_enemigos_of_jugador(jugador)) == 0

  if _ejcpa_ret then
    _ejcpa_ret = es_jugador_aliado(jugador) or get_grado_hostilidad(MY_PLAYER_ID, jugador) < 0.5
  end

  if _ejcpa_ret then
    local mensaje = generar_mensaje_ayuda_militar(jugador)
    _ejcpa_ret = puede_enviar_mensaje_diplomatico(mensaje, TINC_NIVEL_MILITAR_DEFENSIVO_TERRESTRE_BAJO)
  end

  return _ejcpa_ret
end


function compare_candidatos_peticion_ayuda(jugador1, jugador2)
  -- aux
  _ccpa_jugador1 = jugador1
  -- aux
  _ccpa_jugador2 = jugador2

  -- local
  _ccpa_amistad1 = 1 - get_grado_hostilidad(MY_PLAYER_ID, jugador1)
  -- local
  _ccpa_amistad2 = 1 - get_grado_hostilidad(MY_PLAYER_ID, jugador2)

  -- local
  _ccpa_nivel_defensivo1 = get_nivel_defensivo(jugador1)
  -- local
  _ccpa_nivel_defensivo2 = get_nivel_defensivo(jugador2)

  -- local
  _ccpa_preferencia1 = (_ccpa_amistad1 + _ccpa_nivel_defensivo1) / 2
  -- local
  _ccpa_preferencia2 = (_ccpa_amistad2 + _ccpa_nivel_defensivo2) / 2

  return _ccpa_preferencia1 > _ccpa_preferencia2
end



-----------------------------------------------------
-- generar batallones
-----------------------------------------------------
function generar_batallones(origen, prioridad_base, mantenimiento)

  _gb_curables = get_efectivos_danados()  
  for it_curable in _gb_curables do
	  local id_efectivo = _gb_curables[it_curable]
	  _gb_preferencia_militar = get_preferencia_orden(TO_CURAR_EFECTIVO, MINISTER_MILITAR, origen, 0, 0, true, id_efectivo, TAM_EJERCITO, false)
	  _gb_preferencia_economic = get_preferencia_orden(TO_CURAR_EFECTIVO, MINISTER_ECONOMIC, origen, 0, 0, true, id_efectivo, TAM_EJERCITO, false)
	  _gb_preferencia_diplomatic = get_preferencia_orden(TO_CURAR_EFECTIVO, MINISTER_DIPLOMATIC, origen, 0, 0, true, id_efectivo, TAM_EJERCITO, false)
	  _gb_prioridad = get_prioridad_ponderada(_gb_preferencia_militar, _gb_preferencia_economic, _gb_preferencia_diplomatic)
	  if(_gb_preferencia_militar > 0.0 and _gb_prioridad > 0.0) then
	    CURAR_EFECTIVO(origen, prioridad_base, _gb_prioridad, false, id_efectivo, TAM_EJERCITO, false)
	  end
	  if _gb_prioridad >= preferencias_minimas_ordenes.mejora_militar then
		  
	  end
  end
  
  _gb_cuarteles = get_cuarteles()

  for it_cuartel in _gb_cuarteles do
    _gb_cuartel = _gb_cuarteles[it_cuartel]
    _gb_pais = get_pais_of_cuartel(_gb_cuartel)
    _gb_max_prioridad = 0.0
    _gb_max_tropa = 0    
	  for it_tropa in tropas.all do
	    _gb_tropa = tropas.all[it_tropa]
	    if(true == es_tropa_construible_en_pais(_gb_tropa, _gb_pais)) then  		
	      _gb_preferencia_militar     = get_preferencia_orden(TO_FORMAR_BATALLON, MINISTER_MILITAR, origen, 0, 0, true, _gb_tropa, _gb_pais, false, false)
	      _gb_preferencia_economic    = get_preferencia_orden(TO_FORMAR_BATALLON, MINISTER_ECONOMIC, origen, 0, 0, true, _gb_tropa, _gb_pais, false, false)
	      _gb_preferencia_diplomatic  = get_preferencia_orden(TO_FORMAR_BATALLON, MINISTER_DIPLOMATIC, origen, 0, 0, true, _gb_tropa, _gb_pais, false, false)
	      _gb_prioridad = get_prioridad_ponderada(_gb_preferencia_militar, _gb_preferencia_economic, _gb_preferencia_diplomatic)
	      if _gb_preferencia_militar > 0.0 and _gb_prioridad > _gb_max_prioridad then
	        _gb_max_prioridad = _gb_prioridad
	        _gb_max_tropa = _gb_tropa
	      end
	      --if _gb_preferencia_militar > 0.0 and _gb_prioridad > 0.0 then
			    --FORMAR_BATALLON(origen, prioridad_base, _gb_prioridad, false, _gb_tropa, _gb_pais, false, mantenimiento)
	      --end
	    end
    end
    if _gb_max_prioridad > 0.0 then
      FORMAR_BATALLON(origen, prioridad_base, _gb_max_prioridad, false, _gb_max_tropa, _gb_pais, false, mantenimiento)
      
      _gb_efectivo_renovable = get_efectivo_renovable(_gb_cuartel)
      if(_gb_efectivo_renovable ~= 0) then
        LICENCIAR_EFECTIVO(origen, prioridad_base, _gb_max_prioridad, false, _gb_efectivo_renovable)
      end
    end
		generar_iniciativas_mejora_en_pais(origen, "mejora_militar", MEJORA_CREAR_BATALLON, _gb_pais, nil, prioridad_base, MINISTER_MILITAR)
		generar_iniciativas_mejora_en_pais(origen, "mejora_militar", MEJORA_CREAR_MANDO,    _gb_pais, nil, prioridad_base, MINISTER_MILITAR)
  end
  
  _gb_paises_sin_cuartel = get_paises_sin_cuartel()
  
  for it_pais in _gb_paises_sin_cuartel do
	  _gb_pais = _gb_paises_sin_cuartel[it_pais]
	  generar_iniciativas_mejora_en_pais(origen, "mejora_militar", MEJORA_CREAR_BATALLON, _gb_pais, nil, prioridad_base, MINISTER_MILITAR)	
  end  
end

-------------------------------------------------------------
-- Genera barcos
-------------------------------------------------------------
function generar_barcos(origen, prioridad_base, mantenimiento)
  local curables = get_barcos_danados()  
  for it_curable in curables do
  	local id_barco = curables[it_curable]
	  _gba_preferencia_militar    = get_preferencia_orden(TO_CURAR_EFECTIVO, MINISTER_MILITAR, origen, 0, 0, true, id_barco, TAM_FLOTA, false)
	  _gba_preferencia_economic   = get_preferencia_orden(TO_CURAR_EFECTIVO, MINISTER_ECONOMIC, origen, 0, 0, true, id_barco, TAM_FLOTA, false)
	  _gba_preferencia_diplomatic = get_preferencia_orden(TO_CURAR_EFECTIVO, MINISTER_DIPLOMATIC, origen, 0, 0, true, id_barco, TAM_FLOTA, false)
	  _gba_preferencia            = get_prioridad_ponderada(_gba_preferencia_militar, _gba_preferencia_economic, _gba_preferencia_diplomatic)
	  if _gba_preferencia >= 0.0 and _gba_preferencia_militar > 0.0 then	
		  CURAR_EFECTIVO(origen, prioridad_base, _gba_preferencia, false, id_barco, TAM_FLOTA, false)
	  end
  end
 
  _gba_puertos_militares = get_puertos_militares()  
  for it_puerto in _gba_puertos_militares do
    _gba_puerto = _gba_puertos_militares[it_puerto]
		_gba_provincia = get_provincia_of_puerto(_gba_puerto)
		_gba_pais = get_pais_of_provincia(_gba_provincia)
		_gba_max_preferencia = 0.0
		_gba_max_barco = 0
	  for it_barcos in barcos.all do
	    _gba_barco = barcos.all[it_barcos]
	    if(true == es_barco_construible_en_puerto(_gba_barco, _gba_puerto)) then  		
	      _gba_preferencia_militar    = get_preferencia_orden(TO_FORMAR_BARCO_MILITAR, MINISTER_MILITAR, origen, 0, 0, true, _gba_barco, _gba_puerto, false, false)
	      _gba_preferencia_economic   = get_preferencia_orden(TO_FORMAR_BARCO_MILITAR, MINISTER_ECONOMIC, origen, 0, 0, true, _gba_barco, _gba_puerto, false, false)
	      _gba_preferencia_diplomatic = get_preferencia_orden(TO_FORMAR_BARCO_MILITAR, MINISTER_DIPLOMATIC, origen, 0, 0, true, _gba_barco, _gba_puerto, false, false)
    	  _gba_preferencia            = get_prioridad_ponderada(_gba_preferencia_militar, _gba_preferencia_economic, _gba_preferencia_diplomatic)
    	  if _gba_preferencia_militar > 0.0 and _gba_preferencia > _gba_max_preferencia then
    	    _gba_max_preferencia  = _gba_preferencia
    	    _gba_max_barco        = _gba_barco
    	  end
	      --if _gba_preferencia > 0.0 and _gba_preferencia_militar > 0.0 then	
			    --FORMAR_BARCO(origen, prioridad_base, _gba_preferencia , false, _gba_barco, _gba_puerto, false, mantenimiento)
	      --end
	    end
    end
    if _gba_max_preferencia > 0.0 then
      FORMAR_BARCO(origen, prioridad_base, _gba_max_preferencia , false, _gba_max_barco, _gba_puerto, false, mantenimiento)
    end
		generar_iniciativas_mejora_en_pais(origen, "mejora_militar", MEJORA_CREAR_BARCO_MILITAR, _gba_pais, _gba_provincia, prioridad_base, MINISTER_MILITAR)
  end
  
  _gba_provincias_sin_puerto = get_provincias_sin_puerto()  
  for it_provincia in _gba_provincias_sin_puerto do
	  _gba_provincia = _gba_provincias_sin_puerto[it_provincia]
	  _gba_pais = get_pais_of_provincia(_gba_provincia)
	  generar_iniciativas_mejora_en_pais(origen, "mejora_militar", MEJORA_CREAR_BARCO_MILITAR, _gba_pais, _gba_provincia, prioridad_base, MINISTER_MILITAR)
  end  

end

--------------------------------------------------------
-- genera mensajes de paz para una tabla de enemigos
--------------------------------------------------------
function generar_paz(enemigos, origen, prioridad)
	for it_enemigo in enemigos do
		local enemigo = enemigos[it_enemigo]
		local mensaje = generar_mensaje_paz(enemigo, {})
		ENVIAR_MENSAJE_DIPLOMATICO(origen, prioridad, 0.0, false, mensaje)
	end
end

----------------------------
-- compara cuarteles
----------------------------
function compare_cuarteles(cuartel0, cuartel1)
  local pref0 = get_preferencia_cuartel(cuartel0)
  local pref1 = get_preferencia_cuaretel(cuartel1)
  
  return pref1 > pref0
end

----------------------------------------------
-- true si los jugadores estan a distancia 1
----------------------------------------------
function son_cofronterizos(jugador0, jugador1)
	return get_distancia_jugadores(jugador0, jugador1) == 1
end

-------------------------------------------------------------------------------------------------
-- devuelve la prioridad ponderada 
-------------------------------------------------------------------------------------------------
--function get_prioridad_ponderada(prioridad_militar, prioridad_economico, prioridad_diplomatico)
--  local perfil = get_perfil()
--  return (prioridad_militar*perfil[PF_PORCENTAJE_FACETA_MILITAR]+prioridad_economico*perfil[PF_PORCENTAJE_FACETA_ECONOMICA]+ prioridad_diplomatico*perfil[PF_PORCENTAJE_FACETA_DIPLOMATICA])
--end