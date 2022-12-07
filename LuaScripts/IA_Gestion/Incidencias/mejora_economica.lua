-- Lua Script
-- Generacion de las acciones derivadas de las incidencias

------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------- GLOBALS ------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------

tipo_ruta_terrestre = 0
tipo_ruta_maritima = 1


------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------- FUNCTIONS ----------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------


-------------------------------------------------------
-- generar mejoras economicas
-------------------------------------------------------
function generar_mejoras_economicas(origen, mejora_recurso,  gravedad, recalcular_prioridad)
  
  local preferencia_recursos = 0.0
  local preferencia_comercio = 0.0
  
  generar_auto_mejora(origen, mejora_recurso, gravedad, preferencia_recursos-1)        
  
  if( mejora_recurso == MEJORA_PRODUCCION_DINERO) then
    generar_rutas_terrestres(origen, gravedad, recalcular_prioridad)
    generar_rutas_maritimas(origen, gravedad, recalcular_prioridad)
  end
  
end


function generar_rutas_terrestres(origen, gravedad, recalcular_prioridad)
	generar_rutas_habilitadas(origen, gravedad, true, recalcular_prioridad)
end


function generar_rutas_maritimas(origen, gravedad, recalcular_prioridad)
	generar_rutas_habilitadas(origen, gravedad, false, recalcular_prioridad)
	generar_flotas_comerciales(origen, gravedad, recalcular_prioridad)
end


----------------------------------------------------------------
-- funcion que genera flotas comerciales
----------------------------------------------------------------
function generar_flotas_comerciales(origen, prioridad, recalcular_prioridad)
    
    local provincias_puerto = get_provincias_con_puerto(get_my_id())    
    local puertos_comerciales = table_filter_one(provincias_puerto, tiene_puerto_comercial)

    local rutas_maritimas =  {}
    for it_puerto in puertos_comerciales do
      local puerto = puertos_comerciales[it_puerto]      
      local flotas_construibles = get_flotas_construibles_en_puerto(puerto)      
      for it_flota in flotas_construibles do
        local flota = flotas_construibles[it_flota]
        local destinos = get_rutas_maritimas_construibles(puerto, flota)
        for it_destino in destinos do
          local destino = destinos[it_destino]
          local valor = get_valor_ruta_maritima_construible(destino, flota)
          if(rutas_maritimas[destino] == NIL or rutas_maritimas[destino].valor < valor) then
            rutas_maritimas[destino] = {puerto = get_puerto_comercial_of_provincia(puerto), flota = flota, destino = destino, valor = valor}
          end
        end
      end
   end    

   
   table.sort(rutas_maritimas, compare_valor_ruta)
   for it_ruta in rutas_maritimas do
     local ruta = rutas_maritimas[it_ruta]
     CONSTRUIR_BARCO(origen, prioridad, ruta.valor, recalcular_prioridad, ruta.flota, ruta.puerto)
   end

   generar_auto_mejora(origen, MEJORA_CREAR_BARCO_COMERCIAL, prioridad, 0.0, 0.1)        
end

----------------------------------------------------------------
-- funcion que genera las rutas habilitadas
----------------------------------------------------------------
function generar_rutas_habilitadas(origen, prioridad, terrestres, recalcular_prioridad)
    local rutas = {}

  if terrestres then
	  calcular_rutas_terrestres(rutas)
  else
	  calcular_rutas_maritimas(rutas)
  end

    table.sort(rutas, compare_valor_ruta)
    generar_rutas(origen, rutas, prioridad, recalcular_prioridad)
	if( table.getn(rutas) < table.getn(paises.visibles_geograficamente) ) then
	 local preferencia = 1 - table.getn(rutas) / table.getn(paises.visibles_geograficamente)
     generar_auto_mejora(origen, MEJORA_INFLUENCIA_GEOGRAFICA, prioridad, preferencia, preferencia+0.1)
	end      
    
end

----------------------------------------------------------------
-- funcion que calcula las rutas terrestres habilitadas
----------------------------------------------------------------
function calcular_rutas_terrestres(rutas)
    local destinos_terrestres = get_rutas_terrestres()   
    local paises_destino = table_transform_one(destinos_terrestres, get_pais_of_capital_idx)
    paises_destino = table_filter_one(paises_destino, es_posible_construir_en_pais)
    for it_pais in paises_destino do
      local pais = paises_destino[it_pais]      
      local destino = destinos_terrestres[it_pais]
      local construibles = table_filter_one(edificios_por_pais[pais].construibles, es_edificio_ruta_terrestre)
      for it_construible in construibles do
        local edificio = construibles[it_construible]
        local valor = get_valor_ruta_terrestre(destino, edificio)
        table.insert(rutas, { pais = pais, edificio = edificio, valor = valor, tipo = 0})
      end
    end  
end



----------------------------------------------------------------
-- funcion que calcula las rutas maritimas habilitadas
----------------------------------------------------------------
function calcular_rutas_maritimas(rutas)
	local flotas = get_flotas_comerciales()
	for it_flota in flotas do
		local flota = flotas[it_flota]        
		local destinos_flota = get_rutas_maritimas(flota)
		for it_destino in destinos_flota do
		local destino = destinos_flota[it_destino]
		local valor = get_valor_ruta_maritima(destino, flota) 
			table.insert(rutas, { flota = flota, destino = destino, valor = valor, tipo = 1})
		end        
	end
end

----------------------------------------------------------------
-- dada una tabla de rutas genera acciones de creacion de rutas
----------------------------------------------------------------
function generar_rutas(origen, rutas, prioridad, recalcular_prioridad)
    for it_ruta in rutas do
      local ruta = rutas[it_ruta]
      if(ruta.tipo == tipo_ruta_terrestre) then
        generar_auto_mejora_en_pais(ruta.pais, origen, MEJORA_PRODUCCION_DINERO, prioridad, ruta.valor, ruta.valor + 0.1)
      else
        GENERAR_RUTA_MARITIMA(origen, prioridad, ruta.valor, recalcular_prioridad, ruta.flota, ruta.destino)
      end
    end
end

-------------------------------------------------
-- comparacion rutas por valor de la ruta
-------------------------------------------------
function compare_valor_ruta(ruta0, ruta1)    
  return ruta0.valor > ruta1.valor
end
