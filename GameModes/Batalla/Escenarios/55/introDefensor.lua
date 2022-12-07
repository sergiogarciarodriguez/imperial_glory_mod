
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
  
  time1 = reproduce_camara ("game/gameModes/Batalla/CamarasPresentacion/CamarasEscenarios/Camara55Marruecos.V3D",0.0, false,0.9);
  time2 = reproduce_texto ("LTEXT_TEXTUISECUENCIAS_MARRUECOS_DEFENSOR_1")
  
  -- Determinamos las mayor duración de todas las acciones
  maxTime = time1
  
  -- Pasamos a la secuencia 2 cuando pase el tiempo maximo de las acciones reproducidas
  if (esVictoriaTotal()) then
  	temporizador ( maxTime, "comenzar_batalla" )
  else
  	temporizador ( maxTime, "secuencia2" )
  end
  
  fade_color (245,200,180,130, 245,200,180,0,0,3)
  fade_color (240,220,200,0, 240,220,200,255,maxTime-0.5,0.5)

end

-- ---------------------------------------------------
-- secuencia de visualización de la aldea
-- ---------------------------------------------------
function secuencia2 ()  
  
  estado_defecto_secuencia()
  muestra_tropas_amigas()  
  
  -- Inicializamos valores de tiempo a 0
  
  local time1 = nil
  local time2 = nil
  local maxTime = nil
  
  -- Ejecutamos nuestras acciones
  
  time1 = reproduce_camara_relativa ("game/gameModes/Batalla/Camaraspresentacion/CamaraEdifBg02.V3D", "LOC_Aldea", false,1.3)
  time2 = reproduce_texto ("LTEXT_TEXTUISECUENCIAS_MARRUECOS_DEFENSOR_2")
    
  -- Determinamos las mayor duración de todas las acciones
  maxTime = time1
  
  -- Pasamos a la secuencia 3 cuando pase el tiempo maximo de las acciones reproducidas
  temporizador ( maxTime, "secuencia3" )
  fade_color (240,220,200,255, 240,220,200,0,0,1)
  fade_color (240,220,200,0, 240,220,200,255,maxTime-0.5,0.5)
  
end

-- ---------------------------------------------------
-- secuencia de visualización de las ruinas
-- ---------------------------------------------------
function secuencia3 ()  
  
  estado_defecto_secuencia()
  muestra_tropas_amigas()  
  
  -- Inicializamos valores de tiempo a 0
  
  local time1 = nil
  local time2 = nil
  local maxTime = nil
  
  -- Ejecutamos nuestras acciones
  
  time1 = reproduce_camara ("game/gameModes/Batalla/Camaraspresentacion/CamaraTMarruecos1.V3D", 0.0,false,0.85);
  time2 = reproduce_texto ("LTEXT_TEXTUISECUENCIAS_MARRUECOS_DEFENSOR_3")
    
  -- Determinamos las mayor duración de todas las acciones
  maxTime = time1
  
  -- Pasamos a la secuencia 3 cuando pase el tiempo maximo de las acciones reproducidas
  temporizador ( maxTime, "secuencia4" )
  fade_color (240,220,200,255, 240,220,200,0,0,1)
  fade_color (240,220,200,0, 240,220,200,255,maxTime-0.5,0.5)
  
end

-- ---------------------------------------------------
-- secuencia de visualización de las jaimas
-- ---------------------------------------------------
function secuencia4 ()  
  
  estado_defecto_secuencia()
  muestra_tropas_amigas()  
  
  -- Inicializamos valores de tiempo a 0
  
  local time1 = nil
  local time2 = nil
  local maxTime = nil
  
  -- Ejecutamos nuestras acciones
  
  time1 = reproduce_camara_relativa ("game/gameModes/Batalla/Camaraspresentacion/CamaraEdifBg03.V3D", "LOC_Aldea2" , false, 1.0)
  time2 = reproduce_texto ("LTEXT_TEXTUISECUENCIAS_MARRUECOS_DEFENSOR_4")
    
  -- Determinamos las mayor duración de todas las acciones
  maxTime = time1
  
  -- Pasamos a la secuencia 3 cuando pase el tiempo maximo de las acciones reproducidas
  temporizador ( maxTime, "comenzar_batalla" )
  fade_color (240,220,200,255, 240,220,200,0,0,1)
  fade_color (60,20,0,0, 0,0,0,255,maxTime-3,3)
  
end