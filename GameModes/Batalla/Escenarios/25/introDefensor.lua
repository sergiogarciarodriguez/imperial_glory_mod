
-- --------------------------------------------
-- función principal de la secuencia.
-- se llamará al ejecutar la secuencia definida
-- por el script, y debera llamar la función
-- que inicia la primera secuencia
-- --------------------------------------------
function inicia_secuencia()
  -- lanzamos la primera secuencia:
  
  estado_defecto_secuencia()
  muestra_tropas_amigas()  
  
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
  
  time1 = reproduce_camara ("game/gameModes/Batalla/CamarasPresentacion/CamarasEscenarios/Camara25Catalunya.V3D",0.0,false,1.0);
  time2 = reproduce_texto ("LTEXT_TEXTUISECUENCIAS_CATALUNYA_DEFENSOR_1")
  
  -- Determinamos las mayor duración de todas las acciones
  maxTime = time1
  
  -- Pasamos a la secuencia 2 cuando pase el tiempo maximo de las acciones reproducidas
  temporizador ( maxTime, "secuencia2" )
  fade_color (250,245,230,255, 255,255,255,0,0,2)
  fade_color (255,255,255,0, 255,255,255,255,maxTime-1.5, 1.5)

end

-- ---------------------------------------------------
-- secuencia de visualización de la masía
-- ---------------------------------------------------
function secuencia2 ()  
  
  estado_defecto_secuencia()
  muestra_tropas_amigas()  
  
  -- Inicializamos valores de tiempo a 0
  
  local time1 = nil
  local time2 = nil
  local maxTime = nil
  
  -- Ejecutamos nuestras acciones
  
  time1 = reproduce_camara_relativa ("game/gameModes/Batalla/Camaraspresentacion/CamaraEdifBg02.V3D", "LOC_Masia", false, 0.75)
  time2 = reproduce_texto ("LTEXT_TEXTUISECUENCIAS_CATALUNYA_DEFENSOR_2")
    
  -- Determinamos las mayor duración de todas las acciones
  maxTime = time1
  
  -- Pasamos a la secuencia 3 cuando pase el tiempo maximo de las acciones reproducidas
  temporizador ( maxTime, "secuencia3" )
  fade_color (255,255,255,255, 255,255,255,0,0, 0.7)
  fade_color (255,255,255,0, 255,255,255,255,maxTime-0.7, 0.7)
  
end

-- ---------------------------------------------------
-- secuencia de visualización de la aldea
-- ---------------------------------------------------
function secuencia3 ()  
  
  estado_defecto_secuencia()
  muestra_tropas_amigas()  
  
  -- Inicializamos valores de tiempo a 0
  
  local time1 = nil
  local time2 = nil
  local maxTime = nil
  
  -- Ejecutamos nuestras acciones
  
  time1 = reproduce_camara_relativa ("game/gameModes/Batalla/Camaraspresentacion/CamaraEdifBg01.V3D", "LOC_Aldea" , false, 0.65)
  time2 = reproduce_texto ("LTEXT_TEXTUISECUENCIAS_CATALUNYA_DEFENSOR_3")
    
  -- Determinamos las mayor duración de todas las acciones
  maxTime = time1-2
  
  -- Pasamos a la secuencia 3 cuando pase el tiempo maximo de las acciones reproducidas
  temporizador ( maxTime, "comenzar_batalla" )
  fade_color (255,255,255,255, 255,255,255,0,0, 0.7)
  fade_color (0,0,0,0, 0,0,0,255,maxTime-2, 2)
  
end