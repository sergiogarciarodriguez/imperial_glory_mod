-- Necesitamos evaluar las reglas en un orden mas coherente
-- A falta de un sistema de inferencia perfecto, lo haremos asi:
--
-- COMO DEFENSOR
-- Lo mas importante son los objetivos de mapa (si hay)
-- Filtramos todo lo demas y comparamos los objetivos entre si
-- Un criterio para las tropas de cada objetivo de mapa sera cuantos objetivos hay en el mapa
-- 
-- Si no hay objetivo de mapa, debemos buscar la mejor zona
-- en el mapa para atrincherarnos
-- 
-- Una vez hayamos colocado la fuerza principal podemos evaluar
-- ocupar posiciones avanzadas con las tropas extra de
-- la fuerza principal
--
-- TODO:
-- Hay que ver si se da mas prioridad a ocupar posiciones avanzadas
-- o solo lo hacemos si tenemos tropas "extra"
--
-- COMO ATACANTE
-- Debo dejar la iniciativa al defensor
-- Si el defensor se comporta normalmente, ocupara los objetivos
-- de mapa o alguna zona defendible
--
-- Lo que hago es buscar un punto desde el que atacarle
-- y aproximarme, con todas mis tropas a atacarle desde ahi
--
-- Se puede evaluar un ataque simultaneo por varios frentes
-- 
-- Se puede evaluar tambien un ataque desde una posicion ventajosa
--
-- Si el defensor hace "cosas raras" como dejar objetivos abandonados
-- convendra que reaccione y vaya a por esos objetivos


-- Añadimos la variable global que controla si estamos aburridos de esperar en el CZ
add_global_var("bBoredYet", false);
-- Constante de "cuando me he aburrido"
uTimeToGetBored = 900*10;   -- multiplico por 10 porque ese es el fps, no? (por ahora se aburren a los 5 minutos)
if(get_GameDifficulty()==0)then
  uTimeToGetBored = uTimeToGetBored/10;
end

-----------------------------------------------
-- Hace el log en la pestaña adecuada a si es atacante o defensor
-----------------------------------------------
function log_SE(text)

  log("*SE_"..get_attacker_text()..":"..text);
  
end

-----------------------------------------------
-- Elige, de una lista de intereses, el mejor
-- Devuelve el interes elegido
-- Si no devuelve nada se considera que ningun
-- interes vale
-----------------------------------------------
function select_winner_interest(interests)

  log_SE("--------------------------------------------------");
  
  log_SE("");
  
  for i=1,table.getn(interests) do
    log_SE(" "..i..": "..get_interest_text(interests[i]));
  end
  log_SE("--");
  
  -- compruebo que no me haya aburrido de esperar o que no esté en mucha superioridad
  if time_bored() > uTimeToGetBored or iam_clearly_superior() then
    set_global_var("bBoredYet", true);
    objective_setATFlankTroopsProb(0);
  end
  
  local winner = find_winner_interest(interests);
  log_SE("WINNER: " .. get_interest_text(winner));
  log_SE("--------------------------------------------------");
  return winner;
  
end


-----------------------------------------------
-- Devuelve los intereses de un tipo especifico,
-- y los borra de la lista
-----------------------------------------------
function sacar_por_tipo(interests, tipo)

  elegidos = {};
  
  local i = 1;
  while i <= table.getn(interests) do
    if interest_GetType(interests[i]) == tipo then
      table.insert(elegidos, interests[i]);
      table.remove(interests, i);
    else
      i = i+1;
    end
  end

  return elegidos;
  
end

-----------------------------------------------
-- Inserta elementos de una tabla al final de
-- otra
-----------------------------------------------
function append_table(tabla_dest, tabla_src)

  local num = table.getn(tabla_src);
  for i=1,num do
    tabla_dest.insert(table_src[i]);
  end

end

-----------------------------------------------
-- 
-----------------------------------------------
function find_winner_interest(interests)
  
  -- Regla: si soy claramente superior intentaré elegir un objetivo ejército enemigo
  local bGotBored = get_global_var("bBoredYet");
  if is_clearly_superior() or bGotBored or (not iam_attacker() and not enough_troops_for_OM()) then
    local best_ee = nil;
    log_SE("We are clearly superior, so we shall try to find the best interest EJERCITO_ENEMIGO");
    -- definimos la probabilidad de mandar tropas por el flanco 0, porque queremos hacer un ataque directo
    objective_setATFlankTroopsProb(0);
    local ejercitos_enemigos = sacar_por_tipo(interests, TI_EJERCITO_ENEMIGO);
    if table.getn(ejercitos_enemigos) > 0 then
      best_ee = select_best_sequential(ejercitos_enemigos);
      log_SE("Best EE: "..get_interest_text(best_ee));
      return best_ee;
    end
  end
  
  -- Regla: si defiendo el mapa y hay objetivos, son prioritarios
  local best_om = nil;
  objetivos_mapa = sacar_por_tipo(interests, TI_OBJETIVO_MAPA);
  if not iam_attacker() then
    if table.getn(objetivos_mapa) >= 1 then 
      best_om =  select_best_sequential(objetivos_mapa);
      log_SE("Best OM: "..get_interest_text(best_om));
    end
  end
  
  -- Regla: Tengo el mejor OM, si hay algun puente, lo busco a ver si me interesa
  if best_om then      
    puentes = sacar_por_tipo(interests, TI_PUENTE);
    if table.getn(puentes) > 0 then
      log_SE("Bridges: " .. table.getn(puentes));
      return compare_zone_with_bridge(best_om, puentes);
    else
      return best_om;
    end
  end

  
  -- Regla: si defiendo el mapa y hay zonas, las comparo entre ellas, y me quedo solo con una
  local best_zona = nil;
  zonas = sacar_por_tipo(interests, TI_ZONA_INTERESANTE);
  log_SE("Zonas: "..table.getn(zonas));
  if table.getn(zonas) > 0 then
    best_zona = select_best_sequential(zonas);
    log_SE("Best ZI: "..get_interest_text(best_zona));
  end

  -- Regla: Si soy atacante, comparo la zona contra los intereses de mapa
  if iam_attacker() and best_zona then
    -- Soy el atacante, comparo los objetivos de mapa con la mejor zona, y me quedo solo con uno
    table.insert(objetivos_mapa, 1, best_zona);
    best_zona = select_best_sequential(objetivos_mapa);
    log_SE("Best ZI (after OM): "..get_interest_text(best_zona));
  end  
  
  
  -- Regla: Filtro la zona contra los puentes
  if best_zona then
    puentes = sacar_por_tipo(interests, TI_PUENTE);
    if table.getn(puentes) > 0 then
      log_SE("Bridges: " .. table.getn(puentes));
      best_zona = compare_zone_with_bridge(best_zona, puentes);
      log_SE("Best ZI (after bridge): "..get_interest_text(best_zona));
    end
  end
  
  -- La insertamos como primera, sera el interes de referencia
  -- con el que se compararan los demas
  if best_zona then
    table.insert(interests, 1, best_zona);
  end

  
  -- Me queda la mejor zona, los grupos enemigos y los puentes
  -- ¿COMO COMPARO EL ENEMIGO CON LA ZONA?
  
  log_SE("Comparacion abierta: "..table.getn(interests));
  return select_best_sequential(interests);

end

-----------------------------------------------
-- 
-----------------------------------------------
function compare_zone_with_bridge(zone, puentes)

  local i = 0;
  local n = table.getn(puentes);
  local res = 1;
  local zone_type = interest_GetType(zone);
  
  if zone_type == TI_OBJETIVO_MAPA then
    while i < n and res == 1 do
      i = i+1;
      res = esmejor_OM_PU(zone, puentes[i]);
    end
  elseif zone_type == TI_ZONA_INTERESANTE then
    while i < n and res == 1 do
      i = i+1;
      res = esmejor_ZI_PU(zone, puentes[i]);
    end
  else
    log_SE("Objetivo "..get_interest_text(zone).." se hace pasar por una zona (comparacion con puentes)");
  end

  if res == 1 then
    return zone;
  else
    return puentes[i];
  end  

end

-----------------------------------------------
-- 
-----------------------------------------------
function select_best_sequential(interests)

  -- Siempre tendre al menos un interes en la lista, o la funcion no se llamaria
  local best_interest = interests[1];
  
  --log("Select best con " .. table.getn(interests) .. " intereses");

  local num = table.getn(interests);
  for i=2,num do
    if calculate_esmejor(interests[i], best_interest) == 1 then
      best_interest = interests[i];
    end      
  end


  return best_interest;

end

-----------------------------------------------
-- 
-----------------------------------------------
function invertir_orden(orden)
  if orden == 1 then
    return 2;
  elseif orden == 2 then
    return 1;
  else
    return orden;
  end
end

-----------------------------------------------
-- Devuelve el numero (1 o 2) del mejor interes
-----------------------------------------------
function calculate_esmejor(interest1, interest2)
  
  local interest_type1 = interest_GetType(interest1);
  local interest_type2 = interest_GetType(interest2);
  
  local esmejor = 0;
  
  if interest_type1 == TI_OBJETIVO_MAPA then
    if interest_type2 == TI_OBJETIVO_MAPA then
      esmejor = esmejor_OM_OM(interest1, interest2);
    elseif interest_type2 == TI_ZONA_INTERESANTE then
      esmejor = esmejor_OM_ZI(interest1, interest2);
    elseif interest_type2 == TI_EJERCITO_ENEMIGO then
      esmejor = esmejor_OM_EE(interest1, interest2);
    elseif interest_type2 == TI_PUENTE then
      esmejor = esmejor_OM_PU(interest1, interest2);
    end
  elseif interest_type1 == TI_ZONA_INTERESANTE then
    if interest_type2 == TI_OBJETIVO_MAPA then
      esmejor = invertir_orden( esmejor_OM_ZI(interest2, interest1) );
    elseif interest_type2 == TI_ZONA_INTERESANTE then
      esmejor = esmejor_ZI_ZI(interest1, interest2);
    elseif interest_type2 == TI_EJERCITO_ENEMIGO then
      esmejor = esmejor_ZI_EE(interest1, interest2);
    elseif interest_type2 == TI_PUENTE then
      esmejor = esmejor_ZI_PU(interest1, interest2);
    end
  elseif interest_type1 == TI_EJERCITO_ENEMIGO then
    if interest_type2 == TI_OBJETIVO_MAPA then
      esmejor = invertir_orden( esmejor_OM_EE(interest2, interest1) );
    elseif interest_type2 == TI_ZONA_INTERESANTE then
      esmejor = invertir_orden( esmejor_ZI_EE(interest2, interest1) );
    elseif interest_type2 == TI_EJERCITO_ENEMIGO then
      esmejor = esmejor_EE_EE(interest1, interest2);
    elseif interest_type2 == TI_PUENTE then
      esmejor = esmejor_EE_PU(interest1, interest2);
    end
  elseif interest_type1 == TI_PUENTE then
    if interest_type2 == TI_OBJETIVO_MAPA then
      esmejor = invertir_orden( esmejor_OM_PU(interest2, interest1) );
    elseif interest_type2 == TI_ZONA_INTERESANTE then
      esmejor = invertir_orden( esmejor_ZI_PU(interest2, interest1) );
    elseif interest_type2 == TI_EJERCITO_ENEMIGO then
      esmejor = invertir_orden( esmejor_EE_PU(interest2, interest1) );
    elseif interest_type2 == TI_PUENTE then
      esmejor = esmejor_PU_PU(interest1, interest2);
    end
  end

  if esmejor == 0 then
    log_SE("ERROR NO HE ENCONTRADO NINGUN TIPO!!!");
  end
  
  return esmejor;
  
end

-----------------------------------------------
-- Clampea un numero entre 0 y 1
-----------------------------------------------
function normalize(val)
  if val < 0 then return 0; end
  if val > 1 then return 1; end
  return val;
end

-----------------------------------------------
-- Normaliza el numero y suaviza la curva
--
--  |  /       |   ---
--  | /    ->  |  /
--  |/___      |--___
-----------------------------------------------
function smooth_normalize(val)
  val = normalize(val);
  local val2 = val*val;
  return 3*val2 - 2*val2*val;
end

-----------------------------------------------
--
-----------------------------------------------
function esmejor_OM_OM(interest1, interest2)

  -- Si tengo alguno de los objetivos y el otro no, gana el que ya tengo
  local tengo_objetivo1 = accomplished_Objective(interest1);
  local tengo_objetivo2 = accomplished_Objective(interest2);
  
  if tengo_objetivo1 and not tengo_objetivo2 then
    log_SE(""..get_interest_text(interest1) .. " > " .. get_interest_text(interest2) .. " (Tengo el 1º)");
    return 1;
  end
  
  if tengo_objetivo2 and not tengo_objetivo1 then
    log_SE(""..get_interest_text(interest2) .. " > " .. get_interest_text(interest1) .. " (Tengo el 2º)");
    return 2;
  end

  -- Si ningun objetivo esta cumplido, los trato como si fueran zonas
  return esmejor_ZI_ZI(interest1, interest2);

end

-----------------------------------------------
--
-----------------------------------------------
function dar_num_apostables(res_list)
  local n = table.getn(res_list);
  local num = 0;
  for i=1,n do
    local tropa = res_list[i];
    if res_IsShootingInfantry(tropa) then
      num = num + 1;
    end
  end
  return num;
end

-----------------------------------------------
--
-----------------------------------------------
function set_ZI_ZI_params()
  -- TERRENO
  -- Factores de importancia
  zizi_factor_casas = 0.5;
  zizi_factor_bosques = 0.5;
  zizi_factor_alturas = 0.5;
  zizi_factor_combo = 1;
  zizi_factor_percent_apostadas = 1;

  -- Valores maximos, para comparar
  zizi_max_casas   = 4;
  zizi_max_bosques = 2;
  zizi_max_alturas = 100; -- ahora mismo salen bastantes

  -- MAP BORDER
  zizi_factor_map_border = 1;
  zizi_max_border  = 37000;
  
  -- COMPARACION FINAL
  -- Factores generales
  zizi_factor_terreno = 1;
  zizi_factor_activo  = 0.5;
  zizi_factor_dist    = 1.5;
  -- el factor del rand dependerá del nivel de dificultad
  local gamedif = get_GameDifficulty();
  if(gamedif==0)then
    zizi_factor_rand = 2.0;
  elseif(gamedif==1)then
    zizi_factor_rand = 1.0;
  else
    zizi_factor_rand    = 0.5;
    -- también cambiamos algún otro parámetro para hacer más difícil el nivel difícil (sic)
    -- cambiamos estos factores para que se quede en una zona interesante cercana para que no le pillen en medio
    zizi_factor_map_border = 0.5;
    zizi_factor_dist = 2.0;
  end
end

-----------------------------------------------
--
-----------------------------------------------
function set_EE_EE_params()
  eeee_factor_dist = 1;
  eeee_factor_activo = 0.5;
  eeee_factor_objetivosmapa = 1;
  eeee_distom_muylejos = 50000;
end

-----------------------------------------------
--
-----------------------------------------------
function esmejor_ZI_ZI(interest1, interest2)

  local id1 = interest_GetId(interest1);
  local id2 = interest_GetId(interest2);

  -- Si el enemigo esta ya en una zona y en otra no, voy a la vacia  
  local enemy_en_zona1 = interest_IsEnemyThere(interest1);
  local enemy_en_zona2 = interest_IsEnemyThere(interest2);
  
  if enemy_en_zona1 and not enemy_en_zona2 then
    log_SE(""..get_interest_text(interest2) .. " > " .. get_interest_text(interest1) .. " (Enemigo en el 1º)");
    return 2;
  end
  
  if enemy_en_zona2 and not enemy_en_zona1 then
    log_SE(""..get_interest_text(interest1) .. " > " .. get_interest_text(interest2) .. " (Enemigo en el 2º)");
    return 1;
  end
  
  -- PARAMETROS CONFIGURABLES!!!
  set_ZI_ZI_params();
  
  -- Factor: el objetivo ya esta creado
  local activo1 = 0;
  if interest_HasObjective(interest1) then 
    activo1 = 1; 
  end
  local activo2 = 0;
  if interest_HasObjective(interest2) then 
    activo2 = 1; 
  end
  
  local umbral_dist = 5000; -- Factor que se aplica para que, en distancias cortas muy proximas, los valores no se distorsionen
  
  -- Factor: distancia
  local dist1 = 1 - smooth_normalize((interest_MyDist(interest1) - umbral_dist) / interest_DistEnemy(interest1));
  local dist2 = 1 - smooth_normalize((interest_MyDist(interest2) - umbral_dist) / interest_DistEnemy(interest2));
  

  local num_casas1, num_bosques1, num_alturas1 = interest_GetTerrain(interest1);
  local num_casas2, num_bosques2, num_alturas2 = interest_GetTerrain(interest2);


  local percent_apostadas1 = 0;
  local percent_apostadas2 = 0;
  if num_casas1 + num_bosques1 > 0 then
    local res1 = interest_GetResources(interest1);
    local n_res_apostables1 = dar_num_apostables(res1);
    if n_res_apostables1 > 0 then
      percent_apostadas1 = smooth_normalize((num_casas1 + num_bosques1) / n_res_apostables1);
    end
  end
  if num_casas2 + num_bosques2 > 0 then
    local res2 = interest_GetResources(interest2);
    local n_res_apostables2 = dar_num_apostables(res2);
    if n_res_apostables2 > 0 then
      percent_apostadas2 = smooth_normalize((num_casas2 + num_bosques2) / n_res_apostables2);
    end
  end

  local dist_border1 = interest_DistMapBorder(interest1);
  local dist_border2 = interest_DistMapBorder(interest2);
  
  local percent_casas1   = normalize(num_casas1 / zizi_max_casas);
  local percent_bosques1 = normalize(num_bosques1 / zizi_max_bosques);
  local percent_alturas1 = smooth_normalize(num_alturas1 / zizi_max_alturas);
  local percent_casas2   = normalize(num_casas2 / zizi_max_casas);
  local percent_bosques2 = normalize(num_bosques2 / zizi_max_bosques);
  local percent_alturas2 = smooth_normalize(num_alturas2 / zizi_max_alturas);
  
  -- A mayor distancia, mejor puntuacion
  local percent_border1  = smooth_normalize(dist_border1 / zizi_max_border);
  local percent_border2  = smooth_normalize(dist_border2 / zizi_max_border);

  local combo1 = 0;
  if ((num_casas1 > 0) or (num_bosques1 > 0)) and (num_alturas1 > 0) then 
    combo1 = normalize(percent_alturas1 + percent_casas1 + percent_bosques1); 
  end
  local combo2 = 0;
  if ((num_casas2 > 0) or (num_bosques2 > 0)) and (num_alturas2 > 0) then
    combo2 = normalize(percent_alturas2 + percent_casas2 + percent_bosques2);
  end
  
  local terreno1 = zizi_factor_casas *  percent_casas1
                   + zizi_factor_bosques * percent_bosques1 
                   + zizi_factor_alturas * percent_alturas1
                   + zizi_factor_combo * combo1
                   + zizi_factor_percent_apostadas * percent_apostadas1;
  local terreno2 = zizi_factor_casas * percent_casas2
                   + zizi_factor_bosques * percent_bosques2
                   + zizi_factor_alturas * percent_alturas2
                   + zizi_factor_combo * combo2
                   + zizi_factor_percent_apostadas * percent_apostadas2;
  
  local rand1 = interest_GetRandom(interest1);
  local rand2 = interest_GetRandom(interest2);
  
  local peso1 = (activo1 * zizi_factor_activo) + (dist1 * zizi_factor_dist) + (terreno1 * zizi_factor_terreno) + (percent_border1 * zizi_factor_map_border) + (rand1 * zizi_factor_rand);
  local peso2 = (activo2 * zizi_factor_activo) + (dist2 * zizi_factor_dist) + (terreno2 * zizi_factor_terreno) + (percent_border2 * zizi_factor_map_border) + (rand2 * zizi_factor_rand);

  if peso1 > peso2 then
    log_SE(""..get_interest_text(interest1).." > "..get_interest_text(interest2));
    log_SE(string.format(" - (Peso: %.2f=[Act:%d, Dst:%.2f, Bor:%.2f, Trr:%.2f(C:%d(%.2f),B:%d(%.2f),A:%d(%.2f),p:%.2f), Rnd:%.2f] - %.2f=[Act:%d, Dst:%.2f, Bor:%.2f, Trr:%.2f(C:%d(%.2f),B:%d(%.2f),A:%d(%.2f),p:%.2f), Rnd:%.2f])",         
        peso1, activo1, dist1, percent_border1, terreno1, num_casas1, percent_casas1, num_bosques1, percent_bosques1, num_alturas1, percent_alturas1, percent_apostadas1, rand1,
        peso2, activo2, dist2, percent_border2, terreno2, num_casas2, percent_casas2, num_bosques2, percent_bosques2, num_alturas2, percent_alturas2, percent_apostadas2, rand2));
    return 1;
  else
    log_SE(""..get_interest_text(interest2).." > "..get_interest_text(interest1));
    log_SE(string.format(" - (Peso: %.2f=[Act:%d, Dst:%.2f, Bor:%.2f, Trr:%.2f(C:%d(%.2f),B:%d(%.2f),A:%d(%.2f),p:%.2f), Rnd:%.2f] - %.2f=[Act:%d, Dst:%.2f, Bor: %.2f, Trr:%.2f(C:%d(%.2f),B:%d(%.2f),A:%d(%.2f),p:%.2f), Rnd:%.2f])",         
        peso2, activo2, dist2, percent_border2, terreno2, num_casas2, percent_casas2, num_bosques2, percent_bosques2, num_alturas2, percent_alturas2, percent_apostadas2, rand2,
        peso1, activo1, dist1, percent_border1, terreno1, num_casas1, percent_casas1, num_bosques1, percent_bosques1, num_alturas1, percent_alturas1, percent_apostadas1, rand1));
    return 2;
  end
  
end

-----------------------------------------------
--
-----------------------------------------------
function esmejor_EE_EE(interest1, interest2)
  
  -- TODO:
  -- Calibrar fightpower de los dos intereses

  set_EE_EE_params();
  
  if not interest_FitsForTroops(interest1) then
    return 2;
  end
  if not interest_FitsForTroops(interest2) then
    return 1;
  end
  
  -- Factor: el objetivo ya esta creado
  local activo1 = 0;
  if interest_HasObjective(interest1) then activo1 = 1; end
  local activo2 = 0;
  if interest_HasObjective(interest2) then activo2 = 1; end
  
  local umbral_dist = 5000; -- Factor que se aplica para que, en distancias cortas muy proximas, los valores no se distorsionen

  -- Factor: distancia
  local dist1 = 1 - smooth_normalize((interest_MyDist(interest1) - umbral_dist) / interest_DistEnemy(interest1));
  local dist2 = 1 - smooth_normalize((interest_MyDist(interest2) - umbral_dist) / interest_DistEnemy(interest2));

  -- Factor: distancia a objetivos mapa (si no hay OM, distancia es 0)
  local distom1 = 1 - smooth_normalize(interest_DistOM(interest1) / eeee_distom_muylejos);
  local distom2 = 1 - smooth_normalize(interest_DistOM(interest2) / eeee_distom_muylejos);
  
  local peso1 = (activo1 * eeee_factor_activo) + (dist1 * eeee_factor_dist) + (distom1 * eeee_factor_objetivosmapa);
  local peso2 = (activo2 * eeee_factor_activo) + (dist2 * eeee_factor_dist) + (distom2 * eeee_factor_objetivosmapa);

  if peso1 > peso2 then
    log_SE(" "..get_interest_text(interest1) .. " > " .. get_interest_text(interest2));
    log_SE(string.format(" - (Peso: %.2f=[Act:%d, Dst:%.2f] - %.2f=[Act:%d, Dst:%.2f]", peso1, activo1, dist1, peso2, activo2, dist2));
    return 1;
  else
    log_SE(" "..get_interest_text(interest2) .. " > " .. get_interest_text(interest1));
    log_SE(string.format(" - (Peso: %.2f=[Act:%d, Dst:%.2f] - %.2f=[Act:%d, Dst:%.2f]", peso2, activo2, dist2, peso1, activo1, dist1));
    return 2;
  end
  
end

-----------------------------------------------
--
-----------------------------------------------
function esmejor_PU_PU(interest1, interest2)

  log_SE("####!!!! SE ESTA LLAMANDO A PU vs PU, QUE NO TIENE SENTIDO");
  return 1;
----  
----  mydist1 = interest_MyDist(interest1);
----  mydist2 = interest_MyDist(interest2);
----  margen = 5000;
----  
----  if mydist1 + margen < mydist2 then
----    log(""..get_interest_text(interest1).." > "..get_interest_text(interest2).." (El puente 1 esta mas cerca)");
----    return 1;
----  end
----  
----  if mydist2 + margen < mydist1 then
----    log(""..get_interest_text(interest2).." > "..get_interest_text(interest1).." (El puente 2 esta mas cerca)");
----    return 1;
----  end
----  
----  -- Si el enemigo esta ya en un puente y en otro no, voy al vacio
----  enemy_en_zona1 = interest_IsEnemyThere(interest1);
----  enemy_en_zona2 = interest_IsEnemyThere(interest2);
----  
----  if enemy_en_zona1 and not enemy_en_zona2 then
----    log("*SE:"..get_interest_text(interest2) .. " > " .. get_interest_text(interest1) .. " (Enemigo en el 1º)");
----    return 2;
----  end
----  
----  if enemy_en_zona2 and not enemy_en_zona1 then
----    log("*SE:"..get_interest_text(interest1) .. " > " .. get_interest_text(interest2) .. " (Enemigo en el 2º)");
----    return 1;
----  end
----  
----  -- Factor: el objetivo ya esta creado
----  activo1 = 0;
----  if interest_HasObjective(interest1) then activo1 = 1; end
----  activo2 = 0;
----  if interest_HasObjective(interest2) then activo2 = 1; end
----  
----  -- Factor: distancia
----  dist1 = 1 - normalize(mydist1 / interest_DistEnemy(interest1));
----  dist2 = 1 - normalize(mydist2 / interest_DistEnemy(interest2));
----
----  factor_activo = 0.5;
----  factor_dist   = 1;
----  
----  peso1 = (activo1 * factor_activo) + (dist1 * factor_dist);
----  peso2 = (activo2 * factor_activo) + (dist2 * factor_dist);
----
----  if peso1 > peso2 then
----    log("*SE:"..get_interest_text(interest1) .. " > " .. get_interest_text(interest2) .. " (Peso: "..peso1.."["..activo1..","..dist1.."] "..peso2.."["..activo2..","..dist2.."]");
----    return 1;
----  else
----    log("*SE:"..get_interest_text(interest2) .. " > " .. get_interest_text(interest1) .. " (Peso: "..peso2.."["..activo2..","..dist2.."] "..peso1.."["..activo1..","..dist1.."]");
----    return 2;
----  end
  
end

-----------------------------------------------
--
-----------------------------------------------
function esmejor_OM_ZI(interest1, interest2)

  local tengo_objetivo1 = accomplished_Objective(interest1);
  if tengo_objetivo1 then
    log_SE(""..get_interest_text(interest1) .. " > " .. get_interest_text(interest2) .. " (Prefiero OM a ZI porque ya tengo el objetivo)");
    return 1;
  end
  
  -- Si soy defensor, de momento siempre prefiero objetivos de mapa
  if not iam_attacker() then
    log_SE(""..get_interest_text(interest1) .. " > " .. get_interest_text(interest2) .. " (Prefiero OM a ZI cuando estoy defendiendo)");
    return 1;
  end
  
  -- Si soy atacante, los trato como si fueran zonas sin mas
  return esmejor_ZI_ZI(interest1, interest2);

end

-----------------------------------------------
--
-----------------------------------------------
function esmejor_OM_EE(interest1, interest2)

  local tengo_objetivo1 = accomplished_Objective(interest1);
  if tengo_objetivo1 then
    log_SE(""..get_interest_text(interest1) .. " > " .. get_interest_text(interest2) .. " (Prefiero OM a PU porque ya tengo el objetivo)");
    return 1;
  end

  -- Lo trato como una zona
  return esmejor_ZI_EE(interest1, interest2);

end

-----------------------------------------------
--
-----------------------------------------------
function esmejor_ZI_EE(interest1, interest2)

  -- si le queremos dar las tropas extra le damos mayor prioridad al ee
  if interest_FitsForExtraTroops(interest2) then
    log_SE(""..get_interest_text(interest2).." > "..get_interest_text(interest1).." (El EE sólo coge las tropas extra)");
    return 2;
  end

  local zi_activo = 0;
  if interest_HasObjective(interest1) then 
    zi_activo = 1; 
  end
  local ee_activo = 0;
  if interest_HasObjective(interest2) then 
    ee_activo = 1; 
  end

  if ee_activo and not zi_activo then
    log_SE(""..get_interest_text(interest2).." > "..get_interest_text(interest1).." (Ya estoy atacando al enemigo)");
    -- OJO AQUI!!!!!! Este return 2 no estaba puesto, y es posible que hiciera falta...
    return 2;
  end

  -- Si el enemigo ya esta en la zona, atacamos
  local enemy_en_zona = interest_IsEnemyThere(interest1);
  if enemy_en_zona then
    log_SE(""..get_interest_text(interest2) .. " > " .. get_interest_text(interest1) .. " (Enemigo esta en la zona)");
    return 2;
  end

  local my_dist_zona    = interest_MyDist(interest1);
  local dist_enemy_zona = interest_DistEnemy(interest1);

  -- Si estoy mas lejos que el enemigo a la zona, prefiero atacarle, porque no llegare a tiempo
  local margen = 5000;
  if my_dist_zona + margen > dist_enemy_zona then
    log_SE(""..get_interest_text(interest2) .. " > " .. get_interest_text(interest1) .. " (Enemigo esta mas cerca de la zona)");
    return 2;
  end
  
  -- estoy mas cerca de la zona, pero soy el atacante, prefiero atacar
  if iam_attacker() then
    log_SE(""..get_interest_text(interest2) .. " > " .. get_interest_text(interest1) .. " (Prefiero EE a ZI porque soy atacante)");
    return 2;
  else
    log_SE(""..get_interest_text(interest1) .. " > " .. get_interest_text(interest2) .. " (Prefiero ZI a EE porque soy defensor)");
    return 1;
  end

end

-----------------------------------------------
--
-----------------------------------------------
function esmejor_OM_PU(interest1, interest2)

  local tengo_objetivo1 = accomplished_Objective(interest1);
  if tengo_objetivo1 then
--    log_SE("*SE:"..get_interest_text(interest1) .. " > " .. get_interest_text(interest2) .. " (Prefiero OM a PU porque ya tengo el objetivo)");
--    return 1;
    log_SE("Aunque tengo ya el interes "..get_interest_text(interest1).." sigo comparacion con "..get_interest_text(interest2));
  end
  
  return esmejor_ZI_PU(interest1, interest2);
  
----  pos1_x, pos1_y = interest_GetPos(interest1);
----  pos2_x, pos2_y = interest_GetPos(interest2);
----  
----  enemigos_cerca_puente, enemigos_cerca_objetivo = bridgeInTheMiddle(pos2_x, pos2_y, pos1_x, pos1_y);
----  
----  if enemigos_cerca_objetivo == 0 then
----    log(get_interest_text(interest2) .. " > " .. get_interest_text(interest1) .. " (Prefiero el puente porque esta en medio)");
----    return 2;
----  end
----
----  -- TODO:
----  -- de momento siempre prefiero objetivos de mapa
----  log("*SE:"..get_interest_text(interest1) .. " > " .. get_interest_text(interest2) .. " (El puente no sirve para nada)");
----  return 1;

end

-----------------------------------------------
--
-----------------------------------------------
function esmejor_ZI_PU(interest1, interest2)

  -- Verifico si los enemigos tienen que cruzar el puente para llegar a la zona
  local pos1_x, pos1_y = interest_GetPos(interest1);
  local pos2_x, pos2_y = interest_GetPos(interest2);
  
  local enemigos_cerca_puente, enemigos_cerca_zona, enemigos_cruzan = bridgeInTheMiddle(pos2_x, pos2_y, pos1_x, pos1_y);
  
  if enemigos_cruzan <= 0 then
    log_SE("Nadie va a pasar por el puente: "..get_interest_text(interest1)..", razon por la que preferimos la ZI");
    return 1;
  end 
  
  if enemigos_cerca_zona > 0 then
    log_SE(""..get_interest_text(interest1) .. " > " .. get_interest_text(interest2) .. " (Prefiero la zona porque el puente esta en parla)");
    return 1;
  end

  -- Si el enemigo esta en uno solo de los dos, elijo el otro
  local enemy_en_zona   = interest_IsEnemyThere(interest1);
  local enemy_en_puente = interest_IsEnemyThere(interest2);
  
  if enemy_en_zona and not enemy_en_puente then
    log_SE(""..get_interest_text(interest2) .. " > " .. get_interest_text(interest1) .. " (Enemigo en la zona)");
    return 2;
  end
    
  if enemy_en_puente and not enemy_en_zona then
    log_SE(""..get_interest_text(interest1) .. " > " .. get_interest_text(interest2) .. " (Enemigo en el puente)");
    return 1;
  end

  local my_dist_puente    = interest_MyDist(interest2);
  local dist_enemy_puente = interest_DistEnemy(interest2);
  local margen_puente     = 5000;
  local maslejos_puente   = ((my_dist_puente + margen_puente) > dist_enemy_puente);
  
  local my_dist_zona    = interest_MyDist(interest1);
  local dist_enemy_zona = interest_DistEnemy(interest1);
  local margen_zona     = 5000;
  local maslejos_zona   = ((my_dist_zona + margen_zona) > dist_enemy_zona);

  if maslejos_puente then
    if not maslejos_zona then
      log_SE(""..get_interest_text(interest1) .. " > " .. get_interest_text(interest2) .. " (El enemigo esta mas cerca del puente)");
      return 1;
    else
      log_SE(""..get_interest_text(interest1) .. " > " .. get_interest_text(interest2) .. " (El enemigo esta mas cerca de ambos, elijo zona)");
      return 1; -- Aunque para la zona el enemigo tambien este mas cerca, lo prefiero al puente
    end
  end

  -- Si estoy mas lejos de la zona, pero no del puente, voy al puente  
  if maslejos_zona then
    log_SE(""..get_interest_text(interest2) .. " > " .. get_interest_text(interest1) .. " (El enemigo esta mas cerca de la zona)");
    return 2;
  end
  
  -- Si estoy mas cerca de los dos, elijo el puente    
  log_SE(""..get_interest_text(interest2) .. " > " .. get_interest_text(interest1) .. " (Prefiero puente)");
  return 2;

end

-----------------------------------------------
--
-----------------------------------------------
function esmejor_EE_PU(interest1, interest2)

  local pos1_x, pos1_y = interest_GetPos(interest1);
  local pos2_x, pos2_y = interest_GetPos(interest2);
  
  local enemigos_cerca_puente, enemigos_lejos_puente = bridgeInTheMiddle(pos2_x, pos2_y, pos1_x, pos1_y);
  --log_SE("Enemigos cerca puente " .. enemigos_cerca_puente .. " enemigos lejos " .. enemigos_lejos_puente);
  
  if enemigos_lejos_puente == 0 then
    log_SE(""..get_interest_text(interest1) .. " > " .. get_interest_text(interest2) .. " (Prefiero el puente, porque el enemigo tiene que pasar por el)");
    return 2;
  end

  -- TODO:
  -- Si estoy atacando, elijo ejercito, si defiendo, elijo puente
  if iam_attacker() then
    log_SE(""..get_interest_text(interest1) .. " > " .. get_interest_text(interest2) .. " (Prefiero EE a PU porque soy atacante)");
    return 1;
  else
    log_SE(""..get_interest_text(interest2) .. " > " .. get_interest_text(interest1) .. " (Prefiero PU a EE porque soy defensor)");
    return 2;
  end
  
end

---------------------------------------------------
--
---------------------------------------------------
function compara_ZI(interest1, interest2)

  -- Factor: el objetivo ya esta creado
  local activo1 = 0;
  if interest_HasObjective(interest1) then 
    activo1 = 1; 
  end
  local activo2 = 0;
  if interest_HasObjective(interest2) then 
    activo2 = 1; 
  end
  
  -- PARAMETROS CONFIGURABLES!!!
  set_ZI_ZI_params();

  local umbral_dist = 25000;

  local dist1 = 0;
  local dist2 = 0;
  

  local num_casas1, num_bosques1, num_alturas1 = interest_GetTerrain(interest1);
  local num_casas2, num_bosques2, num_alturas2 = interest_GetTerrain(interest2);


  local percent_apostadas1 = 0;
  local percent_apostadas2 = 0;
  if num_casas1 + num_bosques1 > 0 then
    local res1 = res_GetResources();
    local n_res_apostables1 = dar_num_apostables(res1);
    if n_res_apostables1 > 0 then
      percent_apostadas1 = smooth_normalize((num_casas1 + num_bosques1) / n_res_apostables1);
    end
  end
  if num_casas2 + num_bosques2 > 0 then
    local res2 = res_GetResources();
    local n_res_apostables2 = dar_num_apostables(res2);
    if n_res_apostables2 > 0 then
      percent_apostadas2 = smooth_normalize((num_casas2 + num_bosques2) / n_res_apostables2);
    end
  end

  local dist_border1 = interest_DistMapBorder(interest1);
  local dist_border2 = interest_DistMapBorder(interest2);
  
  local percent_casas1   = normalize(num_casas1 / zizi_max_casas);
  local percent_bosques1 = normalize(num_bosques1 / zizi_max_bosques);
  local percent_alturas1 = smooth_normalize(num_alturas1 / zizi_max_alturas);
  local percent_casas2   = normalize(num_casas2 / zizi_max_casas);
  local percent_bosques2 = normalize(num_bosques2 / zizi_max_bosques);
  local percent_alturas2 = smooth_normalize(num_alturas2 / zizi_max_alturas);
  
  -- A mayor distancia, mejor puntuacion
  local percent_border1  = smooth_normalize(dist_border1 / zizi_max_border);
  local percent_border2  = smooth_normalize(dist_border2 / zizi_max_border);

  local combo1 = 0;
  if ((num_casas1 > 0) or (num_bosques1 > 0)) and (num_alturas1 > 0) then 
    combo1 = normalize(percent_alturas1 + percent_casas1 + percent_bosques1); 
  end
  local combo2 = 0;
  if ((num_casas2 > 0) or (num_bosques2 > 0)) and (num_alturas2 > 0) then
    combo2 = normalize(percent_alturas2 + percent_casas2 + percent_bosques2);
  end
  
  local terreno1 = zizi_factor_casas *  percent_casas1
                   + zizi_factor_bosques * percent_bosques1 
                   + zizi_factor_alturas * percent_alturas1
                   + zizi_factor_combo * combo1
                   + zizi_factor_percent_apostadas * percent_apostadas1;
  local terreno2 = zizi_factor_casas * percent_casas2
                   + zizi_factor_bosques * percent_bosques2
                   + zizi_factor_alturas * percent_alturas2
                   + zizi_factor_combo * combo2
                   + zizi_factor_percent_apostadas * percent_apostadas2;
  
  local rand1 = interest_GetRandom(interest1);
  local rand2 = interest_GetRandom(interest2);
  
  local peso1 = (activo1 * zizi_factor_activo) + (dist1 * zizi_factor_dist) + (terreno1 * zizi_factor_terreno) + (percent_border1 * zizi_factor_map_border) + (rand1 * zizi_factor_rand);
  local peso2 = (activo2 * zizi_factor_activo) + (dist2 * zizi_factor_dist) + (terreno2 * zizi_factor_terreno) + (percent_border2 * zizi_factor_map_border) + (rand2 * zizi_factor_rand);

  if peso1 > peso2 then
    log_SE(""..get_interest_text(interest1).." > "..get_interest_text(interest2));
    log_SE(string.format(" - (Peso: %.2f=[Act:%d, Dst:%.2f, Bor:%.2f, Trr:%.2f(C:%d(%.2f),B:%d(%.2f),A:%d(%.2f),p:%.2f), Rnd:%.2f] - %.2f=[Act:%d, Dst:%.2f, Bor:%.2f, Trr:%.2f(C:%d(%.2f),B:%d(%.2f),A:%d(%.2f),p:%.2f), Rnd:%.2f])",         
        peso1, activo1, dist1, percent_border1, terreno1, num_casas1, percent_casas1, num_bosques1, percent_bosques1, num_alturas1, percent_alturas1, percent_apostadas1, rand1,
        peso2, activo2, dist2, percent_border2, terreno2, num_casas2, percent_casas2, num_bosques2, percent_bosques2, num_alturas2, percent_alturas2, percent_apostadas2, rand2));
    return 1;
  else
    log_SE(""..get_interest_text(interest2).." > "..get_interest_text(interest1));
    log_SE(string.format(" - (Peso: %.2f=[Act:%d, Dst:%.2f, Bor:%.2f, Trr:%.2f(C:%d(%.2f),B:%d(%.2f),A:%d(%.2f),p:%.2f), Rnd:%.2f] - %.2f=[Act:%d, Dst:%.2f, Bor: %.2f, Trr:%.2f(C:%d(%.2f),B:%d(%.2f),A:%d(%.2f),p:%.2f), Rnd:%.2f])",         
        peso2, activo2, dist2, percent_border2, terreno2, num_casas2, percent_casas2, num_bosques2, percent_bosques2, num_alturas2, percent_alturas2, percent_apostadas2, rand2,
        peso1, activo1, dist1, percent_border1, terreno1, num_casas1, percent_casas1, num_bosques1, percent_bosques1, num_alturas1, percent_alturas1, percent_apostadas1, rand1));
    return 2;
  end
  
end

---------------------------------------------------
--
---------------------------------------------------
function filter_interests(interests)

  local nInterests = table.getn(interests);
  local retInterests = {};
  
  log_SE("--------------------------------------------------------------------------");
  log_SE("Filtrando Intereses para dejar únicamente 2 Zonas Interesantes y todos los Ejércitos Enemigos");
  
  local bestZI = nil;
  local nextZI = nil;
  
  for i=1,nInterests do
    local interest = interests[i];

    if interest_GetType(interest) == TI_EJERCITO_ENEMIGO or interest_GetType(interest) == TI_OBJETIVO_MAPA or interest_GetType(interest) == TI_SAN_PETERSBURGO then
      table.insert(retInterests, interest);
    elseif interest_GetType(interest) == TI_ZONA_INTERESANTE then
      if bestZI==nil then
        bestZI = interest;
      elseif nextZI==nil then
        if(compara_ZI(bestZI,interest)==2)then
          nextZI = bestZI;
          bestZI = interest;
        else
          nextZI = interest;
        end
      else
        if(compara_ZI(bestZI,interest)==2)then
          nextZI = bestZI;
          bestZI = interest;
        elseif(compara_ZI(nextZI,interest)==2)then
          nextZI = interest;
        end
      end
    end
  end

  -- ahora hay que meter bestZI y nextZI en los intereses a devolver (si tienen algo)
  if bestZI ~= nil then
    table.insert(retInterests, bestZI);
    if nextZI ~= nil then
      table.insert(retInterests, nextZI);
    end
  end
  
  log_SE("--------------------------------------------------------------------------");

  return retInterests;

end