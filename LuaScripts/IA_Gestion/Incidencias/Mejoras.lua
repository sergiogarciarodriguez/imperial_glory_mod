-- Lua Script
-- Gestión de mejoras genericas para solucionar incidencias/iniciativas

------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------- GLOBALS ----------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------

edificios = { all = {}, construyendose = {}, construibles = {}, construidos = {}}
edificios_por_pais = {}
tecnologias = {all = {}, investigandose = {}, investigables = {}, investigadas = {}}
tropas = { all = {},  construibles = {} }
barcos = { all = {}, construibles = {} }
jugadores = { all = {}, visibles_diplomaticamente = {}, enemigos = {}, imperiales = {} }
paises = { all = {}, visibles_geograficamente = {}, visibles_militarmente = {}}
perfil = {}


------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------- FUNCTIONS ----------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------------
-- init_globals
------------------------------------------------------------------------------------------------------------------------------
function init_mejoras()
  perfil = get_perfil()
  edificios = { all = {}, construyendose = {}, construibles = {}, construidos = {}}
  edificios_por_pais = {}
  tecnologias = {all = {}, investigandose = {}, investigables = {}, investigadas = {}}
  tropas = { all = {},  construibles = {} }
  barcos = { all = {}, construibles = {} }
  jugadores = { all = {}, visibles_diplomaticamente = {} }
  paises = { all = {}, visibles_geograficamente = {}, visibles_militarmente = {}}

  edificios.all = get_edificios()
  edificios.construyendose = table_filter_one(edificios.all, esta_edificio_construyendose)
  edificios.construibles = table_filter_one(edificios.all , es_edificio_construible)
  edificios.construidos = table_filter_one(edificios.all , esta_edificio_construido)

  paises.all = get_all_paises()
  for it_paises in paises.all do
    local pais = paises.all[it_paises]
    edificios_por_pais[pais] = { construyendose = get_edificios_construyendose_en_pais(pais), 
                                 construibles   = get_edificios_construibles_en_pais(pais), 
                                 construidos    = get_edificios_construidos_en_pais(pais) }
    --edificios_por_pais[pais].construyendose = table_filter_two(edificios.all, esta_edificio_construyendose_en_pais, pais)
    --edificios_por_pais[pais].construibles   = table_filter_two(edificios.all, es_edificio_construible_en_pais, pais)
    --edificios_por_pais[pais].construidos    = table_filter_two(edificios.all, esta_edificio_construido_en_pais, pais)
  end

  jugadores.all = get_jugadores()
  jugadores.visibles_diplomaticamente = table_filter_one(jugadores.all, es_jugador_visible_diplomaticamente)  
  jugadores.enemigos = table_filter_one(jugadores.all, es_jugador_enemigo)
  jugadores.imperiales = table_filter_one(jugadores.all, es_jugador_imperial)
  paises.visibles_geograficamente = table_filter_one(paises.all, es_pais_visible_geograficamente)
  paises.visibles_militarmente = table_filter_one(paises.all, es_pais_visible_militarmente)
  
  tecnologias.all = get_tecnologias()
  tecnologias.investigandose = table_filter_one(tecnologias.all, esta_tecnologia_investigandose)
  tecnologias.investigables = table_filter_one(tecnologias.all, es_tecnologia_investigable)
  tecnologias.investigadas = table_filter_one(tecnologias.all, ha_investigado_tecnologia)
  
  tropas.all = get_tropas()
  tropas.construibles = table_filter_one(tropas.all , es_tropa_construible)
  barcos.all = get_barcos()
  --barcos.construibles = table_filter_one(barcos.all, es_barco_construible)

end

---------------------------------------------------------------
-- genera una incidencia de mejora
---------------------------------------------------------------
function generar_auto_mejora(origen, mejora, prioridad_base, prioridad_min, prioridad_max)

  -- CONSTRUIR EDIFICIO 
  local edificios_con_mejora = get_edificios_construibles_con_mejora(mejora)
  
  table.sort(edificios_con_mejora, compare_edificios_construibles)
  
  local num_ordenes_generadas = 0
  local prioridad = prioridad_min
  if(prioridad_max == NIL) then
    prioridad_max = prioridad_min + 1
  end
  --if(prioridad_max - prioridad_min < 0) then
  --assert(prioridad_max - prioridad_min >= 0)
  local inc_prioridad = (prioridad_max - prioridad_min)/ table.getn(edificios_con_mejora)
  for iterator_edificio in edificios_con_mejora do
    local edificio = edificios_con_mejora[iterator_edificio].edificio
    local pais     = edificios_con_mejora[iterator_edificio].pais

    CONSTRUIR_EDIFICIO(origen, prioridad_base, prioridad, false, edificio, pais, 0, false) 
    num_ordenes_generadas = num_ordenes_generadas + 1
    prioridad = prioridad + inc_prioridad
  end  

  if(table.getn(edificios_con_mejora) > 0 or table.getn(table_filter_two(edificios.construyendose, tiene_edificio_mejora, mejora))> 0) then
    return num_ordenes_generadas
  end

  -- INVESTIGAR TECNOLOGIA
  local tecnologias_con_mejora = get_tecnologias_investigables_con_mejora(mejora)
  if( table.getn(tecnologias_con_mejora) > 0) then    
    local distancia_tecno = table_transform_one(tecnologias_con_mejora, get_distancia_tecnologia)    
    local min_dist_tecno = table_min(distancia_tecno)
    -- TODO: Especificar si se debe forzar o no
    INVESTIGAR_TECNOLOGIA(origen, prioridad_base, prioridad_min, false, tecnologias_con_mejora[min_dist_tecno], false)    
    num_ordenes_generadas = num_ordenes_generadas + 1
  elseif(mejora ~= MEJORA_CAMBIO_GOBIERNO) then    
    num_ordenes_generadas = num_ordenes_generadas + generar_auto_mejora(origen, MEJORA_CAMBIO_GOBIERNO, prioridad_base, prioridad_min, prioridad_max)    
  end  
    
  return num_ordenes_generadas
end


function get_edificios_construibles_con_mejora(mejora)
  local construibles = table_filter_two(edificios.construibles, tiene_edificio_mejora, mejora)
  local paises       = get_paises(MY_PLAYER_ID)
  
  local tabla = {}

  for it_edificio in construibles do
    for it_pais in paises do
      local edificio = construibles[it_edificio]
      local pais     = paises[it_pais]

      if es_edificio_construible_en_pais(edificio, pais) then
        table.insert(tabla, { ["edificio"] = edificio, ["pais"] = pais })
      end
    end
  end

  return tabla
end


function get_edificios_construibles_en_pais_con_mejora(pais, mejora)
  local construibles = table_filter_two(edificios_por_pais[pais].construibles, tiene_edificio_mejora, mejora)
  
  local tabla = {}

  for it_edificio in construibles do
    local edificio = construibles[it_edificio]

    if es_edificio_construible_en_pais(edificio, pais) then
      table.insert(tabla, edificio)
    end
  end

  return tabla
end

function get_tecnologias_investigables_con_mejora(mejora)
  return table_filter_two(tecnologias.investigables, tiene_tecnologia_mejora, mejora)  
end

-----------------------------------------
-- Dada una mejora, obtiene las tecnologias
-- que proporcionan dicha mejora y que se
-- hallan investigadas para el jugador con
-- turno.
-----------------------------------------
function get_tecnologias_investigadas_con_mejora(mejora)
  return table_filter_two(tecnologias.investigadas, tiene_tecnologia_mejora, mejora)  
end

-----------------------------------------
-- Devuelve true si hay alguna construccion
-- en proceso con dicha mejora
----------------------------------------
function existe_mejora_construyendose(mejora)
  
  local construyendose = table_filter_two(edificios.construyendose, tiene_edificio_mejora, mejora)
  return(table.getn(construyendose) > 0) 

end

-----------------------------------------
-- Devuelve true si hay alguna tecnologia
-- investigandose con dicha mejora
----------------------------------------
function existe_mejora_investigandose(mejora)
  local investigandose = table_filter_two(tecnologias.investigandose, tiene_tecnologia_mejora, mejora)
  
  return (table.getn(investigandose) > 0) 
end

-----------------------------------------
-- Devuelve true si existe alguna 
-- construiccion que realiza dicha mejora
----------------------------------------
function existe_mejora_construida(mejora)

  local construidos = table_filter_two(edificios.construidos, tiene_edificio_mejora, mejora ) 
  return(table.getn(construidos) > 0)

end

---------------------------------------------------------------
-- genera una incidencia de mejora en un pais dado
---------------------------------------------------------------
function generar_auto_mejora_en_pais(pais, origen, mejora, prioridad_base, prioridad_min, prioridad_max, provincia)

  -- CONSTRUIR EDIFICIO 
  local edificios_con_mejora = get_edificios_construibles_en_pais_con_mejora(pais, mejora)
  if(provincia == NIL ) then
	provincia = 0
  else
	edificios_con_mejora = table_filter_two(edificios_con_mejora, es_edificio_construible_en_provincia, provincia)
  end
  
  table.sort(edificios_con_mejora, compare_edificio_precio)
  
  local num_ordenes_generadas = 0
  local prioridad = prioridad_min
 
  local inc_prioridad = (prioridad_max - prioridad_min)/ table.getn(edificios_con_mejora)  
  for iterator_edificio in edificios_con_mejora do
    CONSTRUIR_EDIFICIO(origen, prioridad_base, prioridad, false, edificios_con_mejora[iterator_edificio], pais, provincia, false) 
    num_ordenes_generadas = num_ordenes_generadas + 1
    prioridad = prioridad + inc_prioridad
  end  
       
  if(table.getn(edificios_con_mejora) > 0 or table.getn(table_filter_two(edificios_por_pais[pais].construyendose, tiene_edificio_mejora, mejora))> 0) then
    return num_ordenes_generadas
  end

  -- INVESTIGAR TECNOLOGIA
  local tecnologias_con_mejora = get_tecnologias_investigables_con_mejora(mejora)
  if( table.getn(tecnologias_con_mejora) > 0) then    
    local distancia_tecno = table_transform_one(tecnologias_con_mejora, get_distancia_tecnologia)    
    local min_dist_tecno = table_min(distancia_tecno)
    -- TODO: Especificar si se debe forzar o no
    INVESTIGAR_TECNOLOGIA(origen, prioridad_base, prioridad_min, false, tecnologias_con_mejora[min_dist_tecno], false)    
    num_ordenes_generadas = num_ordenes_generadas + 1
  elseif(mejora ~= MEJORA_CAMBIO_GOBIERNO) then    
    num_ordenes_generadas = num_ordenes_generadas + generar_auto_mejora(origen, MEJORA_CAMBIO_GOBIERNO, prioridad_base, prioridad_min, prioridad_max)    
  end  

  return num_ordenes_generadas
end

-----------------------------------------
-- Devuelve true si hay alguna construccion
-- en proceso con dicha mejora en el pais
----------------------------------------
function existe_mejora_construyendose_en_pais(pais, mejora)
  
  local construyendose = table_filter_two(edificios_por_pais[pais].construyendose, tiene_edificio_mejora, mejora)
  return(table.getn(construyendose) > 0) 

end

-----------------------------------------
-- Devuelve true si existe alguna 
-- construiccion que realiza dicha mejora
----------------------------------------
function existe_mejora_construida(mejora)

  local construidos = table_filter_two(edificios.construidos, tiene_edificio_mejora, mejora ) 
  return(table.getn(construidos) > 0)

end


-------------------------------------------
-- comparación de paises por importancia 
-- economica
-------------------------------------------
function compare_pais_economic(pais0, pais1)
  if(pais1 == NIL) then
	return true
  end
  local importancia0 = get_importancia_economica(pais0)
  local importancia1 = get_importancia_economica(pais1)
  
  return(importancia1 > importancia0)
end


-------------------------------------------
-- comparación de edificios construibles
-------------------------------------------
function compare_edificios_construibles(edificio0, edificio1)
  local ret = false
  if(edificio1 == NIL or edificio0 == NIL) then
	ret = true
  else	
	local importancia0 = get_importancia_economica(edificio0.pais)
	local importancia1 = get_importancia_economica(edificio1.pais)
	  
	if (importancia0 > importancia1) then
		ret = true
	elseif (importancia0 < importancia1) then
		ret = false
	else
		ret = compare_edificio_precio(edificio0.edificio, edificio1.edificio)
	end
  end

  return ret
end


-----------------------------------------------
-- comparación de paises por grado de relacion
-----------------------------------------------
function compare_pais_relacion(pais0, pais1)
  if(pais1 == NIL) then
	return true
  end

  local relacion0 = get_grado_hostilidad(get_jugador_of_pais(pais0), get_my_id())
  local relacion1 = get_grado_hostilidad(get_jugador_of_pais(pais1), get_my_id())
  
  return(relacion1 < relacion0)
end

-----------------------------------------------
-- comparacion de edificios por precio
-----------------------------------------------
function compare_edificio_precio(edificio0, edificio1)
  if(edificio1 == NIL) then
	return true
  end
  local precio0 = get_valor_real_edificio(edificio0)
  local precio1 = get_valor_real_edificio(edificio1)
  
  return precio1 < precio0
end


-----------------------------
-- true si el pais es enemigo
-----------------------------
function es_pais_enemigo(pais)
  local jugador = get_jugador_of_pais(pais)
  
  return es_jugador_enemigo(jugador)
end


-----------------------------
-- true si el pais es no enemigo
-----------------------------
function es_pais_no_enemigo(pais)
  
  return false ==  es_pais_enemigo(pais)
end



-----------------------------
-- Devuelve los IDs de países del jugador donde tiene habilitada la
-- construcción de cierto edificio.
-----------------------------
function get_paises_para_construccion(edificio)
  local paises_construccion = {}

  for it_paises in paises.all do
    local pais = paises.all[it_paises]
    
    if table_exist(edificios_por_pais[pais].construibles, edificio) then
      table.insert(paises_construccion, pais)
    end
  end
  
  return paises_construccion
end