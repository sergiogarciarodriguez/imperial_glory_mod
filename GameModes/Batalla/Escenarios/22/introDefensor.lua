-- --------------------------------------------
-- función principal de la secuencia.
-- se llamará al ejecutar la secuencia definida
-- por el script, y debera llamar la función
-- que inicia la primera secuencia
-- --------------------------------------------
function inicia_secuencia()
  -- lanzamos la primera secuencia:
  
  estado_defecto_secuencia()  
  
  secuencia1();
end

-- ------------------------------------------------------
-- secuencia de panorámica del terreno de batalla
-- ----------------------------------------------
function secuencia1 ()

  estado_defecto_secuencia()
  muestra_tropas_amigas()

  -- Inicializamos valores de tiempo a 0
  
  local time1 = nil
  local time2 = nil
  local maxTime = nil
  
  -- Ejecutamos nuestras acciones
  
  time1 = reproduce_camara ("game/gameModes/Batalla/CamarasPresentacion/CamarasEscenarios/Camara22Castilla.V3D",0.0, false, 1.0);
  time2 = reproduce_texto ("LTEXT_TEXTUISECUENCIAS_CASTILLA_DEFENSOR_1")
  
  -- Determinamos las mayor duración de todas las acciones
  maxTime = max (time1, time2)
  
  -- Pasamos a la secuencia 2 cuando pase el tiempo maximo de las acciones reproducidas
  if (esVictoriaTotal()) then
  	temporizador ( maxTime, "comenzar_batalla" )
  else
  	temporizador ( maxTime, "secuencia2" )
  end
  
 fade_color (5,0,0,255, 150,50,0,0,0,1.5)
  fade_color (50,0,0,0, 10,0,0,255, maxTime-0.8,0.8)

end

-- ------------------------------------------------------
-- secuencia de panorámica de la ermita
-- ----------------------------------------------
function secuencia2 ()

  estado_defecto_secuencia()
  muestra_tropas_amigas()

  -- Inicializamos valores de tiempo a 0
  
  local time1 = nil
  local time2 = nil
  local maxTime = nil
  
  -- Ejecutamos nuestras acciones
  
  time1 = reproduce_camara ("game/gameModes/Batalla/CamarasPresentacion/CamarasEscenarios/Camara22CastillaB.V3D",0.0, false, 1.0);
  time2 = reproduce_texto ("LTEXT_TEXTUISECUENCIAS_CASTILLA_DEFENSOR_2")
  
  -- Determinamos las mayor duración de todas las acciones
  maxTime = max (time1, time2)
  
  -- Pasamos a la secuencia 2 cuando pase el tiempo maximo de las acciones reproducidas
  temporizador ( maxTime, "secuencia3" )
   fade_color (10,0,0,255, 5,0,0,0, 0,1.0)
  fade_color (245,250,255,0, 245,250,255,255, maxTime-1.0,1.0)

end

-- ------------------------------------------------------
-- secuencia de panorámica de la aldea
-- ----------------------------------------------
function secuencia3 ()

  estado_defecto_secuencia()
  muestra_tropas_amigas()

  -- Inicializamos valores de tiempo a 0
  
  local time1 = nil
  local time2 = nil
  local maxTime = nil
  
  -- Ejecutamos nuestras acciones
  
  time1 = reproduce_camara_relativa ("game/gameModes/Batalla/CamarasPresentacion/CamaraEdifBg01.V3D", "LOC_Aldea", false, 1.0);
  time2 = reproduce_texto ("LTEXT_TEXTUISECUENCIAS_CASTILLA_DEFENSOR_3")
  
  -- Determinamos las mayor duración de todas las acciones
  maxTime = max (time1, time2)
  
  -- Pasamos a la secuencia 2 cuando pase el tiempo maximo de las acciones reproducidas
  temporizador ( maxTime, "comenzar_batalla" )
   fade_color (245,250,255,255, 245,250,255,0, 0,1.5)
  fade_color (128,0,0,0, 0,0,0,255, maxTime-1.5,1.5)
end