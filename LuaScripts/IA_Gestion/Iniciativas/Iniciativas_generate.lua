-- Lua Script
-- Generacion de las acciones derivadas de las iniciativas

-- Nota: Se está evitando usar variables locales en todo momento, para facilitar la depuración.
--       Para ello se está añadiendo a todos los nombres de variables un prefijo dependiente de la
--       función en que se encuentran. Este prefijo evita que haya colisiones de variables globales.
--       Para facilitar la tarea de eliminar el uso de variables globales y dejar los scripts en su
--       estado final, habrá que marcar de manera especial los lugares donde se definen las variables
--       locales:
--        
--          -- local
--          _<prefijo>_var = ...        -- Define una variable local "var"
--
--       Para los parámetros y otras variables que son locales implícitamente (p.ej. iteradores),
--       se creará una variable global para ellas, marcada de la siguiente manera:
--
--          -- aux
--          _<prefijo>_param = param
--
--       De esta manera, modificar los scripts para eliminar este uso se reduce a ejecutar los siguientes
--       comandos Replace:
--
--          Replace "--:wh*local(:Wh*\n)*:Wh*_[:Al:Nu]+_" with "local " para eliminar el uso de globales.
--          Replace "--:Wh*aux(:Wh*\n)*.*$" with "" para eliminar el uso de variables auxiliares.
--          Replace "<_[:Al:Nu]+_" with "" para eliminar todos los prefijos restantes de las variables.
--
--       Habrá que evitar entonces definir variables cuyo nombre real empiece por '_'


preferencias_iniciativas = 
{
  ["guerra"] = {},
  ["paz"]    = {},
  ["ruta_terrestre"] = {},
  ["ruta_maritima"] = {},
  ["mejora_produccion"] = {}
}


preferencias_minimas_ordenes = 
{
  ["guerra"]             = 0.05,
  ["alianza"]            = 0.05,
  ["paz"]                = 0.05,
  ["edificio_anexion"]   = 0,
  ["tecnologia_anexion"] = 0,
  ["mensaje_anexion"]    = 0,
  ["ruta_terrestre"]	   = 0,
  ["ruta_maritima"]		   = 0,
  ["mejora_produccion"]  = 0,
  ["mejora_militar"]	   = 0.001,
  ["permiso_paso"]		   = 0.1,
  ["envio_efectivos"]		 = 0,
  ["realizar_sabotaje"] 	 = 0,
  ["matrimonio"]             = 0,
}

------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------- FUNCTIONS ----------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------


-----------------------------------------------
-- Genera la iniciativa de mejora militar
-----------------------------------------------
function generate_iniciativa_mejora_militar()
  -- Eliminamos las órdenes anteriores
  clear_orders(TINI_MEJORA_MILITAR)

	generar_ordenes_mejora_militar(TINI_MEJORA_MILITAR)
end

function generate_iniciativa_permiso_paso()
  -- Eliminamos las órdenes anteriores
  clear_orders(TINI_PERMISO_PASO)

	generar_ordenes_permiso_paso(TINI_PERMISO_PASO)
end

-----------------------------------------------
-- Genera la iniciativa de dinero
-----------------------------------------------
function generate_iniciativa_dinero()
  -- local
  _gid_regenerar = g_ultima_orden == nil

  if not _gid_regenerar then
    return
  end

  -- Eliminamos las órdenes anteriores
  clear_orders(TINI_INGRESO_DINERO_BAJO)

	generar_ordenes_rutas()
	generar_ordenes_crear_flotas_comerciales()
	generar_mejora_economica(TINI_INGRESO_DINERO_BAJO, MEJORA_PRODUCCION_DINERO)		
end

-----------------------------------------------
-- Genera la iniciativa de comida
-----------------------------------------------
function generate_iniciativa_comida()
  -- Eliminamos las órdenes anteriores
  clear_orders(TINI_INGRESO_COMIDA_BAJO)

	generar_mejora_economica(TINI_INGRESO_COMIDA_BAJO, MEJORA_PRODUCCION_COMIDA)	
end

-----------------------------------------------
-- Genera la iniciativa de matprimas
-----------------------------------------------
function generate_iniciativa_matprimas()
  -- Eliminamos las órdenes anteriores
  clear_orders(TINI_INGRESO_MATPRIMAS_BAJO)

	generar_mejora_economica(TINI_INGRESO_MATPRIMAS_BAJO, MEJORA_PRODUCCION_MATPRIMAS)	
end

-----------------------------------------------
-- Genera la iniciativa de ciencia
-----------------------------------------------
function generate_iniciativa_ciencia()
  -- Eliminamos las órdenes anteriores
  clear_orders(TINI_INGRESO_CIENCIA_BAJO)
end

-----------------------------------------------
-- Genera la iniciativa de poblacion
-----------------------------------------------
function generate_iniciativa_poblacion()
  -- Eliminamos las órdenes anteriores
  clear_orders(TINI_INGRESO_POBLACION_BAJO)

	generar_mejora_economica(TINI_INGRESO_POBLACION_BAJO, MEJORA_POBLACION)	
end

-------------------------------------------------------
-- Genera acciones de iniciativa de subvencionar una
-- rebelion mediante una celula de resistencia.
-------------------------------------------------------
function generate_iniciativa_subvencionar_celula_resistencia()
 -- Eliminamos las órdenes anteriores
 clear_orders(TINI_SUBVENCIONAR_CELULA_RESISTENCIA)

 -- El proceso sera el siguiente:
 -- * Para cada jugador imperial que no este eliminado y no sea el actual:
 --   * Si su grado de hostilidad es superior al de neutralidad:
 --    * Para cada pais anexionado por el jugador
 --      * Obtenemos los edificios construibles asociados a la mejora de sabotaje
 --      * Obtenemos grado de aprobacion para cada uno de ellos
 --      * Mandamos a que se hagan
 
 for it_jugador in jugadores.imperiales do    
  -- local
  _giscr_jugador_it = jugadores.imperiales[it_jugador]
  
  if not esta_jugador_eliminado(_giscr_jugador_it) and _giscr_jugador_it ~= MY_PLAYER_ID then  
    -- Comprueba si el grado de relacion es de enemistad
    -- local
   _giscr_grado_relacion = get_grado_relacion(MY_PLAYER_ID, _giscr_jugador_it)
    
   if _giscr_grado_relacion == TGR_ENEMISTAD then
    -- Itera por los paises anexionados por el jugador
    -- local
    _giscr_paises_jugador = get_paises(_giscr_jugador_it);
    
    for it_pais in _giscr_paises_jugador do    
     -- local
     _giscr_pais_it            = _giscr_paises_jugador[it_pais]
     _giscr_pais_it_anexionado = esta_pais_anexionado(_giscr_pais_it)
     
     if _giscr_pais_it_anexionado then
      -- Obtenemos edificios producibles con la mejora de sabotaje 
      -- Nota: - Realmente habra solo uno pero por si acaso iteramos por todos
      -- local
      _giscr_edificios_sabotaje = get_edificios_construibles_en_pais_con_mejora(_giscr_pais_it, MEJORA_SABOTAJE)
      
      for it_edificio in _giscr_edificios_sabotaje do
      
      -- local
       _giscr_edificio_it = _giscr_edificios_sabotaje[it_edificio]
       
       -- Obtenemos grado de aprobacion
       -- Nota: - Solo interesara el grado de aprobacion de los ministros milita, diplomatico y economico
       
       -- locals
       _giscr_prioridad_ministro_militar     = get_preferencia_orden(TO_CONSTRUIR_EDIFICIO, MINISTER_MILITAR, TINI_SUBVENCIONAR_CELULA_RESISTENCIA, 0, 0, true, _giscr_edificio_it, _giscr_pais_it, 0, false)
       _giscr_prioridad_ministro_economico   = get_preferencia_orden(TO_CONSTRUIR_EDIFICIO, MINISTER_ECONOMIC, TINI_SUBVENCIONAR_CELULA_RESISTENCIA, 0, 0, true, _giscr_edificio_it, _giscr_pais_it, 0, false)
       _giscr_prioridad_ministro_diplomatico = get_preferencia_orden(TO_CONSTRUIR_EDIFICIO, MINISTER_DIPLOMATIC, TINI_SUBVENCIONAR_CELULA_RESISTENCIA, 0, 0, true, _giscr_edificio_it, _giscr_pais_it, 0, false)
              
       _giscr_prioridad_final                = get_prioridad_ponderada(_giscr_prioridad_ministro_militar, _giscr_prioridad_ministro_economico, _giscr_prioridad_ministro_diplomatico)
              
       -- En caso de que el grado de aprobacion sea suficiente, ordenamos que se haga
       if _giscr_prioridad_final >= preferencias_minimas_ordenes.realizar_sabotaje then         
         CONSTRUIR_EDIFICIO(TINI_SUBVENCIONAR_CELULA_RESISTENCIA, _giscr_prioridad_final, 0, false, _giscr_edificio_it, _giscr_pais_it, 0, false)
       end              
       
      end            
     end -- if          
    end  -- for    
   end  -- if    
  end -- if     
 end -- for
  
end

-------------------------------------------------------
-- Genera la orden de matrimonio sobre el pais candidato
-- que proceda.
-- El proceso sera el siguiente:
--  * Hallar todos los jugadores con los que sea posible boda
--    * En caso de haber encontrado al menos un jugador:
--       * Ordenar los jugadores obtenidos por interes
--       * Tomar el primer jugador de la tabla ordenada y
--         obtener la preferencia de cada uno de los
--         ministros por el mismo.
--       * Mandar la peticion de realizar matrimonio.
-------------------------------------------------------
function generate_iniciativa_matrimonio()
 -- Eliminamos las órdenes anteriores
 clear_orders(TINI_MATRIMONIO)

 -- Obtenemos jugadores con los que podamos casarnos
 _gim_jugadores          = get_jugadores() 
 _gim_jugadores_casaderos = {}
 
 _gim_it_jugador = nil
 for _gim_it_jugador in _gim_jugadores do   
 
  local _gim_jugador = _gim_jugadores[_gim_it_jugador] 
  
  if (puede_proponer_matrimonio(MY_PLAYER_ID, _gim_jugador)) then
  
   table.insert(_gim_jugadores_casaderos, _gim_jugador)
   
  end  
  
 end
 
 -- En caso de haber encontrado al menos un jugador con el que sea posible la boda seguimos comprobando
 if table.getn(_gim_jugadores_casaderos) > 0 then
  
  -- Ordenamos tabla de jugadores casaderos en base a una formula 
  table.sort(_gim_jugadores_casaderos, compare_jugadores_casaderos) 
  
  -- El jugador que haya quedado en la cabeza sera el que mas interese para un casamiento
  local _gim_jugador_casadero = _gim_jugadores_casaderos[1]
   
  -- Lanzamos la peticion de realizar matrimonio 
   -- Generamos mensaje
   -- Obtenemos la preferencia de la orden
   -- Enviamos el mensaje
   
  _gim_mensaje     = generar_mensaje_matrimonio(_gim_jugador_casadero)
  _gim_preferencia = get_preferencia_orden(TO_ENVIAR_MENSAJE_DIPLOMATICO, MINISTER_INVALID, TINI_MATRIMONIO, 0, 0, true, _gim_mensaje)
  
  if _gim_preferencia >= preferencias_minimas_ordenes.matrimonio then
   ENVIAR_MENSAJE_DIPLOMATICO(TINI_MATRIMONIO, _gim_preferencia, 0, false, _gim_mensaje)
  end
  
 end
  
end

-------------------------------------------------------
-- Funcion de apoyo para ordenar una tabla de jugadores
-- casaderos. 
-------------------------------------------------------
function compare_jugadores_casaderos(jugador1, jugador2)
  if jugador1 == nil or jugador2 == nil then
    return true
  end

 local _cjc_interes_jugador_casadero_1 = calcule_interes_jugador_casadero(jugador1)
 local _cjc_interes_jugador_casadero_2 = calcule_interes_jugador_casadero(jugador2)
 
 return _cjc_interes_jugador_casadero_1 < _cjc_interes_jugador_casadero_2
end

-------------------------------------------------------
-- Funcion encargada de hallar el interes del jugador
-- pasado con respecto al jugador con el turno de cara a
-- una posible boda.
-- La formula tendra en cuenta 3 factores:
-- * Si el jugador es neutral
-- * Si el jugador esta cerca
-- * Si hay amistad
-- Cada factor tendra un peso diferente siendo el mas
-- importante el que sea jugador neutral.
-------------------------------------------------------
function calcule_interes_jugador_casadero (jugador)

 -- Establece los pesos en variables
 local _cjc_peso_jug_local           = 0.5
 local _cjc_peso_jug_zona_influencia = 0.4
 local _cjc_peso_jug_amistad         = 0.1
 
 -- Halla los factores para los diferentes pesos
 local _cjc_factor_jug_neutral         = 0.0
 local _cjc_factor_jug_zona_influencia = 0.0
 local _cjc_factor_jug_amistad         = 0.0
 
 if (not es_jugador_imperial(jugador)) then 
  _cjc_factor_jug_neutral = 1.0
 end
 
 local _cjc_zona_influencia = get_zona_influencia_geografica_of_jugadores(MY_PLAYER_ID, jugador)
 _cjc_factor_jug_zona_influencia = 1.0 - (_cjc_zona_influencia / ZI_3)
 
 local _cjc_grado_hostilidad = get_grado_hostilidad(MY_PLAYER_ID, jugador)
 _cjc_factor_jug_amistad = 1.0 - (_cjc_grado_hostilidad / 100.0)
 
 -- Calcula el valor final de interes
 local _cjc_interes = _cjc_peso_jug_local * _cjc_factor_jug_neutral + 
                      _cjc_peso_jug_zona_influencia * _cjc_factor_jug_zona_influencia + 
                      _cjc_peso_jug_amistad * _cjc_factor_jug_amistad
                      
 return _cjc_interes               
end

-------------------------------------------------------
-- Genera acciones de iniciativa de asimilar
-------------------------------------------------------
function generate_iniciativa_asimilar()
  -- local
  _gia_regenerar = g_ultima_orden    == nil                           or
                   g_ultima_orden[1] == TO_ATACAR_JUGADOR             or
                   g_ultima_orden[1] == TO_CURAR_EFECTIVO             or
                   g_ultima_orden[1] == TO_ENVIAR_MENSAJE_DIPLOMATICO or
                   g_ultima_orden[1] == TO_COBRAR_QUEST               or
                   g_ultima_orden[1] == TO_LICENCIAR_EFECTIVO

  if not _gia_regenerar then
    return
  end

  -- Eliminamos las órdenes anteriores
  clear_orders(TINI_ASIMILAR)

  -- local
  _gia_jugadores = get_jugadores()
  _gia_maximo_jugador_atacable = 0
  _gia_maxima_preferencia_ataque = -1.0
  -- aux
  _gia_it_jugador = nil
  _gia_aliados = {}
  for _gia_it_jugador in _gia_jugadores do
    -- local
    _gia_jugador = _gia_jugadores[_gia_it_jugador]

    if _gia_jugador ~= MY_PLAYER_ID and es_jugador_visible_diplomaticamente(_gia_jugador) then
      -- Generamos las distintas órdenes que tienen que ver con esta iniciativa            
      if not table_exist(_gia_aliados, _gia_jugador) then
        _gia_preferencia_ataque = generar_ordenes_guerra(_gia_jugador)
        if(_gia_preferencia_ataque > _gia_maxima_preferencia_ataque) then
          _gia_maxima_preferencia_ataque = _gia_preferencia_ataque
          _gia_maximo_jugador_atacable = _gia_jugador
        end
      end
      generar_ordenes_paz(_gia_jugador)
      generar_ordenes_anexion(_gia_jugador)
      
    end
  end
  
  if(_gia_maximo_jugador_atacable ~= 0) then
    generar_ordenes_alianza(_gia_maximo_jugador_atacable)
  end
  
  _gia_jugador_mas_odiado = get_jugador_mas_odiado()
  
  if(_gia_jugador_mas_odiado > 0  and _gia_jugador_mas_odiado ~= _gia_maximo_jugador_atacable) then
    generar_ordenes_alianza(_gia_jugador_mas_odiado)
  end
end
 

function generar_ordenes_paz(jugador)

  -- aux
  _gop_jugador = jugador

  if not es_jugador_enemigo(_gop_jugador) then
    return
  end

  -- Generamos mensaje de paz
  -- local
  _gop_mensaje = generar_mensaje_paz(_gop_jugador, {})

  if not puede_enviar_mensaje_diplomatico(_gop_mensaje, TINI_ASIMILAR) then
    generar_auto_mejora_tratado(_gop_mensaje, TINI_ASIMILAR)
  elseif(incidencias[TINC_NUMERO_CONFLICTOS_ELEVADO].enviados == 0) then
    -- local
    _gop_preferencia = get_preferencia_orden(TO_ENVIAR_MENSAJE_DIPLOMATICO, MINISTER_INVALID, TINI_ASIMILAR, 0, 0, true, _gop_mensaje)

    if preferencias_iniciativas.paz[_gop_jugador] == nil then
      preferencias_iniciativas.paz[_gop_jugador] = {}
    end
    preferencias_iniciativas.paz[_gop_jugador].preferencia = _gop_preferencia

    if _gop_preferencia >= preferencias_minimas_ordenes.paz then
      ENVIAR_MENSAJE_DIPLOMATICO(TINI_ASIMILAR, _gop_preferencia, 0, false, _gop_mensaje)
    end
  end
end


-------------------------------------------------
-- genera ordenes de guerra
-------------------------------------------------
function generar_ordenes_guerra(jugador)
  -- aux
  _gog_jugador = jugador
  -- local
  _gog_maxima_preferencia = -1.0

  _gog_perfil = get_perfil()
  -- aux
  _gog_jugador = jugador
  -- local
  _gog_mensaje = nil
  -- local
  _gog_preferencias = nil
  -- local
  _gog_preferencia_minima = 0

  -- Generamos mensaje de guerra
  if (not esta_jugador_en_guerra_diplomatica(MY_PLAYER_ID)) and puede_atacar_jugador(MY_PLAYER_ID, _gog_jugador) then
  
    _gog_mensaje = generar_mensaje_declaracion_guerra(_gog_jugador)

    if not puede_enviar_mensaje_diplomatico(_gog_mensaje, TINI_ASIMILAR) then
      generar_auto_mejora_tratado(_gog_mensaje, TINI_ASIMILAR)
    else
      -- local
      _gog_prioridad_ministro_militar     = get_preferencia_orden(TO_ENVIAR_MENSAJE_DIPLOMATICO, MINISTER_MILITAR,    TINI_ASIMILAR, 0, 0, true, _gog_mensaje)
      -- local
      _gog_prioridad_ministro_economico   = get_preferencia_orden(TO_ENVIAR_MENSAJE_DIPLOMATICO, MINISTER_ECONOMIC,   TINI_ASIMILAR, 0, 0, true, _gog_mensaje)
      -- local
      _gog_prioridad_ministro_diplomatico = get_preferencia_orden(TO_ENVIAR_MENSAJE_DIPLOMATICO, MINISTER_DIPLOMATIC, TINI_ASIMILAR, 0, 0, true, _gog_mensaje)
              
      -- local
      _gog_preferencia = get_prioridad_ponderada(_gog_prioridad_ministro_militar, _gog_prioridad_ministro_economico, _gog_prioridad_ministro_diplomatico)

      if preferencias_iniciativas.guerra[_gog_jugador] == nil then
        preferencias_iniciativas.guerra[_gog_jugador] = {}
      end
      preferencias_iniciativas.guerra[_gog_jugador].preferencia = _gog_preferencia
      
      _gog_min_dist_tropas = get_min_dist_tropas(_gog_jugador)
      
      if _gog_min_dist_tropas >= 0 then
        _gia_aliados = table_concat(_gia_aliados, get_aliados_of_jugador(_gia_jugador) )
      end

      if _gog_preferencia >= preferencias_minimas_ordenes.guerra and _gog_prioridad_ministro_militar >= -_gog_perfil[PF_TEMERIDAD] and _gog_min_dist_tropas >= 0 then
        if(get_hostilidad_media() < get_perfil()[PF_UMBRAL_DECLARACION_GUERRA] or table.getn(jugadores.all) == 2 or  _gog_min_dist_tropas > 2 ) then
          if es_jugador_atacable_sin_declaracion(_gog_jugador) then
            ATACAR_JUGADOR(TINI_ASIMILAR, _gog_preferencia, 0, false, _gog_jugador)
          end
        else
          ENVIAR_MENSAJE_DIPLOMATICO(TINI_ASIMILAR, _gog_preferencia, 0, false, _gog_mensaje)
        end
      else
        --if _gog_prioridad_ministro_militar < preferencias_minimas_ordenes.guerra and _gog_prioridad_ministro_diplomatico > preferencias_minimas_ordenes.guerra or 
          -- _gog_prioridad_ministro_militar < preferencias_minimas_ordenes.guerra and _gog_prioridad_ministro_diplomatico == 0 and get_grado_hostilidad(MY_PLAYER_ID, _gog_jugador) > 0.5 
        if _gog_preferencia > _gog_maxima_preferencia then
          _gog_maxima_preferencia = _gog_preferencia
        end
      end
    end
    
  end
   
  return _gog_maxima_preferencia

end

-------------------------------------------------
-- genera ordenes de alianzas
-------------------------------------------------
function generar_ordenes_alianza(jugador)
  -- aux
  _goal_jugador = jugador
  -- local
  _goal_aliados_factibles = get_aliados_factibles(MY_PLAYER_ID, jugador)

  if table.getn(_goal_aliados_factibles) > 0 then
    iniciar_ataque_con_alianzas(jugador, _goal_aliados_factibles)
  end
end

-------------------------------------------------
-- genera ordenes de ataque con alianzas
-------------------------------------------------
function iniciar_ataque_con_alianzas(enemigo, aliados_factibles)
  _iaca_perfil = get_perfil()
  -- aux
  _iaca_enemigo = enemigo
  -- aux
  _iaca_aliados_factibles = aliados_factibles
  -- local
  _iaca_conjuntos_alianzas = {}
  -- aux
  _iaca_it_aliado = 0

  table.sort(_iaca_aliados_factibles, compare_aliados_factibles)
  
  for _iaca_it_aliado in _iaca_aliados_factibles do
    -- local
    _iaca_aliado = _iaca_aliados_factibles[_iaca_it_aliado].jugador
    -- local
    _iaca_mensaje_coalicion = _iaca_aliados_factibles[_iaca_it_aliado].mensaje
    -- local
    _iaca_conjunto_alianzas_actual = {}

    if table.getn(_iaca_conjuntos_alianzas) > 0 then
      -- local
      _iaca_conjunto_alianzas_anterior = _iaca_conjuntos_alianzas[table.getn(_iaca_conjuntos_alianzas)]
      -- local
      _iaca_it_conjunto_alianzas_anterior = 0

      for _iaca_it_conjunto_alianzas_anterior in _iaca_conjunto_alianzas_anterior do
        table.insert(_iaca_conjunto_alianzas_actual, _iaca_conjunto_alianzas_anterior[_iaca_it_conjunto_alianzas_anterior])
      end
    end
    table.insert(_iaca_conjunto_alianzas_actual, _iaca_mensaje_coalicion)

    if not puede_enviar_mensaje_diplomatico(_iaca_conjunto_alianzas_actual, TINI_ASIMILAR) then
      -- Si no podemos enviar este conjunto de mensajes de coalición entonces no continuamos.
      break
    end

    table.insert(_iaca_conjuntos_alianzas, _iaca_conjunto_alianzas_actual)

    if table.getn(_iaca_conjuntos_alianzas) >= 2 then
      -- Si hemos llegado al límite de aliados que queremos intentar conseguir no seguimos considerando más jugadores.
      break
    end
  end

  -- local
  _iaca_mejor_conjunto_alianzas = nil
  -- local
  _iaca_mejor_preferencia = -1

  for _iaca_it_conjunto_alianzas in _iaca_conjuntos_alianzas do
    -- local
    _iaca_conjunto_alianzas = _iaca_conjuntos_alianzas[_iaca_it_conjunto_alianzas]
    
    -- local
    _iaca_prioridad_ministro_militar     = get_preferencia_orden(TO_ENVIAR_MENSAJE_DIPLOMATICO, MINISTER_MILITAR,    TINI_ASIMILAR, 0, 0, true, _iaca_conjunto_alianzas)
    -- local
    _iaca_prioridad_ministro_economico   = get_preferencia_orden(TO_ENVIAR_MENSAJE_DIPLOMATICO, MINISTER_ECONOMIC,   TINI_ASIMILAR, 0, 0, true, _iaca_conjunto_alianzas)
    -- local
    _iaca_prioridad_ministro_diplomatico = get_preferencia_orden(TO_ENVIAR_MENSAJE_DIPLOMATICO, MINISTER_DIPLOMATIC, TINI_ASIMILAR, 0, 0, true, _iaca_conjunto_alianzas)
                
    -- local
    _iaca_preferencia = get_prioridad_ponderada(_iaca_prioridad_ministro_militar, _iaca_prioridad_ministro_economico, _iaca_prioridad_ministro_diplomatico)

    --_iaca_preferencia = get_preferencia_orden(TO_ENVIAR_MENSAJE_DIPLOMATICO, MINISTER_INVALID, TINI_ASIMILAR, 0, 0, true, _iaca_conjunto_alianzas)
    if _iaca_preferencia > _iaca_mejor_preferencia and _iaca_prioridad_ministro_militar >= -_iaca_perfil[PF_TEMERIDAD] then
      _iaca_mejor_preferencia       = _iaca_preferencia
      _iaca_mejor_conjunto_alianzas = _iaca_conjunto_alianzas
    end
  end

  if _iaca_mejor_conjunto_alianzas ~= nil and 
     _iaca_mejor_preferencia >= preferencias_minimas_ordenes.alianza and
      not es_orden_vetada(_iaca_mejor_preferencia) 
  then
      _iaca_min_dist_tropas = get_min_dist_tropas(_iaca_enemigo)
      if _iaca_min_dist_tropas > 2 then
        if es_jugador_atacable_sin_declaracion(_iaca_enemigo) then
          ATACAR_JUGADOR(TINI_ASIMILAR, _iaca_mejor_preferencia, 0, false, _iaca_enemigo)
        end
      elseif _iaca_min_dist_tropas >= 0 then
        ENVIAR_MENSAJE_DIPLOMATICO(TINI_ASIMILAR, _iaca_mejor_preferencia, 0, false, _iaca_mejor_conjunto_alianzas)
      end
  end
end


-------------------------------------------------------------------------------
-- Devuelve la lista ordenada de aliados factibles para jugador_local contra 
-- jugador_enemigo. Si el jugador enemigo es un país uniprovincial entonces
-- ningún aliado es factible.
-- Los aliados factibles son aquellos jugadores que:
--    - Estan en el area de influencia militar.
--    - Pueden firmar alianza con el jugador contra el enemigo.
--    - Si el jugador enemigo es un país neutral no uniprovincial, el aliado 
--      no es un imperio (ya que se produciría un conflicto de intereses para 
--      ver quién anexionaría el país en caso de vencer).
-- La ordenación se lleva a cabo según lo devuelto por 'get_preferencia_aliado'
-------------------------------------------------------------------------------
function get_aliados_factibles(jugador_local, jugador_enemigo)
  -- aux
  _gaf_jugador_local   = jugador_local
  -- aux
  _gaf_jugador_enemigo = jugador_enemigo
  -- local 
  _gaf_aliados    = {}
  -- local 
  _gaf_candidatos = get_jugadores()
  -- aux
  _gaf_it = 0

  for _gaf_it in _gaf_candidatos do
    -- local 
    _gaf_candidato = _gaf_candidatos[_gaf_it]
    -- local 
    _gaf_mensaje_alianza = {}

    -- local 
    _gaf_ok = _gaf_candidato ~= _gaf_jugador_local and _gaf_candidato ~= _gaf_jugador_enemigo

    if _gaf_ok then
      _gaf_ok = es_jugador_visible_militarmente(_gaf_candidato)
    end
    
    if _gaf_ok and not es_jugador_imperial(_gaf_jugador_enemigo) then
      _gaf_ok = not es_jugador_imperial(_gaf_candidato)
    end

    if _gaf_ok then
      _gaf_ok = puede_atacar_jugador(_gaf_candidato, _gaf_jugador_enemigo)
    end

    if _gaf_ok then
      _gaf_mensaje_alianza = generar_mensaje_coalicion(_gaf_candidato, _gaf_jugador_enemigo, false, {})
      _gaf_ok = puede_enviar_mensaje_diplomatico(_gaf_mensaje_alianza, TINI_ASIMILAR)
    end
    
    if _gaf_ok then  
      table.insert(_gaf_aliados, { ["jugador"] = _gaf_candidato, ["mensaje"] = _gaf_mensaje_alianza } )
    end
  end

  return _gaf_aliados
end


-------------------------------------------------
-- comparaciond de aliados factibles
-------------------------------------------------
function compare_aliados_factibles(aliado1, aliado2)
  if aliado1 == nil or aliado2 == nil then
    return true
  end

  local mensaje1 = aliado1.mensaje
  local mensaje2 = aliado2.mensaje

  return mensaje1[MD_INDEX_OFERTA_DINERO] < mensaje2[MD_INDEX_OFERTA_DINERO]
end


-------------------------------------------------
-- genera ordenes anexion
-------------------------------------------------
function generar_ordenes_anexion(jugador)
  if es_jugador_imperial(MY_PLAYER_ID) then
    -- aux
    _goa_jugador = jugador

    if not es_jugador_imperial(_goa_jugador) and 
       not es_jugador_enemigo(_goa_jugador) then
      -- Solamente intentaremos anexionar paises neutrales.

      if not esta_jugador_asediado(_goa_jugador) or
         not es_jugador_enemigo(get_jugador_asediando(_goa_jugador)) then

        if es_jugador_visible_militarmente(_goa_jugador) then
          generar_ordenes_edificios_anexion(_goa_jugador)
        end
        generar_ordenes_mensajes_anexion(_goa_jugador)
      end

    end
  end
end

-------------------------------------------------
-- genera ordenes edificios de anexion
-------------------------------------------------
function generar_ordenes_edificios_anexion(jugador)
  -- aux
  _goea_jugador = jugador

  -- local
  _goea_pais_jugador = get_pais_inicial(_goea_jugador)
  -- local
  _goea_edificios_anexion = get_edificios_construibles_en_pais_con_mejora(_goea_pais_jugador, MEJORA_ASIMILACION_PACIFICA + MEJORA_HABILITA_ASIMILACION_PACIFICA)

  if table.getn(_goea_edificios_anexion) > 0 then
    --aux
    _goea_it_edificio = nil
    for _goea_it_edificio in _goea_edificios_anexion do
      -- local
      _goea_edificio = _goea_edificios_anexion[_goea_it_edificio]
      -- local
      _goea_preferencia = get_preferencia_orden(TO_CONSTRUIR_EDIFICIO, MINISTER_INVALID, TINI_ASIMILAR, 0, 0, true, _goea_edificio, _goea_pais_jugador, 0, true)

      if _goea_preferencia >= preferencias_minimas_ordenes.edificio_anexion and not es_orden_vetada(_goea_preferencia) then
        CONSTRUIR_EDIFICIO(TINI_ASIMILAR, _goea_preferencia, 0, false, _goea_edificio, _goea_pais_jugador, 0, false)
      end
    end
  else
    -- local
    _goea_tecnologias_anexion = get_tecnologias_investigables_con_mejora(MEJORA_ASIMILACION_PACIFICA + MEJORA_HABILITA_ASIMILACION_PACIFICA)

    --aux
    _goea_it_tecnologia = nil
    for _goea_it_tecnologia in _goea_tecnologias_anexion do
      -- local
      _goea_tecnologia = _goea_tecnologias_anexion[_goea_it_tecnologia]
      -- local
      _goea_preferencia = get_preferencia_orden(TO_INVESTIGA_TECNOLOGIA, MINISTER_INVALID, TINI_ASIMILAR, 0, 0, true, _goea_tecnologia, false)

      if _goea_preferencia >= preferencias_minimas_ordenes.tecnologia_anexion and not es_orden_vetada(_goea_preferencia) then
        INVESTIGAR_TECNOLOGIA(TINI_ASIMILAR, _goea_preferencia, 0, false, _goea_tecnologia, false)
      end
    end
  end
end


-------------------------------------------------
-- genera ordenes mensajes de anexion
-------------------------------------------------
function generar_ordenes_mensajes_anexion(jugador)
  -- aux
  _goma_jugador = jugador

  _goma_mensaje = generar_mensaje_mejora_relaciones(_goma_jugador)

  if not puede_enviar_mensaje_diplomatico(_goma_mensaje, TINI_ASIMILAR) then
    generar_auto_mejora_tratado(_goma_mensaje, TINI_ASIMILAR)
  else
    -- local
    _goma_preferencia = get_preferencia_orden(TO_ENVIAR_MENSAJE_DIPLOMATICO, MINISTER_INVALID, TINI_ASIMILAR, 0, 0, true, _goma_mensaje)

    if _goma_preferencia >= preferencias_minimas_ordenes.mensaje_anexion and not es_orden_vetada(_goma_preferencia) then
      ENVIAR_MENSAJE_DIPLOMATICO(TINI_ASIMILAR, _goma_preferencia, 0, false, _goma_mensaje)
    end
  end
end


-------------------------------------------------
-- genera auto mejora de tratado diplomatico
-------------------------------------------------
function generar_auto_mejora_tratado(mensaje, origen)
  -- aux
  _gamt_mensaje = mensaje

  if not puede_enviar_mensaje_diplomatico_por_tipo(_gamt_mensaje) then
    -- Miramos a ver si no podemos enviarlo por no tener la tecnologia requerida
    if not tiene_tecnologia_requerida_por_mensaje(_gamt_mensaje[MD_INDEX_TIPO]) then
      INVESTIGAR_TECNOLOGIA(origen, 0, 0, true, get_idx_tecnologia_requerida_por_mensaje(_gamt_mensaje[MD_INDEX_TIPO]), false)
      return true
    end
  end

  return false
end

-------------------------------------------------
-- genera ordenes de rutas
-------------------------------------------------
function generar_ordenes_rutas(jugador)

	_goru_rutas = {}
	calcular_rutas_terrestres(_goru_rutas)
	_goru_num_rutas_terrestres = table.getn(_goru_rutas)
	_goru_ausencia_rutas_terrestre = ( _goru_num_rutas_terrestres == 0)		
	calcular_rutas_maritimas(_goru_rutas)
	_goru_num_rutas_maritimas = table.getn(_goru_rutas) - _goru_num_rutas_terrestres
	_goru_ausencia_rutas_maritimas = (_goru_num_rutas_maritimas == 0)
	_goru_ausencia_edificios_rutas_terrestres = false
	_goru_tecnologias_rutas_terrestres = get_tecnologias_investigables_con_mejora(MEJORA_PRODUCCION_DINERO)
	
	for it_ruta in _goru_rutas do
		_goru_ruta = _goru_rutas[it_ruta]
		if(_goru_ruta.tipo == tipo_ruta_terrestre) then
			_goru_edificios = get_edificios_construibles_en_pais_con_mejora(_goru_ruta.pais, MEJORA_PRODUCCION_DINERO)
			for it_edificio in _goru_edificios do
				_goru_edificio = _goru_edificios[it_edificio]
				_goru_preferencia = get_preferencia_orden(TO_CONSTRUIR_EDIFICIO, MINISTER_INVALID, TINI_INGRESO_DINERO_BAJO, 0, 0, true, _goru_edificio, _goru_ruta.pais,0,  true)
				if _goru_preferencia >= preferencias_minimas_ordenes.ruta_terrestre then
					CONSTRUIR_EDIFICIO(TINI_INGRESO_DINERO_BAJO, _goru_preferencia, 0, false, _goru_edificio, _goru_ruta.pais, 0, true)
				end				

			end
			_goru_ausencia_edificios_rutas_terrestres = _goru_ausencia_edificios_rutas_terrestres or table.getn(_goru_edificios) > 0
		else
			_goru_preferencia = get_preferencia_orden(TO_GENERAR_RUTA_MARITIMA, MINISTER_INVALID, TINI_INGRESO_DINERO_BAJO, 0, 0, true, _goru_ruta.flota, _goru_ruta.destino)
			if _goru_preferencia >= preferencias_minimas_ordenes.ruta_maritima then

				GENERAR_RUTA_MARITIMA(TINI_INGRESO_DINERO_BAJO, _goru_preferencia, 0, false, _goru_ruta.flota, _goru_ruta.destino)
			end			
		end
	end	
	
end

-------------------------------------------------
-- genera iniciativa crear flotas comerciales
-------------------------------------------------
function generar_ordenes_crear_flotas_comerciales()

    _gocf_provincias_puerto = get_provincias_con_puerto(MY_PLAYER_ID)    
    _gocf_puertos_comerciales = table_filter_one(_gocf_provincias_puerto, tiene_puerto_comercial)

    _gocf_rutas_maritimas =  {}
	for it_puerto in _gocf_puertos_comerciales do
		_gocf_puerto = _gocf_puertos_comerciales[it_puerto]      
		_gocf_flotas_construibles = get_flotas_construibles_en_puerto(_gocf_puerto)      
		for it_flota in _gocf_flotas_construibles do
			_gocf_flota = _gocf_flotas_construibles[it_flota]
			_gocf_destinos = get_rutas_maritimas_construibles(_gocf_puerto, _gocf_flota)
			for it_destino in _gocf_destinos do
				_gocf_destino = _gocf_destinos[it_destino]
				_gocf_valor = get_valor_ruta_maritima_construible(_gocf_destino, _gocf_flota)
				if(_gocf_rutas_maritimas[_gocf_destino] == NIL or _gocf_rutas_maritimas[_gocf_destino].valor < _gocf_valor) then
					_gocf_rutas_maritimas[_gocf_destino] = {puerto = get_puerto_comercial_of_provincia(_gocf_puerto), flota = _gocf_flota, destino = _gocf_destino, valor = _gocf_valor}
				end
			end
		end
	end    
      
   for it_ruta in _gocf_rutas_maritimas do
     _gocf_ruta = _gocf_rutas_maritimas[it_ruta]
     _gocf_preferencia = get_preferencia_orden(TO_CONSTRUIR_BARCO_COMERCIAL, MINISTER_INVALID, TINI_INGRESO_DINERO_BAJO, 0, 0, true,_gocf_ruta.flota, _gocf_ruta.puerto)
     if(_gocf_preferencia >= preferencias_minimas_ordenes.mejora_produccion) then
		CONSTRUIR_BARCO(TINI_INGRESO_DINERO_BAJO, _gocf_preferencia, 0, false, _gocf_ruta.flota, _gocf_ruta.puerto)
     end     
   end

   generar_mejora_economica(TINI_INGRESO_DINERO_BAJO,MEJORA_CREAR_BARCO_COMERCIAL)
end

-------------------------------------------------
-- genera iniciativa mejora economica
-------------------------------------------------
function generar_mejora_economica(origen, mejora)
	_gome_edificios = get_edificios_construibles_con_mejora(mejora)
	for it_edificio in _gome_edificios do
		_gome_edificio = _gome_edificios[it_edificio].edificio
		_gome_pais = _gome_edificios[it_edificio].pais
		_gome_preferencia = get_preferencia_orden(TO_CONSTRUIR_EDIFICIO, MINISTER_INVALID, origen, 0, 0, true, _gome_edificio, _gome_pais, 0, true)
		if _gome_preferencia >= preferencias_minimas_ordenes.mejora_produccion then
			CONSTRUIR_EDIFICIO(origen, _gome_preferencia, 0, false, _gome_edificio, _gome_pais, 0, true)
		end		
	end

	_gome_tecnologias = get_tecnologias_investigables_con_mejora(mejora)	
	
	if table.getn(_gome_tecnologias) > 0 then
		_gome_distancia_tecno = table_transform_one(_gome_tecnologias, get_distancia_tecnologia)    
		_gome_min_dist_tecno = table_min(_gome_distancia_tecno)
		_gome_preferencia = get_preferencia_orden(TO_INVESTIGA_TECNOLOGIA, MINISTER_INVALID, origen, 0, 0, true, _gome_tecnologias[_gome_min_dist_tecno], false) 

		if _gome_preferencia >= preferencias_minimas_ordenes.mejora_produccion then
			--INVESTIGAR_TECNOLOGIA(origen, _gome_preferencia, 0, false, _gome_tecnologias[_gome_min_dist_tecno], false) 
		end
	end	
end

-------------------------------------------------
-- genera iniciativa mejoras militares
-------------------------------------------------
function generar_ordenes_mejora_militar(origen)
	
	generar_iniciativa_mejora_batallones(origen)
	generar_iniciativa_mejora_barcos(origen)
	_gomm_table_mejoras = {MEJORA_HABILITAR_TACTICA_MILITAR, MEJORA_CALIDAD_BATALLONES, MEJORA_PERMITE_CURAR_BATALLONES}
	if(table.getn(get_puertos_militares()) > 0) then
		table_concat(_gomm_table_mejoras, {MEJORA_CALIDAD_BARCOS_MILITARES, MEJORA_EXPERIENCIA_BATALLONES, MEJORA_EXPERIENCIA_BARCOS_MILITARES} )
	end
	_gomm_mejora = union_mejoras( _gomm_table_mejoras );
	generar_iniciativas_mejora_jugador(origen, "mejora_militar", _gomm_mejora)
end


-------------------------------------------------
-- genera iniciativa crear batallones
-------------------------------------------------
function generar_iniciativa_mejora_batallones(origen)
 
  ------------------  CURAR EFECTIVOS ------------------
  local curables = get_efectivos_danados()  
  for it_curable in curables do
	local id_efectivo = curables[it_curable]
	_goib_preferencia = get_preferencia_orden(TO_CURAR_EFECTIVO, MINISTER_INVALID, origen, 0, 0, true, id_efectivo, TAM_EJERCITO, false)
	if _goib_preferencia >= preferencias_minimas_ordenes.mejora_militar then
		CURAR_EFECTIVO(origen, _goib_preferencia, 0, false, id_efectivo, TAM_EJERCITO, false)
	end
  end

  
  ------------------  CREAR EFECTIVOS ------------------
 _goib_cuarteles = get_cuarteles()

  for it_cuartel in _goib_cuarteles do
    _goib_cuartel = _goib_cuarteles[it_cuartel]

    _goib_pais = get_pais_of_cuartel(_goib_cuartel)
    _goib_max_pref = preferencias_minimas_ordenes.mejora_militar
    _goib_max_troop = 0    
	  for it_tropa in tropas.all do
	    _goib_tropa = tropas.all[it_tropa]
	    if(true == es_tropa_construible_en_pais(_goib_tropa, _goib_pais)) then  		
	      _goib_preferencia = get_preferencia_orden(TO_FORMAR_BATALLON, MINISTER_INVALID, origen, 0, 0, true, _goib_tropa, _goib_pais, false, false)
	      if _goib_preferencia >= _goib_max_pref then
	        _goib_max_troop = _goib_tropa
	        _goib_max_pref = _goib_preferencia
	      end
	    end
    end

    if(_goib_max_troop > 0) then
      FORMAR_BATALLON(origen, _goib_max_pref, 0, false, _goib_max_troop, _goib_pais, false, false)
  
      _goib_efectivo_renovable = get_efectivo_renovable(_goib_cuartel)
      if(_goib_efectivo_renovable ~= 0) then
        LICENCIAR_EFECTIVO(origen, 1.0, 1.0, false, _goib_efectivo_renovable)
      end
    end

		generar_iniciativas_mejora_en_pais(origen, "mejora_militar", MEJORA_CREAR_BATALLON, _goib_pais)
		generar_iniciativas_mejora_en_pais(origen, "mejora_militar", MEJORA_CREAR_MANDO, _goib_pais)
  end
  
  ------------------  CURAR CUARTELES ------------------
  _goib_paises_sin_cuartel = get_paises_sin_cuartel()  
  for it_pais in _goib_paises_sin_cuartel do
	  _goib_pais = _goib_paises_sin_cuartel[it_pais]
	  generar_iniciativas_mejora_en_pais(origen, "mejora_militar", MEJORA_CREAR_BATALLON, _goib_pais)	
  end  
  
end

-------------------------------------------------
-- genera iniciativas crear barcos
-------------------------------------------------
function generar_iniciativa_mejora_barcos(origen)
 
  local curables = get_barcos_danados()  
  for it_curable in curables do
	  local id_barco = curables[it_curable]
	  _gimb_preferencia = get_preferencia_orden(TO_CURAR_EFECTIVO, MINISTER_INVALID, origen, 0, 0, true, id_barco, TAM_FLOTA, false)
	  if _gimb_preferencia >= preferencias_minimas_ordenes.mejora_militar then	
		  CURAR_EFECTIVO(origen, _goib_preferencia, 0, false, id_barco, TAM_FLOTA, false)
	  end
  end
 
  _gimb_puertos_militares = get_puertos_militares()  
  for it_puerto in _gimb_puertos_militares do
    _gimb_puerto = _gimb_puertos_militares[it_puerto]
		_gimb_provincia = get_provincia_of_puerto(_gimb_puerto)
		_gimb_pais = get_pais_of_provincia(_gimb_provincia)

	  for it_barcos in barcos.all do
	    _gimb_barco = barcos.all[it_barcos]
	    if(true == es_barco_construible_en_puerto(_gimb_barco, _gimb_puerto)) then  		
	      _gimb_preferencia = get_preferencia_orden(TO_FORMAR_BARCO_MILITAR, MINISTER_INVALID, origen, 0, 0, true, _gimb_barco, _gimb_puerto, false, false)
	      if _gimb_preferencia >= preferencias_minimas_ordenes.mejora_militar then
			    FORMAR_BARCO(origen, _gimb_preferencia , 0, false, _gimb_barco, _gimb_puerto, false, false)
	      end
	    end
    end

    generar_iniciativas_mejora_en_pais(origen, "mejora_militar", MEJORA_CREAR_BARCO_MILITAR, _gimb_pais, _gimb_provincia)
  end
  
  _gimb_provincias_sin_puerto = get_provincias_sin_puerto()  
  for it_provincia in _gimb_provincias_sin_puerto do
	  _gimb_provincia = _gimb_provincias_sin_puerto[it_provincia]
	  _gimb_pais = get_pais_of_provincia(_gimb_provincia)
	  generar_iniciativas_mejora_en_pais(origen, "mejora_militar", MEJORA_CREAR_BARCO_MILITAR, _gimb_pais, _gimb_provincia)
  end  
 
end

-------------------------------------------------
-- genera iniciativas mejora generica en pais
-------------------------------------------------
function generar_iniciativas_mejora_en_pais(origen, tipo,  mejora, pais , provincia, prioridad_base, ministro_obligado)

  _gimp_edificios_con_mejora = get_edificios_construibles_en_pais_con_mejora(pais, mejora)
  if(provincia == NIL ) then
	provincia = 0
  else
	_gimp_edificios_con_mejora = table_filter_two(_gimp_edificios_con_mejora, es_edificio_construible_en_provincia, provincia)
  end  
  
  for iterator_edificio in _gimp_edificios_con_mejora do
	  _gimp_edificio = _gimp_edificios_con_mejora[iterator_edificio]
	  _gimp_preferencia_militar     = get_preferencia_orden(TO_CONSTRUIR_EDIFICIO, MINISTER_MILITAR, origen, 0, 0, true, _gimp_edificio, pais, provincia, true)
	  _gimp_preferencia_economic    = get_preferencia_orden(TO_CONSTRUIR_EDIFICIO, MINISTER_ECONOMIC, origen, 0, 0, true, _gimp_edificio, pais, provincia, true)
    _gimp_preferencia_diplomatic  = get_preferencia_orden(TO_CONSTRUIR_EDIFICIO, MINISTER_DIPLOMATIC, origen, 0, 0, true, _gimp_edificio, pais, provincia, true)
    _gimp_preferencia             = get_prioridad_ponderada(_gimp_preferencia_militar, _gimp_preferencia_economic, _gimp_preferencia_diplomatic)
  
    --if _gimp_preferencia >= preferencias_minimas_ordenes[tipo] and not es_orden_vetada(_gimp_preferencia) then
    if cumple_preferencia(tipo, _gimp_preferencia_militar, _gimp_preferencia_economic, _gimp_preferencia_diplomatic, _gimp_preferencia, ministro_obligado) then
      if(prioridad_base == nil) then
	      CONSTRUIR_EDIFICIO(origen, _gimp_preferencia, 0, false, _gimp_edificio, pais, provincia, true)
      else
	      CONSTRUIR_EDIFICIO(origen, _gimp_preferencia, _gimp_preferencia, false, _gimp_edificio, pais, provincia, true)
	    end
    end
  end  
       
  -- INVESTIGAR TECNOLOGIA
  _gimp_tecnologias_con_mejora = get_tecnologias_investigables_con_mejora(mejora)
  if( table.getn(_gimp_tecnologias_con_mejora) > 0) then    
	  for iterator_tecnologia in _gimp_tecnologias_con_mejora do
	    _gimp_tecnologia = _gimp_tecnologias_con_mejora[iterator_tecnologia]
	    _gimp_edificio = get_idx_edificio_of_tecnologia(_gimp_tecnologia)
	    if(_gimp_edificio > 0) then
  		  _gimp_preferencia_militar     = get_preferencia_orden(TO_CONSTRUIR_EDIFICIO, MINISTER_MILITAR, origen, 0, 0, true, _gimp_edificio, pais, provincia, true)
  		  _gimp_preferencia_economic    = get_preferencia_orden(TO_CONSTRUIR_EDIFICIO, MINISTER_ECONOMIC, origen, 0, 0, true, _gimp_edificio, pais, provincia, true)
  		  _gimp_preferencia_diplomatic  = get_preferencia_orden(TO_CONSTRUIR_EDIFICIO, MINISTER_DIPLOMATIC, origen, 0, 0, true, _gimp_edificio, pais, provincia, true)
  		  _gimp_preferencia             = get_prioridad_ponderada(_gimp_preferencia_militar, _gimp_preferencia_economic, _gimp_preferencia_diplomatic)
	    else
		    _gimp_preferencia_militar     = get_preferencia_orden(TO_INVESTIGA_TECNOLOGIA, MINISTER_MILITAR, origen, 0, 0, true, _gimp_tecnologia, false)
		    _gimp_preferencia_economic    = get_preferencia_orden(TO_INVESTIGA_TECNOLOGIA, MINISTER_ECONOMIC, origen, 0, 0, true, _gimp_tecnologia, false)
		    _gimp_preferencia_diplomatic  = get_preferencia_orden(TO_INVESTIGA_TECNOLOGIA, MINISTER_DIPLOMATIC, origen, 0, 0, true, _gimp_tecnologia, false)
  		  _gimp_preferencia             = get_prioridad_ponderada(_gimp_preferencia_militar, _gimp_preferencia_economic, _gimp_preferencia_diplomatic)
	    end
      if cumple_preferencia(tipo, _gimp_preferencia_militar, _gimp_preferencia_economic, _gimp_preferencia_diplomatic, _gimp_preferencia, ministro_obligado) then
        if(prioridad_base == nil) then
		      INVESTIGAR_TECNOLOGIA(origen, _gimp_preferencia, 1/get_distancia_tecnologia(_gimp_tecnologia), false, _gimp_tecnologia, false)    
		    else
		      INVESTIGAR_TECNOLOGIA(origen, prioridad_base, _gimp_preferencia, false, _gimp_tecnologia, false)    
		    end
	    end
	  end
  elseif(mejora ~= MEJORA_CAMBIO_GOBIERNO) then    
    generar_iniciativas_mejora_en_pais(origen, tipo, MEJORA_CAMBIO_GOBIERNO, pais, provincia, prioridad_base, ministro_obligado)    
  end  

end

function cumple_preferencia(tipo, preferencia_militar, preferencia_economico, preferencia_diplomatico, preferencia_ponderada, ministro_obligado)
  
  if preferencia_ponderada >= preferencias_minimas_ordenes[tipo] and not es_orden_vetada(preferencia_ponderada) then
    if(ministro_obligado == MINISTER_MILITAR) then
      return preferencia_militar >= preferencias_minimas_ordenes[tipo] and not es_orden_vetada(preferencia_militar)
    elseif(ministro_obligado == MINISTER_ECONOMIC) then
      return preferencia_economico >= preferencias_minimas_ordenes[tipo] and not es_orden_vetada(preferencia_economico)
    elseif(ministro_obligado == MINISTER_DIPLOMATIC) then
      return preferencia_diplomatico >= preferencias_minimas_ordenes[tipo] and not es_orden_vetada(preferencia_diplomatico)
    else
      return true
    end
  end
  
  return false
end

-------------------------------------------------
-- genera iniciativas mejora generica jugador
-------------------------------------------------
function generar_iniciativas_mejora_jugador(origen, tipo,  mejora)

  _gimj_edificios_con_mejora = get_edificios_construibles_con_mejora(mejora)
  
  for iterator_edificio in _gimj_edificios_con_mejora do
	_gimj_edificio = _gimj_edificios_con_mejora[iterator_edificio].edificio
	_gimj_pais = _gimj_edificios_con_mejora[iterator_edificio].pais

	_gimj_preferencia = get_preferencia_orden(TO_CONSTRUIR_EDIFICIO, MINISTER_INVALID, origen, 0, 0, true, _gimj_edificio, _gimj_pais, 0, true)

    if _gimj_preferencia >= preferencias_minimas_ordenes[tipo] and not es_orden_vetada(_gimj_preferencia) then
	  CONSTRUIR_EDIFICIO(origen, _gimj_preferencia, 0, false, _gimj_edificio, _gimj_pais, 0, true)
    end
  end  
       
  -- INVESTIGAR TECNOLOGIA
  _gimj_tecnologias_con_mejora = get_tecnologias_investigables_con_mejora(mejora)
  if( table.getn(_gimj_tecnologias_con_mejora) > 0) then    
	for iterator_tecnologia in _gimj_tecnologias_con_mejora do
	  _gimj_tecnologia = _gimj_tecnologias_con_mejora[iterator_tecnologia]
	  _gimj_preferencia = get_preferencia_orden(TO_INVESTIGA_TECNOLOGIA, MINISTER_INVALID, origen, 0, 0, true, _gimj_tecnologia, false)
	  if _gimj_preferencia >= preferencias_minimas_ordenes[tipo] and not es_orden_vetada(_gimj_preferencia) then
		INVESTIGAR_TECNOLOGIA(origen, _gimj_preferencia, 0, false, _gimj_tecnologia, false)    
	  end
	end
  elseif(mejora ~= MEJORA_CAMBIO_GOBIERNO) then    
    generar_iniciativas_mejora_jugador(origen, tipo, MEJORA_CAMBIO_GOBIERNO)
  end  

end

-------------------------------------------------
-- genera ordenes de permiso de paso
-------------------------------------------------
function generar_ordenes_permiso_paso(origen)	

	for it_jugador in jugadores.all do
		_gopp_jugador = jugadores.all[it_jugador]
		_gopp_distancia = get_distancia_jugadores(MY_PLAYER_ID, _gopp_jugador)
		if(_gopp_distancia == 1) then
			_gopp_mensaje = generar_mensaje_permiso_paso(_gopp_jugador, false)	
			if not puede_enviar_mensaje_diplomatico(_gopp_mensaje, origen) then
				generar_auto_mejora_tratado(_gopp_mensaje, origen)
			else
				_gopp_preferencia = get_preferencia_orden(TO_ENVIAR_MENSAJE_DIPLOMATICO, MINISTER_INVALID, TINI_ASIMILAR, 0, 0, true, _gopp_mensaje)

				if _gopp_preferencia >= preferencias_minimas_ordenes.permiso_paso then
					ENVIAR_MENSAJE_DIPLOMATICO(TINI_ASIMILAR, _gopp_preferencia, 0, false, _gopp_mensaje)
				end				
			end
		end		
	end	
end


function generate_iniciativa_enviar_efectivos()	

  -- Eliminamos las órdenes anteriores
  clear_orders(TINI_ENVIAR_EFECTIVOS)

  -- local
  _giee_aliados   = table_filter_one(get_jugadores(), es_jugador_aliado)
  -- local
  _giee_jugadores = table_filter_one(_giee_aliados, esta_jugador_asediado)

  -- local
  _giee_jugadores_peticion = get_jugadores_peticion_ayuda()
  for it_jugadores_peticion in _giee_jugadores_peticion do
    table.insert(_giee_jugadores, _giee_jugadores_peticion[it_jugadores_peticion])
  end

  if table.getn(_giee_jugadores) > 1 then
    table.sort(_giee_jugadores, compare_jugadores_enviar_efectivos)
  end

  -- aux
  _giee_it_jugador = 0
  for _giee_it_jugador in _giee_jugadores do
    -- local
    _giee_jugador = _giee_jugadores[_giee_it_jugador]

    -- local
    _giee_batallones = get_batallones_para_envio(_giee_jugador)
    -- TODO: Considerar enviar barcos

    if table.getn(_giee_batallones) == 0 then
      -- No tenemos efectivos que podamos mandar, así que salimos
      break
    end

    -- local
    _giee_mensaje = generar_mensaje_envio_efectivos(_giee_jugador, _giee_batallones, {}, true)
    -- Ajustamos el precio dependiendo de nuestro grado de relación con el país
    _giee_mensaje[MD_INDEX_OFERTA_DINERO] = get_grado_hostilidad(MY_PLAYER_ID, _giee_jugador) * _giee_mensaje[MD_INDEX_OFERTA_DINERO]

		if not puede_enviar_mensaje_diplomatico(_giee_mensaje, TINI_ENVIAR_EFECTIVOS) then
			generar_auto_mejora_tratado(_giee_mensaje, TINI_ENVIAR_EFECTIVOS)
      break
		else
			_giee_preferencia = get_preferencia_orden(TO_ENVIAR_MENSAJE_DIPLOMATICO, MINISTER_INVALID, TINI_ENVIAR_EFECTIVOS, 0, 0, true, _giee_mensaje)

			if _giee_preferencia >= preferencias_minimas_ordenes.envio_efectivos then
				ENVIAR_MENSAJE_DIPLOMATICO(TINI_ENVIAR_EFECTIVOS, _giee_preferencia, 0, false, _giee_mensaje)
        -- No enviamos más efectivos en este turno
        break
			end				
		end
  end
end


function compare_jugadores_enviar_efectivos(jugador1, jugador2)
  -- aux
  _cjee_jugador1 = jugador1
  -- aux
  _cjee_jugador2 = jugador2
  
  local ret

  if jugador1 == nil or jugador2 == nil then
	  ret = true
  else	

    -- local
    _cjee_jugador1_es_aliado = es_jugador_aliado(_cjee_jugador1)
    -- local
    _cjee_jugador2_es_aliado = es_jugador_aliado(_cjee_jugador2)

    if _cjee_jugador1_es_aliado and not _cjee_jugador2_es_aliado then
      -- Damos preferencia al aliado
      ret = true
    elseif not _cjee_jugador1_es_aliado and _cjee_jugador2_es_aliado then
      -- Damos preferencia al aliado
      ret = false
    else
      -- Damos preferencia al que peor nivel defensivo tenga

      -- local
      _cjee_nivel_defensivo_jugador1 = get_nivel_defensivo(_cjee_jugador1)
      -- local
      _cjee_nivel_defensivo_jugador2 = get_nivel_defensivo(_cjee_jugador2)

      ret = _cjee_nivel_defensivo_jugador1 < _cjee_nivel_defensivo_jugador2
    end

  end

  return ret
end


function generate_iniciativa_comprar_territorios()
  -- Eliminamos las órdenes anteriores
  clear_orders(TINI_COMPRAR_TERRITORIOS)

  -- local
  _gict_provincias_iniciales_perdidas = table_filter_two(get_provincias_perdidas(MY_PLAYER_ID, true), es_provincia_inicial, MY_PLAYER_ID)
  
  -- local
  _gict_posibles_compras = {}

  -- aux
  _gict_it_provincias = 0
  for _gict_it_provincias in _gict_provincias_iniciales_perdidas do
    -- local
    _gict_provincia = _gict_provincias_iniciales_perdidas[_gict_it_provincias]
    -- local
    _gict_jugador   = get_jugador_of_provincia(_gict_provincia)
    -- local
    _gict_mensaje   = generar_mensaje_intercambio(_gict_jugador, 0, 0, 0, 0, {}, { _gict_provincia }, true)
    -- local
    _gict_precio    = _gict_mensaje[MD_INDEX_OFERTA_DINERO]

    table.insert(_gict_posibles_compras, { ["jugador"] = _gict_jugador, ["provincia"] = _gict_provincia, ["precio"] = _gict_precio })
  end

  if table.getn(_gict_posibles_compras) > 1 then
    table.sort(_gict_posibles_compras, compare_compra_territorio)
  end

  -- aux
  _gict_it_compras = 0
  for _gict_it_compras in _gict_posibles_compras do
    -- local
    _gict_compra     = _gict_posibles_compras[_gict_it_compras]
    -- local
    _gict_jugador   = _gict_compra.jugador
    -- local
    _gict_provincia = _gict_compra.provincia
    -- local
    _gict_precio    = _gict_compra.precio

    -- Comprobamos que tenemos dinero suficiente y el jugador es amigo.
    -- local
    _gict_dinero = get_presupuesto_riqueza(TR_DINERO, TH_INICIATIVAS, false)

    if _gict_dinero >= _gict_precio and get_grado_hostilidad(MY_PLAYER_ID, _gict_jugador) <= 0.5 then
      -- local
      _gict_mensaje = generar_mensaje_intercambio(_gict_jugador, 0, 0, 0, 0, {}, { _gict_provincia }, true)
    
		  if not puede_enviar_mensaje_diplomatico(_gict_mensaje, TINI_COMPRAR_TERRITORIOS) then
			  generar_auto_mejora_tratado(_gict_mensaje, TINI_COMPRAR_TERRITORIOS)
		  else
		    ENVIAR_MENSAJE_DIPLOMATICO(TINI_COMPRAR_TERRITORIOS, 0, 0, true, _gict_mensaje)
		  end

      break
    end
  end
end


function generate_iniciativa_vender_territorios()
  -- Eliminamos las órdenes anteriores
  clear_orders(TINI_VENDER_TERRITORIOS)

  -- local
  _givt_provincias_ampliadas           = get_provincias_ampliadas(MY_PLAYER_ID)
  -- local
  _givt_provincias_ampliadas_inconexas = table_filter_two(_givt_provincias_ampliadas, es_provincia_inconexa, MY_PLAYER_ID)
  
  -- local
  _givt_candidatos = table_filter_one(get_jugadores(), filter_candidato_vender_territorio)

  -- local
  _givt_posibles_ventas = {}

  -- aux
  _givt_it_candidatos = 0
  for _givt_it_candidatos in _givt_candidatos do
    -- local
    _givt_candidato = _givt_candidatos[_givt_it_candidatos]

    -- aux
    _givt_it_provincias = 0
    for _givt_it_provincias in _givt_provincias_ampliadas_inconexas do
      -- local
      _givt_provincia = _givt_provincias_ampliadas_inconexas[_givt_it_provincias]
      -- local
      _givt_mensaje   = generar_mensaje_intercambio(_givt_candidato, 0, 0, 0, 0, { _givt_provincia }, {}, true)
      -- local
      _givt_precio    = _givt_mensaje[MD_INDEX_INTERCAMBIO_DINERO]

      table.insert(_givt_posibles_ventas, { ["jugador"] = _givt_candidato, ["provincia"] = _givt_provincia, ["precio"] = _givt_precio })
    end
  end

  if table.getn(_givt_posibles_ventas) > 1 then
    table.sort(_givt_posibles_ventas, compare_venta_territorio)
  end

  -- aux
  _givt_it_ventas = 0
  for _givt_it_ventas in _givt_posibles_ventas do
    -- local
    _givt_venta     = _givt_posibles_ventas[_givt_it_ventas]
    -- local
    _givt_jugador   = _givt_venta.jugador
    -- local
    _givt_provincia = _givt_venta.provincia
    -- local
    _givt_precio    = _givt_venta.precio

    -- local
    _givt_valor_provincia = get_valor_provincia(_givt_provincia, _givt_jugador, false)

    -- Comprobamos que nos ofrece al menos la mitad de lo que vale para nosotros la provincia
    if _givt_precio >= _givt_valor_provincia / 2 then
      -- local
      _givt_mensaje = generar_mensaje_intercambio(_givt_jugador, 0, 0, 0, 0, { _givt_provincia }, {}, true)
    
		  if not puede_enviar_mensaje_diplomatico(_givt_mensaje, TINI_VENDER_TERRITORIOS) then
			  generar_auto_mejora_tratado(_givt_mensaje, TINI_VENDER_TERRITORIOS)
		  else
		    ENVIAR_MENSAJE_DIPLOMATICO(TINI_VENDER_TERRITORIOS, 0, 0, true, _givt_mensaje)
		  end

      break
    end
  end
end


function filter_candidato_vender_territorio(jugador)
  return get_grado_hostilidad(jugador, MY_PLAYER_ID) <= 0.5 and es_jugador_visible_diplomaticamente(jugador)
end


function compare_venta_territorio(venta1, venta2)
  return venta1.precio > venta2.precio
end


function compare_compra_territorio(compra1, compra2)
  return compra1.precio < compra2.precio
end