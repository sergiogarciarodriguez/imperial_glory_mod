
-- --------------------------------------------
-- funci�n principal de la secuencia.
-- se llamar� al ejecutar la secuencia definida
-- por el script, y debera llamar la funci�n
-- que inicia la primera secuencia
-- --------------------------------------------
function inicia_secuencia()
  -- lanzamos la primera secuencia:
  
  estado_defecto_secuencia()  
  
  secuencia1();
end

-- ------------------------------------------------------
-- secuencia de panor�mica del terreno de batalla
-- ----------------------------------------------
function secuencia1 ()

  -- Preparamos el entorno para la secuencia
  -- Ej.: esta secuencia podria ser una panor�mica de todo el terreno de batalla, mostrando unicamente esto:

  estado_defecto_secuencia()  
  muestra_tropas_amigas() 

  -- Inicializamos valores de tiempo a 0
  
  local time1 = nil
  local time2 = nil
  local maxTime = nil
  
  -- Ejecutamos nuestras acciones
  
  time1 = reproduce_camara ("game/gameModes/Batalla/CamarasPresentacion/CamarasEscenarios/Camara39Finlandia.V3D",0.0,false,1);
  time2 = reproduce_texto ("LTEXT_TEXTUISECUENCIAS_FINLANDIA_DEFENSOR_1")
  
  -- Determinamos las mayor duraci�n de todas las acciones
  maxTime = time1
  
  -- Pasamos a la secuencia 2 cuando pase el tiempo maximo de las acciones reproducidas
  temporizador ( maxTime, "secuencia2" )
  fade_color (0,0,0,150, 0,0,0,0,  -0,0.8)
  fade_color (255,255,255,0, 255,255,255,255,maxTime-2,2)

end

-- ---------------------------------------------------
-- secuencia de visualizaci�n de la aldea
-- ---------------------------------------------------
function secuencia2 ()  
  
  estado_defecto_secuencia()  
  muestra_tropas_amigas() 
  
  -- Inicializamos valores de tiempo a 0
  
  local time1 = nil
  local time2 = nil
  local maxTime = nil
  
  -- Ejecutamos nuestras acciones
  
  time1 = reproduce_camara ("game/gameModes/Batalla/Camaraspresentacion/CamaraObjetivoFinlandia.V3D", 0.0, false, 1)
  time2 = reproduce_texto ("LTEXT_TEXTUISECUENCIAS_FINLANDIA_DEFENSOR_2")
    
  -- Determinamos las mayor duraci�n de todas las acciones
  maxTime = time1
  
  -- Pasamos a la secuencia 3 cuando pase el tiempo maximo de las acciones reproducidas
  temporizador ( maxTime, "comenzar_batalla" )
  fade_color (255,255,255,255, 255,255,255,0,0,2.5)
  fade_color (0,0,0,0, 0,0,0,255,maxTime-2,2)
  
end