
-- --------------------------------------------
-- funci?n principal de la secuencia.
-- se llamar? al ejecutar la secuencia definida
-- por el script, y debera llamar la funci?n
-- que inicia la primera secuencia
-- --------------------------------------------
function inicia_secuencia()
  -- lanzamos la primera secuencia:
  
  estado_defecto_secuencia()  
  
  secuencia1();
end

-- ------------------------------------------------------
-- secuencia de panor?mica del terreno de batalla
-- ----------------------------------------------
function secuencia1 ()

  -- Preparamos el entorno para la secuencia
  -- Ej.: esta secuencia podria ser una panor?mica de todo el terreno de batalla, mostrando unicamente esto:

  estado_defecto_secuencia()
  muestra_tropas_amigas()  

  -- Inicializamos valores de tiempo a 0
  
  local time1 = nil
  local time2 = nil
  local maxTime = nil
  
  -- Ejecutamos nuestras acciones
  
  time1 = reproduce_camara ("game/gameModes/Batalla/CamarasPresentacion/CamarasEscenarios/Camara03Irlanda.V3D",0.0,false,0.4);
  time2 = reproduce_texto ("LTEXT_TEXTUISECUENCIAS_IRLANDA_ATACANTE_1")
  
  -- Determinamos las mayor duraci?n de todas las acciones
  maxTime = max (time1, time2)
  
  -- Pasamos a la secuencia 2 cuando pase el tiempo maximo de las acciones reproducidas
  temporizador ( maxTime, "secuencia2" )
  fade_color (255,255,255,0, 255,255,255,255,maxTime-0.5, 0.5)

end

-- -----------------------------------------
-- secuencia de visualizaci?n de la aldea
-- -----------------------------------------
function secuencia2 ()  
  
  estado_defecto_secuencia()  
  
  -- Inicializamos valores de tiempo a 0
  
  local time1 = nil
  local time2 = nil
  local maxTime = nil
  
  -- Ejecutamos nuestras acciones
  
  time1 = reproduce_camara_relativa ("game/gameModes/Batalla/Camaraspresentacion/CamaraEdifSm01.V3D", "LOC_aldea" ,false,0.4)
  time2 = reproduce_texto ("LTEXT_TEXTUISECUENCIAS_IRLANDA_ATACANTE_2")
    
  -- Determinamos las mayor duraci?n de todas las acciones
  maxTime = time2 + 1
  
  -- Pasamos a la secuencia 3 cuando pase el tiempo maximo de las acciones reproducidas
  temporizador ( maxTime, "comenzar_batalla" )
  fade_color (255,255,255,255, 255,255,255,0,0.0, 0.5)
  fade_color (0,0,0,0, 0,0,0,255,maxTime-3, 3)
  
end