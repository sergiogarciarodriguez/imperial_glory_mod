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
  local maxTime = nil
  
  -- Ejecutamos nuestras acciones
  
  time1 = reproduce_camara ("game/gameModes/Batalla/CamarasPresentacion/CamarasEscenarios/Camara42Egipto.V3D",0.0,false,1.0);
  time2 = reproduce_texto ("LTEXT_TEXTUISECUENCIAS_EGIPTO_ATACANTE_1")
  
  -- Determinamos las mayor duración de todas las acciones
  maxTime = time1 -3
  
  -- Pasamos a la secuencia 2 cuando pase el tiempo maximo de las acciones reproducidas
    if (esVictoriaTotal()) then
  	temporizador ( maxTime, "comenzar_batalla" )
  else
  	temporizador ( maxTime, "secuencia2" )
  end
  fade_color (200,190,160,50, 200,190,160,0,0,5)
  fade_color (200,190,160,0, 200,190,160,255,maxTime-0.8,0.8)

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
  
  time1 = reproduce_camara_relativa ("game/gameModes/Batalla/Camaraspresentacion/CamaraEdifSm02.V3D", "LOC_Aldea" ,true,0.65 )
  time2 = reproduce_texto ("LTEXT_TEXTUISECUENCIAS_EGIPTO_ATACANTE_2")
    
  -- Determinamos las mayor duración de todas las acciones
  maxTime = time1-2
  
  -- Pasamos a la secuencia 3 cuando pase el tiempo maximo de las acciones reproducidas
  temporizador ( maxTime, "comenzar_batalla" )
  fade_color (200,190,160,255, 200,190,160,0,0,1)
  fade_color (50,30,0,0, 0,0,0,255,maxTime-2,2)
  
end