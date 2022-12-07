
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

  -- Preparamos el entorno para la secuencia
  -- Ej.: esta secuencia podria ser una panorámica de todo el terreno de batalla, mostrando unicamente esto:

  estado_defecto_secuencia()
  muestra_tropas_amigas()  

  -- Inicializamos valores de tiempo a 0
  
  local time1 = nil
  local time2 = nil
  local maxTime = nil
  
  -- Ejecutamos nuestras acciones
  
  time1 = reproduce_camara ("game/gameModes/Batalla/CamarasPresentacion/CamarasEscenarios/Camara02Escocia.V3D",0.0,false,1);
  time2 = reproduce_texto ("LTEXT_TEXTUISECUENCIAS_ESCOCIA_ATACANTE_1")
  
  -- Determinamos las mayor duración de todas las acciones
  maxTime = time1
  
  -- Pasamos a la secuencia 2 cuando pase el tiempo maximo de las acciones reproducidas
  temporizador ( maxTime, "secuencia2" )
  fade_color (0,0,0,150, 0,0,0,0,  -0,0.8)
  fade_color (255,255,255,0, 255,255,255,255,maxTime-1, 1)

end

-- -----------------------------------------
-- secuencia de visualización de la aldea
-- -----------------------------------------
function secuencia2 ()  
  
  estado_defecto_secuencia()  
  muestra_tropas_amigas() 
  
  -- Inicializamos valores de tiempo a 0
  
  local time1 = nil
  local time2 = nil
  local maxTime = nil
  
  -- Ejecutamos nuestras acciones
  
  time1 = reproduce_camara ("game/gameModes/Batalla/Camaraspresentacion/CamaraObjetivoEscocia.V3D", 0.0, false, 1 )
  time2 = reproduce_texto ("LTEXT_TEXTUISECUENCIAS_ESCOCIA_ATACANTE_2")
    
  -- Determinamos las mayor duración de todas las acciones
  maxTime = time1
  
  -- Pasamos a la secuencia 3 cuando pase el tiempo maximo de las acciones reproducidas
  temporizador ( maxTime, "secuencia3" )
  fade_color (255,255,255,255, 255,255,255,0,0.0, 0.5)
  fade_color (255,255,255,0, 255,255,255,255,maxTime-1, 1)

end

-- ---------------------------------------------
-- secuencia de visualización del primer puente
-- ---------------------------------------------
function secuencia3 ()  
  
  estado_defecto_secuencia()  
  muestra_tropas_amigas() 
  
  -- Inicializamos valores de tiempo a 0
  
  local time1 = nil
  local time2 = nil
  local maxTime = nil
  
  -- Ejecutamos nuestras acciones
  
  time1 = reproduce_camara ("game/gameModes/Batalla/Camaraspresentacion/CamaraPuenteEscocia01.V3D", 0.0, false, 1)
  time2 = reproduce_texto ("LTEXT_TEXTUISECUENCIAS_ESCOCIA_ATACANTE_3")
    
  -- Determinamos las mayor duración de todas las acciones
  maxTime = time1
  
  -- Pasamos a la secuencia 3 cuando pase el tiempo maximo de las acciones reproducidas
  temporizador ( maxTime, "secuencia4" )
  fade_color (255,255,255,255, 255,255,255,0,0.0, 0.5)
  fade_color (255,255,255,0, 255,255,255,255,maxTime-0.5, 0.5)
  
end

-- ----------------------------------------------
-- secuencia de visualización del segundo puente
-- ----------------------------------------------
function secuencia4 ()  
  
  estado_defecto_secuencia()  
  muestra_tropas_amigas() 
  
  -- Inicializamos valores de tiempo a 0
  
  local time1 = nil
  local time2 = nil
  local maxTime = nil
  
  -- Ejecutamos nuestras acciones
  
  time1 = reproduce_camara ("game/gameModes/Batalla/Camaraspresentacion/CamaraPuenteEscocia02.V3D", 0.0, false, 1 )
  time2 = reproduce_texto ("LTEXT_TEXTUISECUENCIAS_ESCOCIA_ATACANTE_4")
    
  -- Determinamos las mayor duración de todas las acciones
  maxTime = time1
  
  -- Pasamos a la secuencia 3 cuando pase el tiempo maximo de las acciones reproducidas
  temporizador ( maxTime, "comenzar_batalla" )
  fade_color (255,255,255,255, 255,255,255,0,0.0, 0.5)
  fade_color (0,0,0,0, 0,0,0,255,maxTime-3.0, 3.0)
  
end