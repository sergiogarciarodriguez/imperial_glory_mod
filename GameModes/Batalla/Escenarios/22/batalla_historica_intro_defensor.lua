-- Batallas históricas: Arapiles (Castilla - 22) -> DEFENSOR
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
  
  time1 = reproduce_camara ("game/gameModes/Batalla/CamarasPresentacion/CamarasEscenarios/Camara22Castilla.V3D");
  time2 = reproduce_texto ("LTEXT_HISTORICA_ARAPILES_DEFENSOR")
  time3 = reproduce_locucion ("S_HB_ARAPILES_DEFENSE")
  
  -- Determinamos las mayor duración de todas las acciones
  maxTime = time1
  
  -- Pasamos a la secuencia 2 cuando pase el tiempo maximo de las acciones reproducidas
  temporizador ( maxTime, "secuencia2" )
  fade_color (5,0,0,255, 150,50,0,0,0,1.5)
  fade_color (50,0,0,0, 10,0,0,255, maxTime-0.8,0.8)


end

-- ------------------------------------------------------
-- secuencia de panorámica de la aldea
-- ----------------------------------------------
function secuencia2 ()

  estado_defecto_secuencia()
  muestra_tropas_amigas()

  -- Inicializamos valores de tiempo a 0
  
  local time1 = nil
  local maxTime = nil
  
  -- Ejecutamos nuestras acciones
  
  time1 = reproduce_camara_relativa ("game/gameModes/Batalla/CamarasPresentacion/CamaraEdifSm03.V3D", "LOC_Aldea");
  
  -- Determinamos las mayor duración de todas las acciones
  maxTime = time1
  
  -- Pasamos a la secuencia 2 cuando pase el tiempo maximo de las acciones reproducidas
  temporizador ( maxTime, "comenzar_batalla" )
  fade_color (5,0,0,255, 150,50,0,0, 0,0.7)
  fade_color (0,0,0,0, 0,0,0,255, maxTime-2,2)
end