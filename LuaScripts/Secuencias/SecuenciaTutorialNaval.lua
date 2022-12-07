-- --------------------------------------------
-- función principal de la secuencia.
-- se llamará al ejecutar la secuencia definida
-- por el script, y debera llamar la función
-- que inicia la primera secuencia
-- --------------------------------------------
width = 1024;
height = 768;

ID_BOTON_FIRE_ESTRIBOR = 1163088978
ID_BOTON_AMMO_CHAINS   = 1179993415
ID_BOTON_MINIMAPA      = 1112359248
ID_BOTON_ABORDAR       = 1094864722


ID_BARRA_CONTROL_BARCOS = 1111704129 
ID_PANEL_ORDENES        = 1347371585
ID_ZONA_SENSIBLE_PANEL_ORDENES = 1515406670

ID_ZONA_SENSIBLE_NAVAL  = 1515406158

ID_TECLA_UP    = 1264538960
ID_TECLA_DOWN  = 1264534606
ID_TECLA_LEFT  = 1264537682
ID_TECLA_RIGHT = 1264537157

tecla_UP    = false
tecla_DOWN  = false
tecla_LEFT  = false
tecla_RIGHT = false

ID_BOTON_ESC = 1330662977	-- 'OPNA'
ID_TECLA_ESC = 1262834499	-- 'KESC'

function permitirESC()

  add_filtro(tipo_mensaje_ui_generico, ID_TECLA_ESC)
  add_filtro(tipo_mensaje_ui_generico, ID_BOTON_ESC)
  ponEventoTeclaEscape()

end

function ponEventoTeclaEscape()

  on_event("confirmacionSalidaDelTutorial", tipo_mensaje_game_buttton_release,ID_BOTON_ESC)
  on_event("confirmacionSalidaDelTutorial", tipo_mensaje_game_buttton_release,ID_TECLA_ESC)
  
end

function confirmacionSalidaDelTutorial()

  pause(true)
  filtrar_todos(false)
  id_ventana_confirmacion_fin_tutorial = 1234

  open_messagebox (id_ventana_confirmacion_fin_tutorial,"LTEXT_TUTORIAL_SALIDA_TITULO", "LTEXT_TUTORIAL_SALIDA_TEXTO",TMB_NORMAL,"LTEXT_TUTORIAL_SALIDA_ACEPTAR","LTEXT_TUTORIAL_SALIDA_CANCELAR" )
  on_event("exit_to_main_menu_eliminando_marcas",tipo_mensaje_messagebox_close, id_ventana_confirmacion_fin_tutorial, 0)
  on_event("vuelve_al_tutorial",tipo_mensaje_messagebox_close, id_ventana_confirmacion_fin_tutorial, 1)

end

function exit_to_main_menu_eliminando_marcas()
  pause(false)
  elimina_todas_marcas(0)
  exit_to_main_menu()
  
end

function vuelve_al_tutorial()

  filtrar_todos(true)
  ponEventoTeclaEscape()
  pause(false)  
end

-----------------------------------------
-- PERMITE MOVIMIENTO DE CAMARA Y ZOOM --
-----------------------------------------
function permitir_camara()

  add_filtro(tipo_mensaje_ui_generico, ID_TECLA_UP   )
  add_filtro(tipo_mensaje_ui_generico, ID_TECLA_DOWN )
  add_filtro(tipo_mensaje_ui_generico, ID_TECLA_LEFT )
  add_filtro(tipo_mensaje_ui_generico, ID_TECLA_RIGHT) 
  add_filtro(tipo_mensaje_ui_generico, ID_ZONA_SENSIBLE_NAVAL, MSG_MOUSE_WHEEL)

end



function inicia_secuencia()
  -- lanzamos la primera secuencia:
  step0()
end

-- ---------------------- STEP 0 -------------------------------
function step0()
  
  enable_IA(false)
  abrir_ventana_tutorial(700, 50, tipo_ventana_alargado, "LTEXT_TUTORIAL_NAVAL_TITULO", "LTEXT_TUTORIAL_NAVAL_1_A", "LTEXT_TUTORIAL_NAVAL_1_B", true)
  add_filtro(tipo_mensaje_game_buttton_release, id_boton_ventana_tutorial)
  on_event("step1", tipo_mensaje_game_buttton_release, id_boton_ventana_tutorial)

  permitirESC()
end

-- ---------------------- STEP 1 -------------------------------
function step1()
   
  cerrar_ventana_tutorial()
  select_barco_by_index(0)
  abrir_ventana_tutorial(700, 50, tipo_ventana_alargado, "LTEXT_TUTORIAL_NAVAL_TITULO", "LTEXT_TUTORIAL_NAVAL_0_A", "LTEXT_TUTORIAL_NAVAL_0_B", true)
  add_filtro(tipo_mensaje_ui_generico, id_boton_ventana_tutorial, MSG_MOUSE_L_RELEASE)
  add_filtro(tipo_mensaje_ui_generico, id_boton_ventana_tutorial, MSG_MOUSE_ENTER)
  add_filtro(tipo_mensaje_ui_generico, id_boton_ventana_tutorial, MSG_MOUSE_LEAVE)
  add_filtro(tipo_mensaje_ui_generico, id_boton_ventana_tutorial, MSG_KEY_UP)
  on_event("step2", tipo_mensaje_ui_generico, id_boton_ventana_tutorial, MSG_MOUSE_L_RELEASE)

  permitirESC()
end

-- ---------------------- STEP 2 -------------------------------
function step2()

  limpia_eventos ()
  limpia_filtros ()   
  cerrar_ventana_tutorial()
  permitirESC()
  permitir_camara()
  
  abrir_ventana_tutorial(700, 50, tipo_ventana_alargado, "LTEXT_TUTORIAL_NAVAL_TITULO", 
                         "LTEXT_TUTORIAL_NAVAL_2_A", "LTEXT_TUTORIAL_NAVAL_2_B", false)
                         
  --add_filtro(tipo_mensaje_ui_generico, ID_TECLA_UP   )
  --add_filtro(tipo_mensaje_ui_generico, ID_TECLA_DOWN )
  --add_filtro(tipo_mensaje_ui_generico, ID_TECLA_LEFT )
  --add_filtro(tipo_mensaje_ui_generico, ID_TECLA_RIGHT)

  on_event("tecla_camara_up",    tipo_mensaje_ui_generico, ID_TECLA_UP)
  on_event("tecla_camara_down",  tipo_mensaje_ui_generico, ID_TECLA_DOWN)
  on_event("tecla_camara_left",  tipo_mensaje_ui_generico, ID_TECLA_LEFT)
  on_event("tecla_camara_right", tipo_mensaje_ui_generico, ID_TECLA_RIGHT)
  
end

-- ---------------------- teclas camara  ------------------
function tecla_camara_up()
  tecla_UP = true
  if (tecla_UP and tecla_DOWN and tecla_LEFT and tecla_RIGHT)
  then
    temporizador(3, "step3")
  end
end

function tecla_camara_down()
  tecla_DOWN = true
  if (tecla_UP and tecla_DOWN and tecla_LEFT and tecla_RIGHT)
  then
    temporizador(3, "step3")
  end
end

function tecla_camara_left()
  tecla_LEFT = true
  if (tecla_UP and tecla_DOWN and tecla_LEFT and tecla_RIGHT)
  then
    temporizador(3, "step3")
  end
end

function tecla_camara_right()
  tecla_RIGHT = true
  if (tecla_UP and tecla_DOWN and tecla_LEFT and tecla_RIGHT)
  then
    temporizador(3, "step3")
  end
end

-- ---------------------- STEP 3 -------------------------------
function step3()
  
  limpia_eventos ()
  limpia_filtros ()   
  cerrar_ventana_tutorial()
  permitirESC()
  permitir_camara()
  
  set_camera_target(112711, 45997, 2, 0)
  
  abrir_ventana_tutorial(700, 50, tipo_ventana_alargado, "LTEXT_TUTORIAL_NAVAL_TITULO", 
                         "LTEXT_TUTORIAL_NAVAL_3_A", 
                         "LTEXT_TUTORIAL_NAVAL_3_B", true)

  add_filtro(tipo_mensaje_game_buttton_release, id_boton_ventana_tutorial)
  on_event("step4", tipo_mensaje_game_buttton_release, id_boton_ventana_tutorial)

end

-- ---------------------- STEP 4 -------------------------------
function step4()
  
  limpia_eventos ()
  limpia_filtros ()   
  cerrar_ventana_tutorial()
  permitirESC()
  permitir_camara()
  
  abrir_ventana_tutorial(700, 50, tipo_ventana_alargado, "LTEXT_TUTORIAL_NAVAL_TITULO", 
                         "LTEXT_TUTORIAL_NAVAL_4_A", 
                         "LTEXT_TUTORIAL_NAVAL_4_B", true)

  nueva_marca_grafica("MARCA_AMARILLA", 1, -13, 203, 0.4)

  -- add_filtro(tipo_mensaje_game_buttton_release, id_boton_ventana_tutorial)
  add_filtro(tipo_mensaje_ui_generico, id_boton_ventana_tutorial, MSG_MOUSE_L_RELEASE)
  add_filtro(tipo_mensaje_ui_generico, id_boton_ventana_tutorial, MSG_MOUSE_ENTER)
  add_filtro(tipo_mensaje_ui_generico, id_boton_ventana_tutorial, MSG_MOUSE_LEAVE)
  add_filtro(tipo_mensaje_ui_generico, id_boton_ventana_tutorial, MSG_KEY_UP)
  on_event("step5", tipo_mensaje_ui_generico, id_boton_ventana_tutorial, MSG_MOUSE_L_RELEASE)

end

-- ---------------------- STEP 5 -------------------------------
function step5()
  
  limpia_eventos ()
  limpia_filtros ()   
  cerrar_ventana_tutorial()
  permitirESC()
  permitir_camara()
  elimina_marca_grafica(1, 0.8) 
  
  abrir_ventana_tutorial(700, 50, tipo_ventana_alargado, "LTEXT_TUTORIAL_NAVAL_TITULO", 
                         "LTEXT_TUTORIAL_NAVAL_5_A", 
                         "LTEXT_TUTORIAL_NAVAL_5_B", true)

  add_filtro(tipo_mensaje_game_buttton_release, id_boton_ventana_tutorial)
  on_event("step6", tipo_mensaje_game_buttton_release, id_boton_ventana_tutorial)

end

-- ---------------------- STEP 6 -------------------------------
function step6()
  
  limpia_eventos ()
  limpia_filtros ()   
  cerrar_ventana_tutorial()
  permitirESC()
  permitir_camara()
  
  abrir_ventana_tutorial(700, 50, tipo_ventana_alargado, "LTEXT_TUTORIAL_NAVAL_TITULO", 
                         "LTEXT_TUTORIAL_NAVAL_6_A", 
                         "LTEXT_TUTORIAL_NAVAL_6_B", false)

  nueva_marca_grafica("MARCA_CIRCULO", 2, 492, 540, 0.5)

  add_filtro(tipo_mensaje_ui_generico, ID_BARRA_CONTROL_BARCOS)
  add_filtro(tipo_mensaje_ui_generico, ID_PANEL_ORDENES)
  add_filtro(tipo_mensaje_ui_generico, ID_ZONA_SENSIBLE_PANEL_ORDENES) 
  add_filtro(tipo_mensaje_game_buttton_release, ID_BOTON_AMMO_CHAINS)
  
  on_event("step7", tipo_mensaje_generico, MSG_NAVAL_CAMBIO_MUNICION)
  -- on_event("step7",tipo_mensaje_game_buttton_release, ID_BOTON_AMMO_CHAINS)

end

-- ---------------------- STEP 7 -------------------------------
function step7()
  
  limpia_eventos ()
  limpia_filtros ()   
  cerrar_ventana_tutorial()
  permitirESC()
  permitir_camara()
  elimina_marca_grafica(2, 0.8) 
  
  abrir_ventana_tutorial(700, 50, tipo_ventana_alargado, "LTEXT_TUTORIAL_NAVAL_TITULO", 
                         "LTEXT_TUTORIAL_NAVAL_7_A", 
                         "LTEXT_TUTORIAL_NAVAL_7_B", true)

  nueva_marca_grafica("MARCA_AMARILLA", 3, 510, 650, 0.5)

  add_filtro(tipo_mensaje_game_buttton_release, id_boton_ventana_tutorial)
  on_event("step9", tipo_mensaje_game_buttton_release, id_boton_ventana_tutorial)

end

-- ---------------------- STEP 8 -------------------------------
-- el 8 nos lo saltamos a proposito, el barco ya esta seleccionado

-- ---------------------- STEP 9 -------------------------------
function step9()
  
  limpia_eventos ()
  limpia_filtros ()   
  cerrar_ventana_tutorial()
  permitirESC()
  permitir_camara()
  elimina_marca_grafica(3, 0.8) 
  
  abrir_ventana_tutorial(700, 50, tipo_ventana_alargado, "LTEXT_TUTORIAL_NAVAL_TITULO", 
                         "LTEXT_TUTORIAL_NAVAL_9_A", 
                         "LTEXT_TUTORIAL_NAVAL_9_B", false)

  add_filtro(tipo_mensaje_ui_generico, ID_ZONA_SENSIBLE_NAVAL)
  on_event("mover_barco", tipo_mensaje_generico, MSG_NAVAL_MOVER_BARCO)

end

function mover_barco()
  limpia_eventos ()
  limpia_filtros ()   
  cerrar_ventana_tutorial()

  permitirESC()

  move_barco(0.4, 5.0)
  camera_follow_barco(0)
   
  temporizador(20, "parar_barco")
end

function parar_barco()

  stop_barco()
  temporizador(2, "step10")
end

-- ---------------------- STEP 10 -------------------------------
function step10()
   
  permitirESC()
  permitir_camara()
  abrir_ventana_tutorial(50, 50, tipo_ventana_alargado, "LTEXT_TUTORIAL_NAVAL_TITULO", 
                         "LTEXT_TUTORIAL_NAVAL_10_A", 
                         "LTEXT_TUTORIAL_NAVAL_10_B", true)

  nueva_marca_grafica("MARCA_AMARILLA", 4, 415, 610, 0.7)

  add_filtro(tipo_mensaje_game_buttton_release, id_boton_ventana_tutorial)
  on_event("step11", tipo_mensaje_game_buttton_release, id_boton_ventana_tutorial)

end

-- ---------------------- STEP 11 -------------------------------
function step11()
  
  limpia_eventos ()
  limpia_filtros ()   
  cerrar_ventana_tutorial()
  permitirESC()
  permitir_camara()
  
  elimina_marca_grafica(4, 0.8) 
 
  abrir_ventana_tutorial(50, 50, tipo_ventana_alargado, "LTEXT_TUTORIAL_NAVAL_TITULO", 
                         "LTEXT_TUTORIAL_NAVAL_11_A", 
                         "LTEXT_TUTORIAL_NAVAL_11_B", false)

  nueva_marca_grafica("MARCA_CIRCULO", 5, 510, 582, 0.6)

  add_filtro(tipo_mensaje_ui_generico, ID_BARRA_CONTROL_BARCOS)
  add_filtro(tipo_mensaje_ui_generico, ID_PANEL_ORDENES)
  add_filtro(tipo_mensaje_ui_generico, ID_ZONA_SENSIBLE_PANEL_ORDENES) 
  add_filtro(tipo_mensaje_game_buttton_release, ID_BOTON_FIRE_ESTRIBOR)

  on_event("step12", tipo_mensaje_ui_generico, ID_BOTON_FIRE_ESTRIBOR, MSG_MOUSE_L_RELEASE)
  on_event("step12", tipo_mensaje_ui_generico, ID_BOTON_FIRE_ESTRIBOR, MSG_KEY_UP)

end

-- ---------------------- STEP 12 -------------------------------
function step12()
  
  limpia_eventos ()
  limpia_filtros ()   
  cerrar_ventana_tutorial()
  permitirESC()
  permitir_camara()
  camera_follow_barco(0)
  
  abrir_ventana_tutorial(50, 50, tipo_ventana_alargado, "LTEXT_TUTORIAL_NAVAL_TITULO", 
                         "LTEXT_TUTORIAL_NAVAL_12_A", 
                         "LTEXT_TUTORIAL_NAVAL_12_B", false)

  add_filtro(tipo_mensaje_ui_generico, ID_BARRA_CONTROL_BARCOS)
  add_filtro(tipo_mensaje_ui_generico, ID_PANEL_ORDENES)
  add_filtro(tipo_mensaje_ui_generico, ID_ZONA_SENSIBLE_PANEL_ORDENES) 
  add_filtro(tipo_mensaje_game_buttton_release, ID_BOTON_FIRE_ESTRIBOR)

  on_event("step13", tipo_mensaje_generico, MSG_NAVAL_SIN_VELAS)
end

-- ---------------------- STEP 13 -------------------------------
function step13()
  
  limpia_eventos ()
  limpia_filtros ()   
  cerrar_ventana_tutorial()
  permitirESC()
  permitir_camara()
  elimina_marca_grafica(5, 0.8) 
  
  abrir_ventana_tutorial(50, 50, tipo_ventana_alargado, "LTEXT_TUTORIAL_NAVAL_TITULO", 
                         "LTEXT_TUTORIAL_NAVAL_13_A", 
                         "LTEXT_TUTORIAL_NAVAL_13_B", false)

  nueva_marca_grafica("MARCA_CIRCULO", 6, 447, 652, 0.5)

  add_filtro(tipo_mensaje_ui_generico, ID_BARRA_CONTROL_BARCOS)
  add_filtro(tipo_mensaje_ui_generico, ID_PANEL_ORDENES)
  add_filtro(tipo_mensaje_ui_generico, ID_ZONA_SENSIBLE_PANEL_ORDENES) 
  add_filtro(tipo_mensaje_game_buttton_release, ID_BOTON_ABORDAR)
  
  add_filtro(tipo_mensaje_ui_generico, ID_ZONA_SENSIBLE_NAVAL, MSG_MOUSE_L_RELEASE)

  on_event("step14", tipo_mensaje_generico, MSG_NAVAL_CAPTURADO)
end


-- ---------------------- STEP 14 -------------------------------
function step14()
  
  limpia_eventos ()
  limpia_filtros ()   
  cerrar_ventana_tutorial()
  permitirESC()
  permitir_camara()
  elimina_marca_grafica(6, 0.8) 
  
  abrir_ventana_tutorial(50, 50, tipo_ventana_alargado, "LTEXT_TUTORIAL_NAVAL_TITULO", 
                         "LTEXT_TUTORIAL_NAVAL_14_A", 
                         "LTEXT_TUTORIAL_NAVAL_14_B", true)

  add_filtro(tipo_mensaje_game_buttton_release, id_boton_ventana_tutorial)
  on_event("step16", tipo_mensaje_game_buttton_release, id_boton_ventana_tutorial)
end

-- ---------------------- STEP 15 -------------------------------
function step15()
  
  limpia_eventos ()
  limpia_filtros ()   
  cerrar_ventana_tutorial()
  permitirESC()
  permitir_camara()
  
  abrir_ventana_tutorial(50, 50, tipo_ventana_alargado, "LTEXT_TUTORIAL_NAVAL_TITULO", 
                         "LTEXT_TUTORIAL_NAVAL_15_A", 
                         "LTEXT_TUTORIAL_NAVAL_15_B", true)

  -- add_filtro(tipo_mensaje_game_buttton_release, id_boton_ventana_tutorial)
  add_filtro(tipo_mensaje_ui_generico, id_boton_ventana_tutorial, MSG_MOUSE_L_RELEASE)
  add_filtro(tipo_mensaje_ui_generico, id_boton_ventana_tutorial, MSG_MOUSE_ENTER)
  add_filtro(tipo_mensaje_ui_generico, id_boton_ventana_tutorial, MSG_MOUSE_LEAVE)
  add_filtro(tipo_mensaje_ui_generico, id_boton_ventana_tutorial, MSG_KEY_UP)
  on_event("step16", tipo_mensaje_ui_generico, id_boton_ventana_tutorial, MSG_MOUSE_L_RELEASE)
  
end

-- ---------------------- STEP 16 -------------------------------
function step16()
  
  limpia_eventos ()
  limpia_filtros ()   
  cerrar_ventana_tutorial()
  permitirESC()
  permitir_camara()
  
  abrir_ventana_tutorial(50, 50, tipo_ventana_alargado, "LTEXT_TUTORIAL_NAVAL_TITULO", 
                         "LTEXT_TUTORIAL_NAVAL_16_A", 
                         "LTEXT_TUTORIAL_NAVAL_16_B", true)

  add_filtro(tipo_mensaje_game_buttton_release, id_boton_ventana_tutorial)
  on_event("final", tipo_mensaje_game_buttton_release, id_boton_ventana_tutorial)
   
end

-- ---------------------- FINAL -------------------------------
function step16()

  elimina_todas_marcas(1.0)
  cerrar_ventana_tutorial()
  limpia_filtros ()   
  filtrar_todos(false)
  
  -- finaliza_secuencia()
  -- exit_to_main_menu()
   
  id_ventana_confirmacion_fin_tutorial = 1234

  open_messagebox (id_ventana_confirmacion_fin_tutorial, "LTEXT_TUTORIAL_FINAL_TODOS_TITULO", "LTEXT_TUTORIAL_FINAL_SOLONAVAL_TEXTO", TMB_NORMAL, "LTEXT_TUTORIAL_FINAL_TODOS_MENUTUTORIAL") 
  on_event("salir_borrando_marcas",tipo_mensaje_messagebox_close, id_ventana_confirmacion_fin_tutorial, 0)
  
end

function salir_borrando_marcas()

	elimina_todas_marcas(0)
	exit_to_main_menu();

end