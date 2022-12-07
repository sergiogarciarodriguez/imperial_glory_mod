-- constantes de los identificadores de los videos (respecto al scriptblock de la secuencia)
video_creditos = 1447314258 -- 'VDCR'
videoGB        = 1447314993 -- 'VDF1'
videoFR        = 1447314994 -- 'VDF2'
videoAUS       = 1447314995 -- 'VDF3'
videoRU        = 1447314996 -- 'VDF4'
videoPRU       = 1447314997 -- 'VDF5'

creditos       = 1129465156 -- 'CRED'
visor_textos   = 1448363341 -- 'VTEM'

-- constantes identificadores imperio
--imperio_francia, imperio_inglaterra, imperio_austria, imperio_prusia, imperio_rusia

-- variable identificador imperio local
--imperio_jugador_local

-- variable nombre imperio local
--nombre_imperio_jugador_local

-- constentes tipos de secuencia
--secuencia_derrota, secuencia_victoria

-- variable con el tipo de secuencia actual
--tipo_secuencia



-- --------------------------------------------
-- función principal de la secuencia.
-- se llamará al ejecutar la secuencia definida
-- por el script, y debera llamar la función
-- que inicia la primera secuencia
-- --------------------------------------------
function inicia_secuencia()

  -- seleccion de la secuencia
  if tipo_secuencia == secuencia_victoria then
    inicia_secuencia_victoria()
  else
    inicia_secuencia_derrota()
  end

end

-- ------------------------------------------------------------------------------------------------------------
-- Esta funcion es llamada cuando se presiona una tecla, las secuencias de salida terminan al pulsar cualquiera
-- ------------------------------------------------------------------------------------------------------------
function on_key_up(IDTecla)
  finaliza_secuencia()
end

function on_key_up_ASCII(IDTecla)
end

-- ------------------------------------------------------
-- SECUENCIA DE VICTORIA
-- ----------------------------------------------
function inicia_secuencia_victoria ()

  set_active_ctrl(visor_textos,true)
  
  -- Ejecutamos nuestras acciones
  if imperio_jugador_local == imperio_francia then
    reproduce_video (videoFR)
    temporizador ( 1.452, "reproduce_texto_francia_1" )
    
  elseif imperio_jugador_local == imperio_inglaterra then
    reproduce_video (videoGB)
    temporizador ( 1.452, "reproduce_texto_granbretanya_1" )
    
  elseif imperio_jugador_local == imperio_austria then
    reproduce_video (videoAUS)
    temporizador ( 1.452, "reproduce_texto_austria_1" )
    
  elseif imperio_jugador_local == imperio_prusia then
    reproduce_video (videoPRU)
    temporizador ( 1.452, "reproduce_texto_prusia_1" )
    
  else
    reproduce_video (videoRU)
    temporizador ( 1.452, "reproduce_texto_rusia_1" )
  end
      
end

function inicia_secuencia_derrota()

  -- video de créditos
  reproduce_video (video_creditos)

  reproduce_texto_tiempo ( "LTEXT_MSGBOX_PARTIDAPERDIDA_TEXT" , 6)
  
  -- cerrar la secuencia en 10 segundos
  temporizador ( 15, "finaliza_secuencia" )
end

function inicia_secuencia_creditos()

  -- quito la música del video anterior y pongo la musica nueva
--  stop_all_sounds();
--  reproduce_musica("S_GEST_MUSIC_CREDITS");
  -- y reproducimos el video de créditos
  reproduce_video (video_creditos)  
  set_active_ctrl(creditos,true)
  
end


-- -----------------------------------------------------------
-- Esta funcion se llama al llegar al final de cualquier video
-- -----------------------------------------------------------
function on_video_end(IDVideo)
  -- si termina el scroller de creditos (que tambien es el de derrota), se sale
  if IDVideo == creditos then
    finaliza_secuencia()
  else
    -- si no es video de derrota entonces es de victoria y se pasa a la secuencia de los creditos
    inicia_secuencia_creditos()
  end
end

-- ---------------------------------------------
-- Funciones de reproducción de textos: Francia
-- ---------------------------------------------
function reproduce_texto_francia_1()

	local cadena_por_defecto = transforma_texto("LTEXT_UI_VICTORIA_TOTAL_FRANCIA_1")
	reproduce_texto_tiempo (cadena_por_defecto , 6.048)
	temporizador ( 6.408, "reproduce_texto_francia_2" )
end

function reproduce_texto_francia_2()

	local cadena_por_defecto = transforma_texto("LTEXT_UI_VICTORIA_TOTAL_FRANCIA_2")
	reproduce_texto_tiempo (cadena_por_defecto , 6.06)
	temporizador ( 6.18, "reproduce_texto_francia_3" )
end

function reproduce_texto_francia_3()

	local cadena_por_defecto = transforma_texto("LTEXT_UI_VICTORIA_TOTAL_FRANCIA_3")
	reproduce_texto_tiempo (cadena_por_defecto , 6.06)
	temporizador ( 6.552, "reproduce_texto_francia_4" )
end

function reproduce_texto_francia_4()

	local cadena_por_defecto = transforma_texto("LTEXT_UI_VICTORIA_TOTAL_FRANCIA_4")
	reproduce_texto_tiempo (cadena_por_defecto , 8.652)
	temporizador ( 10.272, "reproduce_texto_francia_5" )
end

function reproduce_texto_francia_5()

	local cadena_por_defecto = transforma_texto("LTEXT_UI_VICTORIA_TOTAL_FRANCIA_5")
	reproduce_texto_tiempo (cadena_por_defecto , 6.108)
	temporizador ( 6.048, "reproduce_texto_francia_6" )
end

function reproduce_texto_francia_6()

	local cadena_por_defecto = transforma_texto("LTEXT_UI_VICTORIA_TOTAL_FRANCIA_6")
	reproduce_texto_tiempo (cadena_por_defecto , 8.424)
end

-- ---------------------------------------------
-- Funciones de reproducción de textos: Austria
-- ---------------------------------------------
function reproduce_texto_austria_1()

	local cadena_por_defecto = transforma_texto("LTEXT_UI_VICTORIA_TOTAL_AUSTRIA_1")
	reproduce_texto_tiempo (cadena_por_defecto , 6.048)
	temporizador ( 6.408, "reproduce_texto_austria_2" )
end

function reproduce_texto_austria_2()

	local cadena_por_defecto = transforma_texto("LTEXT_UI_VICTORIA_TOTAL_AUSTRIA_2")
	reproduce_texto_tiempo (cadena_por_defecto , 6.06)
	temporizador ( 6.18, "reproduce_texto_austria_3" )
end

function reproduce_texto_austria_3()

	local cadena_por_defecto = transforma_texto("LTEXT_UI_VICTORIA_TOTAL_AUSTRIA_3")
	reproduce_texto_tiempo (cadena_por_defecto , 6.06)
	temporizador ( 6.552, "reproduce_texto_austria_4" )
end

function reproduce_texto_austria_4()

	local cadena_por_defecto = transforma_texto("LTEXT_UI_VICTORIA_TOTAL_AUSTRIA_4")
	reproduce_texto_tiempo (cadena_por_defecto , 8.652)
	temporizador ( 10.272, "reproduce_texto_austria_5" )
end

function reproduce_texto_austria_5()

	local cadena_por_defecto = transforma_texto("LTEXT_UI_VICTORIA_TOTAL_AUSTRIA_5")
	reproduce_texto_tiempo (cadena_por_defecto , 6.108)
	temporizador ( 6.048, "reproduce_texto_austria_6" )
end

function reproduce_texto_austria_6()

	local cadena_por_defecto = transforma_texto("LTEXT_UI_VICTORIA_TOTAL_AUSTRIA_6")
	reproduce_texto_tiempo (cadena_por_defecto , 8.424)
end

-- ---------------------------------------------
-- Funciones de reproducción de textos: UK
-- ---------------------------------------------
function reproduce_texto_granbretanya_1()

	local cadena_por_defecto = transforma_texto("LTEXT_UI_VICTORIA_TOTAL_GRANBRETANYA_1")
	reproduce_texto_tiempo (cadena_por_defecto , 6.048)
	temporizador ( 6.408, "reproduce_texto_granbretanya_2" )
end

function reproduce_texto_granbretanya_2()

	local cadena_por_defecto = transforma_texto("LTEXT_UI_VICTORIA_TOTAL_GRANBRETANYA_2")
	reproduce_texto_tiempo (cadena_por_defecto , 6.06)
	temporizador ( 6.18, "reproduce_texto_granbretanya_3" )
end

function reproduce_texto_granbretanya_3()

	local cadena_por_defecto = transforma_texto("LTEXT_UI_VICTORIA_TOTAL_GRANBRETANYA_3")
	reproduce_texto_tiempo (cadena_por_defecto , 6.06)
	temporizador ( 6.552, "reproduce_texto_granbretanya_4" )
end

function reproduce_texto_granbretanya_4()

	local cadena_por_defecto = transforma_texto("LTEXT_UI_VICTORIA_TOTAL_GRANBRETANYA_4")
	reproduce_texto_tiempo (cadena_por_defecto , 8.652)
	temporizador ( 10.272, "reproduce_texto_granbretanya_5" )
end

function reproduce_texto_granbretanya_5()

	local cadena_por_defecto = transforma_texto("LTEXT_UI_VICTORIA_TOTAL_GRANBRETANYA_5")
	reproduce_texto_tiempo (cadena_por_defecto , 6.108)
	temporizador ( 6.048, "reproduce_texto_granbretanya_6" )
end

function reproduce_texto_granbretanya_6()

	local cadena_por_defecto = transforma_texto("LTEXT_UI_VICTORIA_TOTAL_GRANBRETANYA_6")
	reproduce_texto_tiempo (cadena_por_defecto , 8.424)
end


-- ---------------------------------------------
-- Funciones de reproducción de textos: Prusia
-- ---------------------------------------------
function reproduce_texto_prusia_1()

	local cadena_por_defecto = transforma_texto("LTEXT_UI_VICTORIA_TOTAL_PRUSIA_1")
	reproduce_texto_tiempo (cadena_por_defecto , 6.048)
	temporizador ( 6.408, "reproduce_texto_prusia_2" )
end

function reproduce_texto_prusia_2()

	local cadena_por_defecto = transforma_texto("LTEXT_UI_VICTORIA_TOTAL_PRUSIA_2")
	reproduce_texto_tiempo (cadena_por_defecto , 6.06)
	temporizador ( 6.18, "reproduce_texto_prusia_3" )
end

function reproduce_texto_prusia_3()

	local cadena_por_defecto = transforma_texto("LTEXT_UI_VICTORIA_TOTAL_PRUSIA_3")
	reproduce_texto_tiempo (cadena_por_defecto , 6.06)
	temporizador ( 6.552, "reproduce_texto_prusia_4" )
end

function reproduce_texto_prusia_4()

	local cadena_por_defecto = transforma_texto("LTEXT_UI_VICTORIA_TOTAL_PRUSIA_4")
	reproduce_texto_tiempo (cadena_por_defecto , 8.652)
	temporizador ( 10.272, "reproduce_texto_prusia_5" )
end

function reproduce_texto_prusia_5()

	local cadena_por_defecto = transforma_texto("LTEXT_UI_VICTORIA_TOTAL_PRUSIA_5")
	reproduce_texto_tiempo (cadena_por_defecto , 6.108)
	temporizador ( 6.048, "reproduce_texto_prusia_6" )
end

function reproduce_texto_prusia_6()

	local cadena_por_defecto = transforma_texto("LTEXT_UI_VICTORIA_TOTAL_PRUSIA_6")
	reproduce_texto_tiempo (cadena_por_defecto , 8.424)
end

-- ---------------------------------------------
-- Funciones de reproducción de textos: Rusia
-- ---------------------------------------------
function reproduce_texto_rusia_1()

	local cadena_por_defecto = transforma_texto("LTEXT_UI_VICTORIA_TOTAL_RUSIA_1")
	reproduce_texto_tiempo (cadena_por_defecto , 6.048)
	temporizador ( 6.408, "reproduce_texto_rusia_2" )
end

function reproduce_texto_rusia_2()

	local cadena_por_defecto = transforma_texto("LTEXT_UI_VICTORIA_TOTAL_RUSIA_2")
	reproduce_texto_tiempo (cadena_por_defecto , 6.06)
	temporizador ( 6.18, "reproduce_texto_rusia_3" )
end

function reproduce_texto_rusia_3()

	local cadena_por_defecto = transforma_texto("LTEXT_UI_VICTORIA_TOTAL_RUSIA_3")
	reproduce_texto_tiempo (cadena_por_defecto , 6.06)
	temporizador ( 6.552, "reproduce_texto_rusia_4" )
end

function reproduce_texto_rusia_4()

	local cadena_por_defecto = transforma_texto("LTEXT_UI_VICTORIA_TOTAL_RUSIA_4")
	reproduce_texto_tiempo (cadena_por_defecto , 8.652)
	temporizador ( 10.272, "reproduce_texto_rusia_5" )
end

function reproduce_texto_rusia_5()

	local cadena_por_defecto = transforma_texto("LTEXT_UI_VICTORIA_TOTAL_RUSIA_5")
	reproduce_texto_tiempo (cadena_por_defecto , 6.108)
	temporizador ( 6.048, "reproduce_texto_rusia_6" )
end

function reproduce_texto_rusia_6()

	local cadena_por_defecto = transforma_texto("LTEXT_UI_VICTORIA_TOTAL_RUSIA_6")
	reproduce_texto_tiempo (cadena_por_defecto , 8.424)
end