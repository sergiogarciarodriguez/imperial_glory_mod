
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
  
  time1 = reproduce_camara ("game/gameModes/Batalla/CamarasPresentacion/CamarasEscenarios/Camara19Kursk.V3D", 0.0, false, 1.0);
  time2 = reproduce_texto ("LTEXT_TEXTUISECUENCIAS_KURSK_DEFENSOR_1")
  
  -- Determinamos las mayor duración de todas las acciones
  maxTime = max (time1, time2)
  
  -- Pasamos a la secuencia 2 cuando pase el tiempo maximo de las acciones reproducidas
  temporizador ( maxTime, "secuencia2" )
  fade_color (240,240,255,130, 240,240,255,0,0,4)
  fade_color (235,185,150,0, 255,255,255,255,maxTime-0.8,0.8)

end

-- ---------------------------------------------------
-- secuencia de visualización del bosque 1
-- ---------------------------------------------------
function secuencia2 ()  
  
  estado_defecto_secuencia() 
  muestra_tropas_amigas()  
  
  -- Inicializamos valores de tiempo a 0
  
  local time1 = nil
  local time2 = nil
  local maxTime = nil
  
  -- Ejecutamos nuestras acciones
  
  time1 = reproduce_camara_relativa ("game/gameModes/Batalla/Camaraspresentacion/CamaraEdifBg02.V3D", "LOC_Bosque1" , false, 0.6)
  time2 = reproduce_texto ("LTEXT_TEXTUISECUENCIAS_KURSK_DEFENSOR_2")
    
  -- Determinamos las mayor duración de todas las acciones
  maxTime = time1
  
  -- Pasamos a la secuencia 3 cuando pase el tiempo maximo de las acciones reproducidas
  temporizador ( maxTime, "comenzar_batalla" )
  fade_color (255,255,255,255, 255,255,255,0,0,1)
  fade_color (0,0,0,0, 0,0,0,255,maxTime-2,2)
  
end