-- constantes de los identificadores de los videos (respecto al scriptblock de la secuencia)
video_creditos = 1447314258 -- 'VDCR'
creditos       = 1129465156 -- 'CRED'
visor_textos   = 1448363341 -- 'VTEM'

-- --------------------------------------------
-- función principal de la secuencia.
-- se llamará al ejecutar la secuencia definida
-- por el script, y debera llamar la función
-- que inicia la primera secuencia
-- --------------------------------------------
function inicia_secuencia()
  -- lanzamos la primera secuencia:
  secuencia1()
end

-- -----------------------------------------------------------------------------------------------------------
-- Esta funcion es llamada cuando se presiona una tecla, en los creditos solo se sale con el escape y el boton
-- -----------------------------------------------------------------------------------------------------------
function on_key_up(IDTecla)
  -- no hace nada, se sale con el boton
end

local mu = "LASVAQUITASHACENMU"
local muIdx = 1;

function on_key_up_ASCII(IDTecla)
  if IDTecla == string.byte( mu, muIdx ) then
    muIdx = muIdx + 1;
  else
    muIdx = 1;
  end

  if muIdx == string.len( mu ) + 1 then
    switchMooMode();
  end
end

-- -----------------------------------------------------------
-- Esta funcion se llama al llegar al final de cualquier video
-- -----------------------------------------------------------
function on_video_end(IDVideo)
  -- si termina el scroller de creditos (que tambien es el de derrota), se sale
  if IDVideo == creditos then
    finaliza_secuencia()
  end
  -- si termina el video1, sale de la secuencia
  -- if IDVideo == video1 then
  --  finaliza_secuencia()
  -- end
end

-- ------------------------------------------------------
-- NOTA: esto ahora no hace nada, pero si se quiere mostrar textos emergentes antes de poner los creditos hay que
--  poner aqui algunas cosas (reproduce_texto_fuente, los temporizadores, ... ) y seguramente un temporizador para 
--  que se vuelva al menu principal cuando terminen todos los creditos
-- ----------------------------------------------
function secuencia1 ()

  -- Inicializamos valores de tiempo a 0
  local time = nil
  set_active_ctrl(visor_textos,true)
  
  -- paramos la música del menú principal
  stop_all_sounds()

  -- Ejecutamos nuestras acciones
  reproduce_video (video_creditos)
  reproduce_musica ("S_MAINMENU_CREDITS_MUSIC")
  --  parametros (texto,fuente,tiempo_en_segundos,rojo,verde,azul,fadeout_segundos,fadein_segundos)                          
  -- reproduce_texto_fuente ("Imperial Glory","Fonts/Times25n.fnt", 4,255,255,255,0.5,0.5)

  -- el +1 es por el fade in y el fade out, de medio segundo cada uno 
  time = 0 -- 2 + 1

  -- Pasamos a la secuencia 2 cuando pase el tiempo maximo de las acciones reproducidas
  -- temporizador ( time , "secuencia2" )
  secuencia2()

end

-- ------------------------------------------------------
-- Activa los creditos
-- ----------------------------------------------
function secuencia2 ()

  -- Inicializamos valores de tiempo a 0
  local time = nil
  
  set_active_ctrl(creditos,true)
  
end

