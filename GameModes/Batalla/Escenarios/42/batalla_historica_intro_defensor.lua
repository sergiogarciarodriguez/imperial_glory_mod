-- Batallas hist�ricas: Pir�mides (Egipto - 42)
-- --------------------------------------------
-- funci�n principal de la secuencia.
-- se llamar� al ejecutar la secuencia definida
-- por el script, y debera llamar la funci�n
-- que inicia la primera secuencia
-- --------------------------------------------
function inicia_secuencia()
  -- lanzamos la primera secuencia:
  
  estado_defecto_secuencia()  
  
  secuencia1();
end

-- ------------------------------------------------------
-- secuencia de panor�mica del terreno de batalla
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
  
  time1 = reproduce_camara ("game/gameModes/Batalla/CamarasPresentacion/CamarasEscenarios/Camara42Egipto.V3D",0.0,false,1.0);
  time2 = reproduce_texto ("LTEXT_HISTORICA_PIRAMIDES_DEFENSOR")
  time3 = reproduce_locucion ("S_HB_PYRAMID_DEFENSE")
  
  -- Determinamos las mayor duraci�n de todas las acciones
  maxTime = time1
  
  -- Pasamos a la secuencia 2 cuando pase el tiempo maximo de las acciones reproducidas
  temporizador ( maxTime, "secuencia2" )
  fade_color (200,190,160,50, 200,190,160,0,0,5)
  fade_color (200,190,160,0, 200,190,160,255,maxTime-0.8,0.8)

end

-- ---------------------------------------------------
-- secuencia de visualizaci�n de la aldea
-- ---------------------------------------------------
function secuencia2 ()  
  
  estado_defecto_secuencia()  
  muestra_tropas_amigas()
  
  -- Inicializamos valores de tiempo a 0
  
  local time1 = nil
  local maxTime = nil
  
  -- Ejecutamos nuestras acciones
  
  time1 = reproduce_camara_relativa ("game/gameModes/Batalla/Camaraspresentacion/CamaraEdifSm02.V3D", "LOC_Aldea" ,true,0.65)
    
  -- Determinamos las mayor duraci�n de todas las acciones
  maxTime = time1 - 1
  
  -- Pasamos a la secuencia 3 cuando pase el tiempo maximo de las acciones reproducidas
  temporizador ( maxTime, "comenzar_batalla" )
  fade_color (200,190,160,255, 200,190,160,0,0,1)
  fade_color (50,30,0,0, 0,0,0,255,maxTime-2.5,2.5)
  
end