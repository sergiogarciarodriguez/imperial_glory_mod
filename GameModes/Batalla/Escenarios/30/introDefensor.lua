
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
  
  time1 = reproduce_camara ("game/gameModes/Batalla/CamarasPresentacion/CamarasEscenarios/Camara30Anatolia.V3D",0.0,false,1);
  time2 = reproduce_texto ("LTEXT_TEXTUISECUENCIAS_ANATOLIA_DEFENSOR_1")
  
  -- Determinamos las mayor duración de todas las acciones
  maxTime = time1
  
  -- Pasamos a la secuencia 2 cuando pase el tiempo maximo de las acciones reproducidas
  if (esVictoriaTotal()) then
  	temporizador ( maxTime, "comenzar_batalla" )
  else
  	temporizador ( maxTime, "secuencia2" )
  end
  
  fade_color (0,0,0,150, 0,0,0,0,  -0,0.8)
  fade_color (255,255,225,0, 250,240,205,255,maxTime-2,2)

end

-- ---------------------------------------------------
-- secuencia de visualización de la aldea
-- ---------------------------------------------------
function secuencia2 ()  
  
  estado_defecto_secuencia()  
  muestra_tropas_amigas() 
  
  -- Inicializamos valores de tiempo a 0
  
  local time1 = nil
  local time2 = nil
  local maxTime = nil
  
  -- Ejecutamos nuestras acciones
  
  time1 = reproduce_camara ("game/gameModes/Batalla/Camaraspresentacion/CamaraObjetivoAnatolia.V3D", 0.0,false,0.65 )
  time2 = reproduce_texto ("LTEXT_TEXTUISECUENCIAS_ANATOLIA_DEFENSOR_2")
    
  -- Determinamos las mayor duración de todas las acciones
  maxTime = time1
  
  -- Pasamos a la secuencia 3 cuando pase el tiempo maximo de las acciones reproducidas
  temporizador ( maxTime, "comenzar_batalla" )
  fade_color (250,240,205,255, 255,255,255,0,0,3)
  fade_color (0,0,0,0, 0,0,0,255,maxTime-2,2)
  
end