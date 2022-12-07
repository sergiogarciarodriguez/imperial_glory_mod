
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
  
  time1 = reproduce_camara ("game/gameModes/Batalla/CamarasPresentacion/CamarasEscenarios/Camara10Branderburgo.V3D",0.0,false,0.65);
  time2 = reproduce_texto ("LTEXT_TEXTUISECUENCIAS_BRANDENBURGO_ATACANTE_1")
  
  -- Determinamos las mayor duración de todas las acciones
  maxTime = time1
  
  -- Pasamos a la secuencia 2 cuando pase el tiempo maximo de las acciones reproducidas
  if (esVictoriaTotal()) then
  	temporizador ( maxTime, "comenzar_batalla" )
  else
  	temporizador ( maxTime, "secuencia2" )
  end
  
  fade_color (255,240,225,0, 255,240,225,255,maxTime-0.7,0.7)

end

-- ---------------------------------------------------
-- secuencia de visualización del palacio de Brandenburgo
-- ---------------------------------------------------
function secuencia2 ()  
  
  estado_defecto_secuencia()
  muestra_tropas_amigas()  
  
  -- Inicializamos valores de tiempo a 0
  
  local time1 = nil
  local time2 = nil
  local maxTime = nil
  
  -- Ejecutamos nuestras acciones
  
  time1 = reproduce_camara ("game/gameModes/Batalla/Camaraspresentacion/CamaraTBranderburgo1.V3D", 0.0,false,1.0);
  time2 = reproduce_texto ("LTEXT_TEXTUISECUENCIAS_BRANDENBURGO_ATACANTE_2")
    
  -- Determinamos las mayor duración de todas las acciones
  maxTime = time1
  
  -- Pasamos a la secuencia 3 cuando pase el tiempo maximo de las acciones reproducidas
  temporizador ( maxTime, "comenzar_batalla" )
  fade_color (255,240,225,255, 255,240,225,0, 0.0,1.5)
  fade_color (255,240,225,0, 255,240,225,255,maxTime-2,2)
  
end