
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
  
  time1 = reproduce_camara ("game/gameModes/Batalla/CamarasPresentacion/CamarasEscenarios/Camara32Grecia.V3D", 0.0, false, 1.0);
  time2 = reproduce_texto ("LTEXT_TEXTUISECUENCIAS_GRECIA_DEFENSOR_1")
  
  -- Determinamos las mayor duración de todas las acciones
  maxTime = max (time1, time2)
  
  -- Pasamos a la secuencia 2 cuando pase el tiempo maximo de las acciones reproducidas
  temporizador ( maxTime, "secuencia2" )
  fade_color (235,245,255,255, 245,250,255,0,0,4)
  fade_color (235,245,255,0, 245,250,255,255,maxTime-1.5,1.5)

end

-- ---------------------------------------------------
-- secuencia de visualización de las ruinas 1
-- ---------------------------------------------------
function secuencia2 ()  
  
  estado_defecto_secuencia()
  muestra_tropas_amigas()   
  
  -- Inicializamos valores de tiempo a 0
  
  local time1 = nil
  local time2 = nil
  local maxTime = nil
  
  -- Ejecutamos nuestras acciones
  
  time1 = reproduce_camara_relativa ("game/gameModes/Batalla/Camaraspresentacion/CamaraEdifSm02.V3D", "LOC_Ruinas1", false, 0.9)
  time2 = reproduce_texto ("LTEXT_TEXTUISECUENCIAS_GRECIA_DEFENSOR_2")
    
  -- Determinamos las mayor duración de todas las acciones
  maxTime = max (time1, time2) - 1.8
  
  -- Pasamos a la secuencia 3 cuando pase el tiempo maximo de las acciones reproducidas
  temporizador ( maxTime, "secuencia3" )
  fade_color (235,245,255,255, 245,250,255,0,0,1)
  fade_color (235,245,255,0, 245,245,225,255,maxTime-1.0,1.0)
  
end

-- ---------------------------------------------------
-- secuencia de visualización de las ruinas 3
-- ---------------------------------------------------
function secuencia3 ()  
  
  estado_defecto_secuencia()
  muestra_tropas_amigas()   
  
  -- Inicializamos valores de tiempo a 0
  
  local time1 = nil
  local time2 = nil
  local maxTime = nil
  
  -- Ejecutamos nuestras acciones
  
  time1 = reproduce_camara_relativa ("game/gameModes/Batalla/Camaraspresentacion/CamaraEdifSm03.V3D", "LOC_Ruinas3", false, 0.75 )
  time2 = reproduce_texto ("LTEXT_TEXTUISECUENCIAS_GRECIA_DEFENSOR_3")
    
  -- Determinamos las mayor duración de todas las acciones
  maxTime = max (time1, time2)
    
  -- Pasamos a la secuencia 3 cuando pase el tiempo maximo de las acciones reproducidas
  temporizador ( maxTime, "comenzar_batalla" )
  fade_color (245,245,225,255, 245,250,255,0,0,2)
  fade_color (0,0,0,0, 0,0,0,255,maxTime-2,2)
  
end