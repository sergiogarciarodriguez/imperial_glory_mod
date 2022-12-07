-- Batallas históricas: Waterloo (BBatavia - 49) -> Atacante
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
  local time3 = nil
  local maxTime = nil
  
  -- Ejecutamos nuestras acciones
  
  time1 = reproduce_camara ("game/gameModes/Batalla/CamarasPresentacion/CamarasEscenarios/Camara49Batavia.V3D");
  time2 = reproduce_texto ("LTEXT_HISTORICA_WATERLOO_ATACANTE")
  time3 = reproduce_locucion ("S_HB_WATERLOO_ATTACK")
  
  -- Determinamos las mayor duración de todas las acciones
  maxTime = time1
  
  -- Pasamos a la secuencia 2 cuando pase el tiempo maximo de las acciones reproducidas
  temporizador ( maxTime, "secuencia2" )
  fade_color (255,255,255,0, 255,255,255,255, maxTime-0.5,0.5)

end

-- ---------------------------------------------------
-- secuencia de visualización de Hugomount
-- ---------------------------------------------------
function secuencia2 ()  
  
  estado_defecto_secuencia()  
  
  -- Inicializamos valores de tiempo a 0
  
  local time1 = nil
  local time2 = nil
  local maxTime = nil
  
  -- Ejecutamos nuestras acciones
  
  time1 = reproduce_camara_relativa ("game/gameModes/Batalla/Camaraspresentacion/CamaraEdifSm03.V3D", "LOC_Belle" )
    
  -- Determinamos las mayor duración de todas las acciones
  maxTime = time1 - 3
  
  -- Pasamos a la secuencia 3 cuando pase el tiempo maximo de las acciones reproducidas
  temporizador ( maxTime, "secuencia3" )
  fade_color (255,255,255,255, 255,255,255,0, 0,1)
  fade_color (255,255,255,0, 255,255,255,255, maxTime-0.5,0.5)
 
  
end

-- ---------------------------------------------------
-- secuencia de visualización de la Belle aliance
-- ---------------------------------------------------
function secuencia3 ()  
  
  estado_defecto_secuencia()  
  
  -- Inicializamos valores de tiempo a 0
  
  local time1 = nil
  local maxTime = nil
  
  -- Ejecutamos nuestras acciones
  
  time1 = reproduce_camara_relativa ("game/gameModes/Batalla/Camaraspresentacion/CamaraEdifSm02.V3D", "LOC_Hougoumont" )
    
  -- Determinamos las mayor duración de todas las acciones
  maxTime = time1 - 2
  
  -- Pasamos a la secuencia 3 cuando pase el tiempo maximo de las acciones reproducidas
  temporizador ( maxTime, "secuencia4" )
  fade_color (255,255,255,255, 255,255,255,0, 0,1)
  fade_color (255,255,255,0, 255,255,255,255, maxTime-0.5,0.5)
 
  
end

-- ---------------------------------------------------
-- secuencia de visualización de la haye sainte
-- ---------------------------------------------------
function secuencia4 ()  
  
  estado_defecto_secuencia()  
  
  -- Inicializamos valores de tiempo a 0
  
  local time1 = nil
  local maxTime = nil
  
  -- Ejecutamos nuestras acciones
  
  time1 = reproduce_camara_relativa ("game/gameModes/Batalla/Camaraspresentacion/CamaraEdifSm01.V3D", "LOC_Haye", false, 0.7)
    
  -- Determinamos las mayor duración de todas las acciones
  maxTime = time1 - 1
  
  -- Pasamos a la secuencia 3 cuando pase el tiempo maximo de las acciones reproducidas
  temporizador ( maxTime, "comenzar_batalla" )
  fade_color (255,255,255,255, 255,255,255,0, 0,1)
  fade_color (0,0,0,0, 0,0,0,255, maxTime-3,3)
 
  
end