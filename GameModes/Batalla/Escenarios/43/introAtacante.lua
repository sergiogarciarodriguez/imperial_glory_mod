
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
  
  time1 = reproduce_camara ("game/gameModes/Batalla/CamarasPresentacion/CamarasEscenarios/Camara43Cirenaica.V3D",0.0,false,1);
  time2 = reproduce_texto ("LTEXT_TEXTUISECUENCIAS_CIRENAICA_ATACANTE_1")
  
  -- Determinamos las mayor duración de todas las acciones
  maxTime = time1
  
  -- Pasamos a la secuencia 2 cuando pase el tiempo maximo de las acciones reproducidas
  temporizador ( maxTime, "secuencia2" )
  fade_color (0,0,0,150, 0,0,0,0,  -0,0.8)
  fade_color (110,70,40,0, 210,160,100,255,maxTime-2,2)
 
end

-- ---------------------------------------------------
-- secuencia de visualización de las jaimas1
-- ---------------------------------------------------
function secuencia2 ()  
  
  estado_defecto_secuencia()  
  muestra_tropas_amigas() 
  
  -- Inicializamos valores de tiempo a 0
  
  local time1 = nil
  local time2 = nil
  local maxTime = nil
  
  -- Ejecutamos nuestras acciones
  
  time1 = reproduce_camara ("game/gameModes/Batalla/Camaraspresentacion/CamaraJaimaCirenaica01.V3D", 0.0, false, 1)
  time2 = reproduce_texto ("LTEXT_TEXTUISECUENCIAS_CIRENAICA_ATACANTE_2")
    
  -- Determinamos las mayor duración de todas las acciones
  maxTime = time1
  
  -- Pasamos a la secuencia 3 cuando pase el tiempo maximo de las acciones reproducidas
  temporizador ( maxTime, "secuencia3" )
  fade_color (210,160,100,255, 210,160,100,0,0,4)
  fade_color (255,245,235,0, 255,245,235,255,maxTime-1,1)
  
end

-- ---------------------------------------------------
-- secuencia de visualización de la aldea (casa)
-- ---------------------------------------------------
function secuencia3 ()  
  
  estado_defecto_secuencia()  
  muestra_tropas_amigas() 
  
  -- Inicializamos valores de tiempo a 0
  
  local time1 = nil
  local time2 = nil
  local maxTime = nil
  
  -- Ejecutamos nuestras acciones
  
  time1 = reproduce_camara ("game/gameModes/Batalla/Camaraspresentacion/CamaraAldeaCirenaica.V3D", 0.0,false,1 )
  time2 = reproduce_texto ("LTEXT_TEXTUISECUENCIAS_CIRENAICA_ATACANTE_3")
    
  -- Determinamos las mayor duración de todas las acciones
  maxTime = time1
  
  -- Pasamos a la secuencia 3 cuando pase el tiempo maximo de las acciones reproducidas
  temporizador ( maxTime, "secuencia4" )
  fade_color (255,245,235,255, 255,245,235,0,0,1)
  fade_color (255,245,235,0, 255,245,235,255,maxTime-1,1)
  
end

-- ---------------------------------------------------
-- secuencia de visualización de las otras jaimas
-- ---------------------------------------------------
function secuencia4 ()  
  
  estado_defecto_secuencia()  
  muestra_tropas_amigas() 
  
  -- Inicializamos valores de tiempo a 0
  
  local time1 = nil
  local time2 = nil
  local maxTime = nil
  
  -- Ejecutamos nuestras acciones
  
  time1 = reproduce_camara ("game/gameModes/Batalla/Camaraspresentacion/CamaraJaimaCirenaica02.V3D", 0.0, false, 1 )
  time2 = reproduce_texto ("LTEXT_TEXTUISECUENCIAS_CIRENAICA_ATACANTE_4")
    
  -- Determinamos las mayor duración de todas las acciones
  maxTime = time1
  
  -- Pasamos a la secuencia 3 cuando pase el tiempo maximo de las acciones reproducidas
  temporizador ( maxTime, "comenzar_batalla" )
  fade_color (255,245,235,255, 255,245,235,0,0,1)
  fade_color (110,70,40,0, 30,15,10,255,maxTime-2,2)
  
  
end