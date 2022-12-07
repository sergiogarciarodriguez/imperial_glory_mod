-- Secuencia 27: Seleccionar Polonia (click derecho) -> nueva_marca_grafica_3D("MARCA_FLECHA3DROJA", 1, 9000, 210, 7500, 2.5, true)
-- Secuencia 14: Mover oficial -> marca en izhora, marca amarilla en cuartel
-- Secuencia 20: Mover tropas -> marca amarilla en cuartel
-- Secuencia 40: Modo comercial -> marca amarilla en ruta activada
-- marca galicia y marca kiev


-- --------------------------------------------
-- función principal de la secuencia.
-- se llamará al ejecutar la secuencia definida
-- por el script, y debera llamar la función
-- que inicia la primera secuencia
-- Pero que tío más de puta madre el que haya hecho este tutorialazo
-- --------------------------------------------

-- add_filtro(tipo_mensaje_ui_generico, id_boton_ventana_tutorial)
-- on_event("secuencia2", tipo_mensaje_game_buttton_release, id_boton_ventana_tutorial) -- CONTINUAR
-- MSG_MOUSE_ENTER
-- MSG_MOUSE_LEAVE
-- MSG_MOUSE_L_CLICK

numero_teclas_pulsadas = 0

  id_boton_construir = 1111704900
  id_boton_tropas = 1111708754
  id_boton_cerrar_construccion = 1163413844
  id_boton_pasar_turno = 1112560725
  id_boton_abrir_arbol = 1347241800
  id_boton_modo_comercial = 1111835471
  id_gestor_botones_modos_mapa = 1195527503
  id_boton_abrir_diplomacia = 1347241796
  id_boton_alianza_defensiva = 1128419410
  id_gestor_controles_diplomacia = 1196442450
  id_panel_construcciones = 1346588494
  id_panel_mandos = 1296125508
  id_panel_infanteria = 1229866561
  id_boton_cerrar_tropas = 1163413844
  id_boton_cerrar_info_provincia = 1163413844 -- 'EXIT'
  id_boton_cerrar_arbol = 129
  id_boton_cerrar_diplomacia = 129
  id_boton_ok = 128
  id_visor_construcciones = 1448104527
  id_dlg_produccion_edificios = 1146111300
  id_dlg_produccion_efectivos = 1146115154
  id_dlg_informacion_provincia = 1145850192 -- 'DLIP'
  id_notificacion_peque = 1129141058
  id_notificacion_grande = 1129136711
  id_notificacion_gigante = 1129136728
  id_ventana_tecnologias  = 1449083220
  id_ventana_diplomacia	= 1449083984 -- 'V_DP'
  ZONA_MAPA              = 1515012432
  IDX_COMERCIO_INTERNACIONAL = 6
  VISOR_DLGCONTENIDOPOLITICOMILITAR = 1145262157
  ID_MAPA_DIPLOMACIA = 1296126032 -- 'MAPP'
  ID_GESTOR_PROPUESTA = 1195593810 -- 'GCPR'
  ID_BOTON_ENVIAR_DIPLOMACIA = 1112819022 -- 'BTEN'
  ID_NOTIFICACION_DIPLOMACIA = 1146244420 -- 'DRMD'
  
  ID_GESTOR_CHECKBOX_EFECTIVOS = 1197425474 --'G_CB'  
    
  ID_TECLA_SCROLL_DCHA                   = 1413760338 --'TDER';
  ID_TECLA_SCROLL_IZQ                    = 1414093393 --'TIZQ';
  ID_TECLA_SCROLL_FONDO                  = 1414747458 -- 'TSUB';
  ID_TECLA_SCROLL_PRINCIPIO              = 1413562945 --'TABA';
  ID_TECLA_ESCAPE_GESTION                = 1195725635 -- 'GESC'
  ID_BOTON_ESCAPE_GESTION				 = 1111839555 -- 'BESC'


tempz1 = 6

-- ALTO Y ANCHO DE PANTALLA
width = 1024;
height = 768;

-- POSICION DEL BOTON DE TECNOLOGIAS
btnTecnologiasX = width - 58
btnTecnologiasY = height - 122

-- POSICION DEL BOTON DE COMERCIO INTERNACIONAL
btnTechComercioX = 50
btnTechComercioY = height - 260

-- POSICION DEL BOTON DE CERRAR ARBOL
btnCerrarArbolX = width - 72
btnCerrarArbolY = height - 70

-- POSICION DEL BOTON DE CONSTRUCCIONES
btnConstruirX = 6
btnConstruirY = height - 73

-- POSICION DEL BOTON DE CUARTEL
btnCuartelX = 180
btnCuartelY = 175

-- POSICION DEL BOTON DE CERRAR VENTANA DE CONSTRUCCIONES
btnCerrarConstruccionesX = width - 181
btnCerrarConstruccionesY = height - 173

-- POSICION DEL BOTON DE SIGUIENTE TURNO
btnNextTurnX = width - 140
btnNextTurnY = height - 100

-- POSICION DEL BOTON DE ALIANZA DEFENSIVA
btnAlianzaX = 10
btnAlianzaY = height/2 + 20

-- POSICION DEL BOTON DE MODO COMERCIAL
btnComercialModeX = 0
btnComercialModeY = height - 160

-- POSICION DEL BOTON DE MODO MILITAR
btnMilitarModeX = 40
btnMilitarModeY = height - 175

-- POSICION DE LA PESTAÑA COMANDANTES
btnCommandersX = width - 420
btnCommandersY = 125

function inicia_secuencia()
  -- lanzamos la primera secuencia:
  elimina_todas_marcas(1)
  cerrar_ventana_tutorial()
  filtrar_todos(true)
  
  -- llamar a esta funcion despues de filtrar_todos(true) en los pasos en los que se permita salir del tutorial
  --	NOTA: la ventana de salir del tutorial solo saldra el los casos donde sale el menu en el juego habitual
  permite_menu_escape()
  
  -- ponEventoTeclaEscape()
  
  secuencia1()
  --hordaRusa()

end

-----------------------------------------
-- PERMITE MOVIMIENTO DE CAMARA Y ZOOM --
-----------------------------------------
function permitir_camara()

  add_filtro(tipo_mensaje_ui_generico,ID_TECLA_SCROLL_DCHA)
  add_filtro(tipo_mensaje_ui_generico,ID_TECLA_SCROLL_IZQ)
  add_filtro(tipo_mensaje_ui_generico,ID_TECLA_SCROLL_FONDO)
  add_filtro(tipo_mensaje_ui_generico,ID_TECLA_SCROLL_PRINCIPIO)
  add_filtro(tipo_mensaje_ui_generico,ZONA_MAPA, MSG_MOUSE_WHEEL)
  
  add_filtro(tipo_mensaje_ui_generico,ZONA_MAPA, MSG_MOUSE_M_RELEASE)
  add_filtro(tipo_mensaje_ui_generico,ZONA_MAPA, MSG_MOUSE_M_DRAG)
  add_filtro(tipo_mensaje_ui_generico,ZONA_MAPA, MSG_MOUSE_MOVE)

end


-----------------------------
-- CREA UNA HORDA DE RUSOS --
-----------------------------
function hordaRusa()

  filtrar_todos(false)
  for i = 0, 200 , 1 do
	idEfectivoRuso4 = crea_ficha(TAM_EJERCITO,"KIEV","TENIENTE","FUSILERO","FUSILERO","MILICIA")
	idEfectivoRuso4 = crea_ficha(TAM_EJERCITO,"KURKS","TENIENTE","FUSILERO","FUSILERO","MILICIA")
	idEfectivoRuso4 = crea_ficha(TAM_EJERCITO,"MINSK","TENIENTE","FUSILERO","FUSILERO","MILICIA")
  end
  
end

-------------------------
-- INDICE DEL TUTORIAL --
-------------------------
function secuencia1()

  destruye_elementos(TAM_EJERCITO)
  destruye_elementos(TAM_FLOTA)
  elimina_todas_marcas(1)
  -- esto es necesario para que se pueda poner en proteccion mutua paises que no queremos que
  -- aparezcan en la ventana de diplomacia al seleccionar pactos de proteccion mutua
  set_max_jugadores_proteccion_mutua(6)
  
  -- esto es necesario para que en el tutorial nunca se quede sin recursos suficientes para construir los edificios y tropas
  -- dinero, comida, materias primas, poblacion
  ingresa_recursos_en_jugador_local(1000, 0, 0, 0)
  
  crea_proteccion_mutua_entre( "JUG_RUSIA", "JUG_OTOMANO" , 18)
  crea_proteccion_mutua_entre( "JUG_RUSIA", "JUG_SUECIA", 18)
  
  set_provincia_seleccionada ( "LETONIA" )

  abrir_ventana_tutorial(710, 90, tipo_ventana_alargado, "LTEXT_TUTORIAL_GENERICO_TITULO", "LTEXT_TUTORIAL_GESTION_1_A","LTEXT_TUTORIAL_GESTION_0_B", true)
  add_filtro(tipo_mensaje_ui_generico, id_boton_ventana_tutorial)
  on_event("secuencia2", tipo_mensaje_game_buttton_release, id_boton_ventana_tutorial) -- CONTINUAR
  
end

----------------
-- BIENVENIDA --
----------------
function secuencia2()

  limpia_eventos()
  limpia_filtros()
  filtrar_todos(true)
  
  -- llamar a esta funcion despues de filtrar_todos(true) en los pasos en los que se permita salir del tutorial
  --	NOTA: la ventana de salir del tutorial solo saldra el los casos donde sale el menu en el juego habitual
  permite_menu_escape()
  
  cerrar_ventana_tutorial()
  abrir_ventana_tutorial(710, 90, tipo_ventana_alargado, "LTEXT_TUTORIAL_GESTION_TITULO", "LTEXT_TUTORIAL_GESTION_0_A","LTEXT_TUTORIAL_GESTION_1_B", true)
  --para que no se salte esta ventana al pulsar sobre la otra
  add_filtro(tipo_mensaje_ui_generico, id_boton_ventana_tutorial, MSG_MOUSE_L_RELEASE)
  add_filtro(tipo_mensaje_ui_generico, id_boton_ventana_tutorial, MSG_MOUSE_ENTER)
  add_filtro(tipo_mensaje_ui_generico, id_boton_ventana_tutorial, MSG_MOUSE_LEAVE)
  add_filtro(tipo_mensaje_ui_generico, id_boton_ventana_tutorial, MSG_KEY_UP)
  add_filtro(tipo_mensaje_ui_generico, id_boton_ventana_tutorial, MSG_KEY_UP)
  on_event("secuencia3", tipo_mensaje_ui_generico, id_boton_ventana_tutorial, MSG_MOUSE_L_RELEASE)  
  
end

--------------------------
-- MOVIMIENTO DE CAMARA --
--------------------------
function secuencia3()

  limpia_eventos()
  limpia_filtros()
  filtrar_todos(true)
  -- llamar a esta funcion despues de filtrar_todos(true) en los pasos en los que se permita salir del tutorial
  --	NOTA: la ventana de salir del tutorial solo saldra el los casos donde sale el menu en el juego habitual
  permite_menu_escape()

  cerrar_ventana_tutorial()
  
  permitir_camara()
  
  on_event("contador_teclas", tipo_mensaje_ui_generico,ID_TECLA_SCROLL_DCHA, MSG_KEY_UP)
  on_event("contador_teclas", tipo_mensaje_ui_generico,ID_TECLA_SCROLL_IZQ, MSG_KEY_UP)
  on_event("contador_teclas", tipo_mensaje_ui_generico,ID_TECLA_SCROLL_FONDO, MSG_KEY_UP)
  on_event("contador_teclas", tipo_mensaje_ui_generico,ID_TECLA_SCROLL_PRINCIPIO, MSG_KEY_UP)  
  
  abrir_ventana_tutorial(width/2-250, height/2-300, tipo_ventana_normal, "LTEXT_TUTORIAL_GESTION_TITULO", "LTEXT_TUTORIAL_GESTION_2_A","LTEXT_TUTORIAL_GESTION_2_B", false)
  
end

-----------------------------
-- MOVIMIENTO DE CAMARA II --
-----------------------------
function contador_teclas()
  numero_teclas_pulsadas = numero_teclas_pulsadas + 1
  if numero_teclas_pulsadas >= 4 then
      -- elimina los eventos del escape
      limpia_eventos()
      temporizador ( 1 , "secuencia4" ) -- MOVER CAMARA
    numero_teclas_pulsadas = 0
  end

end

-------------------------
-- CAPITAL DEL IMPERIO --
-------------------------
function secuencia4()

  limpia_eventos()
  limpia_filtros()
  filtrar_todos(true)
  -- llamar a esta funcion despues de filtrar_todos(true) en los pasos en los que se permita salir del tutorial
  --	NOTA: la ventana de salir del tutorial solo saldra el los casos donde sale el menu en el juego habitual
  permite_menu_escape()
  permitir_camara()

  elimina_todas_marcas(1.0)  
  --set_camera_target ( 11600, 11200, 0)
  --set_camera_zoom ( CAMARA_RESET_ZOOM )
  set_target_and_zoom(11600, 11200, 0, 0)  
  cerrar_ventana_tutorial()
  abrir_ventana_tutorial(710, 90, tipo_ventana_alargado, "LTEXT_TUTORIAL_GESTION_TITULO", "LTEXT_TUTORIAL_GESTION_3_A","LTEXT_TUTORIAL_GESTION_3_B", true)
  set_provincia_seleccionada ( "LETONIA" )
  add_filtro(tipo_mensaje_ui_generico, id_boton_ventana_tutorial)
  on_event("secuencia5", tipo_mensaje_game_buttton_release, id_boton_ventana_tutorial) -- CONTINUAR
    
end

-----------------
-- EDIFICIOS I --
-----------------
function secuencia5()

  limpia_eventos()
  limpia_filtros()
  filtrar_todos(true)
  -- llamar a esta funcion despues de filtrar_todos(true) en los pasos en los que se permita salir del tutorial
  --	NOTA: la ventana de salir del tutorial solo saldra el los casos donde sale el menu en el juego habitual
  permite_menu_escape()
  permitir_camara()

  set_provincia_seleccionada ( "LETONIA" ) 
  cerrar_ventana_tutorial()
  abrir_ventana_tutorial(710, 90, tipo_ventana_alargado, "LTEXT_TUTORIAL_GESTION_TITULO", "LTEXT_TUTORIAL_GESTION_4_A","LTEXT_TUTORIAL_GESTION_4_B", false)
  nueva_marca_grafica ("MARCA_CIRCULO", 1, btnConstruirX, btnConstruirY, 0.4)
  add_filtro(tipo_mensaje_ui_generico, id_boton_construir)
  add_filtro(tipo_mensaje_ui_generico, id_panel_construcciones, MSG_GAME_PANEL_CONSTRUCCIONES_OPEN_DLG_PRODUCCION)
  on_event("secuencia6", tipo_mensaje_game_buttton_release, id_boton_construir, MSG_MOUSE_L_RELEASE) -- ABRIR VENTANA CONSTRUCCION
  
end

------------------
-- EDIFICIOS II --
------------------
function secuencia6()

  limpia_eventos()
  limpia_filtros()
  filtrar_todos(true)
  -- llamar a esta funcion despues de filtrar_todos(true) en los pasos en los que se permita salir del tutorial
  --	NOTA: la ventana de salir del tutorial solo saldra el los casos donde sale el menu en el juego habitual
  permite_menu_escape()
  permitir_camara()

  add_filtro(tipo_mensaje_ui_generico, id_boton_construir)
  add_filtro(tipo_mensaje_ui_generico, id_panel_construcciones, MSG_GAME_PANEL_CONSTRUCCIONES_OPEN_DLG_PRODUCCION)
  elimina_todas_marcas(1)
  cerrar_ventana_tutorial()
  abrir_ventana_tutorial(710, 90, tipo_ventana_alargado, "LTEXT_TUTORIAL_GESTION_TITULO", "LTEXT_TUTORIAL_GESTION_5_A","LTEXT_TUTORIAL_GESTION_5_B", false)
  nueva_marca_grafica ("MARCA_CIRCULO", 1, btnCuartelX, btnCuartelY, 0.4)
  add_filtro(tipo_mensaje_ui_generico, id_visor_construcciones)
  add_filtro(tipo_mensaje_ui_generico, id_dlg_produccion_edificios, MSG_GAME_DLG_PRODUCCION_ON_PRODUCCION_EDIFICIO)
  on_event("secuencia7", tipo_mensaje_ui_generico,id_dlg_produccion_edificios, MSG_GAME_DLG_PRODUCCION_ON_PRODUCCION_EDIFICIO)
  
end

-------------------
-- EDIFICIOS III --
-------------------
function secuencia7()

  limpia_eventos()
  limpia_filtros()
  add_filtro(tipo_mensaje_ui_generico, id_dlg_produccion_edificios, MSG_GAME_DLG_PRODUCCION_ON_PRODUCCION_EDIFICIO)
  filtrar_todos(true)
  -- llamar a esta funcion despues de filtrar_todos(true) en los pasos en los que se permita salir del tutorial
  --	NOTA: la ventana de salir del tutorial solo saldra el los casos donde sale el menu en el juego habitual
  permite_menu_escape()
  permitir_camara()

  elimina_todas_marcas(1)
  cerrar_ventana_tutorial()
  abrir_ventana_tutorial(width/2-20, height/2-250, tipo_ventana_normal, "LTEXT_TUTORIAL_GESTION_TITULO", "LTEXT_TUTORIAL_GESTION_6_A","LTEXT_TUTORIAL_GESTION_6_B", false)
  nueva_marca_grafica ("MARCA_CIRCULO", 1, btnCerrarConstruccionesX, btnCerrarConstruccionesY, 0.3)
  
  add_filtro(tipo_mensaje_ui_generico, id_boton_cerrar_construccion)
  
  add_filtro(tipo_mensaje_ui_generico, id_dlg_produccion_edificios, MSG_GAME_CLOSE_DIALOGO)
  on_event("secuencia8", tipo_mensaje_ui_generico, id_dlg_produccion_edificios, MSG_GAME_CLOSE_DIALOGO) -- CERRAR VENTANA CONSTRUCCION
  
end

-----------------
-- PASAR TURNO --
-----------------
function secuencia8()

  limpia_eventos()
  limpia_filtros()
  filtrar_todos(true)
  -- llamar a esta funcion despues de filtrar_todos(true) en los pasos en los que se permita salir del tutorial
  --	NOTA: la ventana de salir del tutorial solo saldra el los casos donde sale el menu en el juego habitual
  permite_menu_escape()
  permitir_camara()

  elimina_todas_marcas(1)
  cerrar_ventana_tutorial()
  abrir_ventana_tutorial(710, 90, tipo_ventana_alargado, "LTEXT_TUTORIAL_GESTION_TITULO", "LTEXT_TUTORIAL_GESTION_7_A","LTEXT_TUTORIAL_GESTION_7_B", false)
  nueva_marca_grafica ("MARCA_CIRCULO", 1, btnNextTurnX, btnNextTurnY, 0.55)

  add_filtro(tipo_mensaje_ui_generico, id_boton_pasar_turno)
  on_event("secuencia8b", tipo_mensaje_game_buttton_release, id_boton_pasar_turno) -- PASAR TURNO
  
end

-------------------
-- PASO DE TURNO --
-------------------
function secuencia8b()


  limpia_eventos()
  elimina_todas_marcas(1)
  cerrar_ventana_tutorial()
  abrir_ventana_tutorial(width/2-250, height/2-300, tipo_ventana_normal, "LTEXT_TUTORIAL_GESTION_TITULO", "LTEXT_TUTORIAL_PASO_TURNO_A","LTEXT_TUTORIAL_PASO_TURNO_B", false)
  on_event("secuencia8c",tipo_mensaje_generico, MSG_GESTION_INICIO_TURNO) -- NUEVO TURNO
  
end

----------------------
-- PASO DE TURNO II --
----------------------
function secuencia8c()

  elimina_todas_marcas(1)
  cerrar_ventana_tutorial()
  
  -- si se sabe que tipo de notificacion es se podrian quitar algunos
  add_filtro(tipo_mensaje_ui_generico, id_notificacion_peque)  
  add_filtro(tipo_mensaje_ui_generico, id_notificacion_grande)  
  add_filtro(tipo_mensaje_ui_generico, id_notificacion_gigante)  
  
  add_filtro(tipo_mensaje_ui_generico, id_boton_ok)
  
  on_event("secuencia9", tipo_mensaje_ui_generico, id_notificacion_peque, MSG_GAME_CLOSE_DIALOGO) -- CERRAR VENTANA CONSTRUCCION
  on_event("secuencia9", tipo_mensaje_ui_generico, id_notificacion_grande, MSG_GAME_CLOSE_DIALOGO) -- CERRAR VENTANA CONSTRUCCION
  on_event("secuencia9", tipo_mensaje_ui_generico, id_notificacion_gigante, MSG_GAME_CLOSE_DIALOGO) -- CERRAR VENTANA CONSTRUCCION
  
end

------------------------------
-- CONSTRUCCION DE MANDOS I --
------------------------------
function secuencia9()

  limpia_eventos()
  limpia_filtros()
  filtrar_todos(true)
  -- llamar a esta funcion despues de filtrar_todos(true) en los pasos en los que se permita salir del tutorial
  --	NOTA: la ventana de salir del tutorial solo saldra el los casos donde sale el menu en el juego habitual
  permite_menu_escape()
  permitir_camara()

  set_provincia_seleccionada ( "LETONIA" )  
  elimina_todas_marcas(1)
  cerrar_ventana_tutorial()
  abrir_ventana_tutorial(width/2-250, height/2-300, tipo_ventana_normal, "LTEXT_TUTORIAL_GESTION_TITULO", "LTEXT_TUTORIAL_GESTION_8_A","LTEXT_TUTORIAL_GESTION_8_B", false)
  nueva_marca_grafica ("MARCA_CIRCULO", 1, btnConstruirX + 15, btnConstruirY - 25, 0.35)
  
  add_filtro(tipo_mensaje_ui_generico, id_boton_tropas)
  add_filtro(tipo_mensaje_ui_generico, id_panel_construcciones, MSG_GAME_PANEL_CONSTRUCCIONES_OPEN_DLG_PRODUCCION)
  on_event("secuencia10", tipo_mensaje_game_buttton_release, id_boton_tropas, MSG_MOUSE_L_RELEASE) -- ABRIR VENTANA TROPAS
    
end

-------------------------------
-- CONSTRUCCION DE MANDOS II --
-------------------------------
function secuencia10()

  limpia_eventos()
  limpia_filtros()
  filtrar_todos(true)
  -- llamar a esta funcion despues de filtrar_todos(true) en los pasos en los que se permita salir del tutorial
  --	NOTA: la ventana de salir del tutorial solo saldra el los casos donde sale el menu en el juego habitual
  permite_menu_escape()
  permitir_camara()

  add_filtro(tipo_mensaje_ui_generico, id_boton_tropas)
  add_filtro(tipo_mensaje_ui_generico, id_panel_construcciones, MSG_GAME_PANEL_CONSTRUCCIONES_OPEN_DLG_PRODUCCION)
  
  elimina_todas_marcas(1)
  cerrar_ventana_tutorial()
  abrir_ventana_tutorial(710, 90, tipo_ventana_alargado, "LTEXT_TUTORIAL_GESTION_TITULO", "LTEXT_TUTORIAL_GESTION_9_A","LTEXT_TUTORIAL_GESTION_9_B", false)
  nueva_marca_grafica ("MARCA_CIRCULO", 1, btnCommandersX, btnCommandersY, 0.5)

  add_filtro(tipo_mensaje_ui_generico, id_panel_mandos)
  add_filtro(tipo_mensaje_ui_generico, ID_GESTOR_CHECKBOX_EFECTIVOS  )
  on_event("secuencia11", tipo_mensaje_checkbox_pushed, id_panel_mandos) -- MODO COMERCIAL
  
end

--------------------------------
-- CONSTRUCCION DE MANDOS III --
--------------------------------
function secuencia11()

  limpia_eventos()
  limpia_filtros()
  filtrar_todos(true)
  -- llamar a esta funcion despues de filtrar_todos(true) en los pasos en los que se permita salir del tutorial
  --	NOTA: la ventana de salir del tutorial solo saldra el los casos donde sale el menu en el juego habitual
  permite_menu_escape()
  permitir_camara()

  elimina_todas_marcas(1)
  cerrar_ventana_tutorial()
  abrir_ventana_tutorial(width/2-50, height/2-300, tipo_ventana_normal, "LTEXT_TUTORIAL_GESTION_TITULO", "LTEXT_TUTORIAL_GESTION_10_A","LTEXT_TUTORIAL_GESTION_10_B", false)
  nueva_marca_grafica ("MARCA_CIRCULO", 1, btnCuartelX - 42, btnCuartelY + 10, 0.6)
  
  add_filtro(tipo_mensaje_ui_generico, id_visor_construcciones)
  add_filtro(tipo_mensaje_ui_generico, id_dlg_produccion_efectivos, MSG_GAME_DLG_PRODUCCION_ON_PRODUCCION_TROPA)
  on_event("secuencia12", tipo_mensaje_ui_generico,id_dlg_produccion_efectivos, MSG_GAME_DLG_PRODUCCION_ON_PRODUCCION_TROPA)
 
end

-------------------------------
-- CONSTRUCCION DE MANDOS IV --
-------------------------------
function secuencia12()

  limpia_eventos()
  limpia_filtros()
  filtrar_todos(true)
  -- llamar a esta funcion despues de filtrar_todos(true) en los pasos en los que se permita salir del tutorial
  --	NOTA: la ventana de salir del tutorial solo saldra el los casos donde sale el menu en el juego habitual
  permite_menu_escape()
  permitir_camara()

  add_filtro(tipo_mensaje_ui_generico, id_dlg_produccion_efectivos, MSG_GAME_DLG_PRODUCCION_ON_PRODUCCION_TROPA)
  elimina_todas_marcas(1)
  cerrar_ventana_tutorial()
  abrir_ventana_tutorial(width/2-250, height/2-300, tipo_ventana_normal, "LTEXT_TUTORIAL_GESTION_TITULO", "LTEXT_TUTORIAL_GESTION_11_A","LTEXT_TUTORIAL_GESTION_11_B", false)
  nueva_marca_grafica ("MARCA_CIRCULO", 1, btnCerrarConstruccionesX - 8, btnCerrarConstruccionesY + 6, 0.3)
  
  add_filtro(tipo_mensaje_ui_generico, id_boton_cerrar_tropas)
  add_filtro(tipo_mensaje_ui_generico, id_dlg_produccion_efectivos, MSG_GAME_CLOSE_DIALOGO)
  on_event("secuencia13", tipo_mensaje_ui_generico, id_dlg_produccion_efectivos, MSG_GAME_CLOSE_DIALOGO) -- CERRAR VENTANA DE ENTRENAMIENTO
  
  
end

-----------------
-- PASAR TURNO --
-----------------
function secuencia13()

  limpia_eventos()
  limpia_filtros()
  filtrar_todos(true)
  -- llamar a esta funcion despues de filtrar_todos(true) en los pasos en los que se permita salir del tutorial
  --	NOTA: la ventana de salir del tutorial solo saldra el los casos donde sale el menu en el juego habitual
  permite_menu_escape()
  permitir_camara()

  add_filtro(tipo_mensaje_ui_generico, id_boton_cerrar_tropas)
  elimina_todas_marcas(1)
  cerrar_ventana_tutorial()
  abrir_ventana_tutorial(width/2-250, height/2-300, tipo_ventana_normal, "LTEXT_TUTORIAL_GESTION_TITULO", "LTEXT_TUTORIAL_GESTION_12_A","LTEXT_TUTORIAL_GESTION_12_B", false)
  nueva_marca_grafica ("MARCA_CIRCULO", 1, btnNextTurnX, btnNextTurnY, 0.55)
  
  add_filtro(tipo_mensaje_ui_generico, id_boton_pasar_turno)
  on_event("secuencia13b", tipo_mensaje_game_buttton_release, id_boton_pasar_turno) -- PASAR TURNO
  
end

-------------------
-- PASO DE TURNO --
-------------------
function secuencia13b()

  limpia_eventos()
  limpia_filtros()
  filtrar_todos(false)
  elimina_todas_marcas(1)
  cerrar_ventana_tutorial()
  abrir_ventana_tutorial(width/2-250, height/2-300, tipo_ventana_normal, "LTEXT_TUTORIAL_GESTION_TITULO", "LTEXT_TUTORIAL_PASO_TURNO_A","LTEXT_TUTORIAL_PASO_TURNO_B", false)
  on_event("secuencia13c",tipo_mensaje_generico, MSG_GESTION_INICIO_TURNO) -- NUEVO TURNO
    
end

----------------------
-- PASO DE TURNO II --
----------------------
function secuencia13c()

  elimina_todas_marcas(1)
  cerrar_ventana_tutorial()
  
  -- si se sabe que tipo de notificacion es se podrian quitar algunos
  add_filtro(tipo_mensaje_ui_generico, id_notificacion_peque)  
  add_filtro(tipo_mensaje_ui_generico, id_notificacion_grande)  
  add_filtro(tipo_mensaje_ui_generico, id_notificacion_gigante)  
  
  add_filtro(tipo_mensaje_ui_generico, id_boton_ok)
  
  -- OK.CONSTRUCCION DE LA TROPA
  on_event("secuencia14", tipo_mensaje_ui_generico, id_notificacion_peque, MSG_GAME_CLOSE_DIALOGO) 
  on_event("secuencia14", tipo_mensaje_ui_generico, id_notificacion_grande, MSG_GAME_CLOSE_DIALOGO) 
  on_event("secuencia14", tipo_mensaje_ui_generico, id_notificacion_gigante, MSG_GAME_CLOSE_DIALOGO)
  
  
end

-------------------
-- MOVER OFICIAL --
-------------------
function secuencia14()

  limpia_eventos()
  limpia_filtros()
  filtrar_todos(true)
  -- llamar a esta funcion despues de filtrar_todos(true) en los pasos en los que se permita salir del tutorial
  --	NOTA: la ventana de salir del tutorial solo saldra el los casos donde sale el menu en el juego habitual
  permite_menu_escape()
  permitir_camara()
 
  add_filtro(tipo_mensaje_ui_generico,ZONA_MAPA, MSG_MOUSE_MOVE)  
  add_filtro(tipo_mensaje_ui_generico,ZONA_MAPA, MSG_MOUSE_L_RELEASE)  
  add_filtro(tipo_mensaje_ui_generico,ZONA_MAPA, MSG_MOUSE_L_DRAG)  
  
  -- filtros para los visores de matriz implicados de controles relacionados con el arrastre de tropas/barcos
  add_filtro(tipo_mensaje_ui_generico, VISOR_DLGCONTENIDOPOLITICOMILITAR, MSG_GAME_DLGCONTENIDO_POLITICOMILITAR_BEGIN_DRAG)
  add_filtro(tipo_mensaje_ui_generico, VISOR_DLGCONTENIDOPOLITICOMILITAR, MSG_GAME_DLGCONTENIDO_POLITICOMILITAR_END_DRAG)
  
  nueva_marca_grafica ("MARCA_CIRCULO", 1, 170, 610, 0.7)
  nueva_marca_grafica_3D("MARCA_FLECHA3DROJA", 1, 10900, 210, 9700, 2.5, true)
  nueva_marca_grafica_3D("MARCA_FLECHA3DAMARILLA", 2, 11300, 200, 9870, 1.5, true)
  
  add_filtro(tipo_mensaje_generico, MSG_GAME_DLGCONTENIDO_POLITICOMILITAR_BEGIN_DRAG)
  -- id del mensaje, id de la cosa que se termina de arrastrar, tipo de la cosa que se termina de arrastrar, id de la cosa sobre la que se arrastra, tipo de la cosa sobre la que se arrastra
  add_filtro(tipo_mensaje_generico, MSG_GAME_DLGCONTENIDO_POLITICOMILITAR_END_DRAG)
      
  cerrar_ventana_tutorial()
  selecciona_edificio(MIC_CUARTEL,"LETONIA")
  
  abrir_ventana_tutorial(710, 90, tipo_ventana_alargado, "LTEXT_TUTORIAL_GESTION_TITULO", "LTEXT_TUTORIAL_GESTION_13_A","LTEXT_TUTORIAL_GESTION_13_B", false)
  on_event("secuencia15",tipo_mensaje_generico, MSG_GESTION_DESACUARTELAMIENTO)
  
end

------------------------------
-- CONSTRUCCION DE TROPAS I --
------------------------------
function secuencia15()

  idTropaInicial = ultimo_id_ejercito_desacuartelado
  limpia_eventos()
  limpia_filtros()
  filtrar_todos(true)
  elimina_todas_marcas(1)
  
  -- llamar a esta funcion despues de filtrar_todos(true) en los pasos en los que se permita salir del tutorial
  --	NOTA: la ventana de salir del tutorial solo saldra el los casos donde sale el menu en el juego habitual
  permite_menu_escape()
  permitir_camara()
  
  set_provincia_seleccionada ( "LETONIA" )   

  cerrar_ventana_tutorial()
  abrir_ventana_tutorial(width/2, height/2-300, tipo_ventana_grande, "LTEXT_TUTORIAL_GESTION_TITULO", "LTEXT_TUTORIAL_GESTION_14_A","LTEXT_TUTORIAL_GESTION_14_B", false)
  nueva_marca_grafica ("MARCA_CIRCULO", 1, btnConstruirX + 15, btnConstruirY - 25, 0.35)

  add_filtro(tipo_mensaje_ui_generico, id_boton_tropas)
  add_filtro(tipo_mensaje_ui_generico, id_panel_construcciones, MSG_GAME_PANEL_CONSTRUCCIONES_OPEN_DLG_PRODUCCION)
  on_event("secuencia15b", tipo_mensaje_game_buttton_release, id_boton_tropas, MSG_MOUSE_L_RELEASE) -- VENTANA DE ENTRENAMIENTO DE TROPAS
     
end

-------------------------------
-- CONSTRUCCION DE MILICIA II --
-------------------------------
function secuencia15b()

  limpia_eventos()
  limpia_filtros()
  filtrar_todos(true)
  -- llamar a esta funcion despues de filtrar_todos(true) en los pasos en los que se permita salir del tutorial
  --	NOTA: la ventana de salir del tutorial solo saldra el los casos donde sale el menu en el juego habitual
  permite_menu_escape()
  permitir_camara()

  add_filtro(tipo_mensaje_ui_generico, id_boton_tropas)
  add_filtro(tipo_mensaje_ui_generico, id_panel_construcciones, MSG_GAME_PANEL_CONSTRUCCIONES_OPEN_DLG_PRODUCCION)
  
  elimina_todas_marcas(1)
  cerrar_ventana_tutorial()
  abrir_ventana_tutorial(710, 90, tipo_ventana_alargado, "LTEXT_TUTORIAL_GESTION_TITULO", "LTEXT_TUTORIAL_GESTION_14_C","LTEXT_TUTORIAL_GESTION_14_D", false)
  nueva_marca_grafica ("MARCA_CIRCULO", 1, btnCommandersX-480, btnCommandersY, 0.5)
  
  add_filtro(tipo_mensaje_ui_generico, id_panel_infanteria)
  add_filtro(tipo_mensaje_ui_generico, ID_GESTOR_CHECKBOX_EFECTIVOS  )
  on_event("secuencia16", tipo_mensaje_checkbox_pushed, id_panel_infanteria)
  
    
end
-------------------------------
-- CONSTRUCCION DE TROPAS II --
-------------------------------
function secuencia16()

  limpia_eventos()
  limpia_filtros()
  filtrar_todos(true)
  -- llamar a esta funcion despues de filtrar_todos(true) en los pasos en los que se permita salir del tutorial
  --	NOTA: la ventana de salir del tutorial solo saldra el los casos donde sale el menu en el juego habitual
  --permite_menu_escape()

  elimina_todas_marcas(1)
  cerrar_ventana_tutorial()
  
  abrir_ventana_tutorial(710, 90, tipo_ventana_alargado, "LTEXT_TUTORIAL_GESTION_TITULO", "LTEXT_TUTORIAL_GESTION_15_A","LTEXT_TUTORIAL_GESTION_15_B", false)
  nueva_marca_grafica ("MARCA_CIRCULO", 1, btnCuartelX - 42, btnCuartelY + 10, 0.6)
  
  add_filtro(tipo_mensaje_ui_generico, id_visor_construcciones)
  add_filtro(tipo_mensaje_ui_generico, id_dlg_produccion_efectivos, MSG_GAME_DLG_PRODUCCION_ON_PRODUCCION_TROPA)
  on_event("secuencia17", tipo_mensaje_ui_generico,id_dlg_produccion_efectivos, MSG_GAME_DLG_PRODUCCION_ON_PRODUCCION_TROPA)
    
end

--------------------------------
-- CONSTRUCCION DE TROPAS III --
--------------------------------
function secuencia17()

  limpia_eventos()
  limpia_filtros()
  filtrar_todos(true)
  -- llamar a esta funcion despues de filtrar_todos(true) en los pasos en los que se permita salir del tutorial
  --	NOTA: la ventana de salir del tutorial solo saldra el los casos donde sale el menu en el juego habitual
  permite_menu_escape()
  permitir_camara()

  add_filtro(tipo_mensaje_ui_generico, id_dlg_produccion_efectivos, MSG_GAME_DLG_PRODUCCION_ON_PRODUCCION_TROPA)
  elimina_todas_marcas(1)
  cerrar_ventana_tutorial()
  abrir_ventana_tutorial(width/2-250, height/2-300, tipo_ventana_normal, "LTEXT_TUTORIAL_GESTION_TITULO", "LTEXT_TUTORIAL_GESTION_16_A","LTEXT_TUTORIAL_GESTION_16_B", false)
  nueva_marca_grafica ("MARCA_CIRCULO", 1, btnCerrarConstruccionesX - 8, btnCerrarConstruccionesY + 6, 0.3)
  
  add_filtro(tipo_mensaje_ui_generico, id_boton_cerrar_tropas)
  add_filtro(tipo_mensaje_ui_generico, id_dlg_produccion_efectivos, MSG_GAME_CLOSE_DIALOGO)
  on_event("secuencia18", tipo_mensaje_ui_generico, id_dlg_produccion_efectivos, MSG_GAME_CLOSE_DIALOGO) -- CERRAR VENTANA DE ENTRENAMIENTO
  
end

-----------------
-- PASAR TURNO --
-----------------
function secuencia18()

  limpia_eventos()
  limpia_filtros()
  filtrar_todos(true)
  -- llamar a esta funcion despues de filtrar_todos(true) en los pasos en los que se permita salir del tutorial
  --	NOTA: la ventana de salir del tutorial solo saldra el los casos donde sale el menu en el juego habitual
  permite_menu_escape()
  permitir_camara()

  add_filtro(tipo_mensaje_ui_generico, id_boton_cerrar_tropas)
  elimina_todas_marcas(1)
  cerrar_ventana_tutorial()
  abrir_ventana_tutorial(width/2-250, height/2-300, tipo_ventana_normal, "LTEXT_TUTORIAL_GESTION_TITULO", "LTEXT_TUTORIAL_GESTION_17_A","LTEXT_TUTORIAL_GESTION_17_B", false)
  nueva_marca_grafica ("MARCA_CIRCULO", 1, btnNextTurnX, btnNextTurnY, 0.55)
  
  add_filtro(tipo_mensaje_ui_generico, id_boton_pasar_turno)
  on_event("secuencia18b", tipo_mensaje_game_buttton_release, id_boton_pasar_turno) -- PASAR TURNO
  
end

-------------------
-- PASO DE TURNO --
-------------------
function secuencia18b()

  limpia_eventos()
  limpia_filtros()
  filtrar_todos(false)
  elimina_todas_marcas(1)
  cerrar_ventana_tutorial()
  abrir_ventana_tutorial(width/2-250, height/2-300, tipo_ventana_normal, "LTEXT_TUTORIAL_GESTION_TITULO", "LTEXT_TUTORIAL_PASO_TURNO_A","LTEXT_TUTORIAL_PASO_TURNO_B", false)
  on_event("secuencia19",tipo_mensaje_generico, MSG_GESTION_INICIO_TURNO) -- NUEVO TURNO

end

--------------------
-- MOVER TROPAS I --
--------------------
function secuencia19 ()

  limpia_eventos()
  limpia_filtros()
  filtrar_todos(true)
  -- llamar a esta funcion despues de filtrar_todos(true) en los pasos en los que se permita salir del tutorial
  --	NOTA: la ventana de salir del tutorial solo saldra el los casos donde sale el menu en el juego habitual
  permite_menu_escape()
  permitir_camara()

  selecciona_edificio(MIC_CUARTEL,"LETONIA")
  elimina_todas_marcas(1)
  nueva_marca_grafica_3D("MARCA_FLECHA3DAMARILLA", 1, 11300, 200, 9870, 1.5, true)
  cerrar_ventana_tutorial()
  abrir_ventana_tutorial(710, 90, tipo_ventana_alargado, "LTEXT_TUTORIAL_GESTION_TITULO", "LTEXT_TUTORIAL_GESTION_18_A","LTEXT_TUTORIAL_GESTION_18_B", true)
  
  add_filtro(tipo_mensaje_ui_generico, id_boton_ventana_tutorial)
  on_event("secuencia20", tipo_mensaje_game_buttton_release, id_boton_ventana_tutorial) -- CONTINUAR
  
end

---------------------
-- MOVER TROPAS II --
---------------------
function secuencia20()

  limpia_eventos()
  limpia_filtros()
  elimina_todas_marcas(1)
  --filtrar_todos(false)

  filtrar_todos(true)
  -- llamar a esta funcion despues de filtrar_todos(true) en los pasos en los que se permita salir del tutorial
  --	NOTA: la ventana de salir del tutorial solo saldra el los casos donde sale el menu en el juego habitual
  --permite_menu_escape()
  permitir_camara()

  add_filtro(tipo_mensaje_ui_generico,ZONA_MAPA, MSG_MOUSE_MOVE)  
  add_filtro(tipo_mensaje_ui_generico,ZONA_MAPA, MSG_MOUSE_L_RELEASE)  
  add_filtro(tipo_mensaje_ui_generico,ZONA_MAPA, MSG_MOUSE_L_DRAG)  
  
  -- filtros para los visores de matriz implicados de controles relacionados con el arrastre de tropas/barcos
  add_filtro(tipo_mensaje_ui_generico, VISOR_DLGCONTENIDOPOLITICOMILITAR, MSG_GAME_DLGCONTENIDO_POLITICOMILITAR_BEGIN_DRAG)
  add_filtro(tipo_mensaje_ui_generico, VISOR_DLGCONTENIDOPOLITICOMILITAR, MSG_GAME_DLGCONTENIDO_POLITICOMILITAR_END_DRAG)
  
  nueva_marca_grafica ("MARCA_CIRCULO", 1, 170, 610, 0.7)
  
  add_filtro(tipo_mensaje_generico, MSG_GAME_DLGCONTENIDO_POLITICOMILITAR_BEGIN_DRAG)
  -- id del mensaje, id de la cosa que se termina de arrastrar, tipo de la cosa que se termina de arrastrar, id de la cosa sobre la que se arrastra, tipo de la cosa sobre la que se arrastra
  add_filtro(tipo_mensaje_generico, MSG_GAME_DLGCONTENIDO_POLITICOMILITAR_END_DRAG)
    
  cerrar_ventana_tutorial()
  abrir_ventana_tutorial(710, 90, tipo_ventana_alargado, "LTEXT_TUTORIAL_GESTION_TITULO", "LTEXT_TUTORIAL_GESTION_19_A","LTEXT_TUTORIAL_GESTION_19_B", false)
  -- temporizador ( tempz1, "secuencia21" ) -- MOVER MILICIA
  on_event("secuencia21",tipo_mensaje_generico, MSG_GESTION_DESACUARTELAMIENTO_TROPA)
  
end

-----------------------
-- EMBARCAR TROPAS I --
-----------------------
function secuencia21 ()

  limpia_eventos()
  limpia_filtros()
  filtrar_todos(true)
  elimina_todas_marcas(1)
  -- llamar a esta funcion despues de filtrar_todos(true) en los pasos en los que se permita salir del tutorial
  --	NOTA: la ventana de salir del tutorial solo saldra el los casos donde sale el menu en el juego habitual
  permite_menu_escape()
  permitir_camara()

  cerrar_ventana_tutorial()
  abrir_ventana_tutorial(710, 90, tipo_ventana_alargado, "LTEXT_TUTORIAL_GESTION_TITULO", "LTEXT_TUTORIAL_GESTION_20_A","LTEXT_TUTORIAL_GESTION_20_B", true)
  
  add_filtro(tipo_mensaje_ui_generico, id_boton_ventana_tutorial)
  on_event("secuencia22", tipo_mensaje_game_buttton_release, id_boton_ventana_tutorial) -- CONTINUAR
  
end

---------------------------
-- ESPERAR PASO DE TURNO --
---------------------------
function secuencia22 ()


  set_target_and_zoom(10000, 9000, 0, -1.0)
  -- set_camera_target ( 10000, 10000, 0)
  -- set_camera_zoom ( CAMARA_ZOOM_OUT, 2 )
  idBarcoInicial = crea_ficha(TAM_FLOTA,"GOLFOFINLANDIA","CORBETA","JUG_RUSIA")
  limpia_eventos()
  limpia_filtros()
  filtrar_todos(true)
  -- llamar a esta funcion despues de filtrar_todos(true) en los pasos en los que se permita salir del tutorial
  --	NOTA: la ventana de salir del tutorial solo saldra el los casos donde sale el menu en el juego habitual
  permite_menu_escape()
  permitir_camara()

  elimina_todas_marcas(1)
  cerrar_ventana_tutorial()
  abrir_ventana_tutorial(710, 90, tipo_ventana_alargado, "LTEXT_TUTORIAL_GESTION_TITULO", "LTEXT_TUTORIAL_GESTION_21_A","LTEXT_TUTORIAL_GESTION_21_B", false)
  nueva_marca_grafica ("MARCA_CIRCULO", 1, btnNextTurnX, btnNextTurnY, 0.55)
  
  add_filtro(tipo_mensaje_ui_generico, id_boton_pasar_turno)
  on_event("secuencia22c", tipo_mensaje_game_buttton_release, id_boton_pasar_turno) -- PASAR TURNO
  
end

-------------------
-- PASO DE TURNO --
-------------------
function secuencia22c()

  limpia_eventos()
  limpia_filtros()
  filtrar_todos(true)
  elimina_todas_marcas(1)
  cerrar_ventana_tutorial()
  abrir_ventana_tutorial(width/2-250, height/2-300, tipo_ventana_normal, "", "LTEXT_TUTORIAL_PASO_TURNO_A","LTEXT_TUTORIAL_PASO_TURNO_B", false)
  on_event("secuencia23",tipo_mensaje_generico, MSG_GESTION_INICIO_TURNO) -- NUEVO TURNO

end

-------------------------
-- EMBARCAR TROPAS III --
-------------------------
function secuencia23 ()

  limpia_eventos()
  limpia_filtros()
  filtrar_todos(true)
  -- llamar a esta funcion despues de filtrar_todos(true) en los pasos en los que se permita salir del tutorial
  --	NOTA: la ventana de salir del tutorial solo saldra el los casos donde sale el menu en el juego habitual
  --permite_menu_escape()
  permitir_camara()

  add_filtro(tipo_mensaje_ui_generico,ZONA_MAPA , MSG_MOUSE_L_CLICK)  
  add_filtro(tipo_mensaje_ui_generico,ZONA_MAPA , MSG_MOUSE_L_RELEASE)  
  add_filtro(tipo_mensaje_ui_generico,ZONA_MAPA , MSG_MOUSE_L_DRAG)  
  add_filtro(tipo_mensaje_ui_generico,ZONA_MAPA , MSG_MOUSE_MOVE)  
  add_filtro(tipo_mensaje_generico, MSG_GESTION_START_DRAG_AGRUPACION, idTropaInicial, SMG_OFICIAL)
  add_filtro(tipo_mensaje_generico, MSG_GESTION_END_DRAG_AGRUPACION, idBarcoInicial, SMG_FLOTA)
  
  cerrar_ventana_tutorial()
  abrir_ventana_tutorial(710, 90, tipo_ventana_alargado, "LTEXT_TUTORIAL_GESTION_TITULO", "LTEXT_TUTORIAL_GESTION_22_A","LTEXT_TUTORIAL_GESTION_22_B", false)
  --temporizador ( tempz1, "secuencia24" ) -- EMBARCAR OFICIAL
  on_event("secuencia24", tipo_mensaje_generico, MSG_GESTION_END_DRAG_AGRUPACION, idBarcoInicial, SMG_FLOTA)
  
end

------------------------
-- EMBARCAR TROPAS IV --
------------------------
function secuencia24 ()

  limpia_eventos()
  limpia_filtros()
  filtrar_todos(true)
  elimina_todas_marcas(1)
  -- llamar a esta funcion despues de filtrar_todos(true) en los pasos en los que se permita salir del tutorial
  --	NOTA: la ventana de salir del tutorial solo saldra el los casos donde sale el menu en el juego habitual
  permite_menu_escape()
  permitir_camara()
  
  nueva_marca_grafica ("MARCA_AMARILLA", 1, 219, 630, 0.3)
  selecciona_ficha(TAM_FLOTA, idBarcoInicial)
  add_filtro(tipo_mensaje_generico, MSG_GESTION_END_DRAG_AGRUPACION, idBarcoInicial, SMG_FLOTA)
  cerrar_ventana_tutorial()
  abrir_ventana_tutorial(710, 90, tipo_ventana_alargado, "LTEXT_TUTORIAL_GESTION_TITULO", "LTEXT_TUTORIAL_GESTION_23_A","LTEXT_TUTORIAL_GESTION_23_B", true)
  add_filtro(tipo_mensaje_ui_generico, id_boton_ventana_tutorial)
  on_event("secuencia25", tipo_mensaje_game_buttton_release, id_boton_ventana_tutorial) -- CONTINUAR
  
end

-----------------------
-- EMBARCAR TROPAS V --
-----------------------
function secuencia25 ()

  limpia_eventos()
  limpia_filtros()
  filtrar_todos(true)
  elimina_todas_marcas(1)
  -- llamar a esta funcion despues de filtrar_todos(true) en los pasos en los que se permita salir del tutorial
  --	NOTA: la ventana de salir del tutorial solo saldra el los casos donde sale el menu en el juego habitual
  --permite_menu_escape()
  permitir_camara()

  limita_movimiento_a_provincias("LETONIA");

  add_filtro(tipo_mensaje_ui_generico,ZONA_MAPA , MSG_MOUSE_L_CLICK)  
  add_filtro(tipo_mensaje_ui_generico,ZONA_MAPA , MSG_MOUSE_L_RELEASE)  
  add_filtro(tipo_mensaje_ui_generico,ZONA_MAPA , MSG_MOUSE_L_DRAG) 
  add_filtro(tipo_mensaje_ui_generico,ZONA_MAPA , MSG_MOUSE_MOVE)  
  add_filtro(tipo_mensaje_ui_generico, id_boton_ok)
  add_filtro(tipo_mensaje_ui_generico, id_notificacion_peque)  
  add_filtro(tipo_mensaje_ui_generico, id_notificacion_grande)  
  add_filtro(tipo_mensaje_ui_generico, id_notificacion_gigante)  
  add_filtro(tipo_mensaje_generico, MSG_GESTION_START_DRAG_AGRUPACION, idTropaInicial, SMG_OFICIAL)
  --add_filtro(tipo_mensaje_generico, MSG_GESTION_END_DRAG_AGRUPACION, idBarcoInicial, SMG_FLOTA)
  add_filtro(tipo_mensaje_generico, MSG_GESTION_END_DROP_AGRUPACION_EN_PROVINCIA, idTropaInicial, SMG_PROVINCIA_TERRESTRE)

  add_filtro(tipo_mensaje_generico, MSG_GAME_DLGCONTENIDO_POLITICOMILITAR_BEGIN_DRAG)
  
  nueva_marca_grafica ("MARCA_CIRCULO", 1, 219, 630, 0.3)
  
  cerrar_ventana_tutorial()
  abrir_ventana_tutorial(710, 90, tipo_ventana_alargado, "LTEXT_TUTORIAL_GESTION_TITULO", "LTEXT_TUTORIAL_GESTION_24_A","LTEXT_TUTORIAL_GESTION_24_B", false)

  add_filtro(tipo_mensaje_ui_generico, VISOR_DLGCONTENIDOPOLITICOMILITAR, MSG_GAME_DLGCONTENIDO_POLITICOMILITAR_BEGIN_DRAG)
  add_filtro(tipo_mensaje_ui_generico, VISOR_DLGCONTENIDOPOLITICOMILITAR, MSG_GAME_DLGCONTENIDO_POLITICOMILITAR_END_DRAG)

  add_filtro(tipo_mensaje_generico, MSG_GAME_DLGCONTENIDO_POLITICOMILITAR_END_DRAG, idTropaInicial, SMG_OFICIAL, convierte_def_provincia_a_id("LETONIA"), SMG_PROVINCIA_TERRESTRE)
  on_event("secuencia26", tipo_mensaje_generico, MSG_GAME_DLGCONTENIDO_POLITICOMILITAR_END_DRAG, idTropaInicial, SMG_OFICIAL, convierte_def_provincia_a_id("LETONIA"), SMG_PROVINCIA_TERRESTRE)
  
end

-------------------
-- PRODUCCION I  --
-------------------
function secuencia26 ()
  
  idTropaInicial = ultimo_id_ejercito_desacuartelado
  limpia_eventos()
  limpia_filtros()
  filtrar_todos(true)
  elimina_todas_marcas(1)
  -- llamar a esta funcion despues de filtrar_todos(true) en los pasos en los que se permita salir del tutorial
  --	NOTA: la ventana de salir del tutorial solo saldra el los casos donde sale el menu en el juego habitual
  permite_menu_escape()
  permitir_camara()

  cerrar_ventana_tutorial()
  abrir_ventana_tutorial(710, 90, tipo_ventana_alargado, "LTEXT_TUTORIAL_GESTION_TITULO", "LTEXT_TUTORIAL_GESTION_25_A","LTEXT_TUTORIAL_GESTION_25_B", true)
  add_filtro(tipo_mensaje_ui_generico, id_boton_ventana_tutorial)
  on_event("secuencia27", tipo_mensaje_game_buttton_release, id_boton_ventana_tutorial) -- CONTINUAR
  
end

--------------------
-- PRODUCCION II  --
--------------------
function secuencia27 ()

  limpia_eventos()
  limpia_filtros()
  filtrar_todos(true)
  -- llamar a esta funcion despues de filtrar_todos(true) en los pasos en los que se permita salir del tutorial
  --	NOTA: la ventana de salir del tutorial solo saldra el los casos donde sale el menu en el juego habitual
  -- permite_menu_escape()
  permitir_camara()
  
  elimina_todas_marcas(1)
  --set_camera_zoom ( CAMARA_RESET_ZOOM )
  --set_camera_target ( 9550, 8500, 0)
  set_target_and_zoom(9250, 7000, 0, 0)
  set_provincia_seleccionada ( "POLONIA" )

  cerrar_ventana_tutorial()
  abrir_ventana_tutorial(710, 90, tipo_ventana_alargado, "LTEXT_TUTORIAL_GESTION_TITULO", "LTEXT_TUTORIAL_GESTION_26_A","LTEXT_TUTORIAL_GESTION_26_B", false)
  nueva_marca_grafica_3D("MARCA_FLECHA3DROJA", 1, 9200, 250, 7500, 2.5, true)
  
  add_filtro(tipo_mensaje_ui_generico,ZONA_MAPA , MSG_MOUSE_R_CLICK)  
  add_filtro(tipo_mensaje_ui_generico,ZONA_MAPA , MSG_MOUSE_R_RELEASE)  
  add_filtro(tipo_mensaje_generico, MSG_MOUSE_R_RELEASE, convierte_def_provincia_a_id("POLONIA"), SMG_PROVINCIA_TERRESTRE )
  on_event("secuencia28", tipo_mensaje_generico, MSG_MOUSE_R_RELEASE, convierte_def_provincia_a_id("POLONIA"), SMG_PROVINCIA_TERRESTRE )
  
end

---------------------
-- PRODUCCION III  --
---------------------
function secuencia28 ()

  limpia_eventos()
  elimina_todas_marcas(1)
  cerrar_ventana_tutorial()
  abrir_ventana_tutorial(710, 90, tipo_ventana_alargado, "LTEXT_TUTORIAL_GESTION_TITULO", "LTEXT_TUTORIAL_GESTION_27_A","LTEXT_TUTORIAL_GESTION_27_B", false)
  nueva_marca_grafica ("MARCA_CIRCULO", 1, btnCerrarConstruccionesX - 75, btnCerrarConstruccionesY, 0.3)
  nueva_marca_grafica ("MARCA_AMARILLA", 2, 565, 430, 0.4)

  add_filtro(tipo_mensaje_ui_generico, id_boton_cerrar_info_provincia)
  
  add_filtro(tipo_mensaje_ui_generico, id_dlg_informacion_provincia, MSG_GAME_CLOSE_DIALOGO)
  on_event("secuencia29", tipo_mensaje_ui_generico, id_dlg_informacion_provincia, MSG_GAME_CLOSE_DIALOGO) -- CERRAR VENTANA INFO PROVINCIAS

end

-------------
-- COMIDA  --
-------------
function secuencia29 ()

  limpia_eventos()
  limpia_filtros()
  filtrar_todos(true)
  elimina_todas_marcas(1)
  -- llamar a esta funcion despues de filtrar_todos(true) en los pasos en los que se permita salir del tutorial
  --	NOTA: la ventana de salir del tutorial solo saldra el los casos donde sale el menu en el juego habitual
  permite_menu_escape()
  permitir_camara()

  add_filtro(tipo_mensaje_ui_generico, id_boton_cerrar_info_provincia)
  set_provincia_seleccionada ( "LETONIA" )    
  elimina_todas_marcas(1)
  cerrar_ventana_tutorial()
  abrir_ventana_tutorial(710, 90, tipo_ventana_alargado, "LTEXT_TUTORIAL_GESTION_TITULO", "LTEXT_TUTORIAL_GESTION_28_A","LTEXT_TUTORIAL_GESTION_28_B", true)
  add_filtro(tipo_mensaje_ui_generico, id_boton_ventana_tutorial)
  on_event("secuencia30", tipo_mensaje_game_buttton_release, id_boton_ventana_tutorial) -- CONTINUAR
  
end

-------------------------
-- CIENCIA Y AVANCES I --
-------------------------
function secuencia30()

  limpia_eventos()
  limpia_filtros()
  filtrar_todos(true)
  -- llamar a esta funcion despues de filtrar_todos(true) en los pasos en los que se permita salir del tutorial
  --	NOTA: la ventana de salir del tutorial solo saldra el los casos donde sale el menu en el juego habitual
  permite_menu_escape()
  permitir_camara()

  cerrar_ventana_tutorial()
  abrir_ventana_tutorial(710, 90, tipo_ventana_alargado, "LTEXT_TUTORIAL_GESTION_TITULO", "LTEXT_TUTORIAL_GESTION_29_A","LTEXT_TUTORIAL_GESTION_29_B", false)
  nueva_marca_grafica ("MARCA_CIRCULO", 1, btnTecnologiasX, btnTecnologiasY, 0.25)
  add_filtro(tipo_mensaje_ui_generico, id_boton_abrir_arbol)
  on_event("secuencia31", tipo_mensaje_game_buttton_release, id_boton_abrir_arbol) -- ABRIR ARBOL
  
end

--------------------------
-- CIENCIA Y AVANCES II --
--------------------------
function secuencia31()

  limpia_eventos()
  limpia_filtros()
  filtrar_todos(true)
  -- llamar a esta funcion despues de filtrar_todos(true) en los pasos en los que se permita salir del tutorial
  --	NOTA: la ventana de salir del tutorial solo saldra el los casos donde sale el menu en el juego habitual
  permite_menu_escape()
  permitir_camara()

  add_filtro(tipo_mensaje_ui_generico, id_boton_abrir_arbol)
  elimina_todas_marcas(1)
  cerrar_ventana_tutorial()
  abrir_ventana_tutorial(width/2-20, height/2-250, tipo_ventana_grande, "LTEXT_TUTORIAL_GESTION_TITULO", "LTEXT_TUTORIAL_GESTION_30_A","LTEXT_TUTORIAL_GESTION_30_B", false)
  nueva_marca_grafica ("MARCA_CIRCULO", 1, btnTechComercioX, btnTechComercioY, 0.4)

  add_filtro(tipo_mensaje_tecnologia, IDX_COMERCIO_INTERNACIONAL,MSG_GAME_NODO_TECNOLOGIA_L_CLICK)
  add_filtro(tipo_mensaje_tecnologia, 0 ,MSG_GAME_NODO_TECNOLOGIA_ENTER)
  add_filtro(tipo_mensaje_tecnologia, 0 ,MSG_GAME_NODO_TECNOLOGIA_LEAVE)
  
  on_event("secuencia32",tipo_mensaje_tecnologia, IDX_COMERCIO_INTERNACIONAL, MSG_GAME_NODO_TECNOLOGIA_L_CLICK)

end

---------------------------
-- CIENCIA Y AVANCES III --
---------------------------
function secuencia32()

  limpia_eventos()
  limpia_filtros()
  filtrar_todos(true)
  -- llamar a esta funcion despues de filtrar_todos(true) en los pasos en los que se permita salir del tutorial
  --	NOTA: la ventana de salir del tutorial solo saldra el los casos donde sale el menu en el juego habitual
  permite_menu_escape()
  permitir_camara()

  --add_filtro(tipo_mensaje_tecnologia, IDX_COMERCIO_INTERNACIONAL,MSG_GAME_NODO_TECNOLOGIA_L_CLICK)
  elimina_todas_marcas(1)
  cerrar_ventana_tutorial()
  abrir_ventana_tutorial(width/2-20, height/2-250, tipo_ventana_normal, "LTEXT_TUTORIAL_GESTION_TITULO", "LTEXT_TUTORIAL_GESTION_31_A","LTEXT_TUTORIAL_GESTION_31_B", false)
  nueva_marca_grafica ("MARCA_CIRCULO", 1, btnCerrarArbolX, btnCerrarArbolY, 0.3)

  add_filtro(tipo_mensaje_tecnologia, 0 ,MSG_GAME_NODO_TECNOLOGIA_ENTER)
  add_filtro(tipo_mensaje_tecnologia, 0 ,MSG_GAME_NODO_TECNOLOGIA_LEAVE)

  add_filtro(tipo_mensaje_ui_generico, id_boton_cerrar_arbol)
  on_event("secuencia33", tipo_mensaje_game_buttton_release, id_boton_cerrar_arbol) -- CERRAR ARBOL


end

-----------------
-- PASAR TURNO --
-----------------
function secuencia33()

  limpia_eventos()
  limpia_filtros()
  filtrar_todos(true)
  -- llamar a esta funcion despues de filtrar_todos(true) en los pasos en los que se permita salir del tutorial
  --	NOTA: la ventana de salir del tutorial solo saldra el los casos donde sale el menu en el juego habitual
  permite_menu_escape()
  permitir_camara()

  add_filtro(tipo_mensaje_ui_generico, id_boton_cerrar_arbol)
  add_filtro(tipo_mensaje_ui_generico, id_ventana_tecnologias)
  elimina_todas_marcas(1)
  cerrar_ventana_tutorial()
  abrir_ventana_tutorial(width/2-250, height/2-300, tipo_ventana_normal, "LTEXT_TUTORIAL_GESTION_TITULO", "LTEXT_TUTORIAL_GESTION_32_A","LTEXT_TUTORIAL_GESTION_32_B", false)
  nueva_marca_grafica ("MARCA_CIRCULO", 1, btnNextTurnX, btnNextTurnY, 0.55)
 
  add_filtro(tipo_mensaje_ui_generico, id_boton_pasar_turno)
  on_event("secuencia33b", tipo_mensaje_game_buttton_release, id_boton_pasar_turno) -- PASAR TURNO 
end


-------------------
-- PASO DE TURNO --
-------------------
function secuencia33b()

  limpia_eventos()
  limpia_filtros()
  filtrar_todos(true)
  elimina_todas_marcas(1)
  cerrar_ventana_tutorial()
  abrir_ventana_tutorial(width/2-250, height/2-300, tipo_ventana_normal, "LTEXT_TUTORIAL_GESTION_TITULO", "LTEXT_TUTORIAL_PASO_TURNO_A","LTEXT_TUTORIAL_PASO_TURNO_B", false)
  on_event("secuencia33c",tipo_mensaje_generico, MSG_GESTION_INICIO_TURNO) -- NUEVO TURNO

end

----------------------
-- PASO DE TURNO II --
----------------------
function secuencia33c()

  elimina_todas_marcas(1)
  cerrar_ventana_tutorial()
  
  -- si se sabe que tipo de notificacion es se podrian quitar algunos
  add_filtro(tipo_mensaje_ui_generico, id_notificacion_peque)  
  add_filtro(tipo_mensaje_ui_generico, id_notificacion_grande)  
  add_filtro(tipo_mensaje_ui_generico, id_notificacion_gigante)  
  
  add_filtro(tipo_mensaje_ui_generico, id_boton_ok)
  add_filtro(tipo_mensaje_ui_generico, 256)  
  
  on_event("secuencia34", tipo_mensaje_ui_generico, id_notificacion_peque, MSG_GAME_CLOSE_DIALOGO) -- CERRAR VENTANA CONSTRUCCION
  on_event("secuencia34", tipo_mensaje_ui_generico, id_notificacion_grande, MSG_GAME_CLOSE_DIALOGO) -- CERRAR VENTANA CONSTRUCCION
  on_event("secuencia34", tipo_mensaje_ui_generico, id_notificacion_gigante, MSG_GAME_CLOSE_DIALOGO) -- CERRAR VENTANA CONSTRUCCION
   
end

-----------------
-- COMERCIO I  --
-----------------
function secuencia34()

  limpia_eventos()
  limpia_filtros()
  filtrar_todos(true)
  -- llamar a esta funcion despues de filtrar_todos(true) en los pasos en los que se permita salir del tutorial
  --	NOTA: la ventana de salir del tutorial solo saldra el los casos donde sale el menu en el juego habitual
  permite_menu_escape()
  permitir_camara()

  elimina_todas_marcas(1)
  cerrar_ventana_tutorial()
  abrir_ventana_tutorial(710, 90, tipo_ventana_alargado, "LTEXT_TUTORIAL_GESTION_TITULO", "LTEXT_TUTORIAL_GESTION_33_A","LTEXT_TUTORIAL_GESTION_33_B", true)
  --set_camera_target ( 9500, 9000, 0)
  --set_camera_zoom ( CAMARA_ZOOM_OUT, 3 )
  set_target_and_zoom(9500, 9000, 0, -1.0)
  set_provincia_seleccionada ( "POLONIA" )
  add_filtro(tipo_mensaje_ui_generico, id_boton_ventana_tutorial)
  on_event("secuencia35", tipo_mensaje_game_buttton_release, id_boton_ventana_tutorial) -- CONTINUAR
  
end


-----------------
-- COMERCIO I  --
-----------------
function secuencia35()

  limpia_eventos()
  limpia_filtros()
  filtrar_todos(true)
  -- llamar a esta funcion despues de filtrar_todos(true) en los pasos en los que se permita salir del tutorial
  --	NOTA: la ventana de salir del tutorial solo saldra el los casos donde sale el menu en el juego habitual
  permite_menu_escape()
  permitir_camara()

  
  cerrar_ventana_tutorial()
  abrir_ventana_tutorial(710, 90, tipo_ventana_alargado, "LTEXT_TUTORIAL_GESTION_TITULO", "LTEXT_TUTORIAL_GESTION_34_A","LTEXT_TUTORIAL_GESTION_34_B", false)
  nueva_marca_grafica ("MARCA_CIRCULO", 1, btnConstruirX, btnConstruirY, 0.4)
  --temporizador ( tempz1, "secuencia36" ) -- ABRIR VENTANA DE EDIFICIOS

  add_filtro(tipo_mensaje_ui_generico, id_boton_construir)
  add_filtro(tipo_mensaje_ui_generico, id_panel_construcciones, MSG_GAME_PANEL_CONSTRUCCIONES_OPEN_DLG_PRODUCCION)
  on_event("secuencia36", tipo_mensaje_game_buttton_release, id_boton_construir, MSG_MOUSE_L_RELEASE) -- ABRIR VENTANA CONSTRUCCION
end

------------------
-- COMERCIO II  --
------------------
function secuencia36()

  limpia_eventos()
  limpia_filtros()
  filtrar_todos(true)
  -- llamar a esta funcion despues de filtrar_todos(true) en los pasos en los que se permita salir del tutorial
  --	NOTA: la ventana de salir del tutorial solo saldra el los casos donde sale el menu en el juego habitual
  permite_menu_escape()
  permitir_camara()

  add_filtro(tipo_mensaje_ui_generico, id_boton_construir)
  add_filtro(tipo_mensaje_ui_generico, id_panel_construcciones, MSG_GAME_PANEL_CONSTRUCCIONES_OPEN_DLG_PRODUCCION)

  elimina_todas_marcas(1)
  cerrar_ventana_tutorial()
  abrir_ventana_tutorial(710, 90, tipo_ventana_alargado, "LTEXT_TUTORIAL_GESTION_TITULO", "LTEXT_TUTORIAL_GESTION_35_A","LTEXT_TUTORIAL_GESTION_35_B", false)
  nueva_marca_grafica ("MARCA_CIRCULO", 1, btnCuartelX, btnCuartelY, 0.4)

  --temporizador ( tempz1, "secuencia37" ) -- COMENZAR RUTA COMERCIAL
  
  add_filtro(tipo_mensaje_ui_generico, id_visor_construcciones)
  add_filtro(tipo_mensaje_ui_generico, id_dlg_produccion_edificios, MSG_GAME_DLG_PRODUCCION_ON_PRODUCCION_EDIFICIO)
  on_event("secuencia37", tipo_mensaje_ui_generico,id_dlg_produccion_edificios, MSG_GAME_DLG_PRODUCCION_ON_PRODUCCION_EDIFICIO)
    
  
end

------------------
-- COMERCIO III --
------------------
function secuencia37()

  limpia_eventos()
  limpia_filtros()
  filtrar_todos(true)
  -- llamar a esta funcion despues de filtrar_todos(true) en los pasos en los que se permita salir del tutorial
  --	NOTA: la ventana de salir del tutorial solo saldra el los casos donde sale el menu en el juego habitual
  permite_menu_escape()
  permitir_camara()

  add_filtro(tipo_mensaje_ui_generico, id_dlg_produccion_edificios, MSG_GAME_DLG_PRODUCCION_ON_PRODUCCION_EDIFICIO)
  elimina_todas_marcas(1)
  cerrar_ventana_tutorial()
  abrir_ventana_tutorial(width/2-20, height/2-250, tipo_ventana_normal, "LTEXT_TUTORIAL_GESTION_TITULO", "LTEXT_TUTORIAL_GESTION_36_A","LTEXT_TUTORIAL_GESTION_36_B", false)
  nueva_marca_grafica ("MARCA_CIRCULO", 1, btnCerrarConstruccionesX, btnCerrarConstruccionesY, 0.3)
  
  --temporizador ( tempz1 , "secuencia38" ) -- CERRAR VENTANA DE CONSTRUCCION
  
  add_filtro(tipo_mensaje_ui_generico, id_boton_cerrar_construccion)
  on_event("secuencia38", tipo_mensaje_game_buttton_release, id_boton_cerrar_construccion) -- CERRAR VENTANA CONSTRUCCION
  
end

-----------------
-- PASAR TURNO --
-----------------
function secuencia38()

  limpia_eventos()
  limpia_filtros()
  filtrar_todos(true)
  -- llamar a esta funcion despues de filtrar_todos(true) en los pasos en los que se permita salir del tutorial
  --	NOTA: la ventana de salir del tutorial solo saldra el los casos donde sale el menu en el juego habitual
  permite_menu_escape()
  permitir_camara()

  add_filtro(tipo_mensaje_ui_generico, id_boton_cerrar_construccion)
  elimina_todas_marcas(1)
  cerrar_ventana_tutorial()
  abrir_ventana_tutorial(width/2-250, height/2-300, tipo_ventana_normal, "LTEXT_TUTORIAL_GESTION_TITULO", "LTEXT_TUTORIAL_GESTION_37_A","LTEXT_TUTORIAL_GESTION_37_B", false)
  nueva_marca_grafica ("MARCA_CIRCULO", 1, btnNextTurnX, btnNextTurnY, 0.55)
  add_filtro(tipo_mensaje_ui_generico, id_boton_pasar_turno)
  on_event("secuencia38b", tipo_mensaje_game_buttton_release, id_boton_pasar_turno) -- PASAR TURNO
  
end

-------------------
-- PASO DE TURNO --
-------------------
function secuencia38b()

  limpia_eventos()
  limpia_filtros()
  filtrar_todos(true)
  elimina_todas_marcas(1)
  cerrar_ventana_tutorial()
  abrir_ventana_tutorial(width/2-250, height/2-300, tipo_ventana_normal, "LTEXT_TUTORIAL_GESTION_TITULO", "LTEXT_TUTORIAL_PASO_TURNO_A","LTEXT_TUTORIAL_PASO_TURNO_B", false)
  on_event("secuencia38c",tipo_mensaje_generico, MSG_GESTION_INICIO_TURNO) -- NUEVO TURNO

end


----------------------
-- PASO DE TURNO II --
----------------------
function secuencia38c()

  elimina_todas_marcas(1)
  cerrar_ventana_tutorial()
  
    -- si se sabe que tipo de notificacion es se podrian quitar algunos
  add_filtro(tipo_mensaje_ui_generico, id_notificacion_peque)  
  add_filtro(tipo_mensaje_ui_generico, id_notificacion_grande)  
  add_filtro(tipo_mensaje_ui_generico, id_notificacion_gigante)  
  
  add_filtro(tipo_mensaje_ui_generico, id_boton_ok)
  add_filtro(tipo_mensaje_ui_generico, 256)
  
  on_event("secuencia39", tipo_mensaje_ui_generico, id_notificacion_peque, MSG_GAME_CLOSE_DIALOGO) -- CERRAR VENTANA CONSTRUCCION
  on_event("secuencia39", tipo_mensaje_ui_generico, id_notificacion_grande, MSG_GAME_CLOSE_DIALOGO) -- CERRAR VENTANA CONSTRUCCION
  on_event("secuencia39", tipo_mensaje_ui_generico, id_notificacion_gigante, MSG_GAME_CLOSE_DIALOGO) -- CERRAR VENTANA CONSTRUCCION
    
end

----------------------
-- MODO COMERCIAL I --
----------------------
function secuencia39()

  limpia_eventos()
  limpia_filtros()
  filtrar_todos(true)
  -- llamar a esta funcion despues de filtrar_todos(true) en los pasos en los que se permita salir del tutorial
  --	NOTA: la ventana de salir del tutorial solo saldra el los casos donde sale el menu en el juego habitual
  permite_menu_escape()
  permitir_camara()

  --set_camera_target ( 10000, 10000, 0) 
  --set_camera_zoom ( CAMARA_ZOOM_OUT, 3 )
  set_target_and_zoom(10000, 9000, 0, -2.0)
  set_provincia_seleccionada ( "LETONIA" )    
    
  elimina_todas_marcas(1)
  cerrar_ventana_tutorial()
  abrir_ventana_tutorial(width/2-250, height/2-300, tipo_ventana_normal, "LTEXT_TUTORIAL_GESTION_TITULO", "LTEXT_TUTORIAL_GESTION_38_A","LTEXT_TUTORIAL_GESTION_38_B", false)
  nueva_marca_grafica ("MARCA_CIRCULO", 1, btnComercialModeX, btnComercialModeY, 0.25)
  add_filtro(tipo_mensaje_ui_generico, id_gestor_botones_modos_mapa)
  add_filtro(tipo_mensaje_ui_generico, id_boton_modo_comercial)
  on_event("secuencia40", tipo_mensaje_checkbox_pushed, id_boton_modo_comercial) -- MODO COMERCIAL
  
end

-----------------------
-- MODO COMERCIAL II --
-----------------------
function secuencia40()

  limpia_eventos()
  elimina_todas_marcas(1)
  cerrar_ventana_tutorial()
  nueva_marca_grafica_3D("MARCA_FLECHA3DAMARILLA", 1, 9700, 210, 8500, 1.5, true)
  abrir_ventana_tutorial(710, 90, tipo_ventana_alargado, "LTEXT_TUTORIAL_GESTION_TITULO", "LTEXT_TUTORIAL_GESTION_39_A","LTEXT_TUTORIAL_GESTION_39_B", true)
  add_filtro(tipo_mensaje_ui_generico, id_boton_ventana_tutorial)
  
  --deja que el tooltip de informacion de rutas se actualize
  add_filtro(tipo_mensaje_ui_generico, ZONA_MAPA, MSG_MOUSE_ENTER)
  add_filtro(tipo_mensaje_ui_generico, ZONA_MAPA, MSG_MOUSE_LEAVE)
  add_filtro(tipo_mensaje_ui_generico, ZONA_MAPA, MSG_MOUSE_MOVE)
  
  on_event("secuencia41", tipo_mensaje_game_buttton_release, id_boton_ventana_tutorial) -- CONTINUAR
  
end

------------------------
-- MODO COMERCIAL III --
------------------------
function secuencia41()

  limpia_eventos()
  limpia_filtros()
  filtrar_todos(true)
  elimina_todas_marcas(1)
  -- llamar a esta funcion despues de filtrar_todos(true) en los pasos en los que se permita salir del tutorial
  --	NOTA: la ventana de salir del tutorial solo saldra el los casos donde sale el menu en el juego habitual
  permite_menu_escape()
  permitir_camara()

  cerrar_ventana_tutorial()
  abrir_ventana_tutorial(710, 90, tipo_ventana_alargado, "LTEXT_TUTORIAL_GESTION_TITULO", "LTEXT_TUTORIAL_GESTION_40_A","LTEXT_TUTORIAL_GESTION_40_B", true)
  --on_event("secuencia42", tipo_mensaje_game_buttton_release, id_boton_ventana_tutorial) -- CONTINUAR
  add_filtro(tipo_mensaje_ui_generico, id_boton_ventana_tutorial, MSG_MOUSE_L_RELEASE)
  add_filtro(tipo_mensaje_ui_generico, id_boton_ventana_tutorial, MSG_MOUSE_ENTER)
  add_filtro(tipo_mensaje_ui_generico, id_boton_ventana_tutorial, MSG_MOUSE_LEAVE)
  add_filtro(tipo_mensaje_ui_generico, id_boton_ventana_tutorial, MSG_KEY_UP)
  on_event("secuencia42", tipo_mensaje_ui_generico, id_boton_ventana_tutorial, MSG_MOUSE_L_RELEASE)  
  
end

------------------------
-- MODO COMERCIAL III --
------------------------
function secuencia42()

  limpia_eventos()
  limpia_filtros()
  filtrar_todos(true)
  -- llamar a esta funcion despues de filtrar_todos(true) en los pasos en los que se permita salir del tutorial
  --	NOTA: la ventana de salir del tutorial solo saldra el los casos donde sale el menu en el juego habitual
  permite_menu_escape()
  permitir_camara()

  cerrar_ventana_tutorial()
  abrir_ventana_tutorial(710, 90, tipo_ventana_alargado, "LTEXT_TUTORIAL_GESTION_TITULO", "LTEXT_TUTORIAL_GESTION_41_A","LTEXT_TUTORIAL_GESTION_41_B", false)
  nueva_marca_grafica ("MARCA_CIRCULO", 1, btnTecnologiasX - 86, btnTecnologiasY, 0.25)
  add_filtro(tipo_mensaje_ui_generico, id_boton_abrir_diplomacia)
  on_event("secuencia43", tipo_mensaje_game_buttton_release, id_boton_abrir_diplomacia) -- ABRIR DIPLOMACIA
  
end

------------------
-- DIPLOMACIA I --
------------------
function secuencia43()

  limpia_eventos()
  limpia_filtros()
  filtrar_todos(true)
  -- llamar a esta funcion despues de filtrar_todos(true) en los pasos en los que se permita salir del tutorial
  --	NOTA: la ventana de salir del tutorial solo saldra el los casos donde sale el menu en el juego habitual
  permite_menu_escape()
  permitir_camara()

  elimina_todas_marcas(1)
  cerrar_ventana_tutorial()
  abrir_ventana_tutorial(710, 90, tipo_ventana_alargado, "LTEXT_TUTORIAL_GESTION_TITULO", "LTEXT_TUTORIAL_GESTION_42_A","LTEXT_TUTORIAL_GESTION_42_B", false)
  nueva_marca_grafica ("MARCA_CIRCULO", 1, btnAlianzaX, btnAlianzaY, 0.50)
  add_filtro(tipo_mensaje_ui_generico, id_boton_abrir_diplomacia)
  --add_filtro(tipo_mensaje_ui_generico, id_boton_cerrar_arbol)
  add_filtro(tipo_mensaje_ui_generico, id_boton_alianza_defensiva, MSG_MOUSE_L_CLICK)
  add_filtro(tipo_mensaje_ui_generico, id_boton_alianza_defensiva, MSG_MOUSE_MOVE)
  add_filtro(tipo_mensaje_ui_generico, id_boton_alianza_defensiva, MSG_MOUSE_ENTER)
  add_filtro(tipo_mensaje_ui_generico, id_boton_alianza_defensiva, MSG_MOUSE_LEAVE)
  add_filtro(tipo_mensaje_ui_generico, ID_GESTOR_PROPUESTA)
  --add_filtro(tipo_mensaje_ui_generico, id_gestor_controles_diplomacia)
  on_event("secuencia44", tipo_mensaje_checkbox_pushed, id_boton_alianza_defensiva) -- ALIANZA DEFENSIVA
  
end

-------------------
-- DIPLOMACIA II --
-------------------
function secuencia44()

  limpia_eventos()
  limpia_filtros()
  filtrar_todos(true)
  -- llamar a esta funcion despues de filtrar_todos(true) en los pasos en los que se permita salir del tutorial
  --	NOTA: la ventana de salir del tutorial solo saldra el los casos donde sale el menu en el juego habitual
  permite_menu_escape()

  add_filtro(tipo_mensaje_ui_generico, id_boton_alianza_defensiva, MSG_MOUSE_L_CLICK)
  add_filtro(tipo_mensaje_ui_generico, id_boton_alianza_defensiva, MSG_MOUSE_MOVE)
  add_filtro(tipo_mensaje_ui_generico, id_boton_alianza_defensiva, MSG_MOUSE_ENTER)
  add_filtro(tipo_mensaje_ui_generico, id_boton_alianza_defensiva, MSG_MOUSE_LEAVE)
  add_filtro(tipo_mensaje_ui_generico, ID_GESTOR_PROPUESTA)
  add_filtro(tipo_mensaje_ui_generico, ID_MAPA_DIPLOMACIA)
  set_provincia_seleccionada ( "LETONIA" )    
  elimina_todas_marcas(1)
  cerrar_ventana_tutorial()
  abrir_ventana_tutorial(710, 90, tipo_ventana_alargado, "LTEXT_TUTORIAL_GESTION_TITULO", "LTEXT_TUTORIAL_GESTION_43_A","LTEXT_TUTORIAL_GESTION_43_B", false)
  nueva_marca_grafica ("MARCA_CIRCULO", 1, width/2 - 140, height/2 - 130, 0.50)
  -- temporizador ( tempz1, "secuencia45" ) -- SELECCIONAR POLONIA
  on_event("secuencia45" , tipo_mensaje_ui_generico, ID_MAPA_DIPLOMACIA,MSG_MAPA_PAISES_PULSACION)
  
  
end

--------------------
-- DIPLOMACIA III --
--------------------
function secuencia45()

  limpia_eventos()
  limpia_filtros()
  filtrar_todos(true)
  -- llamar a esta funcion despues de filtrar_todos(true) en los pasos en los que se permita salir del tutorial
  --	NOTA: la ventana de salir del tutorial solo saldra el los casos donde sale el menu en el juego habitual
  permite_menu_escape()
  permitir_camara()

  add_filtro(tipo_mensaje_ui_generico, ID_MAPA_DIPLOMACIA)
  elimina_todas_marcas(1)
  cerrar_ventana_tutorial()
  abrir_ventana_tutorial(150, height/2-200, tipo_ventana_grande, "LTEXT_TUTORIAL_GESTION_TITULO", "LTEXT_TUTORIAL_GESTION_44_A","LTEXT_TUTORIAL_GESTION_44_B", false)
  nueva_marca_grafica ("MARCA_CIRCULO", 1, width/2 - 90, height - 80, 0.50)
  nueva_marca_grafica ("MARCA_AMARILLA", 2, 766, 276, 0.3)
  
  add_filtro(tipo_mensaje_ui_generico, ID_BOTON_ENVIAR_DIPLOMACIA)
  on_event("secuencia45b" , tipo_mensaje_game_buttton_release, ID_BOTON_ENVIAR_DIPLOMACIA)
  
end

---------------------
-- DIPLOMACIA IIIB --
---------------------
function secuencia45b()

  limpia_eventos()
  limpia_filtros()
  filtrar_todos(false)
  elimina_todas_marcas(1)
  cerrar_ventana_tutorial()

  on_event("secuencia46", tipo_mensaje_ui_generico, ID_NOTIFICACION_DIPLOMACIA, MSG_GAME_CLOSE_DIALOGO) 
 
  
end
-------------------
-- DIPLOMACIA IV --
-------------------
function secuencia46()

  limpia_eventos()
  limpia_filtros()
  filtrar_todos(true)
  -- llamar a esta funcion despues de filtrar_todos(true) en los pasos en los que se permita salir del tutorial
  --	NOTA: la ventana de salir del tutorial solo saldra el los casos donde sale el menu en el juego habitual
  permite_menu_escape()
  permitir_camara()

  --add_filtro(tipo_mensaje_ui_generico, id_boton_ok)
  elimina_todas_marcas(1)
  cerrar_ventana_tutorial()
  abrir_ventana_tutorial(150, height/2-200, tipo_ventana_normal, "LTEXT_TUTORIAL_GESTION_TITULO", "LTEXT_TUTORIAL_GESTION_45_A","LTEXT_TUTORIAL_GESTION_45_B", false)
  nueva_marca_grafica ("MARCA_CIRCULO", 1, btnTecnologiasX - 10, btnTecnologiasY + 51, 0.30)

  add_filtro(tipo_mensaje_ui_generico, id_boton_cerrar_diplomacia)
  on_event("secuencia47" , tipo_mensaje_game_buttton_release, id_boton_cerrar_diplomacia)
  
end

--------------
-- GUERRA I --
--------------
function secuencia47()

  limpia_eventos()
  limpia_filtros()
  filtrar_todos(true)
  -- llamar a esta funcion despues de filtrar_todos(true) en los pasos en los que se permita salir del tutorial
  --	NOTA: la ventana de salir del tutorial solo saldra el los casos donde sale el menu en el juego habitual
  permite_menu_escape()
  permitir_camara()

  add_filtro(tipo_mensaje_ui_generico, id_boton_cerrar_diplomacia)
  add_filtro(tipo_mensaje_ui_generico, id_ventana_diplomacia)  
  elimina_todas_marcas(1)
  cerrar_ventana_tutorial()
  abrir_ventana_tutorial(width/2 - 250, height/2-300, tipo_ventana_normal, "LTEXT_TUTORIAL_GESTION_TITULO", "LTEXT_TUTORIAL_GESTION_46_A","LTEXT_TUTORIAL_GESTION_46_B", false)
  nueva_marca_grafica ("MARCA_CIRCULO", 1, btnNextTurnX, btnNextTurnY, 0.55)
  add_filtro(tipo_mensaje_ui_generico, id_boton_pasar_turno)
  on_event("secuencia47b", tipo_mensaje_game_buttton_release, id_boton_pasar_turno) -- PASAR TURNO
  
end

-------------------
-- PASO DE TURNO --
-------------------
function secuencia47b()

  limpia_eventos()
  limpia_filtros()
  filtrar_todos(true)
  elimina_todas_marcas(1)
  cerrar_ventana_tutorial()
  abrir_ventana_tutorial(width/2-250, height/2-300, tipo_ventana_normal, "LTEXT_TUTORIAL_GESTION_TITULO", "LTEXT_TUTORIAL_PASO_TURNO_A","LTEXT_TUTORIAL_PASO_TURNO_B", false)
  on_event("secuencia47c",tipo_mensaje_generico, MSG_GESTION_INICIO_TURNO) -- NUEVO TURNO

end

function secuencia47c()

  idEfectivoAustriaco = crea_ficha(TAM_EJERCITO,"GALICIA","TENIENTE","FUSILERO","FUSILERO","MILICIA")
  idEfectivoAustriacoGalicia = crea_ficha(TAM_EJERCITO,"GALICIA","TENIENTE","FUSILERO","FUSILERO","MILICIA")
  xAustriaco,yAustriaco,zAustriaco = mueve_ficha(TAM_EJERCITO, idEfectivoAustriaco, "POLONIA")
  --set_camera_target ( 9500, 9000, 0)
  --set_camera_zoom ( CAMARA_ZOOM_OUT, 3 )
  set_target_and_zoom(9500, 9000, 0, 1.0)
     
  secuencia47d()

end

function secuencia47d()
--comprueba si ha terminado el movimiento
  if ha_terminado_movimiento_ficha(TAM_EJERCITO, idEfectivoAustriaco) then
	-- obligatorio llamar a esto al finalizar un movimiento
    terminar_movimiento_ficha(TAM_EJERCITO, idEfectivoAustriaco, xAustriaco , yAustriaco, zAustriaco, "GALICIA", "POLONIA")
	-- cuando termina el movimiento se pasa a la siguiente secuencia
    secuencia48()
  else
    temporizador ( 0.5, "secuencia47d")
  end

end

---------------
-- GUERRA II --
---------------
function secuencia48()

  limpia_eventos()
  limpia_filtros()
  filtrar_todos(true)
  -- llamar a esta funcion despues de filtrar_todos(true) en los pasos en los que se permita salir del tutorial
  --	NOTA: la ventana de salir del tutorial solo saldra el los casos donde sale el menu en el juego habitual
  permite_menu_escape()
  permitir_camara()

  
  elimina_todas_marcas(1)
  cerrar_ventana_tutorial()
  abrir_ventana_tutorial(710, 90, tipo_ventana_alargado, "LTEXT_TUTORIAL_GESTION_TITULO", "LTEXT_TUTORIAL_GESTION_47_A","LTEXT_TUTORIAL_GESTION_47_B", true)
  add_filtro(tipo_mensaje_ui_generico, id_boton_ventana_tutorial)
  on_event("secuencia49", tipo_mensaje_game_buttton_release, id_boton_ventana_tutorial) -- CONTINUAR
 
end


----------------
-- GUERRA III --
----------------
function secuencia49()

  limpia_eventos()
  limpia_filtros()
  filtrar_todos(true)
  -- llamar a esta funcion despues de filtrar_todos(true) en los pasos en los que se permita salir del tutorial
  --	NOTA: la ventana de salir del tutorial solo saldra el los casos donde sale el menu en el juego habitual
  permite_menu_escape()
  permitir_camara()
  nueva_marca_grafica_3D("MARCA_FLECHA3DAMARILLA", 1, 10900, 200, 9700, 1.5, true)
  nueva_marca_grafica_3D("MARCA_FLECHA3DROJA", 1, 10000, 210, 8500, 2.5, true)
  
  --set_camera_target ( 12100, 10200, 0 )
  --set_camera_zoom ( CAMARA_ZOOM_OUT, 3 )
  set_target_and_zoom(11000, 7000, 0, 0.56)
  set_provincia_seleccionada ( "MINSK" )  
  limita_movimiento_a_provincias("MINSK");

  cerrar_ventana_tutorial()
  abrir_ventana_tutorial(710, 90, tipo_ventana_alargado, "LTEXT_TUTORIAL_GESTION_TITULO", "LTEXT_TUTORIAL_GESTION_48_A","LTEXT_TUTORIAL_GESTION_48_B", false)
  
  add_filtro(tipo_mensaje_ui_generico,ZONA_MAPA , MSG_MOUSE_L_CLICK)  
  add_filtro(tipo_mensaje_ui_generico,ZONA_MAPA , MSG_MOUSE_L_RELEASE)  
  add_filtro(tipo_mensaje_ui_generico,ZONA_MAPA , MSG_MOUSE_L_DRAG)  
  add_filtro(tipo_mensaje_ui_generico,ZONA_MAPA , MSG_MOUSE_MOVE)  
  add_filtro(tipo_mensaje_generico, MSG_GESTION_START_DRAG_AGRUPACION, idTropaInicial, SMG_OFICIAL)
  add_filtro(tipo_mensaje_generico, MSG_GESTION_END_DROP_AGRUPACION_EN_PROVINCIA, idTropaInicial, SMG_PROVINCIA_TERRESTRE)
  
  add_filtro(tipo_mensaje_generico, MSG_GESTION_END_DRAG_AGRUPACION, convierte_def_provincia_a_id("MINSK"), SMG_PROVINCIA_TERRESTRE)
  --temporizador ( tempz1, "secuencia24" ) -- EMBARCAR OFICIAL
  on_event("secuencia50", tipo_mensaje_generico, MSG_GESTION_END_DRAG_AGRUPACION, convierte_def_provincia_a_id("MINSK"), SMG_PROVINCIA_TERRESTRE)
 
   
  --temporizador ( tempz1, "secuencia50" ) -- MOVER OFICIAL
  
end

---------------
-- GUERRA IV --
---------------
function secuencia50()
  
  limpia_eventos()
  limpia_filtros()
  filtrar_todos(true)
  elimina_todas_marcas(1)
  -- llamar a esta funcion despues de filtrar_todos(true) en los pasos en los que se permita salir del tutorial
  --	NOTA: la ventana de salir del tutorial solo saldra el los casos donde sale el menu en el juego habitual
  permite_menu_escape()
  permitir_camara()
  set_target_and_zoom(12500, 7500, 0, -1.42)

  add_filtro(tipo_mensaje_generico, MSG_GESTION_END_DRAG_AGRUPACION, convierte_def_provincia_a_id("MINSK"), SMG_PROVINCIA_TERRESTRE)
  
  idEfectivoRuso2 = crea_ficha(TAM_EJERCITO,"KIEV","TENIENTE","FUSILERO","FUSILERO","MILICIA")
  idEfectivoRuso3 = crea_ficha(TAM_EJERCITO,"KIEV","TENIENTE","FUSILERO","FUSILERO","MILICIA")
  idEfectivoRuso4 = crea_ficha(TAM_EJERCITO,"KIEV","TENIENTE","FUSILERO","FUSILERO","MILICIA")
    
  cerrar_ventana_tutorial()
  abrir_ventana_tutorial(710, 90, tipo_ventana_alargado, "LTEXT_TUTORIAL_GESTION_TITULO", "LTEXT_TUTORIAL_GESTION_49_A","LTEXT_TUTORIAL_GESTION_49_B", false)
  nueva_marca_grafica ("MARCA_CIRCULO", 1, btnNextTurnX, btnNextTurnY, 0.55)
  
  --temporizador ( tempz1, "secuencia51" ) -- PASAR TURNO
  add_filtro(tipo_mensaje_ui_generico, id_boton_pasar_turno)
  on_event("secuencia50b", tipo_mensaje_game_buttton_release, id_boton_pasar_turno) -- PASAR TURNO  
  
end

-------------------
-- PASO DE TURNO --
-------------------
function secuencia50b()

  limpia_eventos()
  limpia_filtros()
  filtrar_todos(false)
  elimina_todas_marcas(1)
  cerrar_ventana_tutorial()
  abrir_ventana_tutorial(width/2-250, height/2-300, tipo_ventana_normal, "LTEXT_TUTORIAL_GESTION_TITULO", "LTEXT_TUTORIAL_PASO_TURNO_A","LTEXT_TUTORIAL_PASO_TURNO_B", false)
  on_event("secuencia50c",tipo_mensaje_generico, MSG_GESTION_INICIO_TURNO) -- NUEVO TURNO

end


----------------------
-- PASO DE TURNO II --
----------------------
function secuencia50c()

  elimina_todas_marcas(1)
  cerrar_ventana_tutorial()
  
  -- si se sabe que tipo de notificacion es se podrian quitar algunos
  add_filtro(tipo_mensaje_ui_generico, id_notificacion_peque)  
  add_filtro(tipo_mensaje_ui_generico, id_notificacion_grande)  
  add_filtro(tipo_mensaje_ui_generico, id_notificacion_gigante)  
  
  add_filtro(tipo_mensaje_ui_generico, id_boton_ok)
  
  on_event("secuencia50d", tipo_mensaje_ui_generico, id_notificacion_peque, MSG_GAME_CLOSE_DIALOGO) -- CERRAR VENTANA CONSTRUCCION
  on_event("secuencia50d", tipo_mensaje_ui_generico, id_notificacion_grande, MSG_GAME_CLOSE_DIALOGO) -- CERRAR VENTANA CONSTRUCCION
  on_event("secuencia50d", tipo_mensaje_ui_generico, id_notificacion_gigante, MSG_GAME_CLOSE_DIALOGO) -- CERRAR VENTANA CONSTRUCCION
   
end

-----------------------
-- PASO DE TURNO IIb --
-----------------------
function secuencia50d()

  elimina_todas_marcas(1)
  cerrar_ventana_tutorial()
  
  -- si se sabe que tipo de notificacion es se podrian quitar algunos
  add_filtro(tipo_mensaje_ui_generico, id_notificacion_peque)  
  add_filtro(tipo_mensaje_ui_generico, id_notificacion_grande)  
  add_filtro(tipo_mensaje_ui_generico, id_notificacion_gigante)  
  
  add_filtro(tipo_mensaje_ui_generico, id_boton_ok)
  
  on_event("secuencia51", tipo_mensaje_ui_generico, id_notificacion_peque, MSG_GAME_CLOSE_DIALOGO) -- CERRAR VENTANA CONSTRUCCION
  on_event("secuencia51", tipo_mensaje_ui_generico, id_notificacion_grande, MSG_GAME_CLOSE_DIALOGO) -- CERRAR VENTANA CONSTRUCCION
  on_event("secuencia51", tipo_mensaje_ui_generico, id_notificacion_gigante, MSG_GAME_CLOSE_DIALOGO) -- CERRAR VENTANA CONSTRUCCION
   
end

--------------
-- GUERRA V --
--------------
function secuencia51()

  limpia_eventos()
  limpia_filtros()
  filtrar_todos(true)
  -- llamar a esta funcion despues de filtrar_todos(true) en los pasos en los que se permita salir del tutorial
  --	NOTA: la ventana de salir del tutorial solo saldra el los casos donde sale el menu en el juego habitual
  permite_menu_escape()
  permitir_camara()
  elimina_todas_marcas(1)
  set_target_and_zoom(12500, 7500, 0, -1.42)
  
  nueva_marca_grafica_3D("MARCA_FLECHA3DAMARILLA", 1, 11900, 200, 8400, 1.5, true)
  nueva_marca_grafica_3D("MARCA_FLECHA3DROJA", 1, 9500, 210, 6500, 2.5, true)
  
  cerrar_ventana_tutorial()
  abrir_ventana_tutorial(710, 90, tipo_ventana_alargado, "LTEXT_TUTORIAL_GESTION_TITULO", "LTEXT_TUTORIAL_GESTION_50_A","LTEXT_TUTORIAL_GESTION_50_B", false)
  
  set_provincia_seleccionada ( "GALICIA" )  
  limita_movimiento_a_provincias("GALICIA");  
  
  selecciona_ficha(TAM_EJERCITO, idEfectivoRuso2)  
  add_filtro(tipo_mensaje_ui_generico,ZONA_MAPA , MSG_MOUSE_L_CLICK)  
  add_filtro(tipo_mensaje_ui_generico,ZONA_MAPA , MSG_MOUSE_L_RELEASE)  
  add_filtro(tipo_mensaje_ui_generico,ZONA_MAPA , MSG_MOUSE_L_DRAG)  
  add_filtro(tipo_mensaje_ui_generico,ZONA_MAPA , MSG_MOUSE_MOVE)
  add_filtro(tipo_mensaje_generico, MSG_GESTION_START_DRAG_AGRUPACION, idEfectivoRuso2, SMG_OFICIAL)
  add_filtro(tipo_mensaje_generico, MSG_GESTION_END_DROP_AGRUPACION_EN_PROVINCIA, idEfectivoRuso2, SMG_PROVINCIA_TERRESTRE)

  on_event("secuencia51b_start_drag_ruso2", tipo_mensaje_generico, MSG_GESTION_START_DRAG_AGRUPACION, idEfectivoRuso2, SMG_OFICIAL)
  
  add_filtro(tipo_mensaje_generico, MSG_GESTION_START_DRAG_AGRUPACION, idEfectivoRuso3, SMG_OFICIAL)
  add_filtro(tipo_mensaje_generico, MSG_GESTION_END_DROP_AGRUPACION_EN_PROVINCIA, idEfectivoRuso3, SMG_PROVINCIA_TERRESTRE)

  on_event("secuencia51b_start_drag_ruso3", tipo_mensaje_generico, MSG_GESTION_START_DRAG_AGRUPACION, idEfectivoRuso3, SMG_OFICIAL)
  
  add_filtro(tipo_mensaje_generico, MSG_GESTION_START_DRAG_AGRUPACION, idEfectivoRuso4, SMG_OFICIAL)
  add_filtro(tipo_mensaje_generico, MSG_GESTION_END_DROP_AGRUPACION_EN_PROVINCIA, idEfectivoRuso4, SMG_PROVINCIA_TERRESTRE)

  on_event("secuencia51b_start_drag_ruso4", tipo_mensaje_generico, MSG_GESTION_START_DRAG_AGRUPACION, idEfectivoRuso4, SMG_OFICIAL)

  add_filtro(tipo_mensaje_generico, MSG_GESTION_END_DRAG_AGRUPACION, convierte_def_provincia_a_id("GALICIA"), SMG_PROVINCIA_TERRESTRE)
  --temporizador ( tempz1, "secuencia24" ) -- EMBARCAR OFICIAL
  on_event("secuencia51b_end_drag", tipo_mensaje_generico, MSG_GESTION_END_DRAG_AGRUPACION, convierte_def_provincia_a_id("GALICIA"), SMG_PROVINCIA_TERRESTRE)

  -- temporizador ( tempz1, "secuencia52" ) -- MOVER OFICIAL

	start_drag_ruso2 = false  
	start_drag_ruso3 = false  
	start_drag_ruso4 = false  
	
	end_drag_ruso2 = false  
	end_drag_ruso3 = false  
	end_drag_ruso4 = false  

end

function secuencia51b_start_drag_ruso2()
  on_event("secuencia51b_start_drag_ruso2", tipo_mensaje_generico, MSG_GESTION_START_DRAG_AGRUPACION, idEfectivoRuso2, SMG_OFICIAL)
  start_drag_ruso2 = true  
  start_drag_ruso3 = false  
  start_drag_ruso4 = false  
end

function secuencia51b_start_drag_ruso3()
  on_event("secuencia51b_start_drag_ruso3", tipo_mensaje_generico, MSG_GESTION_START_DRAG_AGRUPACION, idEfectivoRuso3, SMG_OFICIAL)
  start_drag_ruso2 = false
  start_drag_ruso3 = true  
  start_drag_ruso4 = false  
end

function secuencia51b_start_drag_ruso4()
  on_event("secuencia51b_start_drag_ruso4", tipo_mensaje_generico, MSG_GESTION_START_DRAG_AGRUPACION, idEfectivoRuso4, SMG_OFICIAL)
  start_drag_ruso2 = false
  start_drag_ruso3 = false 
  start_drag_ruso4 = true  
end

function secuencia51b_end_drag()
	
	if (start_drag_ruso2) then
		end_drag_ruso2 = true
	end

	if (start_drag_ruso3) then
		end_drag_ruso3 = true
	end

	if (start_drag_ruso4) then
		end_drag_ruso4 = true
	end

	if ( end_drag_ruso2 and end_drag_ruso3 and end_drag_ruso4 ) then 
		secuencia52()
	else
	  -- hay que reponer el evento si quedan tropas por mover
	  on_event("secuencia51b_end_drag", tipo_mensaje_generico, MSG_GESTION_END_DRAG_AGRUPACION, convierte_def_provincia_a_id("GALICIA"), SMG_PROVINCIA_TERRESTRE)
	end
end

---------------
-- GUERRA VI --
---------------
function secuencia52()

  limpia_eventos()
  limpia_filtros()
  filtrar_todos(true)
  elimina_todas_marcas(1)
  -- llamar a esta funcion despues de filtrar_todos(true) en los pasos en los que se permita salir del tutorial
  --	NOTA: la ventana de salir del tutorial solo saldra el los casos donde sale el menu en el juego habitual
  permite_menu_escape()
  permitir_camara()
  set_target_and_zoom(12500, 7500, 0, -1.42)

  nueva_marca_grafica_3D("MARCA_FLECHA3DAMARILLA", 1, 10500, 200, 8400, 1.5, true)
  nueva_marca_grafica_3D("MARCA_FLECHA3DROJA", 1, 9500, 210, 6500, 2.5, true)
  
  selecciona_ficha(TAM_EJERCITO, idTropaInicial)  
  add_filtro(tipo_mensaje_ui_generico,ZONA_MAPA , MSG_MOUSE_L_CLICK)  
  add_filtro(tipo_mensaje_ui_generico,ZONA_MAPA , MSG_MOUSE_L_RELEASE)  
  add_filtro(tipo_mensaje_ui_generico,ZONA_MAPA , MSG_MOUSE_L_DRAG)  
  add_filtro(tipo_mensaje_ui_generico,ZONA_MAPA , MSG_MOUSE_MOVE)
  add_filtro(tipo_mensaje_generico, MSG_GESTION_START_DRAG_AGRUPACION, idTropaInicial, SMG_OFICIAL)
  add_filtro(tipo_mensaje_generico, MSG_GESTION_END_DROP_AGRUPACION_EN_PROVINCIA, idTropaInicial, SMG_PROVINCIA_TERRESTRE)
  
  cerrar_ventana_tutorial()
  abrir_ventana_tutorial(710, 90, tipo_ventana_alargado, "LTEXT_TUTORIAL_GESTION_TITULO", "LTEXT_TUTORIAL_GESTION_51_A","LTEXT_TUTORIAL_GESTION_51_B", false)
  --temporizador ( tempz1, "secuencia53" ) -- MOVER OFICIAL
  
  add_filtro(tipo_mensaje_generico, MSG_GESTION_END_DRAG_AGRUPACION, convierte_def_provincia_a_id("GALICIA"), SMG_PROVINCIA_TERRESTRE)
  --temporizador ( tempz1, "secuencia24" ) -- EMBARCAR OFICIAL
  on_event("secuencia52b", tipo_mensaje_generico, MSG_GESTION_END_DRAG_AGRUPACION, convierte_def_provincia_a_id("GALICIA"), SMG_PROVINCIA_TERRESTRE)
  
end

----------------------
-- REFUERZOS B      --
----------------------
function secuencia52b()

  limpia_eventos()
  elimina_todas_marcas(1)
  cerrar_ventana_tutorial()
  
  -- si se sabe que tipo de notificacion es se podrian quitar algunos
  add_filtro(tipo_mensaje_ui_generico, id_notificacion_peque)  
  add_filtro(tipo_mensaje_ui_generico, id_notificacion_grande)  
  add_filtro(tipo_mensaje_ui_generico, id_notificacion_gigante)  
  
  add_filtro(tipo_mensaje_ui_generico, id_boton_ok)
  add_filtro(tipo_mensaje_ui_generico, 256)  
  
  on_event("secuencia53", tipo_mensaje_ui_generico, id_notificacion_peque, MSG_GAME_CLOSE_DIALOGO) -- CERRAR VENTANA CONSTRUCCION
  on_event("secuencia53", tipo_mensaje_ui_generico, id_notificacion_grande, MSG_GAME_CLOSE_DIALOGO) -- CERRAR VENTANA CONSTRUCCION
  on_event("secuencia53", tipo_mensaje_ui_generico, id_notificacion_gigante, MSG_GAME_CLOSE_DIALOGO) -- CERRAR VENTANA CONSTRUCCION
   
end


---------------
-- REFUERZOS --
---------------
function secuencia53()

  limpia_eventos()
  limpia_filtros()
  filtrar_todos(true)
  elimina_todas_marcas(1)
  -- llamar a esta funcion despues de filtrar_todos(true) en los pasos en los que se permita salir del tutorial
  --	NOTA: la ventana de salir del tutorial solo saldra el los casos donde sale el menu en el juego habitual
  permite_menu_escape()
  permitir_camara()

  idBarcoAustriaco = crea_ficha(TAM_FLOTA,"MARBALTICO","CORBETA","JUG_AUSTRIA")
  cerrar_ventana_tutorial()
  abrir_ventana_tutorial(710, 90, tipo_ventana_alargado, "LTEXT_TUTORIAL_GESTION_TITULO", "LTEXT_TUTORIAL_GESTION_52_A","LTEXT_TUTORIAL_GESTION_52_B", true)
  add_filtro(tipo_mensaje_ui_generico, id_boton_ventana_tutorial)
  on_event("secuencia53b", tipo_mensaje_game_buttton_release, id_boton_ventana_tutorial) -- CONTINUAR
  
end

function secuencia53b()

  limpia_eventos()
  xAustriaco,yAustriaco,zAustriaco = mueve_ficha(TAM_FLOTA, idBarcoAustriaco, "GOLFOFINLANDIA")
  --set_camera_target ( 9500, 9000, 0)
  --set_camera_zoom ( CAMARA_ZOOM_OUT, 3 )
  set_target_and_zoom( 9500, 9000, 0, -1.0)
     
  secuencia53c()

end

function secuencia53c()

  elimina_todas_marcas(1)
--comprueba si ha terminado el movimiento
  if ha_terminado_movimiento_ficha(TAM_FLOTA, idBarcoAustriaco) then
	-- obligatorio llamar a esto al finalizar un movimiento
    terminar_movimiento_ficha(TAM_FLOTA, idBarcoAustriaco, xAustriaco , yAustriaco, zAustriaco, "MARBALTICO", "GOLFOFINLANDIA")
	-- cuando termina el movimiento se pasa a la siguiente secuencia
    secuencia53d()
  else
    temporizador ( 0.5, "secuencia53c")
  end

end


function secuencia53d()

  elimina_todas_marcas(1)
  xAustriaco,yAustriaco,zAustriaco = mueve_ficha(TAM_EJERCITO, idEfectivoAustriaco, "GALICIA")
  --set_camera_target ( 9500, 9000, 0)
  --set_camera_zoom ( CAMARA_ZOOM_OUT, 3 )
  set_target_and_zoom( 9500, 9000, 0, -1.0)
     
  secuencia53e()

end

function secuencia53e()

  elimina_todas_marcas(1)
--comprueba si ha terminado el movimiento
  if ha_terminado_movimiento_ficha(TAM_EJERCITO, idEfectivoAustriaco) then
	-- obligatorio llamar a esto al finalizar un movimiento
    terminar_movimiento_ficha(TAM_EJERCITO, idEfectivoAustriaco, xAustriaco , yAustriaco, zAustriaco, "POLONIA", "GALICIA" )
	-- cuando termina el movimiento se pasa a la siguiente secuencia
    secuencia54()
  else
    temporizador ( 0.5, "secuencia53e")
  end

end

---------------------------------
-- BARCO PRUSIANO Y PASA TURNO --
---------------------------------
function secuencia54()


  limpia_eventos()
  limpia_filtros()
  filtrar_todos(true)
  -- llamar a esta funcion despues de filtrar_todos(true) en los pasos en los que se permita salir del tutorial
  --	NOTA: la ventana de salir del tutorial solo saldra el los casos donde sale el menu en el juego habitual
  permite_menu_escape()
  permitir_camara()

  elimina_todas_marcas(1)
  cerrar_ventana_tutorial()
  abrir_ventana_tutorial(710, 90, tipo_ventana_alargado, "LTEXT_TUTORIAL_GESTION_TITULO", "LTEXT_TUTORIAL_GESTION_53_A","LTEXT_TUTORIAL_GESTION_53_B", false)
  nueva_marca_grafica ("MARCA_CIRCULO", 1, btnNextTurnX, btnNextTurnY, 0.55)
  --temporizador ( tempz1, "secuencia55" ) -- PASAR TURNO

  --add_filtro(tipo_mensaje_ui_generico, id_boton_ventana_tutorial)
  --on_event("secuencia54", tipo_mensaje_game_buttton_release, id_boton_ventana_tutorial) -- CONTINUAR
  
  add_filtro(tipo_mensaje_ui_generico, id_boton_pasar_turno)
  --on_event("secuenciaEsperaVentanaConflicto", tipo_mensaje_game_buttton_release, id_boton_pasar_turno) -- PASAR TURNO
  
  on_event("secuenciaEsperaVentanaConflicto", tipo_mensaje_ui_generico, id_boton_pasar_turno, MSG_MOUSE_L_RELEASE) -- PASAR TURNO
  on_event("secuenciaEsperaVentanaConflicto", tipo_mensaje_ui_generico, id_boton_pasar_turno, MSG_KEY_UP) -- PASAR TURNO  
  
  
end

function secuenciaEsperaVentanaConflicto()
  limpia_eventos()
  limpia_filtros()
  elimina_todas_marcas(1)
  filtrar_todos(false)
  
  on_event("secuenciaVentanaConflicto",tipo_mensaje_generico, MSG_GESTION_ABRIR_VENTANA_CONFLICTO) 
end

function secuenciaVentanaConflicto()

  limpia_eventos()
  limpia_filtros()
  filtrar_todos(true)
  elimina_todas_marcas(1)
  cerrar_ventana_tutorial()
  abrir_ventana_tutorial(710, 90, tipo_ventana_alargado, "LTEXT_TUTORIAL_GESTION_TITULO", "LTEXT_TUTORIAL_GESTION_54_A" ,"LTEXT_TUTORIAL_GESTION_54_B", true)
  add_filtro(tipo_mensaje_ui_generico, id_boton_ventana_tutorial)
  on_event("salidaDelTutorial", tipo_mensaje_game_buttton_release, id_boton_ventana_tutorial) -- CONTINUAR
  
end


---------------------------------------------------------------------------------------------------------------------------
-- FUNCIONES DE SALIDA DEL TUTORIAL DE GESTION
---------------------------------------------------------------------------------------------------------------------------

function salidaDelTutorial()
  id_ventana_confirmacion_fin_tutorial = 1234

  limpia_eventos()
  limpia_filtros()
  filtrar_todos(false)
  elimina_todas_marcas(1)  
  
  if tutorial_batalla_activo then

    open_messagebox (id_ventana_confirmacion_fin_tutorial,"LTEXT_TUTORIAL_FINAL_TODOS_TITULO", "LTEXT_TUTORIAL_FINAL_TODOS_GESTION_TEXTO",TMB_NORMAL,"LTEXT_TUTORIAL_FINAL_TODOS_MENUTUTORIAL","LTEXT_TUTORIAL_FINAL_TODOS_GESTION_BATALLA" )
    on_event("exit_to_tutorial_batalla" ,tipo_mensaje_messagebox_close, id_ventana_confirmacion_fin_tutorial, 1)

  elseif tutorial_naval_activo then

    open_messagebox (id_ventana_confirmacion_fin_tutorial,"LTEXT_TUTORIAL_FINAL_TODOS_TITULO", "LTEXT_TUTORIAL_FINAL_TODOS_GESTION_TEXTO",TMB_NORMAL,"LTEXT_TUTORIAL_FINAL_TODOS_MENUTUTORIAL","LTEXT_TUTORIAL_FINAL_TODOS_BATALLA_NAVAL" )
    on_event("exit_to_tutorial_naval" ,tipo_mensaje_messagebox_close, id_ventana_confirmacion_fin_tutorial, 1)

  else

    open_messagebox (id_ventana_confirmacion_fin_tutorial,"LTEXT_TUTORIAL_FINAL_TODOS_TITULO", "LTEXT_TUTORIAL_FINAL_SOLOGESTION_TEXTO",TMB_NORMAL,"LTEXT_TUTORIAL_FINAL_TODOS_MENUTUTORIAL" )

  end
  
  on_event("salir_borrando_marcas",tipo_mensaje_messagebox_close, id_ventana_confirmacion_fin_tutorial, 0)
  
end

function confirmacionSalidaDelTutorial()

  filtrar_todos(false)
  --elimina_todas_marcas(1)
  id_ventana_confirmacion_fin_tutorial = 1234

  open_messagebox (id_ventana_confirmacion_fin_tutorial,"LTEXT_TUTORIAL_SALIDA_TITULO", "LTEXT_TUTORIAL_SALIDA_TEXTO",TMB_NORMAL,"LTEXT_TUTORIAL_SALIDA_ACEPTAR","LTEXT_TUTORIAL_SALIDA_CANCELAR" )
  on_event("salir_borrando_marcas",tipo_mensaje_messagebox_close, id_ventana_confirmacion_fin_tutorial, 0)
  on_event("vuelve_al_tutorial",tipo_mensaje_messagebox_close, id_ventana_confirmacion_fin_tutorial, 1)

end

function vuelve_al_tutorial()

  filtrar_todos(true)
  ponEventoTeclaEscape()
  
end

function salir_borrando_marcas()

	elimina_todas_marcas(0)
	exit_to_main_menu();

end

function ponEventoTeclaEscape()
  -- on_event("confirmacionSalidaDelTutorial", tipo_mensaje_ui_generico,ID_TECLA_ESCAPE_GESTION, MSG_KEY_UP)
  on_event("confirmacionSalidaDelTutorial", tipo_mensaje_game_buttton_release,ID_BOTON_ESCAPE_GESTION)
end

function permite_menu_escape()

  add_filtro(tipo_mensaje_ui_generico, ID_TECLA_ESCAPE_GESTION)
  add_filtro(tipo_mensaje_ui_generico, ID_BOTON_ESCAPE_GESTION)
  ponEventoTeclaEscape()
  
end


-- 
-- Funcion para poner un target con un zoom determinado y haga bien los calculos respecto al zoom final
-- zoom_level es 0 para el zoom por defecto
--
function set_target_and_zoom(target_x, target_y, target_z, zoom_level)
  
  -- se guardan datos de zoom
  zoom_actual = get_camera_zoom()
  zoom_step =   get_zoom_step_size()
  
  -- se fija el zoom forzando a realizar los calculos con el zoom final
  if zoom_actual < zoom_level then
	set_camera_zoom ( CAMARA_ZOOM_IN, (zoom_level-zoom_actual)/zoom_step, true)
  else
	set_camera_zoom ( CAMARA_ZOOM_OUT, (zoom_actual-zoom_level)/zoom_step, true)
  end
  
  -- calculo del target con zoom final
  set_camera_target ( target_x, target_y, target_z)
  -- restauracion del zoom original
  set_camera_zoom ( CAMARA_ZOOM_VALOR, zoom_actual)

  -- al fin se establece el zoom sin forzarle para que sea una transicion suave
  if zoom_actual < zoom_level then
	set_camera_zoom ( CAMARA_ZOOM_IN, (zoom_level-zoom_actual)/zoom_step, false)
  else
	set_camera_zoom ( CAMARA_ZOOM_OUT, (zoom_actual-zoom_level)/zoom_step, false)
  end
  
end

--esVictoriaTotal()