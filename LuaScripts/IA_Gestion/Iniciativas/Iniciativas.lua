-- Lua Script
-- Gestión de iniciativas del presidente

------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------- INCLUDES ----------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------
include_script(INICIATIVAS_DIR.."Iniciativas_update.lua")
include_script(INICIATIVAS_DIR.."Iniciativas_generate.lua")
include_script(INICIATIVAS_DIR.."Quests_generate.lua")
include_script(INICIATIVAS_DIR.."Quests_requerimientos.lua")
include_script(INICIATIVAS_DIR.."Quests_update.lua")

------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------- GLOBALS -----------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------
total_iniciativas = 0;

-- Enumerados de tipos de iniciativa
iniciativas_enum = {TINI_INGRESO_DINERO_BAJO,
                    TINI_INGRESO_COMIDA_BAJO,
                    TINI_INGRESO_MATPRIMAS_BAJO,
                    TINI_INGRESO_CIENCIA_BAJO,
                    TINI_INGRESO_POBLACION_BAJO,
                    TINI_ASIMILAR,
                    TINI_MEJORA_MILITAR,
                    TINI_PERMISO_PASO,
                    TINI_ENVIAR_EFECTIVOS,
                    TINI_SUBVENCIONAR_CELULA_RESISTENCIA,
                    TINI_MATRIMONIO,
                    TINI_COMPRAR_TERRITORIOS,
                    TINI_VENDER_TERRITORIOS,
                    TINI_QUEST_CARTOGRAFIA,
                    TINI_QUEST_BLOQUEO_CONTINENTAL,
                    TINI_QUEST_PIEDRA_ROSETA,
                    TINI_QUEST_SIMON_BOLIVAR,
                    TINI_QUEST_SISTEMA_METRICO,
                    TINI_QUEST_PAZ_AMIENS,
                    TINI_QUEST_ENCICLOPEDIA,
                    TINI_QUEST_DERECHOS_HUMANOS,
                    TINI_QUEST_100000HIJOS,
                    TINI_QUEST_PROCLAMARSE_SISI_EMPERATRIZ,
                    TINI_QUEST_CONSTITUCION,
                    TINI_QUEST_FERROCARRIL,
                    TINI_QUEST_REVOLUCION_MEDICA,
                    TINI_QUEST_REVOLUCION_AGRARIA,
                    TINI_QUEST_EXPOSICION_UNIVERSAL,
                    TINI_QUEST_SENYOR_MARES
                  }

-- Tabla de iniciativas function pointers
update_iniciativa_func   = {[TINI_INGRESO_DINERO_BAJO]                = update_iniciativa_dinero,
						                [TINI_INGRESO_COMIDA_BAJO]                = update_iniciativa_comida,
						                [TINI_INGRESO_MATPRIMAS_BAJO]             = update_iniciativa_matprimas,
						                [TINI_INGRESO_CIENCIA_BAJO]               = update_iniciativa_ciencia,
						                [TINI_INGRESO_POBLACION_BAJO]             = update_iniciativa_poblacion,
						                [TINI_ASIMILAR]                           = update_iniciativa_asimilar,
						                [TINI_MEJORA_MILITAR]					            = update_iniciativa_mejora_militar,
						                [TINI_PERMISO_PASO]						            = update_iniciativa_permiso_paso,
						                [TINI_ENVIAR_EFECTIVOS]					          = update_iniciativa_enviar_efectivos,						                                                
						                [TINI_SUBVENCIONAR_CELULA_RESISTENCIA]    = update_iniciativa_subvencionar_celula_resistencia,
						                [TINI_MATRIMONIO]                         = update_iniciativa_matrimonio,
						                [TINI_COMPRAR_TERRITORIOS]                = update_iniciativa_comprar_territorios,
						                [TINI_VENDER_TERRITORIOS]                 = update_iniciativa_vender_territorios,
                            [TINI_QUEST_CARTOGRAFIA]                  = update_quest_cartografia,
                            [TINI_QUEST_BLOQUEO_CONTINENTAL]          = update_quest_bloqueo_continental,
                            [TINI_QUEST_PIEDRA_ROSETA]                = update_quest_piedra_roseta,
                            [TINI_QUEST_SIMON_BOLIVAR]                = update_quest_simon_bolivar,
                            [TINI_QUEST_SISTEMA_METRICO]              = update_quest_sistema_metrico,
                            [TINI_QUEST_PAZ_AMIENS]                   = update_quest_paz_amiens,
                            [TINI_QUEST_ENCICLOPEDIA]                 = update_quest_enciclopedia,
                            [TINI_QUEST_DERECHOS_HUMANOS]             = update_quest_derechos_humanos,
                            [TINI_QUEST_100000HIJOS]                  = update_quest_100000hijos,
                            [TINI_QUEST_PROCLAMARSE_SISI_EMPERATRIZ]  = update_quest_proclamarse_sisi_emperatriz,
                            [TINI_QUEST_CONSTITUCION]                 = update_quest_constitucion,
                            [TINI_QUEST_FERROCARRIL]                  = update_quest_ferrocarril,
                            [TINI_QUEST_REVOLUCION_MEDICA]            = update_quest_revolucion_medica,
                            [TINI_QUEST_REVOLUCION_AGRARIA]           = update_quest_revolucion_agraria,
                            [TINI_QUEST_EXPOSICION_UNIVERSAL]         = update_quest_exposicion_universal,
                            [TINI_QUEST_SENYOR_MARES]                 = update_quest_senyor_mares
                            }

generate_iniciativa_func = {[TINI_INGRESO_DINERO_BAJO]                = generate_iniciativa_dinero,
						                [TINI_INGRESO_COMIDA_BAJO]                = generate_iniciativa_comida,
						                [TINI_INGRESO_MATPRIMAS_BAJO]             = generate_iniciativa_matprimas,
						                [TINI_INGRESO_CIENCIA_BAJO]               = generate_iniciativa_ciencia,
						                [TINI_INGRESO_POBLACION_BAJO]             = generate_iniciativa_poblacion,
						                [TINI_ASIMILAR]                           = generate_iniciativa_asimilar,
						                [TINI_MEJORA_MILITAR]				              = generate_iniciativa_mejora_militar,
						                [TINI_PERMISO_PASO]					              = generate_iniciativa_permiso_paso,
						                [TINI_ENVIAR_EFECTIVOS]				            = generate_iniciativa_enviar_efectivos,
							              [TINI_SUBVENCIONAR_CELULA_RESISTENCIA]    = generate_iniciativa_subvencionar_celula_resistencia, 
							              [TINI_MATRIMONIO]                         = generate_iniciativa_matrimonio,
						                [TINI_COMPRAR_TERRITORIOS]                = generate_iniciativa_comprar_territorios,
						                [TINI_VENDER_TERRITORIOS]                 = generate_iniciativa_vender_territorios,
                            [TINI_QUEST_CARTOGRAFIA]                  = generate_quest_cartografia,
                            [TINI_QUEST_BLOQUEO_CONTINENTAL]          = generate_quest_bloqueo_continental,
                            [TINI_QUEST_PIEDRA_ROSETA]                = generate_quest_piedra_roseta,
                            [TINI_QUEST_SIMON_BOLIVAR]                = generate_quest_simon_bolivar,
                            [TINI_QUEST_SISTEMA_METRICO]              = generate_quest_sistema_metrico,
                            [TINI_QUEST_PAZ_AMIENS]                   = generate_quest_paz_amiens,
                            [TINI_QUEST_ENCICLOPEDIA]                 = generate_quest_enciclopedia,
                            [TINI_QUEST_DERECHOS_HUMANOS]             = generate_quest_derechos_humanos,
                            [TINI_QUEST_100000HIJOS]                  = generate_quest_100000hijos,
                            [TINI_QUEST_PROCLAMARSE_SISI_EMPERATRIZ]  = generate_quest_proclamarse_sisi_emperatriz,
                            [TINI_QUEST_CONSTITUCION]                 = generate_quest_constitucion,
                            [TINI_QUEST_FERROCARRIL]                  = generate_quest_ferrocarril,
                            [TINI_QUEST_REVOLUCION_MEDICA]            = generate_quest_revolucion_medica,
                            [TINI_QUEST_REVOLUCION_AGRARIA]           = generate_quest_revolucion_agraria,
                            [TINI_QUEST_EXPOSICION_UNIVERSAL]         = generate_quest_exposicion_universal,
                            [TINI_QUEST_SENYOR_MARES]                 = generate_quest_senyor_mares
                            }
						  
-- Tabla de iniciativas
iniciativas = { [TINI_INGRESO_DINERO_BAJO]                = {enabled = true, prioridad = 0.0},
			          [TINI_INGRESO_COMIDA_BAJO]                = {enabled = true, prioridad = 0.0},
			          [TINI_INGRESO_MATPRIMAS_BAJO]             = {enabled = true, prioridad = 0.0},
				        [TINI_INGRESO_CIENCIA_BAJO]               = {enabled = true, prioridad = 0.0},
				        [TINI_INGRESO_POBLACION_BAJO]             = {enabled = true, prioridad = 0.0},
				        [TINI_ASIMILAR]                           = {enabled = true, prioridad = 0.0},
				        [TINI_MEJORA_MILITAR]					            = {enabled = true, prioridad = 0.0},
				        [TINI_PERMISO_PASO]						            = {enabled = true, prioridad = 0.0},
				        [TINI_ENVIAR_EFECTIVOS]					          = {enabled = true, prioridad = 0.0},
				        [TINI_SUBVENCIONAR_CELULA_RESISTENCIA]    = {enabled = true, prioridad = 0.0},
				        [TINI_MATRIMONIO]                         = {enabled = true, prioridad = 0.0},
						    [TINI_COMPRAR_TERRITORIOS]                = {enabled = true, prioridad = 0.0},
						    [TINI_VENDER_TERRITORIOS]                 = {enabled = true, prioridad = 0.0},
                [TINI_QUEST_CARTOGRAFIA]                  = {enabled = true, prioridad = 0.0},
                [TINI_QUEST_BLOQUEO_CONTINENTAL]          = {enabled = true, prioridad = 0.0},
                [TINI_QUEST_PIEDRA_ROSETA]                = {enabled = true, prioridad = 0.0},
                [TINI_QUEST_SIMON_BOLIVAR]                = {enabled = true, prioridad = 0.0},
                [TINI_QUEST_SISTEMA_METRICO]              = {enabled = true, prioridad = 0.0},
                [TINI_QUEST_PAZ_AMIENS]                   = {enabled = true, prioridad = 0.0},
                [TINI_QUEST_ENCICLOPEDIA]                 = {enabled = true, prioridad = 0.0},
                [TINI_QUEST_DERECHOS_HUMANOS]             = {enabled = true, prioridad = 0.0},
                [TINI_QUEST_100000HIJOS]                  = {enabled = true, prioridad = 0.0},
                [TINI_QUEST_PROCLAMARSE_SISI_EMPERATRIZ]  = {enabled = true, prioridad = 0.0},
                [TINI_QUEST_CONSTITUCION]                 = {enabled = true, prioridad = 0.0},
                [TINI_QUEST_FERROCARRIL]                  = {enabled = true, prioridad = 0.0},
                [TINI_QUEST_REVOLUCION_MEDICA]            = {enabled = true, prioridad = 0.0},
                [TINI_QUEST_REVOLUCION_AGRARIA]           = {enabled = true, prioridad = 0.0},
                [TINI_QUEST_EXPOSICION_UNIVERSAL]         = {enabled = true, prioridad = 0.0},
                [TINI_QUEST_SENYOR_MARES]                 = {enabled = true, prioridad = 0.0}
              }

iniciativas_modificadores_preferencia = { [TINI_INGRESO_DINERO_BAJO]                = 0.0,
					                                [TINI_INGRESO_COMIDA_BAJO]				        = 0.0,
						                              [TINI_INGRESO_MATPRIMAS_BAJO]				      = 0.0,
						                              [TINI_INGRESO_CIENCIA_BAJO]				        = 0.0,
						                              [TINI_INGRESO_POBLACION_BAJO]			        = 0.0,
						                              [TINI_ASIMILAR]							              = 0.0,
						                              [TINI_MEJORA_MILITAR]						          = 0.0,
						                              [TINI_PERMISO_PASO]					              = 0.0,
						                              [TINI_ENVIAR_EFECTIVOS]				            = 0.0,
						                              [TINI_SUBVENCIONAR_CELULA_RESISTENCIA]    = 0.0,
						                              [TINI_MATRIMONIO]                         = 0.0,
						                              [TINI_COMPRAR_TERRITORIOS]                = 0.0,
						                              [TINI_VENDER_TERRITORIOS]                 = 0.0,
                                          [TINI_QUEST_CARTOGRAFIA]                  = 0.0,
                                          [TINI_QUEST_BLOQUEO_CONTINENTAL]          = 0.0,
                                          [TINI_QUEST_PIEDRA_ROSETA]                = 0.0,
                                          [TINI_QUEST_SIMON_BOLIVAR]                = 0.0,
                                          [TINI_QUEST_SISTEMA_METRICO]              = 0.0,
                                          [TINI_QUEST_PAZ_AMIENS]                   = 0.0,
                                          [TINI_QUEST_ENCICLOPEDIA]                 = 0.0,
                                          [TINI_QUEST_DERECHOS_HUMANOS]             = 0.0,
                                          [TINI_QUEST_100000HIJOS]                  = 0.0,
                                          [TINI_QUEST_PROCLAMARSE_SISI_EMPERATRIZ]  = 0.0,
                                          [TINI_QUEST_CONSTITUCION]                 = 0.0,
                                          [TINI_QUEST_FERROCARRIL]                  = 0.0,
                                          [TINI_QUEST_REVOLUCION_MEDICA]            = 0.0,
                                          [TINI_QUEST_REVOLUCION_AGRARIA]           = 0.0,
                                          [TINI_QUEST_EXPOSICION_UNIVERSAL]         = 0.0,
                                          [TINI_QUEST_SENYOR_MARES]                 = 0.0}


function update_iniciativas(force_regenerar)

	for it_iniciativa in iniciativas_enum do
		local iniciativa_enum = iniciativas_enum[it_iniciativa]

		if (iniciativas[iniciativa_enum].enabled or force_regenerar) then
		  update_iniciativa_func[iniciativa_enum]()
		  notify_incidencia(iniciativa_enum, 
                        iniciativas[iniciativa_enum].enabled,
                        iniciativas[iniciativa_enum].prioridad + iniciativas_modificadores_preferencia[iniciativa_enum])
		end
	end	

end


function generate_iniciativas()  
  -- Cogemos la información sobre la última orden ejecutada.
  g_ultima_orden = get_ultima_orden_ejecutada()

	for it_iniciativa in iniciativas_enum do
		local iniciativa_enum = iniciativas_enum[it_iniciativa]

		if iniciativas[iniciativa_enum].enabled then
		  generate_iniciativa_func[iniciativa_enum]()
    end
	end	

end


---------------------------------------------------------------------------------
---- Variables globales
---------------------------------------------------------------------------------
--g_perfil                  = {}
--g_jugador_interes_anexion = NIL
----g_jugador_enemigo_anexion = NIL
--g_mayor_produccion_pais	  = 0
--
--
--
--
---------------------------------------------------------------------------------
---- Generar las iniciativas del presidente.
---- El proceso que se lleva a cabo es el siguiente:
----    - Se generan las iniciativas relacionadas con la anexión, ya sea pacífica 
----      o militar. Ver 'generar_iniciativas_anexion' para más detalles.
----    - TODO
---------------------------------------------------------------------------------
--function generar_iniciativas()
--  LOG(".............GENERACIÓN DE INICIATIVAS.............")
--
--  local num_iniciativas = 0;
--
--  -- Inicializamos la semilla de números aleatorios
--  -- math.randomseed(os.time())
--  -- TODO: De momento la inicializamos siempre al mismo valor para tener comportamiento determinista
--  math.randomseed(0)
--  --if(table.getn(nivel_militar.enemigos) == 0) then
--	--local candidatos = get_paises_fronterizos()
--	--for it_candidato in candidatos do				
--		--ATACAR_JUGADOR(TINI_HOSTIGAR_PAIS, 0, 0, get_jugador_of_pais(candidatos[it_candidato]))
--	--end
--  --end
--  if puede_generar_iniciativas then
--	  -- 1. Calcular la producción de todos los países
--	  calcular_produccion_paises()
--	  -- 2. Generar iniciativas relacionadas con la anexión
--	  local num_iniciativas_militares, num_iniciativas_pacificas = generar_iniciativas_anexion()
--	  -- 3. Generar iniciativas de ataque
--	  num_iniciativas_militares = num_iniciativas_militares + generar_iniciativas_ataque()
--	  num_iniciativas = num_iniciativas_militares + num_iniciativas_pacificas
--	  
--	  if(num_iniciativas_militares == 0 and table.getn(nivel_militar.enemigos) == 0) then
--		generar_iniciativa_ataque_provincia()
--	  end
--	  
--	  num_iniciativas = num_iniciativas + generar_iniciativas_economicas()
--	  
--  end
--  
--  return num_iniciativas
--end
--
------------------------------------------
---- genera iniciativas economicas
------------------------------------------
--function generar_iniciativas_economicas()
--	local valor_real = get_vr()
--	local valor_real_norm = get_vr_normalizado()
--	local VRProblematico = get_perfil()[PF_NIVELVRPROBLEMATICO]
--	
--	if(valor_real[RC_INDEX_DINERO] > 1.0 and valor_real_norm[RC_INDEX_DINERO] > VRProblematico) then
--		local prioridad = math.max(0.0, valor_real_norm[RC_INDEX_DINERO])
--		generar_mejoras_economicas(TINI_INGRESO_DINERO_BAJO, MEJORA_PRODUCCION_DINERO,  prioridad)
--	end	
--	if(valor_real[RC_INDEX_COMIDA] > 1.0 and valor_real_norm[RC_INDEX_COMIDA] > VRProblematico) then
--		local prioridad = math.max(0.0, valor_real_norm[RC_INDEX_COMIDA])
--		generar_mejoras_economicas(TINI_INGRESO_COMIDA_BAJO, MEJORA_PRODUCCION_COMIDA,  prioridad)
--	end	
--	if(valor_real[RC_INDEX_MATPRIMAS] > 1.0 and valor_real_norm[RC_INDEX_MATPRIMAS] > VRProblematico) then
--		local prioridad = math.max(0.0, valor_real_norm[RC_INDEX_MATPRIMAS])
--		generar_mejoras_economicas(TINI_INGRESO_MATPRIMAS_BAJO, MEJORA_PRODUCCION_MATPRIMAS,  prioridad)
--	end	
--	if(valor_real[RC_INDEX_POBLACION] > 1.0 and valor_real_norm[RC_INDEX_POBLACION] > VRProblematico) then
--		local prioridad = math.max(0.0, valor_real_norm[RC_INDEX_POBLACION])
--		generar_mejoras_economicas(TINI_INGRESO_POBLACION_BAJO, MEJORA_PRODUCCION_POBLACION,  prioridad)
--	end	
--
--  return 0
--end
--
------------------------------------------------------
--
------------------------------------------------
---- genera la iniciativa de atacar una provincia
------------------------------------------------
--function generar_iniciativa_ataque_provincia()
--	local candidatos = table_filter_one(get_paises_fronterizos(), es_pais_hostigable)
--	table.sort(candidatos, compare_preferencia_militar)
--	local nivel_defensivo = get_nivel_defensivo(MY_PLAYER_ID)
--	for it_candidato in candidatos do
--		local nivel_defensivo_attack = get_nivel_defensivo_attack(MY_PLAYER_ID, {candidatos[it_candidato]})
--		--local nivel_defensivo_candidato =  get_nivel_defensivo(candidatos[it_candidato])
--		if( nivel_defensivo_attack >= nivel_defensivo ) then --and nivel_defensivo > nivel_defensivo_candidato) then
--			ATACAR_JUGADOR(TINI_ASIMILAR, 0, 0, get_jugador_of_pais(candidatos[it_candidato]))
--			break;
--		end
--	end
--end
--
--
---------------------------------------------------------------------------------
---- Generar las iniciativas relacionadas con la anexión.
---- El proceso que se lleva a cabo es el siguiente:
----    - Se seleccionan todos los países ajenos que sean fronterizos. De momento
----      no se considera el llevar a cabo una anexión de un país no fronterizo.
----    - Si estoy en alguna guerra o mi nivel defensivo no es lo suficientemente
----      alto, considero todos estos países neutrales no enemigos como candidatos 
----      para anexión pacífica.
----    - Si no es así:
----      - Para cada uno de estos países:
----          - Si es imperial, o es neutral y no está en guerra con algún imperial,
----            se considera como candidato para anexión militar, calculándose un 
----            valor de preferencia. Ver 'get_preferencia_generica_anexion_militar'.
----          - Si es neutral y no estamos en guerra con él, se considera como 
----            candidato para anexión pacífica, calculándose un valor de preferencia.
----            Ver 'get_preferencia_generica_anexion_pacifica'.
----      - Se separan los páises en dos conjuntos: el conjunto de países sobre los
----        que se intentará una anexión militar y sobre los que se intentará una
----        anexión pacífica. Si algún país es candidato para ambos tipos de
----        anexiones, se incluirá en un conjunto u otro dependiendo de las
----        preferencias calculadas en el paso anterior.
----      - Para cada país en el conjunto de anexionables militarmente se llama
----        a 'generar_anexion_militar'.
----      - Para cada país en el conjunto de anexionables pacíficamente se llama
----        a 'generar_anexion_pacífica'.
---------------------------------------------------------------------------------
--function generar_iniciativas_anexion()
--  -- Los países neutrales no pueden realizar ningún tipo de anexión
--  if not es_jugador_imperial(MY_PLAYER_ID) then
--    return 0, 0
--  end
--
--  -----------------------------
--  -- 1. Filtrado por fronterizo
--  -----------------------------
--  local paises_fronterizos = get_paises_fronterizos()
--  LOG("Encontrados " .. table.getn(paises_fronterizos) .. " países fronterizos (" .. concat_log(table_transform_one(paises_fronterizos, get_pais_name), ", ") .. ")")
--
--  ----------------------------
--  -- 2. Seleccionar candidatos
--  ----------------------------
--  local candidatos_anexion_militar  = {}
--  local candidatos_anexion_pacifica = {}
--
--  local num_enemigos    = table.getn(get_enemigos_of_jugador(MY_PLAYER_ID))
--  local nivel_defensivo = get_nivel_defensivo(MY_PLAYER_ID)
--
--  if num_enemigos > 0 or nivel_defensivo < (1 - g_perfil[PF_TEMERIDAD]) then
--    -- Si estoy en una guerra o mi nivel defensivo es demasiado bajo, 
--    -- todos los países neutrales no enemigos los considero para anexión pacífica
--    local paises_imperiales         = {}
--    local paises_neutrales_enemigos = {}
--
--    paises_imperiales,         candidatos_anexion_pacifica = table_filter_one(paises_fronterizos, es_pais_imperial)
--    paises_neutrales_enemigos, candidatos_anexion_pacifica = table_filter_one(candidatos_anexion_pacifica, es_pais_enemigo)
--
--    LOG("    => Seleccionados todos los paises neutrales no enemigos (" .. table.getn(candidatos_anexion_pacifica) 
--        .. ") como candidatos para anexión pacífica (tenemos " .. num_enemigos .. " enemigos y nivel defensivo " 
--        .. nivel_defensivo .. ")")
--  else
--    for it_pais in paises_fronterizos do
--      local pais    = paises_fronterizos[it_pais]
--      local jugador = get_jugador_of_pais(pais)
--
--      local anexionable_pacificamente = false
--      local anexionable_militarmente  = false
--
--      -- Comprobamos si el país es candidato para anexión pacífica.
--      -- Lo será si el jugador no es imperial y no estoy en guerra con él.
--      -- Nota: - Es posible que el país sea considerado para anexión pacífica pero
--      --         sea desechado más tarde si el hecho de aumentar relación con él
--      --         hace que nuestra relación con otro jugador que nos interesa más 
--      --         se vea reducida.
--      if not es_jugador_imperial(jugador) and not es_jugador_enemigo(jugador) then
--        anexionable_pacificamente = true
--      end
--
--      -- Comprobamos si el país puede ser anexionado militarmente.
--      -- Lo será si o bien es imperial y no es aliado nuestro, 
--      -- o bien es neutral y no está en guerra con ningún imperio.
--      if es_jugador_imperial(jugador) then
--        -- Nota: - Para imperios esta iniciativa no tiene como fin la anexión,
--        --         sino la eliminación del otro jugador.
--        anexionable_militarmente = not es_jugador_aliado(jugador) and not es_jugador_enemigo(jugador)
--      else
--        local enemigos_imperiales_jugador = table_filter_one(get_enemigos_of_jugador(jugador), es_jugador_imperial)        
--        anexionable_militarmente = table.getn(enemigos_imperiales_jugador) == 0
--      end
--      
--      local aliados_jugador = get_aliados_of_jugador(jugador)
--      anexionable_militarmente = table.getn(aliados_jugador) == 0
--      
--
--      if anexionable_militarmente and anexionable_pacificamente then
--        -- El país es anexionable tanto pacífica como militarmente, así que
--        -- calcularemos una preferencia para cada tipo de anexión y elegiremos
--        -- la más interesante para el jugador.
--        local preferencia_militar  = get_preferencia_generica_anexion_militar(pais)
--        local preferencia_pacifica = get_preferencia_generica_anexion_pacifica(pais)
--
--        if preferencia_militar > preferencia_pacifica then
--          table.insert(candidatos_anexion_militar, pais)
----          LOG("    " .. get_pais_name(pais) .. " puede ser anexionado tanto pacífica (" .. 
----              preferencia_pacifica .. ") como militarmente (" .. preferencia_militar .. ")" ..
----              " => seleccionada anexión militar [ " .. get_nivel_defensivo(jugador) .. " ]")
--        else
--          table.insert(candidatos_anexion_pacifica, pais)
----          LOG("    " .. get_pais_name(pais) .. " puede ser anexionado tanto pacífica (" .. 
----              preferencia_pacifica .. ") como militarmente (" .. preferencia_militar .. ")" ..
----              " => seleccionada anexión pacífica [ " .. get_nivel_defensivo(jugador) .. " ]")
--        end
--      else
--        -- El país solamente es anexionable de una sola manera, así que no es necesario
--        -- calcular ninguna preferencia.
--
--        if anexionable_militarmente then
--          table.insert(candidatos_anexion_militar, pais)
----          LOG("    " .. get_pais_name(pais) .. " => seleccionada anexión militar")
--        elseif anexionable_pacificamente then
--          table.insert(candidatos_anexion_pacifica, pais)
----          LOG("    " .. get_pais_name(pais) .. " => seleccionada anexión pacífica")
--        end
--      end
--    end
--  end
--
--  local num_candidatos_anexion_militar  = table.getn(candidatos_anexion_militar)
--  local num_candidatos_anexion_pacifica = table.getn(candidatos_anexion_pacifica)
--
----  if num_candidatos_anexion_militar + num_candidatos_anexion_pacifica > 0 then
----    LOG("Se han seleccionado " .. num_candidatos_anexion_militar .. " candidatos para anexión militar y "
----       .. num_candidatos_anexion_pacifica .. " candidatos para anexión pacífica")
----  else
----    LOG("No se ha seleccionado ningún candidato para anexión militar o pacífica")
----  end
--
--  -------------------------
--  -- 3. Generar iniciativas
--  -------------------------
--
--	local num_iniciativas_militares = generar_iniciativas_anexion_militar(candidatos_anexion_militar, candidatos_anexion_pacifica)
--	local num_iniciativas_pacificas = generar_iniciativas_anexion_pacifica(candidatos_anexion_pacifica)
--
--  return num_iniciativas_militares, num_iniciativas_pacificas
--end
--
--
---------------------------------------------------------------------------------
---- Devuelve la lista de países considerados fronterizos al jugador
---- Se consideran fronterizos aquellos paises que están en la zona de influencia
---- geográfica del jugador.
---------------------------------------------------------------------------------
--function get_paises_fronterizos()
--  local paises_fronterizos = {}
--
--  local all_paises     = get_all_paises()
--  local paises_ajenos  = {}
----  local paises_propios = get_paises(MY_PLAYER_ID)
--
--  for it_pais in all_paises do
--    local pais    = all_paises[it_pais]
--    local jugador = get_jugador_of_pais(pais)
--  
--    if jugador ~= MY_PLAYER_ID then
--      table.insert(paises_ajenos, pais)
--    end
--    
----    if jugador ~= MY_PLAYER_ID then
----      for it_pais_propio in paises_propios do
----        local pais_propio = paises_propios[it_pais_propio]
--
----        if get_distancia_paises(pais_propio, pais) == 1 then
----          table.insert(paises_fronterizos, pais)
----          break
----        end
----      end
----    end
--  end
--
--  paises_fronterizos = table_filter_one(paises_ajenos, es_pais_visible_geograficamente)
--
--  return paises_fronterizos
--end
--
--
---------------------------------------------------------------------------------
---- Calcula la preferencia de anexionar militarmente este país. Este valor 
---- solamente debe usarse para compararlo con el devuelto por la función 
---- 'get_preferencia_generica_anexion_pacifica'.
---------------------------------------------------------------------------------
--function get_preferencia_generica_anexion_militar(pais)
--  return (1.0 - get_nivel_defensivo(get_jugador_of_pais(pais)))
--         * g_perfil[PF_PORCENTAJE_FACETA_MILITAR]
--end
--
--
---------------------------------------------------------------------------------
---- Calcula la preferencia de anexionar pacíficamente este país. Este valor 
---- solamente debe usarse para compararlo con el devuelto por la función 
---- 'get_preferencia_generica_anexion_militar'.
---------------------------------------------------------------------------------
--function get_preferencia_generica_anexion_pacifica(pais)
--  -- Devuelve el grado de amistad normalizado con el jugador al que pertenece
--  -- el país destino.
--  return (1.0 - get_grado_hostilidad(MY_PLAYER_ID, get_jugador_of_pais(pais)))
--         * g_perfil[PF_PORCENTAJE_FACETA_DIPLOMATICA]
--end
--
--
---------------------------------------------------------------------------------
---- Dada una lista de países genera iniciativas de anexión militar sobre ellos.
---- El proceso que se sigue es el siguiente:
----    - Si el jugador local no puede hacer tratados diplomáticos entonces
----      se generan las iniciativas correspondientes antes de comenzar ninguna
----      anexión militar. Es importante que el jugador pueda hacer tratados
----      diplomáticos porque así podrá buscar aliados y pedir treguas.
----    - Si puede hacer tratados diplomáticos:
----      - Se eliminan de la lista aquellos paises que tienen buena relación
----        con alguno de los paises de la lista de anexionables pacíficamente,
----        de tal manera que evitamos perder puntos de amistad con estos últimos
----        por entrar en conflicto con otros.
----      - Se ordenan los paises por preferencia. Ver 'get_preferencia_anexion_
----        militar'.
----      - Para cada país se comprueba si está en la zona de influencia expansionista:
----          - Si no lo está, se generan las órdenes de mejorar esta zona de influencia.
----          - Si lo está, se generan las iniciativas de anexión militar.
---------------------------------------------------------------------------------
--function generar_iniciativas_anexion_militar(candidatos, candidatos_anexion_pacifica)
--  local num_iniciativas = 0
--  local faceta_militar  = g_perfil[PF_PORCENTAJE_FACETA_MILITAR]
--
--  ------------------------------------------------------
--  -- 1. Comprobar si el jugador puede hacer tratados
--  --    diplomáticos.
--  ------------------------------------------------------
--  if not puede_activar_diplomacia() then
--    LOG("El jugador no puede hacer tratados diplomáticos => mejorando zona de influencia diplomática")
--
--    num_iniciativas = num_iniciativas +
--                      generar_auto_mejora_influencia(TINI_ASIMILAR,
--                                                     MEJORA_INFLUENCIA_DIPLOMATICA,
--                                                     1.0 * faceta_militar,
--                                                     1.0 * faceta_militar)
--  else
--    ------------------------------------------------------
--    -- 2. Eliminar los que tienen buena relación con algún
--    --    país anexionable pacíficamente.
--    ------------------------------------------------------
--    local paises = candidatos --eliminar_jugadores_incompatibles_militar(candidatos, candidatos_anexion_pacifica)
--
--    ------------------------------------------------------
--    -- 3. Ordenar los paises por preferencia
--    ------------------------------------------------------
--    table.sort(paises, compare_preferencia_militar)
--
--    ------------------------------------------------------
--    -- 4. Generar iniciativas
--    ------------------------------------------------------
--    for it_pais in paises do
--      local pais    = paises[it_pais]
--      local jugador = get_jugador_of_pais(pais)
--      
--      -- Solamente generamos mejora de la zona de influencia expansionista si
--      -- el jugador es imperial, el otro jugador es neutral y no es anexionable militarmente.
--      if es_jugador_imperial(MY_PLAYER_ID) and not es_jugador_imperial(jugador) and not es_pais_anexionable_militarmente(pais) then
--        LOG(get_pais_name(pais) .. " no está en la zona de influencia expansionista => mejorando zona de influencia");
--        num_iniciativas = num_iniciativas +
--                          generar_auto_mejora_influencia(TINI_ASIMILAR,
--                                                         MEJORA_INFLUENCIA_EXPANSION,
--                                                         0.9 * faceta_militar,
--                                                         0.9 * faceta_militar)
--      else
--        local conflicto_comenzado       = false
--        local num_iniciativas_militares = 0
--
--        conflicto_comenzado, num_iniciativas_militares = generar_anexion_militar(pais)
--        num_iniciativas = num_iniciativas + num_iniciativas_militares  
--
--        if conflicto_comenzado then
--          -- Si nos hemos metido en una guerra entonces no consideramos más anexiones militares,
--          -- ya que no queremos estar en más de un conflicto.
--          break
--        end 
--      end
--    end
--  end
--
--  return num_iniciativas
--end
--
--
---------------------------------------------------------------------------------
---- Dada una lista de paises, elimina de ella los países que pertenezcan a
---- jugadores que se lleven bien con otros jugadores de una segunda lista 
---- y devuelve una lista con jugadores que no se llevan mal entre sí.
---------------------------------------------------------------------------------
--function eliminar_jugadores_incompatibles_militar(paises_militar, paises_pacifica)
--  local candidatos_seleccionados = {}
--  local eliminados               = {}
--  local jugadores_reduccion_elim = {}
--
--  for it_pais in paises_militar do
--    local pais    = paises_militar[it_pais]
--    local jugador = get_jugador_of_pais(pais)
--
--    local seleccionar = true
--
--    -- Miramos si el jugador al que pertenece este pais se lleva bien
--    -- con alguno de los paises de anexión pacífica
--    for it_pais_pacifica in paises_pacifica do
--      local pais2    = paises_pacifica[it_pais_pacifica]
--      local jugador2 = get_jugador_of_pais(pais2)
--
--      if get_grado_hostilidad(jugador, jugador2) < 0.5 then
----        LOG("Eliminando " .. get_pais_name(pais) .. " de la lista de candidatos para anexión militar"
----            .. " porque produciría una reducción de amistad con " .. get_name(jugador2));
--        table.insert(eliminados, pais)
--        table.insert(jugadores_reduccion_elim, jugador2)
--
--        seleccionar = false
--        break
--      end
--    end
--
--    if seleccionar then
--      table.insert(candidatos_seleccionados, pais)
--    end
--  end
--
--  if table.getn(eliminados) > 0 then
--    LOG("Eliminando " .. concat_log(table_transform_one(eliminados, get_pais_name), ", ") 
--        .. " de candidatos militares porque reducirían amistad con " .. concat_log(table_transform_one(jugadores_reduccion_elim, get_name), ", "))
--  end
--
--  return candidatos_seleccionados
--end
--
--
---------------------------------------------------------------------------------
---- Predicado para ordenar paises según su preferencia de anexión militar
---------------------------------------------------------------------------------
--function compare_preferencia_militar(pais1, pais2)
--  local preferencia1 = get_preferencia_anexion_militar(pais1)
--  local preferencia2 = get_preferencia_anexion_militar(pais2)
--
--  return preferencia1 > preferencia2
--end
--
--
---------------------------------------------------------------------------------
---- Calcula la preferencia de un pais con respecto a la anexión militar.
----    - La debilidad del país
----    - Nuestro grado de relación con él
---- Estos factores están regulados por respectivos porcentajes.
---------------------------------------------------------------------------------
--function get_preferencia_anexion_militar(pais)
--  local jugador   = get_jugador_of_pais(pais)
--  local debilidad = get_nivel_defensivo(jugador)
--  local relacion  = get_grado_hostilidad(MY_PLAYER_ID, jugador)
--
--  return debilidad    * IMPORTANCIA_ANEXIONABILIDAD +
--         (1-relacion) * IMPORTANCIA_MOLABILIDAD
--end
--
--
---------------------------------------------------------------------------------
---- Genera las órdenes necesarias para llevar a cabo la iniciativa de anexionar
---- militarmente un país.
---- Si no tiene visibilidad militar al pais entonces se generarán órdenes para
---- la mejora de la zona de influencia militar.
---- Devuelve en primer lugar un booleano indicando si se ha comenzado un nuevo 
---- conflicto, y en segundo lugar el número de órdenes generadas.
---------------------------------------------------------------------------------
--function generar_anexion_militar(pais)
--  LOG("")
--  if es_pais_imperial(pais) then
--    LOG("*** GENERANDO ORDENES DE ANEXION MILITAR PARA " .. get_pais_name(pais) .. " ***")
--  else
--    LOG("*** GENERANDO ORDENES DE ATAQUE PARA " .. get_pais_name(pais) .. " ***")
--  end
--  LOG("")
--
--  local conflicto_comenzado = false
--  local num_iniciativas     = 0
--
--  local jugador_enemigo = get_jugador_of_pais(pais)
--  local iniciativa
--  
--  if es_jugador_imperial(jugador_enemigo) then
--    iniciativa = TINI_ASIMILAR
--  else
--    iniciativa = TINI_ASIMILAR
--  end
--
--  if not es_pais_visible_militarmente(pais) then
--    -- El país no es visible militarmente, así que aumentamos
--    -- la zona de influencia militar
--    LOG("El país no es visible militarmente => mejorando zona de influencia militar")
--
--    num_iniciativas = num_iniciativas + 
--                      generar_auto_mejora_influencia(iniciativa,
--                                                     MEJORA_INFLUENCIA_MILITAR,
--                                                     1.0 * g_perfil[PF_PORCENTAJE_FACETA_MILITAR],
--                                                     1.0 * g_perfil[PF_PORCENTAJE_FACETA_MILITAR])
--  else
--    -- El país es visible militarmente
--
--    ------------------------------------------------------
--    -- 1. Buscar aliados factibles
--    ------------------------------------------------------
--    local aliados_factibles = get_aliados_factibles(MY_PLAYER_ID, jugador_enemigo)
--    if table.getn(aliados_factibles) == 0 then
--      generar_auto_mejora_influencia(iniciativa, 
--                                     MEJORA_INFLUENCIA_MILITAR,
--                                     1.0 * g_perfil[PF_PORCENTAJE_FACETA_MILITAR],
--                                     0.9 * g_perfil[PF_PORCENTAJE_FACETA_MILITAR])
--
--      LOG("No se ha encontrado ningún aliado factible => mejorando zona de influencia militar")      
--    else
--      LOG("Encontrados " .. table.getn(aliados_factibles) .. " aliados factibles (" 
--          .. concat_log(table_transform_one(aliados_factibles, get_name), ", ") .. ")")
--    end
--    
--    ------------------------------------------------------
--    -- 2. Decidir ataque
--    ------------------------------------------------------
--    local num_mensajes_alianzas_enviados  = 0
--    local num_iniciativas_ataque          = 0
--
--    local preferencia = get_preferencia_anexion_militar(pais)
--    conflicto_comenzado, 
--    num_mensajes_alianzas_enviados, 
--    num_iniciativas_ataque = iniciar_ataque(jugador_enemigo, 
--                                            aliados_factibles, 
--                                            iniciativa,
--                                            preferencia,
--                                            0.8 * preferencia,
--                                            0.9 * preferencia,
--                                            1 - g_perfil[PF_TEMERIDAD])
--
--    num_iniciativas = num_iniciativas + num_iniciativas_ataque
--  end
--
--
--  return conflicto_comenzado, num_iniciativas
--end
--
--
---------------------------------------------------------------------------------
---- Devuelve la lista ordenada de aliados factibles para jugador_local contra 
---- jugador_enemigo. Si el jugador enemigo es un país uniprovincial entonces
---- ningún aliado es factible.
---- Los aliados factibles son aquellos jugadores que:
----    - Estan en el area de influencia militar.
----    - Pueden firmar alianza con el jugador contra el enemigo.
----    - Si el jugador enemigo es un país neutral no uniprovincial, el aliado 
----      no es un imperio (ya que se produciría un conflicto de intereses para 
----      ver quién anexionaría el país en caso de vencer).
---- La ordenación se lleva a cabo según lo devuelto por 'get_preferencia_aliado'
---------------------------------------------------------------------------------
--function get_aliados_factibles(jugador_local, jugador_enemigo)
--  local aliados = {}
--
--  -- Comprobamos si el enemigo es un país neutral uniprovincial
--  --if table.getn(get_provincias(jugador_enemigo)) == 1 then
--  --  return aliados
--  --end
--
--  local candidatos      = get_jugadores()
--
--  for it in candidatos do
--    local candidato = candidatos[it]
--    local mensaje_alianza 
--
--    local ok = candidato ~= jugador_local and candidato ~= jugador_enemigo
--
--    if ok then
--      ok = es_jugador_visible_militarmente(candidato)
--    end
--    
--    if ok then
--      mensaje_alianza = generar_mensaje_coalicion(candidato, jugador_enemigo, false, {})
--      ok = puede_enviar_mensaje_diplomatico_por_tipo(mensaje_alianza)
--    end
--
--    if ok and not es_jugador_imperial(jugador_enemigo) then
--      ok = not es_jugador_imperial(candidato)
--    end
--
--    if ok then  
--      table.insert(aliados, candidato)
--    end
--  end
--
--  -- Ordenamos la lista
--  g_jugador_enemigo_anexion = jugador_enemigo
--  table.sort(aliados, compare_preferencia_aliado)
--
--  return aliados
--end
--
--
---------------------------------------------------------------------------------
---- Devuelve la preferencia de aliarse con un jugador dado contra otro jugador.
---- La preferencia tiene en cuenta los siguientes factores:
----    - El precio de la alianza
----    - TODO
---- Nota: - Se supone que se ha comprobado antes de llamar a esta función que el 
----         jugador dado puede ser aliado del jugador local.
---------------------------------------------------------------------------------
--function get_preferencia_aliado(aliado, enemigo)
--  local preferencia = 0
--
--  local mensaje = generar_mensaje_coalicion(aliado, enemigo, false, {})  
--  local precio  = get_precio_of_tratado(mensaje)
--
--  return -precio
--end
--
--
---------------------------------------------------------------------------------
---- Define una ordenación entre aliados con respecto a su preferencia
---------------------------------------------------------------------------------
--function compare_preferencia_aliado(aliado1, aliado2)
--  assert(g_jugador_enemigo_anexion ~= NIL)
--
--  local preferencia1 = get_preferencia_aliado(aliado1, g_jugador_enemigo_anexion)
--  local preferencia2 = get_preferencia_aliado(aliado2, g_jugador_enemigo_anexion)
--
--  return preferencia1 > preferencia2
--end
--
--
---------------------------------------------------------------------------------
---- Intenta montar una campaña militar contra un jugador. El jugador local
---- evaluará su potencia militar y hará las alianzas necesarias para poder
---- comenzar el conflicto.
---- El proceso que se sigue es el siguiente:
----    - Comprobar si con los aliados en curso es posible iniciar una guerra
----      con el jugador ajeno.
----      - Si no es factible, añadir el siguiente aliado factible y volver
----        a comprobarlo.
----      - Si es factible:
----        - Comparar nuestro poder militar con el del enemigo:
----          - Si nuestro poder militar es lo suficientemente superior
----            (dependiente de nuestro perfil) decidir cuál de estas cosas hacer:
----            - Extorsionar al jugador. En este caso no se lanza ningún mensaje
----              de alianza.
----            - Enviar un mensaje de declaración de guerra. En este caso sí se
----              lanzan todos los mensajes de alianza pendientes.
----          - Si nuestro poder militar no es lo suficientemente superior:
----            - Enviar los mensajes de alianza necesarios (si los hay).
----          - Mandar las órdenes de mejorar militarmente.
----          - Volver.
----    - Si se llega a este punto entonces no se ha decidido ningún ataque.
----      En ese caso, si hay algún pais atacable entonces mejoramos militarmente.
---- Devuelve tres valores:
----    - Un booleano indicando si el conflicto va a comenzar el siguiente turno.
----      Nota: - Aunque el ataque sea factible es posible que el jugador haya 
----              decidido extorsionar primero al enemigo.
----    - El número de mensajes diplomáticos de alianza enviados.
----      Nota: - Este valor no indica necesariamente el número de aliados que se 
----              conseguirán al siguiente turno, ya que los jugadores pueden 
----              rechazarlos.
----    - El número de órdenes generadas.
---------------------------------------------------------------------------------
--function iniciar_ataque(enemigo, aliados_factibles, origen, preferencia, prioridad_min, prioridad_max, nivel_atacante_minimo)
--  LOG("Intentando iniciar ataque contra " .. get_name(enemigo))
--
--  local conflicto_comenzado   = false
--  local num_mensajes_alianza  = 0
--  local num_iniciativas       = 0
--
--  -- Nivel atacante mínimo para considerar factible un conflicto
--  
--
--  -- Lista de jugadores usada en la llamada a get_nivel_atacante.
--  -- Incluye al jugador actual y a sus aliados en curso.
--  local lista_atacante = { MY_PLAYER_ID }
--  local nivel_atacante = get_nivel_atacante(enemigo, lista_atacante)
--  local log = "    Nivel atacante inicial [" .. nivel_atacante .. "] => "
--
--  -- Lista de aliados que se van a intentar hacer
--  local aliados_en_curso = {}
--  local it_aliado        = 1
--
--  repeat
--    -- Nivel atacante tras añadir este aliado factible.
--    -- Se usará para comprobar si este aliado nos aportaría algo
--    local nuevo_nivel_atacante = 0
--  
--    -- Comprobar si con los aliados actuales y los aliados en curso es posible iniciar la guerra.
--    if nivel_atacante >= nivel_atacante_minimo then
--      -- Es suficiente con los aliados considerados
--      LOG("    El nivel atacante actual, con " .. table.getn(aliados_en_curso) .. " aliados, es suficiente => iniciando ataque")
--  
--      -- Comprobamos si nuestro poder militar es lo suficientemente superior
--      -- al del enemigo. Este valor depende de la faceta militar del jugador.
--      -- Si es un jugador totalmente militar entonces no hará una declaración de
--      -- guerra a no ser que sea devastantemente superior al enemigo. En contraste,
--      -- un jugador totalmente diplomático hará una declaración de guerra simplemente
--      -- con que sea factible el conflicto, para así evitar tener pérdida de puntos de
--      -- amistad con los demás países, cosa que ocurre al entrar en una guerra sin
--      -- declaración previa.
--      local nivel_atacante_minimo_para_declaracion_guerra = nivel_atacante_minimo + 
--                                                            (1 - nivel_atacante_minimo)*g_perfil[PF_PORCENTAJE_FACETA_MILITAR]
--
--      if nivel_atacante >= nivel_atacante_minimo_para_declaracion_guerra and table.getn(aliados_en_curso) == 0 then
--        -- Somos lo suficientemente superiores al enemigo, así que no entramos en guerra inmediatamente
--        LOG("        Nivel atacante muy superior (" .. nivel_atacante .. " >= " .. nivel_atacante_minimo_para_declaracion_guerra .. ")")
--        
--        local extorsionar = false
--
--        -- TODO: Decidir si extorsionar al jugador o comenzar el conflicto con una declaración de guerra
--
--        if not extorsionar then
--          local mensaje = generar_mensaje_declaracion_guerra(enemigo)
--
--          ENVIAR_MENSAJE_DIPLOMATICO(origen, preferencia, prioridad_max, mensaje)
--
--          conflicto_comenzado = true
--        end
--      else
--        -- No somos lo suficientemente superiores al enemigo
--        LOG("    Enviando mensajes de alianza a los posibles aliados")
--
--        -- Enviamos los mensajes de alianza necesarios
--        for it_aliado_en_curso in aliados_en_curso do
--          local nuevo_aliado = aliados_en_curso[it_aliado_en_curso]
--
--          local mensaje = generar_mensaje_coalicion(nuevo_aliado, enemigo, false, {})
--          ENVIAR_MENSAJE_DIPLOMATICO(origen, preferencia, prioridad_max, mensaje)
--
--          LOG("Mensaje de alianza a "..get_name(nuevo_aliado).." enviado (" .. mensaje[MD_INDEX_OFERTA_DINERO].. ")")
--
--          num_mensajes_alianza = num_mensajes_alianza + 1
--        end        
--
--        if table.getn(aliados_en_curso) == 0 then
--          ATACAR_JUGADOR(origen, preferencia, prioridad_max, enemigo)
--        end
--
--        conflicto_comenzado = true
--        LOG("    SE HA PRODUCIDO UN CONFLICTO CON " .. get_name(enemigo))
--      end
--
--      -- Enviamos las órdenes de mejorar militarmente
--      LOG("Enviando órdenes de mejora militar")
--      generar_mejora_militar(origen, preferencia, true)
--
--      -- Volvemos
--      break
--    elseif it_aliado <= table.getn(aliados_factibles) then
--      -- No es suficiente con los aliados considerados, así que intentamos hacer otro aliado
--      local aliado_factible = aliados_factibles[it_aliado]
--
--      -- Comprobamos si este nuevo aliado nos aporta algo
--      table.insert(lista_atacante, aliado_factible)
--      nuevo_nivel_atacante = get_nivel_atacante(enemigo, lista_atacante)
--
--      if (nuevo_nivel_atacante > nivel_atacante) then
--        -- El nuevo aliado nos aporta más nivel atacante, así que lo añadimos a la
--        -- lista de aliados en curso
--        table.insert(aliados_en_curso, aliado_factible)
--        nivel_atacante = nuevo_nivel_atacante
--
--        LOG("    " .. get_name(aliado_factible) .. " nos permite aumentar el nivel atacante a " .. nivel_atacante)
--        log = log .. get_name(aliado_factible) .. " [" .. nivel_atacante .. "] "
--      else        
--        -- El nuevo aliado no nos aporta nada, así que no lo consideramos
--        table.remove(lista_atacante)
--
--        LOG("    " .. get_name(aliado_factible) .. " no nos permite mejorar el nivel atacante")
--      end
--    end    
--
--    it_aliado = it_aliado + 1  
--  until it_aliado > table.getn(aliados_factibles) + 1
--
--  LOG(log)
--
--  return conflicto_comenzado, num_mensajes_alianza, num_iniciativas
--end
--
--
---------------------------------------------------------------------------------
---- Dada una lista de países genera iniciativas de anexión pacífica sobre ellos.
---- El proceso a seguir es el siguiente:
----    - La lista de paises pasada se procesa para eliminar de ella los países
----      que son incompatibles con otros que se encuentran en la lista con más
----      preferencia. Dos paises se consideran incompatibles si su grado de 
----      relación es hostil.
---------------------------------------------------------------------------------
--function generar_iniciativas_anexion_pacifica(candidatos)
--  local num_iniciativas = 0
--  local eliminados               = {}
--  local jugadores_reduccion_elim = {}
--
--  -- Eliminamos de la lista de paises candidatos los que pertenezcan a jugadores que se lleven mal entre sí,
--  -- para evitar sufrir una pérdida de puntos de amistad por mejorar relaciones con un jugador que se lleva
--  -- mal con otro con el que también hemos mejorado relaciones.
--  local paises = eliminar_jugadores_incompatibles_pacifica(candidatos)
--
--  -- Nota: - Es necesario copiar los candidatos a una nueva tabla para evitar problemas con LUA cuando
--  --         se itera sobre una tabla dentro de otra iteración sobre ésta.
--  local resto_paises = {}
--  for it_pais in paises do
--    table.insert(resto_paises, paises[it_pais])
--  end
--
--  -- Ahora iteramos por los países candidatos. Todos los jugadores de la lista se llevan bien entre sí.
--  for it_pais in paises do
--    local pais = paises[it_pais]
--
--    num_iniciativas = num_iniciativas + generar_anexion_pacifica(pais, resto_paises)
--  end  
--
--  return num_iniciativas
--end
--
--
---------------------------------------------------------------------------------
---- Dada una lista de paises, elimina de ella los países que pertenezcan a
---- jugadores que se lleven mal con otros jugadores de la lista y devuelve
---- una lista con jugadores que no se llevan mal entre sí.
---------------------------------------------------------------------------------
--function eliminar_jugadores_incompatibles_pacifica(paises_candidatos)
--  local candidatos_seleccionados = {}
--  local eliminados               = {}
--  local jugadores_reduccion_elim = {}
--
--  for it_pais in paises_candidatos do
--    local pais    = paises_candidatos[it_pais]
--    local jugador = get_jugador_of_pais(pais)
--
--    local seleccionar = true
--
--    -- Miramos si el jugador al que pertenece este pais se lleva mal
--    -- con alguno de los candidatos seleccionados
--    for it_pais_seleccionado in candidatos_seleccionados do
--      local pais2    = paises_candidatos[it_pais_seleccionado]
--      local jugador2 = get_jugador_of_pais(pais2)
--
--      if get_grado_hostilidad(jugador, jugador2) > 0.5 then
----        LOG("Eliminando " .. get_pais_name(pais) .. " de la lista de candidatos para anexión pacífica"
----            .. " porque produciría una reducción de amistad con " .. get_name(jugador2));
--        table.insert(eliminados, pais)
--        table.insert(jugadores_reduccion_elim, jugador2)
--
--        seleccionar = false
--        break
--      end
--    end
--
--    if seleccionar then
--      table.insert(candidatos_seleccionados, pais)
--    end
--  end
--
--  if table.getn(eliminados) > 0 then
--    LOG("Eliminando " .. concat_log(table_transform_one(eliminados, get_pais_name), ", ") 
--        .. " de candidatos pacíficos porque reducirían amistad con " .. concat_log(table_transform_one(jugadores_reduccion_elim, get_name), ", "))
--  end
--
--  return candidatos_seleccionados
--end
--
--
---------------------------------------------------------------------------------
---- Genera las órdenes necesarias para llevar a cabo la iniciativa de anexionar
---- pacíficamente un país.
---- El proceso que se sigue es el siguiente:
----    - Si el país no está en nuestra zona de influencia geográfica, primero 
----      intentamos aumentarla, ya que de ésta depende la zona de influencia 
----      expansionista y esta última es requisito para la anexión pacífica.
----      En este caso no se generan más órdenes para esta iniciativa.
----    - Si el país está en nuestra zona de influencia geográfica:
----      - Si el país no se encuentra en nuestra zona de influencia expansionista
----        entonces generamos la orden de aumentar este tipo de zona de influencia.
----        Mientras intentamos aumentar la zona de influencia expansionista podemos
----        ir aumentando la amistad con el país para no perder tiempo.
----      - Si no se ha construido el Consulado se genera la orden de construirlo
----        con preferencia alta.
----      - Generamos las órdenes de construir los edificios que mejoren
----        directamente nuestra amistad con el jugador de ese país.
----      - Si el país no se encuentra en nuestra zona de influencia diplomática:
----        - Generamos la orden de aumentar este tipo de zona de influencia para
----          poder cuanto antes hacer tratados diplomáticos con él.
----      - Si el país se encuentra en nuestra zona de influencia diplomática:
----        - Generamos las órdenes de llevar a cabo tratados diplomáticos
----          que mejoren la amistad directamente con el jugador de ese país.
----      - Generamos las órdenes de construir rutas comerciales hasta ese país.
----      - Generamos las órdenes de construir los edificios que mejoren nuestra
----        amistad con el jugador a través de otros jugadores que sean amigos de 
----        éste.
----      - Generamos las órdenes de llevar a cabo tratados diplomáticos con
----        otros jugadores que mejoren nuestra amistad con el jugador deseado,
----        si estos jugadores están en nuestra zona de influencia diplomática.
---------------------------------------------------------------------------------
--function generar_anexion_pacifica(pais, candidatos_anexion_pacifica)
--  local num_iniciativas = 0
--
--  -- Calculamos la preferencia relativa de este país con respecto a los demás candidatos
--  -- para anexión pacífica. Esta preferencia servirá para llevar una ordenación entre todas
--  -- las órdenes que se generen durante el transcurso de la iniciativa de anexión pacífica.
--  local preferencia = get_preferencia_anexion_pacifica(pais)
--  local perfil      = g_perfil[PF_PORCENTAJE_FACETA_DIPLOMATICA]
--
--  LOG("*** GENERANDO ORDENES DE ANEXION PACIFICA PARA " .. get_pais_name(pais) 
--      .. " (preferencia = " .. preferencia .. ", perfil = " .. perfil .. ") ***")
--
--  ------------------------------------------------------
--  -- 1. Comprobar que el país es visible geográficamente
--  ------------------------------------------------------
--  if not es_pais_visible_geograficamente(pais) then
--    -- Si el país no es visible geográficamente entonces intentamos expandir
--    -- nuestra zona de influencia geográfica y no hacemos nada más.
--    LOG("    El país no es visible geográficamente => mejorando zona de influencia geográfica")
--
--    num_iniciativas = num_iniciativas + 
--                      generar_auto_mejora_influencia(TINI_ASIMILAR, 
--                                                     MEJORA_INFLUENCIA_GEOGRAFICA, 
--                                                     1.0  * perfil,
--                                                     1.0  * perfil * preferencia)
--    return num_iniciativas
--  end 
--
--  ------------------------------------------------------
--  -- 2. Comprobar que el país se encuentra en la zona de
--  --    influencia expansionista.
--  ------------------------------------------------------
--  if not es_pais_anexionable_diplomaticamente(pais) then
--    LOG("    El país no es anexionable => mejorando zona de influencia expansionista")
--
--    num_iniciativas = num_iniciativas + 
--                      generar_auto_mejora_influencia(TINI_ASIMILAR, 
--                                                     MEJORA_INFLUENCIA_EXPANSION, 
--                                                     1.0  * perfil,
--                                                     1.0  * perfil * preferencia)
--  end
--
--  ------------------------------------------------------
--  -- 3. Comprobar si se tiene un Consulado en el país
--  ------------------------------------------------------
--  if not esta_edificio_construido_en_pais(get_idx_edificio("CONSULADO"), pais) then
--    -- El Consulado no está construido, así que se hace lo posible por construirlo
--    LOG("    El Consulado no está construido => intentando construir Consulado")
--
--    -- TODO: Introducir una prioridad entre las órdenes de Consulado haciendo que
--    --       los que se construyan en paises más amigos del jugador tengan preferencia
--    num_iniciativas = num_iniciativas + 
--                      generar_auto_mejora_en_pais(pais,
--                                                  TINI_ASIMILAR,
--                                                  MEJORA_HABILITA_ASIMILACION_PACIFICA, 
--                                                  1.0  * perfil,
--                                                  0.95 * perfil * preferencia, 
--                                                  1.0  * perfil * preferencia)
--  end
--
--  ------------------------------------------------------
--  -- 4. Generar órdenes de construcción de edificios
--  --    para la mejora directa de las relaciones. En
--  --    este punto se considerará también la creación
--  --    de rutas comerciales hacia el país.
--  ------------------------------------------------------
--  LOG("    Intentando construir edificios de anexión pacífica")
--  num_iniciativas = num_iniciativas +
--                    generar_auto_mejora_en_pais(pais,
--                                                TINI_ASIMILAR, 
--                                                MEJORA_ASIMILACION_PACIFICA, 
--                                                0.8 * perfil,
--                                                0.7 * perfil * preferencia, 
--                                                0.8 * perfil * preferencia)
--
--  ------------------------------------------------------
--  -- 5. Comprobar que el jugador es visible diplomáticamente
--  ------------------------------------------------------
--  local jugador_ajeno = get_jugador_of_pais(pais)
--
--  if not es_jugador_visible_diplomaticamente(jugador_ajeno) then
--    -- El jugador no es visible diplomáticamente, así que intentamos aumentar
--    -- nuestra zona de influencia diplomática.
--    -- Esta orden debería tener más prioridad que la de construir edificios de anexión
--    -- pacífica, ya que es importante poder empezar a hacer tratados diplomáticos.
--    LOG("    El jugador no es visible diplomáticamente => aumentando zona de influencia diplomática")
--
--    num_iniciativas = num_iniciativas + 
--                      generar_auto_mejora_influencia(TINI_ASIMILAR, 
--                                                     MEJORA_INFLUENCIA_DIPLOMATICA, 
--                                                     0.9 * perfil,
--                                                     0.9 * perfil * preferencia)    
--  else
--    -- El jugador es visible diplomáticamente, así que intentamos hacer tratados
--    -- diplomáticos con él para mejorar nuestra amistad.
--    
--    local mensaje = generar_mensaje_mejora_relaciones(jugador_ajeno)
--    ENVIAR_MENSAJE_DIPLOMATICO(TINI_ASIMILAR, 0.7 * perfil, 0.6 * perfil, mensaje)
--  end
--
--  ------------------------------------------------------
--  -- 6. Generamos las órdenes de construcción de 
--  --    edificios para mejorar la relación con los
--  --    países que son amigos del que queremos anexionar
--  ------------------------------------------------------
--  LOG("    Comenzando mejora de relaciones indirecta con " .. get_name(jugador_ajeno) 
--      .. " (probando " .. table.getn(candidatos_anexion_pacifica)-1 .. " paises)")
--
--  -- Generamos las iniciativas de construcción de edificios de mejora de amistad
--  -- y de tratados diplomáticos en estos paises
--
--  for it_paises in candidatos_anexion_pacifica do
--    local pais_indirecto    = candidatos_anexion_pacifica[it_paises]
--    local jugador_indirecto = get_jugador_of_pais(pais_indirecto)
--
--    -- Sólo consideramos los otros jugadores
--    if jugador_indirecto ~= jugador_ajeno then
--      local preferencia_jugador_indirecto = 1 - get_grado_hostilidad(jugador_ajeno, jugador_indirecto)
--
----      LOG("        Intentando mejorar relaciones con " .. get_name(jugador_ajeno) .. " a través de " .. 
----          get_name(jugador_indirecto) .. " en " .. get_pais_name(pais_indirecto) .. " (preferencia " ..
----          preferencia_jugador_indirecto .. ")")
--
--      num_iniciativas = num_iniciativas +
--                        generar_auto_mejora_en_pais(pais_indirecto,
--                                                    TINI_ASIMILAR, 
--                                                    MEJORA_ASIMILACION_PACIFICA, 
--                                                    0.5 * perfil, 
--                                                    0.4 * perfil * preferencia * preferencia_jugador_indirecto, 
--                                                    0.5 * perfil * preferencia * preferencia_jugador_indirecto)
--
--      if es_jugador_visible_diplomaticamente(jugador_indirecto) then
--        -- Solamente si el jugador es visible diplomáticamente haremos tratados con él
--        -- para mejorar indirectamente la relación con otro jugador.
--
--        local mensaje = generar_mensaje_mejora_relaciones(jugador_indirecto)
--        ENVIAR_MENSAJE_DIPLOMATICO(TINI_ASIMILAR, 0.4 * perfil, 0.3 * perfil, mensaje)
--      end
--    end
--  end
--
--  return num_iniciativas
--end
--
--
---------------------------------------------------------------------------------
---- Calcula la preferencia de un pais con respecto a la anexión pacífica.
---- La preferencia tendrá en cuenta lo siguiente:
----    - Mi nivel de relación con el país contrastado con el nivel de relación
----      del resto de imperios. Cuanto más imperios tengan un grado de relación
----      bueno con el país menos me interesará intentar anexionarlo, ya que
----      tengo más competencia y mis posibilidades de conseguirlo se reducen.
----    - La riqueza del país, concretamente su producción.
---- Estos factores están regulados por respectivos porcentajes.
---------------------------------------------------------------------------------
--function get_preferencia_anexion_pacifica(pais)
--  -- Calcular valor pacífico
--  local jugador_pais         = get_jugador_of_pais(pais)
--  local jugadores_imperiales = table_filter_one(get_jugadores(), es_jugador_imperial)
--
--  local valor_pacifico = 1 - get_grado_hostilidad(MY_PLAYER_ID, jugador_pais)
--  for it_jugador in jugadores_imperiales do
--    local jugador_imperial  = jugadores_imperiales[it_jugador]
--
--    if jugador_imperial ~= MY_PLAYER_ID then
--      local relacion_imperial = get_grado_hostilidad(jugador_pais, jugador_imperial)   
--
--      valor_pacifico = valor_pacifico * relacion_imperial      
--    end
--  end
--
--  -- Calcular molabilidad
--  -- La molabilidad la definiremos como la proporción de la producción de este país
--  -- con respecto al país que más produce.
--  local molabilidad = 0 --get_produccion_of_pais(pais) / g_mayor_produccion_pais
--
--  -- Calcular preferencia
--  return IMPORTANCIA_ANEXIONABILIDAD * valor_pacifico +
--         IMPORTANCIA_MOLABILIDAD     * molabilidad
--end
--
--
---------------------------------------------------------------------------------
---- Función usada para la ordenación de un vector de países respecto de la
---- relación de éstos con un tercero. Este jugador sobre el que interesa la
---- relación estará especificado en la variable global g_jugador_interes_anexion.
---------------------------------------------------------------------------------
--function compare_grado_relacion(pais1, pais2)
--  assert(g_jugador_interes_anexion ~= 0)
--
--  local jugador1 = get_jugador_of_pais(pais1)
--  local jugador2 = get_jugador_of_pais(pais2)
--
--  return get_grado_hostilidad(g_jugador_interes_anexion, jugador1) < 
--         get_grado_hostilidad(g_jugador_interes_anexion, jugador2)
--end
--
--
---------------------------------------------------------------------------------
---- Genera iniciativas de ataque por parte de los paises neutrales.
---- El proceso que se lleva a cabo es el siguiente:
----    - Se seleccionan todos los países fronterizos
----    - Se filtra la lista dejando solamente los paises a los que nos interesa
----      atacar (ver 'es_pais_atacable_por_neutral')
----    - Se generan las iniciativas de ataque para esos 
---------------------------------------------------------------------------------
--function generar_iniciativas_ataque()
--  local num_iniciativas = 0
--
--  local paises_fronterizos = table_filter_one(get_paises_fronterizos(), es_pais_atacable_por_neutral)
--  LOG("Encontrados " .. table.getn(paises_fronterizos) .. " países fronterizos atacables (" .. concat_log(table_transform_one(paises_fronterizos, get_pais_name), ", ") .. ")")
--
--  local nivel_defensivo = get_nivel_defensivo(MY_PLAYER_ID)
--  if nivel_defensivo >= (1 - g_perfil[PF_TEMERIDAD]) and table.getn(get_enemigos_of_jugador(MY_PLAYER_ID)) == 0 then
--	  LOG("Nivel defensivo "..nivel_defensivo.." Temeridad "..1-g_perfil[PF_TEMERIDAD])
--	  local candidatos = table_filter_one(paises_fronterizos, es_pais_atacable_por_neutral)  
--	  num_iniciativas = num_iniciativas + generar_iniciativas_anexion_militar(candidatos, {})
--  end
--
--  return num_iniciativas
--end
--
--
---------------------------------------------------------------------------------
---- Comprueba si un pais es atacable por el jugador actual, que debe ser neutral
---- Un pais dado será atacable si:
----    - No es aliado del jugador
----    - Su grado de relación es malo
----    - El jugador a atacar no tiene aliados
---------------------------------------------------------------------------------
--function es_pais_atacable_por_neutral(pais)
--  local jugador = get_jugador_of_pais(pais)
--
--  local ok = not es_jugador_aliado(jugador) and 
--             get_grado_hostilidad(jugador, MY_PLAYER_ID) > 0.5 and 
--             table.getn(get_aliados_of_jugador(jugador)) == 0
--
--  return ok
--end
--
--function es_pais_hostigable(pais)
--  local jugador = get_jugador_of_pais(pais)
--
--  local ok = not es_jugador_aliado(jugador) and 
--             get_grado_hostilidad(jugador, MY_PLAYER_ID) > 0.5 
--
--  return ok	
--end
--
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
--function concat_log(lista, separador)
--  local line = ""
--
--  for it in lista do
--    line = line .. lista[it]
--    if it ~= table.getn(lista) then
--      line = line .. separador
--    end
--  end
--
--  return line
--end
--
--
--function calcular_produccion_paises()
--  local producciones = table_transform_one(get_all_paises(), get_produccion_of_pais)
--
--  g_mayor_produccion_pais = 0
--  for it_produccion_pais in producciones do
--    local produccion = producciones[it_produccion_pais]
--
--    -- TODO: Calcular valor de los recursos que produce según mis VRs
--    --g_mayor_produccion_pais = math.max(g_mayor_produccion_pais, produccion)
--  end
--end