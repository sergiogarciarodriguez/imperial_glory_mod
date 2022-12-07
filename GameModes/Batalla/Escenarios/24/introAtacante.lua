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
  
  time1 = reproduce_camara ("game/gameModes/Batalla/CamarasPresentacion/CamarasEscenarios/Camara24PrusiaOriental.V3D", 0.0, false, 1.0);
  time2 = reproduce_texto ("LTEXT_TEXTUISECUENCIAS_PRUSIAORIENTAL_ATACANTE_1")
  
  -- Determinamos las mayor duración de todas las acciones
  maxTime = time1
  
  -- Pasamos a la secuencia 2 cuando pase el tiempo maximo de las acciones reproducidas
  temporizador ( maxTime, "secuencia2" )
  fade_color (0,35,0,255, 0,0,0,0, 0,2)
  fade_color (245,255,240,0, 245,255,240,255, maxTime-1.5,1.5)

end

-- ------------------------------------------------------
-- secuencia de panorámica del bosque1
-- ----------------------------------------------
function secuencia2 ()  
  
  estado_defecto_secuencia()
  muestra_tropas_amigas()  
  
  -- Inicializamos valores de tiempo a 0
  
  local time1 = nil
  local time2 = nil
  local maxTime = nil
  
  -- Ejecutamos nuestras acciones
  
  time1 = reproduce_camara_relativa ("game/gameModes/Batalla/Camaraspresentacion/CamaraEdifBg02.V3D", "LOC_Bosque1" , false, 0.8)
  time2 = reproduce_texto ("LTEXT_TEXTUISECUENCIAS_PRUSIAORIENTAL_ATACANTE_2")
     
  -- Determinamos las mayor duración de todas las acciones
  maxTime = time1
  
  -- Pasamos a la secuencia 3 cuando pase el tiempo maximo de las acciones reproducidas
  temporizador ( maxTime, "secuencia3" )
  fade_color (245,255,240,255, 245,255,240,0, 0,0.5)
  fade_color (255,255,255,0, 255,255,255,255, maxTime-0.5,0.5)
  
end

-- ------------------------------------------------------
-- secuencia de panorámica del bosque2
-- ----------------------------------------------
function secuencia3 ()  
  
  estado_defecto_secuencia()
  muestra_tropas_amigas()  
  
  -- Inicializamos valores de tiempo a 0
  
  local time1 = nil
  local time2 = nil
  local maxTime = nil
  
  -- Ejecutamos nuestras acciones
  
  time1 = reproduce_camara_relativa ("game/gameModes/Batalla/Camaraspresentacion/CamaraEdifBg03.V3D", "LOC_Bosque2", false, 0.5)
  time2 = reproduce_texto ("LTEXT_TEXTUISECUENCIAS_PRUSIAORIENTAL_ATACANTE_3")
  
     
  -- Determinamos las mayor duración de todas las acciones
  maxTime = time1
  
  temporizador ( maxTime, "comenzar_batalla" )
  fade_color (255,255,255,255, 255,255,255,0, 0,0.5)
  fade_color (0,0,0,0, 0,0,0,255, maxTime-1,1)
  
end