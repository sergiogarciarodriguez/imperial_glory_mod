
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
  
  time1 = reproduce_camara ("game/gameModes/Batalla/CamarasPresentacion/CamarasEscenarios/Camara23Aragon.V3D", 0.0, false, 1.3);
  time2 = reproduce_texto ("LTEXT_TEXTUISECUENCIAS_ARAGON_ATACANTE_1")
  
  -- Determinamos las mayor duración de todas las acciones
  maxTime = time1
  
  -- Pasamos a la secuencia 2 cuando pase el tiempo maximo de las acciones reproducidas
  temporizador ( maxTime, "secuencia2" )
  fade_color (255,255,255,0, 255,255,255,255, maxTime-0.5,0.5)

end

-- ---------------------------------------------------
-- secuencia de visualización de la iglesia
-- ---------------------------------------------------
function secuencia2 ()  
  
  estado_defecto_secuencia()  
  muestra_tropas_amigas()
  
  -- Inicializamos valores de tiempo a 0
  
  local time1 = nil
  local time2 = nil
  local maxTime = nil
  
  -- Ejecutamos nuestras acciones
  
  time1 = reproduce_camara_relativa ("game/gameModes/Batalla/Camaraspresentacion/CamaraEdifSm02.V3D", "LOC_Iglesia" , false, 0.75)
  time2 = reproduce_texto ("LTEXT_TEXTUISECUENCIAS_ARAGON_ATACANTE_2")
    
  -- Determinamos las mayor duración de todas las acciones
  maxTime = max (time1, time2)
  
  -- Pasamos a la secuencia 3 cuando pase el tiempo maximo de las acciones reproducidas
  temporizador ( maxTime, "secuencia3" )
  fade_color (255,255,255,255, 255,255,255,0, 0,0.5)
  fade_color (255,255,255,0, 255,255,255,255, maxTime-0.5,0.5)
  
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
  
  time1 = reproduce_camara_relativa ("game/gameModes/Batalla/Camaraspresentacion/CamaraEdifBg02.V3D", "LOC_Aldea", false, 0.63)
  time2 = reproduce_texto ("LTEXT_TEXTUISECUENCIAS_ARAGON_ATACANTE_3")
    
  -- Determinamos las mayor duración de todas las acciones
  maxTime = max (time1, time2)
  
  -- Pasamos a la secuencia 3 cuando pase el tiempo maximo de las acciones reproducidas
  temporizador ( maxTime, "comenzar_batalla" )
  fade_color (255,255,255,255, 255,255,255,0, 0,0.5)
  fade_color (255,255,255,0, 255,255,255,255, maxTime-3,3)
  
end