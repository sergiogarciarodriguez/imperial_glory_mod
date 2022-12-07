-- ======================================================================================================
-- función principal de la secuencia.
-- se llamará al ejecutar la secuencia definida
-- por el script, y debera llamar la función
-- que inicia la primera secuencia
-- Rob es un tio guay q siempre ayuda a todos
-- ======================================================================================================
width = 1024
height = 768
numero_teclas_pulsadas = 0
traceback_function = ""
ID_EDIFICIO_CASA_GALICIA = "15Casa"

-- Posiciones de los iconos de interfaz
pos_interfaz_y = 666
pos_interfaz_1_x = -22
pos_interfaz_2_x = 32
pos_interfaz_3_x = 122
pos_interfaz_4_x = 148
pos_interfaz_5_x = 203


-- Cuidadin, no cambiar esto de orden ni de valores
RUSIA_INF_FUSILERO = 0
RUSIA_INF_TIRADOR = 1
RUSIA_CAB_LANCERO = 2
RUSIA_ART_OBUS = 3
RUSIA_INF_MILICIA = 4

AUSTRIA_INF_FUSILERO = 10
AUSTRIA_CAB_LANCERO = 11
AUSTRIA_INF_TIRADOR = 12

GRUPO_ALL_TROPAS = 666

ID_TECLA_UP    = 1264538960
ID_TECLA_DOWN  = 1264534606
ID_TECLA_LEFT  = 1264537682
ID_TECLA_RIGHT = 1264537157
ID_TECLA_STRAFE_LEFT = 1264536660
ID_TECLA_STRAFE_RIGHT = 1264538196

ID_ZONA_SCROLL_DCHA = 1113084500    --'BXRT'
ID_ZONA_SCROLL_IZQ = 1113082964     --'BXLT'
ID_ZONA_SCROLL_ARRIBA = 1113085264  --'BXUP'
ID_ZONA_SCROLL_ABAJO = 1113080910   --'BXDN'


ID_TECLA_ORIENTAR = 1263489609 -- hotkey orientar

ID_ZONA_SENSIBLE = 1113081665

ID_MINIMAPA      = 1296908624

ID_TECLA_CREACION_GRUPO_1 = 1262700337
ID_TECLA_SELEC_GRUPO_1 = 1263748913

ID_BOTON_INF_FUSILERO = 1409286148
ID_BOTON_INF_TIRADOR = 1409286149
ID_BOTON_INF_MILICIA = 1409286152
ID_BOTON_ART_OBUS = 1409286151
ID_BOTON_CAB_LANCERO = 1409286150

ID_BOTON_FORM_CUADRO = 1111900996
ID_BOTON_ANCLAR = 1095648065

ID_BOTON_ESC = 1111839555

ID_ORDEN_OCUPAR_EDIF = 1329939529
ID_ORDEN_CLICK_TROPA = 1129599567
ID_ORDEN_CLICK_OBJETO = 1129267786
ID_ORDEN_DESOCUPAR_EDIF = 1145390153

ID_TECLA_ESC = 1296388931
ID_MSGBOX_SALIRTUTORIAL = 1514230869
ID_MSGBOX_SALIR_TUTORIAL_BOTON1 = 128
ID_MSGBOX_SALIR_TUTORIAL_BOTON2 = 129
ID_MSGBOX_SALIR_TUTORIAL_BOTON3 = 130
ID_MSGBOX_SALIR_TUTORIAL_BOTON4 = 131


-- ---- EXAMPLES ------------------------------------------------
-- 
-- unselectAllTropas()
-- selectTropa( RUSIA_CAB_LANCERO )
-- 
-- goTropa( AUSTRIA_INF_FUSILERO, 40000.0, 40000.0, 1, 90.0 ) -- posX, posY, correr(0 o 1), orientacionFinal (0.0 -> 360.0)
-- goTropa( AUSTRIA_CAB_LANCERO, 40000.0, 40000.0, 1, 90.0 ) -- posX, posY, correr(0 o 1), orientacionFinal (0.0 -> 360.0)
-- 
-- moverCamaraATropa( RUSIA_CAB_LANCERO )
-- crearCirculo3D( 2, 35000.0, 30000.0, 500.0 ) -- id, pos, radio
-- borraCirculo3D( 2 ) -- id
--
-- on_event( tropa_movida, 30000.0, 3000.0 , 1500.0) -- preguntar a Rob si se quiere usar esto, es para q ocurra un evento cuando una tropa llega a una pos
--
-- --------------------------------------------------------------


function permitirESC()

  add_filtro( tipo_mensaje_ui_generico, ID_TECLA_ESC )
  add_filtro( tipo_mensaje_ui_generico, ID_MSGBOX_SALIRTUTORIAL )
  add_filtro( tipo_mensaje_ui_generico, ID_MSGBOX_SALIR_TUTORIAL_BOTON1 )
  add_filtro( tipo_mensaje_ui_generico, ID_MSGBOX_SALIR_TUTORIAL_BOTON2 )
  add_filtro( tipo_mensaje_ui_generico, ID_MSGBOX_SALIR_TUTORIAL_BOTON3 )
  add_filtro( tipo_mensaje_ui_generico, ID_MSGBOX_SALIR_TUTORIAL_BOTON4 )
  
  add_filtro( tipo_mensaje_ui_generico, ID_BOTON_ESC )
  
end

-----------------------------------------
-- PERMITE MOVIMIENTO DE CAMARA Y ZOOM --
-----------------------------------------
function permitir_camara()

  add_filtro(tipo_mensaje_ui_generico, ID_TECLA_UP   )
  add_filtro(tipo_mensaje_ui_generico, ID_TECLA_DOWN )
  add_filtro(tipo_mensaje_ui_generico, ID_TECLA_LEFT )
  add_filtro(tipo_mensaje_ui_generico, ID_TECLA_RIGHT) 
  add_filtro(tipo_mensaje_ui_generico, ID_TECLA_STRAFE_LEFT) 
  add_filtro(tipo_mensaje_ui_generico, ID_TECLA_STRAFE_RIGHT) 
  
  add_filtro(tipo_mensaje_ui_generico, ID_ZONA_SENSIBLE, MSG_MOUSE_WHEEL)

  add_filtro(tipo_mensaje_ui_generico, ID_ZONA_SCROLL_DCHA, MSG_MOUSE_LEAVE)
  add_filtro(tipo_mensaje_ui_generico, ID_ZONA_SCROLL_DCHA, MSG_MOUSE_ENTER)
  add_filtro(tipo_mensaje_ui_generico, ID_ZONA_SCROLL_IZQ, MSG_MOUSE_LEAVE)
  add_filtro(tipo_mensaje_ui_generico, ID_ZONA_SCROLL_IZQ, MSG_MOUSE_ENTER)
  add_filtro(tipo_mensaje_ui_generico, ID_ZONA_SCROLL_ARRIBA, MSG_MOUSE_LEAVE)
  add_filtro(tipo_mensaje_ui_generico, ID_ZONA_SCROLL_ARRIBA, MSG_MOUSE_ENTER) 
  add_filtro(tipo_mensaje_ui_generico, ID_ZONA_SCROLL_ABAJO, MSG_MOUSE_LEAVE)
  add_filtro(tipo_mensaje_ui_generico, ID_ZONA_SCROLL_ABAJO, MSG_MOUSE_ENTER) 

end
-- --------------------------------------------------------------
-- --------------------------------------------------------------
function mover_error_fusilero()
  
  teleportTropa( RUSIA_INF_FUSILERO, 34000.0, 35000.0, 50.0 )
  moverCamaraATropa( RUSIA_INF_FUSILERO )
  
  borraCirculo3D( 1 )
  step4()
  
end

function mover_error_grupo()
  
  teleportTropa( RUSIA_INF_FUSILERO, 34000.0, 40000.0, 50.0 )
  teleportTropa( RUSIA_INF_TIRADOR, 35000.0, 40000.0, 40.0 )
  teleportTropa( RUSIA_CAB_LANCERO, 36000.0, 40000.0, 30.0 )
  teleportTropa( RUSIA_ART_OBUS, 37000.0, 40000.0, 20.0 )
  teleportTropa( RUSIA_INF_MILICIA, 38000.0, 40000.0, 10.0 )   
  
  moverCamaraATropa( RUSIA_CAB_LANCERO )
  
  borraCirculo3D( 2 )
  
  step7()
  
end

function mover_error_fusilero_apostar()
  
  teleportTropa( RUSIA_INF_FUSILERO, 42000.0, 46700.0, 0.0 )
  moverCamaraATropa( RUSIA_INF_FUSILERO )
  
  borraCirculo3D( 3 )
  step10b()
  
end


-- ======================================================================================================
-- inicia_secuencia: punto de entrada de la secuencia LUA
-- ======================================================================================================
function inicia_secuencia()

  limpia_eventos ()
  limpia_filtros ()
  filtrar_todos(true)
  oculta_minimapa()
  borraCirculo3D(1)
  borraCirculo3D(2)
  borraCirculo3D(3)
  borraCirculo3D(4)
  elimina_marca_grafica(1, 0.8) 
  
  oculta_tropas_enemigas()
  startTutorial()
end

-- ======================================================================================================
-- startTutorial: Preparación del tutorial.
-- ======================================================================================================
function startTutorial()
  
  -- Preparamos el tutorial y lanzamos el primer paso
  teleportTropa( RUSIA_INF_FUSILERO, 30000.0, 36000.0, 50.0 )
  teleportTropa( RUSIA_INF_TIRADOR, 35000.0, 40000.0, 40.0 )
  teleportTropa( RUSIA_CAB_LANCERO, 36000.0, 40000.0, 30.0 )
  teleportTropa( RUSIA_ART_OBUS, 37000.0, 40000.0, 20.0 )
  teleportTropa( RUSIA_INF_MILICIA, 38000.0, 40000.0, 10.0 )  
  
  -- posiciones iniciales en una esquina del mapa
  teleportTropa( AUSTRIA_INF_FUSILERO, 7000.0, 7000.0, 20.0 )
  teleportTropa( AUSTRIA_CAB_LANCERO, 7100.0, 7000.0, 10.0 )  
  teleportTropa( AUSTRIA_INF_TIRADOR, 7200.0, 7000.0, 10.0 )    
  
  moverCamaraATropa( RUSIA_INF_FUSILERO)
   
  step0()
  
end

-- ===============
-- ERROR
-- ===============
function step_error()

  limpia_eventos ()
  limpia_filtros ()
  filtrar_todos(true)

  cerrar_ventana_tutorial()
  abrir_ventana_tutorial(250, 50, tipo_ventana_normal, "LTEXT_TUTORIAL_BATALLA_TITULO", 
                         "LTEXT_TUTORIAL_GENERICO_ERROR",
                         "LTEXT_TUTORIAL_BATALLA_0_B", true)
  
  add_filtro(tipo_mensaje_ui_generico, id_boton_ventana_tutorial)
  add_filtro(tipo_mensaje_ui_generico, id_boton_ventana_tutorial, MSG_MOUSE_L_RELEASE)
  add_filtro(tipo_mensaje_ui_generico, id_boton_ventana_tutorial, MSG_MOUSE_ENTER)
  add_filtro(tipo_mensaje_ui_generico, id_boton_ventana_tutorial, MSG_MOUSE_LEAVE)
  add_filtro(tipo_mensaje_ui_generico, id_boton_ventana_tutorial, MSG_KEY_UP)
  
  on_event(traceback_function, tipo_mensaje_ui_generico, id_boton_ventana_tutorial, MSG_MOUSE_L_RELEASE)

end

-- ======================================================================================================
-- step0
-- ======================================================================================================
function step0 ()

  cerrar_ventana_tutorial()
  abrir_ventana_tutorial(10, 50, tipo_ventana_alargado, "LTEXT_TUTORIAL_BATALLA_TITULO", "LTEXT_TUTORIAL_BATALLA_1_A", "LTEXT_TUTORIAL_BATALLA_1_B", true)
  add_filtro(tipo_mensaje_ui_generico, id_boton_ventana_tutorial)
  on_event("step1", tipo_mensaje_game_buttton_release, id_boton_ventana_tutorial)
  
  permitirESC()
  permitir_camara()
  
end

-- ======================================================================================================
-- step1
-- ======================================================================================================
function step1 ()

  cerrar_ventana_tutorial()
  abrir_ventana_tutorial(10, 50, tipo_ventana_alargado, "LTEXT_TUTORIAL_BATALLA_TITULO", "LTEXT_TUTORIAL_BATALLA_0_A", "LTEXT_TUTORIAL_BATALLA_0_B", true)
  
  permitirESC()
  permitir_camara()
  
  add_filtro(tipo_mensaje_ui_generico, id_boton_ventana_tutorial)
  add_filtro(tipo_mensaje_ui_generico, id_boton_ventana_tutorial, MSG_MOUSE_L_RELEASE)
  add_filtro(tipo_mensaje_ui_generico, id_boton_ventana_tutorial, MSG_MOUSE_ENTER)
  add_filtro(tipo_mensaje_ui_generico, id_boton_ventana_tutorial, MSG_MOUSE_LEAVE)
  add_filtro(tipo_mensaje_ui_generico, id_boton_ventana_tutorial, MSG_KEY_UP)
  on_event("step2", tipo_mensaje_ui_generico, id_boton_ventana_tutorial, MSG_MOUSE_L_RELEASE)
  
end

-- ======================================================================================================
-- step2
-- ======================================================================================================
function step2()

  cerrar_ventana_tutorial()
  abrir_ventana_tutorial(250, 50, tipo_ventana_normal, "LTEXT_TUTORIAL_BATALLA_TITULO", 
                         "LTEXT_TUTORIAL_BATALLA_2_A",
                         "LTEXT_TUTORIAL_BATALLA_2_B", false)
  
  permitirESC()                    
  permitir_camara()

  on_event("contador_teclas",    tipo_mensaje_ui_generico, ID_TECLA_UP)
  on_event("contador_teclas",  tipo_mensaje_ui_generico, ID_TECLA_DOWN)
  on_event("contador_teclas",  tipo_mensaje_ui_generico, ID_TECLA_LEFT)
  on_event("contador_teclas", tipo_mensaje_ui_generico, ID_TECLA_RIGHT)
 
end

-- ---------------------- teclas camara  ------------------
function contador_teclas()
  numero_teclas_pulsadas = numero_teclas_pulsadas + 1
  if numero_teclas_pulsadas >= 4 then
    temporizador ( 1 , "step3" )
    numero_teclas_pulsadas = 0
  end

end


-- ======================================================================================================
-- step3
-- ======================================================================================================
function step3()

  cerrar_ventana_tutorial()
  abrir_ventana_tutorial(250, 50, tipo_ventana_grande, "LTEXT_TUTORIAL_BATALLA_TITULO", 
  	"LTEXT_TUTORIAL_BATALLA_3_A", 
  	"LTEXT_TUTORIAL_BATALLA_3_B", false)
  
  unselectAllTropas()
  nueva_marca_grafica("MARCA_CIRCULO", 1, pos_interfaz_1_x, pos_interfaz_y, 0.4)
  
  add_filtro(tipo_mensaje_ui_generico, 1398035023) -- selector de tropas
  add_filtro(tipo_mensaje_ui_generico, 1111577155) -- barra control

  add_filtro(tipo_mensaje_ui_generico, ID_BOTON_INF_FUSILERO)
  
  on_event( "step4", tipo_mensaje_ui_generico, ID_BOTON_INF_FUSILERO, MSG_MOUSE_L_RELEASE)
    
end

-- ======================================================================================================
-- step4
-- ======================================================================================================
function step4()

  elimina_marca_grafica(1, 0.8) 
  cerrar_ventana_tutorial()
  moverCamaraATropa( RUSIA_INF_FUSILERO )
  abrir_ventana_tutorial(10, 50, tipo_ventana_alargado, "LTEXT_TUTORIAL_BATALLA_TITULO", 
  	"LTEXT_TUTORIAL_BATALLA_4_A", 
  	"LTEXT_TUTORIAL_BATALLA_4_B", false)
    
  crearCirculo3D( 1, 34000.0, 40000.0, 1500.0 )
  
  add_filtro(tipo_mensaje_ui_generico, ID_ZONA_SENSIBLE, MSG_MOUSE_R_CLICK)
  add_filtro(tipo_mensaje_ui_generico, ID_ZONA_SENSIBLE, MSG_MOUSE_R_RELEASE)
  add_filtro(tipo_mensaje_ui_generico, ID_ZONA_SENSIBLE, MSG_MOUSE_R_DRAG)
  add_filtro(tipo_mensaje_ui_generico, ID_ZONA_SENSIBLE, MSG_MOUSE_MOVE)
        
  on_event( "mover_error_fusilero", tipo_mensaje_tropa_movida, RUSIA_INF_FUSILERO, 7000.0, 7000.0, 2500.0 )

  on_event( "step4b", tipo_mensaje_orden_mov, RUSIA_INF_FUSILERO, 34000.0, 40000.0, 1500.0 )
  
end

-- ============
-- step 4b
-- ============
function step4b()

  limpia_eventos ()
  limpia_filtros ()
  filtrar_todos (true)
  
  permitirESC()
  permitir_camara()
  
  cerrar_ventana_tutorial()
  abrir_ventana_tutorial(10, 50, tipo_ventana_alargado, "LTEXT_TUTORIAL_BATALLA_TITULO", "LTEXT_TUTORIAL_BATALLA_4_C", "", false)
 
  on_event( "step5", tipo_mensaje_tropa_movida, RUSIA_INF_FUSILERO, 34000.0, 40000.0, 1500.0 )

end



-- ======================================================================================================
-- step5
-- ======================================================================================================
function step5()
  
  cerrar_ventana_tutorial()
  borraCirculo3D( 1 )
  moverCamaraATropa( RUSIA_INF_FUSILERO )
  abrir_ventana_tutorial(10, 50, tipo_ventana_alargado, "LTEXT_TUTORIAL_BATALLA_TITULO", 
  	"LTEXT_TUTORIAL_BATALLA_5_A", 
  	"LTEXT_TUTORIAL_BATALLA_5_B", false)

  add_filtro(tipo_mensaje_ui_generico, 1398035023) -- selector de tropas
  add_filtro(tipo_mensaje_ui_generico, 1111577155) -- barra control
  
  add_filtro(tipo_mensaje_ui_generico, ID_ZONA_SENSIBLE, MSG_MOUSE_L_CLICK)
  add_filtro(tipo_mensaje_ui_generico, ID_ZONA_SENSIBLE, MSG_MOUSE_L_DRAG)
  add_filtro(tipo_mensaje_ui_generico, ID_ZONA_SENSIBLE, MSG_MOUSE_MOVE)
  add_filtro(tipo_mensaje_ui_generico, ID_ZONA_SENSIBLE, MSG_MOUSE_L_RELEASE)
  add_filtro(tipo_mensaje_ui_generico, ID_ZONA_SENSIBLE, MSG_MOUSE_ENTER)
  add_filtro(tipo_mensaje_ui_generico, ID_ZONA_SENSIBLE, MSG_MOUSE_LEAVE)
  
  add_filtro(tipo_mensaje_ui_generico, ID_ZONA_SENSIBLE, 121) -- END_DRAG

  on_event( "step6", tipo_mensaje_tropas_seleccionadas, GRUPO_ALL_TROPAS )
  
end

-- ======================================================================================================
-- step 6
-- ======================================================================================================
function step6()
	
  cerrar_ventana_tutorial()
  
  limpia_eventos ()
  limpia_filtros ()
  filtrar_todos (true)
  
  permitirESC()
  permitir_camara()
  
  moverCamaraATropa( RUSIA_CAB_LANCERO )
  
  abrir_ventana_tutorial(10, 50, tipo_ventana_alargado, "LTEXT_TUTORIAL_BATALLA_TITULO", 
  	"LTEXT_TUTORIAL_BATALLA_6_A", 
  	"LTEXT_TUTORIAL_BATALLA_6_B", false)
   
  add_filtro(tipo_mensaje_ui_generico, ID_TECLA_CREACION_GRUPO_1)
  on_event("step7", tipo_mensaje_ui_generico, ID_TECLA_CREACION_GRUPO_1)

end

-- ======================================================================================================
-- step 7
-- ======================================================================================================
function step7()
	
  cerrar_ventana_tutorial()
  
  limpia_eventos ()
  
  permitirESC()
  permitir_camara()
  
  abrir_ventana_tutorial(10, 50, tipo_ventana_alargado, "LTEXT_TUTORIAL_BATALLA_TITULO", 
  	"LTEXT_TUTORIAL_BATALLA_7_A", 
  	"LTEXT_TUTORIAL_BATALLA_7_B", false)
  	
  crearCirculo3D( 2, 40000.0, 45000.0, 1500.0 )
  
  add_filtro(tipo_mensaje_ui_generico, ID_ZONA_SENSIBLE, MSG_MOUSE_R_CLICK)
  --add_filtro(tipo_mensaje_ui_generico, ID_ZONA_SENSIBLE, MSG_MOUSE_R_DRAG)
  add_filtro(tipo_mensaje_ui_generico, ID_ZONA_SENSIBLE, MSG_MOUSE_MOVE)
  add_filtro(tipo_mensaje_ui_generico, ID_ZONA_SENSIBLE, MSG_MOUSE_R_RELEASE)
  add_filtro(tipo_mensaje_ui_generico, ID_ZONA_SENSIBLE, MSG_MOUSE_ENTER)
  add_filtro(tipo_mensaje_ui_generico, ID_ZONA_SENSIBLE, MSG_MOUSE_LEAVE)
  
  on_event( "mover_error_grupo", tipo_mensaje_tropa_movida, RUSIA_INF_FUSILERO, 5000.0, 5000.0, 1500.0 )
  on_event( "mover_error_grupo", tipo_mensaje_tropa_movida, RUSIA_INF_MILICIA,  5000.0, 5000.0, 1500.0 )
  on_event( "mover_error_grupo", tipo_mensaje_tropa_movida, RUSIA_INF_TIRADOR,  5000.0, 5000.0, 1500.0 )
  on_event( "mover_error_grupo", tipo_mensaje_tropa_movida, RUSIA_CAB_LANCERO,  5000.0, 5000.0, 1500.0 )
  on_event( "mover_error_grupo", tipo_mensaje_tropa_movida, RUSIA_ART_OBUS,     5000.0, 5000.0, 1500.0 )
  
  on_event( "step7b", tipo_mensaje_orden_mov, GRUPO_ALL_TROPAS, 40000.0, 45000.0, 1500.0 ) -- Rob
    
end


-- ==================================================================
-- step 7b
-- ==================================================================
function step7b()

  limpia_eventos ()
  limpia_filtros ()
  filtrar_todos (true)
  
  permitirESC()
  permitir_camara()
  
  cerrar_ventana_tutorial()
  
  abrir_ventana_tutorial(10, 50, tipo_ventana_alargado, "LTEXT_TUTORIAL_BATALLA_TITULO", "LTEXT_TUTORIAL_BATALLA_8_A", "", false)
  
  on_event( "step9", tipo_mensaje_tropa_movida, RUSIA_INF_TIRADOR,  40000.0, 45000.0, 2000.0 )
  on_event( "step9", tipo_mensaje_tropa_movida, RUSIA_INF_MILICIA,  40000.0, 45000.0, 2000.0 )
  on_event( "step9", tipo_mensaje_tropa_movida, RUSIA_INF_FUSILERO, 40000.0, 45000.0, 2000.0 )
  on_event( "step9", tipo_mensaje_tropa_movida, RUSIA_ART_OBUS,     40000.0, 45000.0, 2000.0 )
  on_event( "step9", tipo_mensaje_tropa_movida, RUSIA_CAB_LANCERO,  40000.0, 45000.0, 2000.0 )
  
  --temporizador (40, "step9")
  
 end
 
 -- ==================================================================
-- step 9
-- ==================================================================
function step9()
  
  limpia_eventos ()
  limpia_filtros ()
  filtrar_todos (true)
  
  permitirESC()
  permitir_camara()
  
  borraCirculo3D( 2 )

  muestra_tropas_enemigas()
  teleportTropa( AUSTRIA_INF_FUSILERO, 41782.0, 59108.0, 180.0 )
  teleportTropa( AUSTRIA_CAB_LANCERO, 42782.0, 59108.0, 180.0 ) 
  teleportTropa( AUSTRIA_INF_TIRADOR , 43782.0, 59108.0, 180.0 ) 
  
  
  cerrar_ventana_tutorial()
  abrir_ventana_tutorial(10, 50, tipo_ventana_alargado, "LTEXT_TUTORIAL_BATALLA_TITULO", "LTEXT_TUTORIAL_BATALLA_9_A", "", false)
   
    
  -- Para q vayan a las posiciones predefinidas
  goTropa( RUSIA_INF_TIRADOR, 41000.0, 46700.0, 1, 0.0 ) 
  goTropa( RUSIA_INF_FUSILERO, 42000.0, 46700.0, 1, 0.0 ) 
  goTropa( RUSIA_ART_OBUS, 43527.0, 43000.0, 0, 0.0 ) 
  goTropa( RUSIA_INF_MILICIA, 44527.0, 43000.0, 1, 0.0 ) 
  goTropa( RUSIA_CAB_LANCERO, 46000.0, 46200.0, 1, 300.0 )  
  
  on_event("step10", tipo_mensaje_tropa_movida, RUSIA_ART_OBUS, 43527.0, 43000.0, 500.0 )
  
 end


 -- ==================================================================
-- step 10
-- ==================================================================
function step10()

  limpia_eventos ()
  limpia_filtros ()
  filtrar_todos (true)
  
  permitirESC()
  permitir_camara()
  
  cerrar_ventana_tutorial()
  abrir_ventana_tutorial(10, 50, tipo_ventana_alargado, "LTEXT_TUTORIAL_BATALLA_TITULO", "LTEXT_TUTORIAL_BATALLA_10_A", "LTEXT_TUTORIAL_BATALLA_10_B", false)
  
  add_filtro(tipo_mensaje_ui_generico, 1398035023) -- selector de tropas
  add_filtro(tipo_mensaje_ui_generico, 1111577155) -- barra control
  add_filtro(tipo_mensaje_ui_generico, ID_BOTON_INF_FUSILERO)
  
  
  nueva_marca_grafica("MARCA_CIRCULO", 1, pos_interfaz_1_x, pos_interfaz_y, 0.4)
  
  add_filtro(tipo_mensaje_ui_generico, ID_ZONA_SENSIBLE, MSG_MOUSE_L_CLICK )
  add_filtro(tipo_mensaje_ui_generico, ID_ZONA_SENSIBLE, MSG_MOUSE_L_RELEASE )
  add_filtro(tipo_mensaje_ui_generico, ID_ZONA_SENSIBLE, MSG_MOUSE_MOVE )
  
  add_filtro(tipo_mensaje_ui_generico, 1414743372)  -- tropa seleccionada
  
  on_event( "step10b", tipo_mensaje_tropas_seleccionadas, RUSIA_INF_FUSILERO )
  on_event( "step10b", tipo_mensaje_ui_generico, ID_BOTON_INF_FUSILERO, MSG_MOUSE_L_RELEASE)
  
  traceback_function = "step10"
  on_event( "step_error", tipo_mensaje_ui_generico, ID_BOTON_INF_TIRADOR, MSG_MOUSE_L_RELEASE)
  on_event( "step_error", tipo_mensaje_ui_generico, ID_BOTON_CAB_LANCERO, MSG_MOUSE_L_RELEASE)
  on_event( "step_error", tipo_mensaje_ui_generico, ID_BOTON_ART_OBUS, MSG_MOUSE_L_RELEASE)
  on_event( "step_error", tipo_mensaje_ui_generico, ID_BOTON_INF_MILICIA, MSG_MOUSE_L_RELEASE)
  
 end

 -- ==================================================================
-- step 10b
-- ==================================================================
function step10b()

  limpia_eventos ()
  limpia_filtros ()
  filtrar_todos (true)
  
  permitirESC()
  permitir_camara()
  
  elimina_marca_grafica(1, 0.8) 
  
  cerrar_ventana_tutorial()
  abrir_ventana_tutorial(10, 50, tipo_ventana_alargado, "LTEXT_TUTORIAL_BATALLA_TITULO", "LTEXT_TUTORIAL_BATALLA_10_C", "LTEXT_TUTORIAL_BATALLA_10_D", false)
  
  moverCamaraATropa( RUSIA_INF_FUSILERO )
  crearCirculo3D( 3, 47500.0, 51000.0, 1500.0 )
  
  
  add_filtro(tipo_mensaje_ui_generico, 1398035023) -- selector de tropas
  add_filtro(tipo_mensaje_ui_generico, 1111577155) -- barra control
  
  add_filtro(tipo_mensaje_ui_generico, ID_ORDEN_OCUPAR_EDIF)
  
  add_filtro(tipo_mensaje_ui_generico, ID_ZONA_SENSIBLE, MSG_MOUSE_R_DRAG)
  add_filtro(tipo_mensaje_ui_generico, ID_ZONA_SENSIBLE, MSG_MOUSE_R_CLICK)
  add_filtro(tipo_mensaje_ui_generico, ID_ZONA_SENSIBLE, MSG_MOUSE_R_RELEASE)
  add_filtro(tipo_mensaje_ui_generico, ID_ZONA_SENSIBLE, MSG_MOUSE_MOVE)
  
  add_filtro(tipo_mensaje_ui_generico, ID_BOTON_INF_FUSILERO)
  add_filtro(tipo_mensaje_ui_generico, 1145393985)  -- BOTON DE DESAPOSTAR!!!
  add_filtro(tipo_mensaje_ui_generico, ID_ORDEN_DESOCUPAR_EDIF)


  	
  on_event( "mover_error_fusilero_apostar", tipo_mensaje_tropa_movida, RUSIA_INF_FUSILERO, 42300.0, 60300.0, 8500.0 )
  	
  on_event( "step11", tipo_mensaje_orden_apostar, RUSIA_INF_FUSILERO, ID_EDIFICIO_CASA_GALICIA )
  
 end
 
-- ==================================================================
-- step 11
-- ==================================================================
function step11()

  borraCirculo3D(3)
  cerrar_ventana_tutorial()
  abrir_ventana_tutorial(10, 50, tipo_ventana_alargado, "LTEXT_TUTORIAL_BATALLA_TITULO", "LTEXT_TUTORIAL_BATALLA_11_A", "LTEXT_TUTORIAL_BATALLA_11_B", true)
  
  -- Marca de desapostar
  nueva_marca_grafica("MARCA_AMARILLA", 1, 927, pos_interfaz_y + 38, 0.3)
  
  add_filtro(tipo_mensaje_ui_generico, id_boton_ventana_tutorial)
  on_event("step12", tipo_mensaje_game_buttton_release, id_boton_ventana_tutorial)
  
 end
 
  -- ==================================================================
-- step 12
-- ==================================================================
function step12()

  elimina_marca_grafica(1, 0.8) 
  
  permitirESC()
  permitir_camara()
  
  cerrar_ventana_tutorial()
  abrir_ventana_tutorial(10, 50, tipo_ventana_alargado, "LTEXT_TUTORIAL_BATALLA_TITULO", "LTEXT_TUTORIAL_BATALLA_12_A", "LTEXT_TUTORIAL_BATALLA_12_B", true)
  
  add_filtro(tipo_mensaje_ui_generico, id_boton_ventana_tutorial)
  on_event("step13", tipo_mensaje_game_buttton_release, id_boton_ventana_tutorial)
  
 end
 
-- ==================================================================
-- step 13
-- ==================================================================
function step13()

  muestra_minimapa()
  cerrar_ventana_tutorial()
  abrir_ventana_tutorial(710, 50, tipo_ventana_alargado, "LTEXT_TUTORIAL_BATALLA_TITULO", "LTEXT_TUTORIAL_BATALLA_13_A", "LTEXT_TUTORIAL_BATALLA_12_B", true)
  
  add_filtro(tipo_mensaje_ui_generico, id_boton_ventana_tutorial)
  on_event("step13x", tipo_mensaje_game_buttton_release, id_boton_ventana_tutorial)
  
 end
 
-- ==================================================================
-- step 13x. Esperamos q se seleccione la artilleria
-- ==================================================================
function step13x()

  oculta_minimapa()
  limpia_eventos ()
  limpia_filtros ()
  filtrar_todos (true)
  
  permitirESC()
  permitir_camara()
  
  cerrar_ventana_tutorial()
  abrir_ventana_tutorial(10, 50, tipo_ventana_alargado, "LTEXT_TUTORIAL_BATALLA_TITULO", "LTEXT_TUTORIAL_BATALLA_13X_A", "LTEXT_TUTORIAL_BATALLA_13X_B", false )
   
  nueva_marca_grafica("MARCA_CIRCULO", 1, pos_interfaz_5_x, pos_interfaz_y, 0.4)
  
  add_filtro(tipo_mensaje_ui_generico, 1398035023) -- selector de tropas
  add_filtro(tipo_mensaje_ui_generico, 1111577155) -- barra control
  add_filtro(tipo_mensaje_ui_generico, ID_BOTON_ART_OBUS)
  
  
  traceback_function = "step13x"
  
  on_event( "step13x2", tipo_mensaje_ui_generico, ID_BOTON_ART_OBUS, MSG_MOUSE_L_RELEASE)
  
  on_event( "step_error", tipo_mensaje_ui_generico, ID_BOTON_INF_FUSILERO, MSG_MOUSE_L_RELEASE)
  on_event( "step_error", tipo_mensaje_ui_generico, ID_BOTON_CAB_LANCERO, MSG_MOUSE_L_RELEASE)
  on_event( "step_error", tipo_mensaje_ui_generico, ID_BOTON_INF_TIRADOR, MSG_MOUSE_L_RELEASE)
  on_event( "step_error", tipo_mensaje_ui_generico, ID_BOTON_INF_MILICIA, MSG_MOUSE_L_RELEASE)
    
 end
 
-- ==================================================================
-- step13x2: esperamos a q se ancle la artilleria
-- ==================================================================
function step13x2()

  limpia_eventos ()
  limpia_filtros ()
  filtrar_todos (true)
          
  permitirESC()
  permitir_camara()
  
  elimina_marca_grafica(1, 0.8) 
  cerrar_ventana_tutorial()
  abrir_ventana_tutorial(10, 50, tipo_ventana_alargado, "LTEXT_TUTORIAL_BATALLA_TITULO", "LTEXT_TUTORIAL_BATALLA_13X2_A", "LTEXT_TUTORIAL_BATALLA_13X2_B", false)
  
  moverCamaraATropa( RUSIA_ART_OBUS )
  
  add_filtro(tipo_mensaje_ui_generico, 1398035023) -- selector de tropas
  add_filtro(tipo_mensaje_ui_generico, 1111577155) -- barra control
  add_filtro(tipo_mensaje_ui_generico, ID_BOTON_ART_OBUS)
  add_filtro(tipo_mensaje_ui_generico, ID_BOTON_ANCLAR)
  
  nueva_marca_grafica("MARCA_CIRCULO", 1, 964, pos_interfaz_y + 40, 0.3)
 
  on_event("step13x3", tipo_mensaje_ui_generico, ID_BOTON_ANCLAR, MSG_MOUSE_L_RELEASE)
  
 end
 
 
-- ==================================================================
-- step13x3. Mensaje tonto q lo buena q es la artilleria
-- ==================================================================
function step13x3()

  cerrar_ventana_tutorial()
  abrir_ventana_tutorial(10, 50, tipo_ventana_alargado, "LTEXT_TUTORIAL_BATALLA_TITULO", "LTEXT_TUTORIAL_BATALLA_13X3_A", "LTEXT_TUTORIAL_BATALLA_13X3_B", true)
  
  permitirESC()
  permitir_camara()
  
  elimina_marca_grafica(1, 0.8)
    
  add_filtro(tipo_mensaje_ui_generico, id_boton_ventana_tutorial)
  on_event("step14", tipo_mensaje_game_buttton_release, id_boton_ventana_tutorial)
  
 end
 
 
-- ==================================================================
-- step 14. Q se seleccione el tirador
-- ==================================================================
function step14()

  limpia_eventos ()
  limpia_filtros ()
  filtrar_todos (true)
  
  permitirESC()
  permitir_camara()
  
  cerrar_ventana_tutorial()
  abrir_ventana_tutorial(10, 50, tipo_ventana_alargado, "LTEXT_TUTORIAL_BATALLA_TITULO", "LTEXT_TUTORIAL_BATALLA_14_A", "LTEXT_TUTORIAL_BATALLA_14_B", false)
   
  unselectAllTropas()
  nueva_marca_grafica("MARCA_CIRCULO", 1, pos_interfaz_2_x, pos_interfaz_y, 0.4)
  
  add_filtro(tipo_mensaje_ui_generico, 1398035023) -- selector de tropas
  add_filtro(tipo_mensaje_ui_generico, 1111577155) -- barra control
  add_filtro(tipo_mensaje_ui_generico, ID_BOTON_INF_TIRADOR)
  add_filtro(tipo_mensaje_ui_generico, ID_BOTON_ANCLAR)
  
  
  traceback_function = "step14"
  
  on_event( "step15", tipo_mensaje_ui_generico, ID_BOTON_INF_TIRADOR, MSG_MOUSE_L_RELEASE)
  
  on_event( "step_error", tipo_mensaje_ui_generico, ID_BOTON_INF_FUSILERO, MSG_MOUSE_L_RELEASE)
  on_event( "step_error", tipo_mensaje_ui_generico, ID_BOTON_CAB_LANCERO, MSG_MOUSE_L_RELEASE)
  on_event( "step_error", tipo_mensaje_ui_generico, ID_BOTON_ART_OBUS, MSG_MOUSE_L_RELEASE)
  on_event( "step_error", tipo_mensaje_ui_generico, ID_BOTON_INF_MILICIA, MSG_MOUSE_L_RELEASE)
  
 end
 
-- ==================================================================
-- step 15. Pulsar el boton de cuadro
-- ==================================================================
function step15()

  limpia_eventos ()
  limpia_filtros ()
  filtrar_todos (true)
          
  permitirESC()
  permitir_camara()
  
  elimina_marca_grafica(1, 0.8) 
  cerrar_ventana_tutorial()
  abrir_ventana_tutorial(10, 50, tipo_ventana_alargado, "LTEXT_TUTORIAL_BATALLA_TITULO", "LTEXT_TUTORIAL_BATALLA_15_A", "LTEXT_TUTORIAL_BATALLA_15_B", false)
  
  moverCamaraATropa( RUSIA_INF_TIRADOR)
  
  add_filtro(tipo_mensaje_ui_generico, 1398035023) -- selector de tropas
  add_filtro(tipo_mensaje_ui_generico, 1111577155) -- barra control
  add_filtro(tipo_mensaje_ui_generico, ID_BOTON_INF_TIRADOR)
  add_filtro(tipo_mensaje_ui_generico, ID_BOTON_FORM_CUADRO)

  
  nueva_marca_grafica("MARCA_CIRCULO", 1, 875, pos_interfaz_y + 33, 0.3)
  
  goTropa( AUSTRIA_CAB_LANCERO, 42000.0, 56000.0, 1, 180.0 ) -- posX, posY, correr(0 o 1), orientacionFinal (0.0 -> 360.0)
  goTropa( AUSTRIA_INF_TIRADOR, 43500.0, 56000.0, 1, 180.0 ) -- posX, posY, correr(0 o 1), orientacionFinal (0.0 -> 360.0)
  
 
  on_event("step15b", tipo_mensaje_ui_generico, ID_BOTON_FORM_CUADRO, MSG_MOUSE_L_RELEASE)
  
 end
 
 -- ==================================================================
 -- step15b. Seleccionar Cab.
 -- ==================================================================
 function step15b()
 
  limpia_eventos ()
  limpia_filtros ()
  filtrar_todos (true)
  
  permitirESC()
  permitir_camara()
  
  elimina_marca_grafica(1, 0.8) 
  cerrar_ventana_tutorial()
  abrir_ventana_tutorial(10, 50, tipo_ventana_alargado, "LTEXT_TUTORIAL_BATALLA_TITULO", "LTEXT_TUTORIAL_BATALLA_15B_A", "LTEXT_TUTORIAL_BATALLA_15B_B", false)
  
  -- Marca en los lanceros
  nueva_marca_grafica("MARCA_CIRCULO", 1, pos_interfaz_4_x, pos_interfaz_y, 0.4)
  

  add_filtro(tipo_mensaje_ui_generico, 1398035023) -- selector de tropas
  add_filtro(tipo_mensaje_ui_generico, 1111577155) -- barra control
  add_filtro(tipo_mensaje_ui_generico, ID_BOTON_CAB_LANCERO)
  add_filtro(tipo_mensaje_ui_generico, ID_BOTON_FORM_CUADRO)    -- necesario para q se pulse el boton :|

  add_filtro(tipo_mensaje_ui_generico, ID_ZONA_SENSIBLE, MSG_MOUSE_L_CLICK )
  add_filtro(tipo_mensaje_ui_generico, ID_ZONA_SENSIBLE, MSG_MOUSE_L_RELEASE )
  add_filtro(tipo_mensaje_ui_generico, ID_ZONA_SENSIBLE, MSG_MOUSE_MOVE )
  
  add_filtro(tipo_mensaje_ui_generico, 1414743372)  -- tropa seleccionada
  
  on_event( "step16", tipo_mensaje_tropas_seleccionadas, RUSIA_CAB_LANCERO )
  on_event( "step16", tipo_mensaje_ui_generico, ID_BOTON_CAB_LANCERO, MSG_MOUSE_L_RELEASE)
  
 end
 
 -- ==================================================================
-- step 16. Dar orden de ataque CAC
-- ==================================================================
function step16()

  limpia_eventos ()
  limpia_filtros ()
  filtrar_todos (true)
  elimina_marca_grafica(1, 0.8)
  
  permitirESC()
  permitir_camara()

  crearCirculo3D( 4, 43500.0, 56000.0, 1300.0 )
  
  cerrar_ventana_tutorial()
  abrir_ventana_tutorial(10, 50, tipo_ventana_alargado, "LTEXT_TUTORIAL_BATALLA_TITULO", "LTEXT_TUTORIAL_BATALLA_16_A", "LTEXT_TUTORIAL_BATALLA_16_B", false)

  add_filtro(tipo_mensaje_ui_generico, 1398035023) -- selector de tropas
  add_filtro(tipo_mensaje_ui_generico, 1111577155) -- barra control
  add_filtro(tipo_mensaje_ui_generico, ID_BOTON_CAB_LANCERO)
  
  moverCamaraATropa( RUSIA_CAB_LANCERO )
  
  
  add_filtro(tipo_mensaje_ui_generico, ID_ZONA_SENSIBLE, MSG_MOUSE_MOVE)
  add_filtro(tipo_mensaje_ui_generico, ID_ZONA_SENSIBLE, MSG_MOUSE_R_CLICK )
  add_filtro(tipo_mensaje_ui_generico, ID_ZONA_SENSIBLE, MSG_MOUSE_R_RELEASE )
  add_filtro(tipo_mensaje_ui_generico, ID_ORDEN_CLICK_TROPA)

  traceback_function = "step16"
  
  on_event( "step16_error", tipo_mensaje_orden_atacarcac, RUSIA_CAB_LANCERO, AUSTRIA_INF_FUSILERO )
  on_event( "step16_error", tipo_mensaje_orden_atacarcac, RUSIA_CAB_LANCERO, AUSTRIA_CAB_LANCERO )
  on_event( "step16_error", tipo_mensaje_tropa_movida, RUSIA_CAB_LANCERO, 42280.0, 58060.0, 7000.0 )
  
  on_event( "step17", tipo_mensaje_orden_atacarcac, RUSIA_CAB_LANCERO, AUSTRIA_INF_TIRADOR )
  
 end
  
function step16_error()

  limpia_eventos ()
  limpia_filtros ()
  filtrar_todos (true)
  
  permitirESC()
  permitir_camara()
  borraCirculo3D( 4 ) -- id
  teleportTropa( RUSIA_CAB_LANCERO, 46000.0, 46200.0, 300.0 )  
  
  step_error()
  
end
 
 -- ==================================================================
-- step 17
-- ==================================================================
function step17()

  limpia_eventos ()
  limpia_filtros ()
  filtrar_todos (true)

  borraCirculo3D( 4 ) -- id
  cerrar_ventana_tutorial()
  
  permitirESC()
  permitir_camara()
  
  add_filtro(tipo_mensaje_ui_generico, id_boton_ventana_tutorial)
  add_filtro(tipo_mensaje_ui_generico, id_boton_ventana_tutorial, MSG_MOUSE_L_RELEASE)
  add_filtro(tipo_mensaje_ui_generico, id_boton_ventana_tutorial, MSG_MOUSE_ENTER)
  add_filtro(tipo_mensaje_ui_generico, id_boton_ventana_tutorial, MSG_MOUSE_LEAVE)
  add_filtro(tipo_mensaje_ui_generico, id_boton_ventana_tutorial, MSG_KEY_UP)

  cargarTropa( AUSTRIA_CAB_LANCERO, RUSIA_INF_TIRADOR )
    
  temporizador(11, "step17_b")
  
 end

-----------------------

----------------------- 
  function step17_b()
 
  limpia_eventos ()
  limpia_filtros ()
  filtrar_todos (true)
  
  permitirESC()
  permitir_camara()
  add_filtro(tipo_mensaje_ui_generico, id_boton_ventana_tutorial)
  add_filtro(tipo_mensaje_ui_generico, id_boton_ventana_tutorial, MSG_MOUSE_L_RELEASE)
  add_filtro(tipo_mensaje_ui_generico, id_boton_ventana_tutorial, MSG_MOUSE_ENTER)
  add_filtro(tipo_mensaje_ui_generico, id_boton_ventana_tutorial, MSG_MOUSE_LEAVE)
  add_filtro(tipo_mensaje_ui_generico, id_boton_ventana_tutorial, MSG_KEY_UP)
  
  goTropa( AUSTRIA_INF_FUSILERO, 1000.0, 45000.0, 1, 270.0 ) -- posX, posY, correr(0 o 1), orientacionFinal (0.0 -> 360.0)
  moverCamaraATropa( AUSTRIA_CAB_LANCERO)
  temporizador(15, "secuenciaHuida")
  
  cerrar_ventana_tutorial()
  abrir_ventana_tutorial(10, 50, tipo_ventana_alargado, "LTEXT_TUTORIAL_BATALLA_TITULO", "LTEXT_TUTORIAL_BATALLA_17_A", "LTEXT_TUTORIAL_BATALLA_17_B", true)
  on_event("salidaDelTutorial", tipo_mensaje_ui_generico, id_boton_ventana_tutorial, MSG_MOUSE_L_RELEASE)
 
 end

---------------------------------------------------
-- FUNCION PARA QUE HUYA LA CABALLERÍA AUSTRÍACA --
---------------------------------------------------
function secuenciaHuida()
  
  goTropa( AUSTRIA_CAB_LANCERO, 1000.0, 45000.0, 1, 270.0 ) -- posX, posY, correr(0 o 1), orientacionFinal (0.0 -> 360.0) -- Mueve a los lanceros a una esquina

end


------------------------------------------------
--  FUNCION DE SALIDA DEL TUTORIAL DE BATALLA --
--        QUE BIEN MAJO HA QUEDADO. Q         --
------------------------------------------------

function salidaDelTutorial()

  limpia_filtros ()
  filtrar_todos (false)
  cerrar_ventana_tutorial()
  borraCirculo3D(1)
  borraCirculo3D(2)
  borraCirculo3D(3)
  borraCirculo3D(4)
  elimina_marca_grafica(1, 0.8) 
  
  id_ventana_confirmacion_fin_tutorial = 1234

  if tutorial_naval_activo then

    open_messagebox (id_ventana_confirmacion_fin_tutorial,"LTEXT_TUTORIAL_FINAL_TODOS_TITULO", "LTEXT_TUTORIAL_FINAL_TODOS_BATALLA_TEXTO",TMB_NORMAL,"LTEXT_TUTORIAL_FINAL_TODOS_MENUTUTORIAL","LTEXT_TUTORIAL_FINAL_TODOS_BATALLA_NAVAL" )
    on_event("exit_to_tutorial_naval" ,tipo_mensaje_messagebox_close, id_ventana_confirmacion_fin_tutorial, 1)

  else

    open_messagebox (id_ventana_confirmacion_fin_tutorial,"LTEXT_TUTORIAL_FINAL_TODOS_TITULO", "LTEXT_TUTORIAL_FINAL_SOLOBATALLA_TEXTO",TMB_NORMAL,"LTEXT_TUTORIAL_FINAL_TODOS_MENUTUTORIAL" )

  end
  
  on_event("exit_to_main_menu",tipo_mensaje_messagebox_close, id_ventana_confirmacion_fin_tutorial, 0)
    
end