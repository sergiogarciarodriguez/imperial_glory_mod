--------------------------------------------------------------------------------
-- Funcion que loggea con una string diferente si es atacante o defensor
--------------------------------------------------------------------------------
function log_RES(text)

  log("*EVALRES_"..get_attacker_text()..":"..text);
  
end

--------------------------------------------------------------------------------
-- Funcion llamada para cada interes
-- Permite al interes quedarse con las tropas que considere necesarias
-- Devuelve un bool indicando si el interes ha encontrado suficientes tropas
-- Efecto lateral: Almacena en interest los recursos que desea
--------------------------------------------------------------------------------
function evaluate_necessary_resources(interest, free_res, extra_res, busy_res, interests)

  interest_type = interest_GetType(interest);
  
  suficientes = false;
  log_RES("...Evaluando "..get_interest_text(interest));
  
  if interest_type == TI_OBJETIVO_MAPA then
    suficientes = evaluate_resources_OM(interest, free_res, extra_res, busy_res);
  elseif interest_type == TI_EJERCITO_ENEMIGO then
    suficientes = evaluate_resources_EE(interest, free_res, extra_res, busy_res);
  elseif interest_type == TI_ZONA_INTERESANTE then
    if get_GameDifficulty()==0 then
      suficientes = evaluate_resources_for_several_ZI(interest, free_res, extra_res, busy_res, interests);
    else
      suficientes = evaluate_resources_ZI(interest, free_res, extra_res, busy_res);
    end
  elseif interest_type == TI_PUENTE then
    suficientes = evaluate_resources_PU(interest, free_res, extra_res, busy_res);
  elseif interest_type == TI_SAN_PETERSBURGO then
    suficientes = evaluate_resources_SP(interest, free_res, extra_res, busy_res);
  end

  return suficientes;

end

-----------------------------------------------
--
-----------------------------------------------
function comp_dist_tropa(dt1, dt2)
  return dt1.dist < dt2.dist;
end

-----------------------------------------------
--
-----------------------------------------------
function clasificar_tropas(tropas, tipo_tropas, interest)

  local n = table.getn(tropas);

  -- Ordenamos por distancia
  local distancias = {};
  for i=1,n do
    table.insert(distancias, { dist = interest_DistResource(interest, tropas[i]), tropa = tropas[i] } );
  end

  table.sort(distancias, comp_dist_tropa);
  
  for i=1,n do
    local tropa = distancias[i].tropa;
    if     res_IsShootingInfantry(tropa) then
      table.insert(tipo_tropas.Infanteria, tropa);
    elseif res_IsCavalry(tropa) then
      table.insert(tipo_tropas.Caballeria, tropa);
    elseif res_IsMilitia(tropa) then
      table.insert(tipo_tropas.Milicia, tropa);
    elseif res_IsArtillery(tropa) then
      table.insert(tipo_tropas.Artilleria, tropa);
    else
      log_RES(("**** TIPO DE TROPA DESCONOCIDO *****"));
      table.insert(tipo_tropas.Infanteria, tropa);
    end    
  end
end

-----------------------------------------------
--
-----------------------------------------------
function sacar_tropas_ya_tengo(interest, tropas, yatengo)
  local i=1;
  while tropas[i] do
    if interest_ObjHasRes(interest, tropas[i]) then
      table.insert(yatengo, tropas[i]);
      table.remove(tropas, i);
    else
      i = i+1;
    end
  end
end

-----------------------------------------------
--
-----------------------------------------------
function sacar_recurso(tropas, recurso)
  local i=1;
  while tropas[i] do
    if tropas[i] == recurso then
      table.remove(tropas, i);
    else
      i = i+1;
    end
  end
end

-----------------------------------------------
--
-----------------------------------------------
function acquire_troops_object_have(interest, free_res, extra_res, busy_res, tropas, tipo_tropas, num_tipo_tropas)

  local yatengo_res = {};

  sacar_tropas_ya_tengo(interest, free_res,  yatengo_res);
  sacar_tropas_ya_tengo(interest, extra_res, yatengo_res);  
  sacar_tropas_ya_tengo(interest, busy_res,  yatengo_res);  

  -- Reviso la lista de las tropas que ya tengo
  -- Debo preguntar si tengo que seleccionar la tropa por fuerza
  local i=1;
  while yatengo_res[i] do
    
    local tropa = yatengo_res[i];
    if not res_IsObjFree(tropa) then
      -- Me veo obligado a cogerla
      log_RES("  Cojo por fuerza "..res_GetInfo(tropa));
      if res_IsShootingInfantry(tropa) then
        num_tipo_tropas.Infanteria = num_tipo_tropas.Infanteria + 1;
      elseif res_IsCavalry(tropa) then
        num_tipo_tropas.Caballeria = num_tipo_tropas.Caballeria + 1;
      elseif res_IsMilitia(tropa) then
        num_tipo_tropas.Milicia = num_tipo_tropas.Milicia + 1;
      elseif res_IsArtillery(tropa) then
        num_tipo_tropas.Artilleria = num_tipo_tropas.Artilleria + 1;
      else
        log_RES(("**** TIPO DE TROPA DESCONOCIDO *****"));
        num_tipo_tropas.Infanteria = num_tipo_tropas.Infanteria + 1;
      end    
      
      table.insert(tropas, tropa);
      table.remove(yatengo_res, i);
    else
      i = i+1;
    end
  end

  clasificar_tropas(yatengo_res, tipo_tropas, interest);

end

-----------------------------------------------
--
-----------------------------------------------
function coger_porcentaje_tropas_tipo(percent, tipo_tropas, num_tipo_tropas, tropas, yatengo_res)

  local nTropas = table.getn(tipo_tropas) + num_tipo_tropas;
  local puedo_coger = round(nTropas * percent);
  puedo_coger = puedo_coger - num_tipo_tropas;
  if puedo_coger < 0 then
    puedo_coger = 0;
  end
  --log_RES("Cojo "..puedo_coger.." infanterias");
  for i=1,puedo_coger do
    local res = tipo_tropas[i];
    table.insert(tropas, res);
    sacar_recurso(yatengo_res, res);
    log_RES("  Cojo infanteria "..res_GetInfo(res));
  end

end

-----------------------------------------------
--
-----------------------------------------------
function evaluate_resources_OM(interest, free_res, extra_res, busy_res)

  -- Dependiendo del numero de objetivos de mapa a conquistar, elijo
  -- ese porcentaje de las tropas
  
  if is_total_victory() then
    log_RES("ERROR, un Total Victory no puede tener Objetivos de Mapa!!!!");
  end
  
  -- Obtengo los objetivos de mapa que deben ir con el mio, para dividir las tropas
  local map_objs = get_map_objectives(interest);
  table.insert(map_objs, interest);
  
  -- Elimino los ratificados
  -- Si he ratificado alguno en una pasada anterior, ya tiene sus tropas, con lo cual no cuenta
  -- en esta pasada
  for i=1,table.getn(map_objs) do
    if interest_Ratified(map_objs[i]) then
      table.remove(map_objs, i);
    end
  end
  
  local nobjs = table.getn(map_objs);
  
  if nobjs <= 1 then
    log_RES("  COGE TODO " .. get_interest_text(interest));
    interest_TakeResources(interest, free_res);
    interest_TakeResources(interest, extra_res);
    interest_TakeResources(interest, busy_res);    
    return true;
  end

  -- Hay mas de un objetivo de mapa, deberia repartir las tropas

  -- TODO: Caso especial, el enemigo tiene el objetivo, pero no hay tropas suyas
  -- debo mandar algo rapido

  log_RES("Hay "..nobjs.." objetivos mapa");
  --local nCasas, nBosques, nAlturas = interest_GetTerrain(interest);

  local tropas = {}; -- Las tropas que quiero
  
  local tipo_tropas = { 
      Artilleria = {}, 
      Infanteria = {}, -- no milicia
      Milicia = {},
      Caballeria = {}
  };
  
  local num_tipo_tropas = { Artilleria = 0, Infanteria = 0, Milicia = 0, Caballeria = 0 };
  
  -- CLASIFICO LAS TROPAS
  -- por tipo
  -- dentro de cada tipo, por orden de "estorbo menos al cogerla"

  -- Las primeras que quiero son las que ya tengo
  local yatengo_res = {};
  if interest_HasObjective(interest) then
    acquire_troops_object_have(interest, free_res, extra_res, busy_res, tropas, tipo_tropas, num_tipo_tropas);
  end
    
  clasificar_tropas(free_res,  tipo_tropas, interest);
  clasificar_tropas(extra_res, tipo_tropas, interest);
  clasificar_tropas(busy_res,  tipo_tropas, interest);

  -- 1.- Estimar cuantas tropas necesito
  -- 2.- Seleccionar de entre las tropas
  --     * las que ya tengo
  --     * por distancia
  --     * por "liberada"
  
  local myfp = 0;
  local totalfp = 0;
  --local fpref = fp_get_reference_global();
  for i=1,nobjs do
    -- Calculo fightpower
    -- Uso el valor de referencia para evitar valores negativos
    local posx, posy = interest_GetPos(map_objs[i]);
    local fp = -get_influence(posx, posy, false, {});
    --fp = fp + fpref;
    if fp < 0 then
      fp = 0;
    end
    
    if map_objs[i] == interest then
      myfp = fp;
    end
    totalfp = totalfp + fp;
  end

  -- Mayor valor de influencia implica mayor presencia enemiga
  log_RES("  -> FP: "..myfp.." TOTAL: "..totalfp);



  -- Me quedo con el porcentaje de tropas correspondiente a la proporcion
  if myfp == 0 then

    if (num_tipo_tropas.Infanteria == 0) and (num_tipo_tropas.Caballeria == 0) and (num_tipo_tropas.Milicia == 0) then
      -- No hay enemigos. Cojo una infanteria, si hay, sino una caballeria, sino una milicia
      local tropa_cojo = tipo_tropas.Infanteria[1];
      if not tropa_cojo then
        tropa_cojo = tipo_tropas.Caballeria[1];
      end
      if not tropa_cojo then
        tropa_cojo = tipo_tropas.Milicia[1];
      end
      if not tropa_cojo then
        tropa_cojo = tipo_tropas.Artilleria[1];
      end
      
      if tropa_cojo then
        table.insert(tropas, tropa_cojo);
      else
        return false;
      end
    end

  else

    -- TODO: Contemplar el caso de que me quede todas las tropas
    -- por problemas de redondeo  

    -- Me quedo con un porcentaje
    local percent = myfp / totalfp;
    
    -- Infanteria
    coger_porcentaje_tropas_tipo(percent, tipo_tropas.Infanteria, num_tipo_tropas.Infanteria, tropas, yatengo_res)
  
    -- Caballeria
    coger_porcentaje_tropas_tipo(percent, tipo_tropas.Caballeria, num_tipo_tropas.Caballeria, tropas, yatengo_res)

    -- Milicia
    coger_porcentaje_tropas_tipo(percent, tipo_tropas.Milicia, num_tipo_tropas.Milicia, tropas, yatengo_res)

      -- ARTILLERIAS (van separadas)
    local nArtillerias = table.getn(tipo_tropas.Artilleria) + num_tipo_tropas.Artilleria;
    if nArtillerias > 0 then
      -- Tengo artilleria
      -- Cojo el porcentaje que me corresponda
      local puedo_coger = round(nArtillerias / nobjs);
      if puedo_coger <= 0 then
        puedo_coger = 1;
      end
      puedo_coger = puedo_coger - num_tipo_tropas.Artilleria;
      if puedo_coger < 0 then
        puedo_coger = 0;
      end
      --log_RES("Cojo "..puedo_coger.." artillerias");
      
      if puedo_coger > 0 then
        -- Las artillerias siempre las cojo por distancia, dada su poca movilidad
        nArtillerias = nArtillerias - num_tipo_tropas.Artilleria;
        local distancias = {};
        nArtillerias = nArtillerias - num_tipo_tropas.Artilleria;
        for i=1,nArtillerias do
          table.insert(distancias, { dist = interest_DistResource(interest, tipo_tropas.Artilleria[i]), tropa = tipo_tropas.Artilleria[i] } );
        end
    
        table.sort(distancias, comp_dist_tropa);
    
        for i=1,puedo_coger do
          local res = distancias[i].tropa;
          table.insert(tropas, res);
          sacar_recurso(yatengo_res, res);
          log_RES("  Cojo artilleria "..res_GetInfo(res));
        end
      end
    end

  end  
  
  log_RES("  TOTAL: Cojo "..table.getn(tropas).." tropas en total");
  interest_TakeResources(interest, tropas);
  return true;
  
end

-----------------------------------------------
--
-----------------------------------------------
function evaluate_resources_EE(interest, free_res, extra_res, busy_res)

  -- local ngroups = num_enemy_groups();

  if fits_for_extra_troops(interest) then
    log_RES("  COGE SOLO EXTRA ".. get_interest_text(interest));
    interest_TakeResources(interest, extra_res);
  else
    -- Cojo todo el ejercito junto, no quiero dividirlo  
    log_RES("  COGE TODO " .. get_interest_text(interest));
    interest_TakeResources(interest, free_res);
    interest_TakeResources(interest, extra_res);
    interest_TakeResources(interest, busy_res);    
  end
  
  return true;  

  -- NO: al final prefiero ir con todo el ejercito junto
  -- Hay mas de un grupo enemigo
  -- Ver como de separados estan
  -- Evaluar la fuerza del grupo
  -- etc

end

-----------------------------------------------
--
-----------------------------------------------
function evaluate_resources_ZI(interest, free_res, extra_res, busy_res)

  -- Si es Total Victory y soy defensor, me atrinchero todos en un punto
  if is_total_victory() and not iam_attacker() then
    log_RES("  COGE TODO " .. get_interest_text(interest));
    interest_TakeResources(interest, free_res);
    interest_TakeResources(interest, extra_res);
    interest_TakeResources(interest, busy_res);    
    return true;  
  end

  -- Si hay objetivos de mapa, ire a por ellos, la zona en principio no me interesa
  -- TODO: podriamos ver de ocupar el objetivo de mapa con unas pocas tropas solo si la zona
  -- cubre el acceso al OM
  if not is_total_victory() then
    log_RES("no quiero ZI cuando hay OM ".. get_interest_text(interest));
    return false;
  end

  -- Si es Total Victory, y soy atacante, no puedo quedarme en una zona, he de ir a buscar al enemigo
  -- Si es Objetivos y soy atacante, en todo caso ire a por los objetivos, nunca a por una zona normal
  if iam_attacker() then
    log_RES("no interesa " .. get_interest_text(interest));
    return false;
  end

end


-----------------------------------------------
--
-----------------------------------------------
function coger_tropas_puente(source_res, tropas, tropas_necesito)

  local n = table.getn(source_res);
  for i=1,n do    
    if res_IsArtillery(source_res[i]) then
      if tropas_necesito.artillerias > 0 then
        tropas_necesito.artillerias = tropas_necesito.artillerias - 1;
        table.insert(tropas, source_res[i]);
      end
    elseif res_IsShootingInfantry(source_res[i]) then
      if tropas_necesito.infanterias > 0 then
        tropas_necesito.infanterias = tropas_necesito.infanterias - 1;
        table.insert(tropas, source_res[i]);
      end
    end    
  end
  
end

-----------------------------------------------
--
-----------------------------------------------
function evaluate_resources_PU(interest, free_res, extra_res, busy_res)

  local tropas = {};
  local tropas_necesito = {
    artillerias = 1,
    infanterias = 2
  };
  
  -- Busco recursos en la lista de libres
  coger_tropas_puente(free_res, tropas, tropas_necesito);
  
  -- Busco recursos en la lista de extra
  if (tropas_necesito.artillerias > 0) or (tropas_necesito.infanterias > 0) then
    coger_tropas_puente(extra_res, tropas, tropas_necesito);
  end
  
  -- Busco recursos en la lista de ocupados
  if (tropas_necesito.artillerias > 0) or (tropas_necesito.infanterias > 0) then
    coger_tropas_puente(busy_res, tropas, tropas_necesito);
  end
  
  interest_TakeResources(interest, tropas);
  
  local suficientes = (tropas_necesito.artillerias <= 0) and (tropas_necesito.infanterias <= 0);
  
  -- log_RES
  local text = "";
  if suficientes then
    text = text .. "TENGO ";
  else
    text = text .. "no llega ";
  end  
  i = 1;
  while tropas[i] do
    text = text .. res_GetInfo(tropas[i]) .. ", ";
    i = i+1;
  end
  log_RES(text .. get_interest_text(interest));
  
  -- En general se anulan los objetivos PUENTE
  --return suficientes;
  return false;

end

-----------------------------------------------
--
-----------------------------------------------
function evaluate_resources_SP(interest, free_res, extra_res, busy_res)

  -- local ngroups = num_enemy_groups();

  -- Cojo todo el ejercito junto, no quiero dividirlo  
  log_RES("  COGE TODO " .. get_interest_text(interest));
  interest_TakeResources(interest, free_res);
  interest_TakeResources(interest, extra_res);
  interest_TakeResources(interest, busy_res);    
  return true;  

end

-------------------------------------------------------------
-- Reparte los recursos entre todas las ZI que hay
-------------------------------------------------------------
function evaluate_resources_for_several_ZI(interest, free_res, extra_res, busy_res, interests)

  local zonas_interesantes = sacar_por_tipo(interests, TI_ZONA_INTERESANTE);
  
  -- Elimino los ratificados
  -- Si he ratificado alguno en una pasada anterior, ya tiene sus tropas, con lo cual no cuenta
  -- en esta pasada
  for i=1,table.getn(zonas_interesantes) do
    if interest_Ratified(zonas_interesantes[i]) then
      table.remove(zonas_interesantes, i);
    end
  end

  local nZonas = table.getn(zonas_interesantes);

  if nZonas <= 1 then
    log_RES("  COGE TODO " .. get_interest_text(interest));
    interest_TakeResources(interest, free_res);
    interest_TakeResources(interest, extra_res);
    interest_TakeResources(interest, busy_res);    
    return true;  
  end

  -- Hay que repartir las tropas

  log_RES("Hay "..nZonas.." zonas entre las que repartir las tropas");
  --local nCasas, nBosques, nAlturas = interest_GetTerrain(interest);

  local tropas = {}; -- Las tropas que quiero
  
  local tipo_tropas = { 
      Artilleria = {}, 
      Infanteria = {}, -- no milicia
      Milicia = {},
      Caballeria = {}
  };
  
  local num_tipo_tropas = { Artilleria = 0, Infanteria = 0, Milicia = 0, Caballeria = 0 };
  
  -- CLASIFICO LAS TROPAS
  -- por tipo
  -- dentro de cada tipo, por orden de "estorbo menos al cogerla"

  -- Las primeras que quiero son las que ya tengo
  local yatengo_res = {};
  if interest_HasObjective(interest) then
    acquire_troops_object_have(interest, free_res, extra_res, busy_res, tropas, tipo_tropas, num_tipo_tropas);
  end
    
  clasificar_tropas(free_res,  tipo_tropas, interest);
  clasificar_tropas(extra_res, tipo_tropas, interest);
  clasificar_tropas(busy_res,  tipo_tropas, interest);

  -- 1.- Estimar cuantas tropas necesito
  -- 2.- Seleccionar de entre las tropas
  --     * las que ya tengo
  --     * por distancia
  --     * por "liberada"
  
  local myfp = 0;
  local totalfp = 0;
  --local fpref = fp_get_reference_global();
  for i=1,nZonas do
    -- Calculo fightpower
    -- Uso el valor de referencia para evitar valores negativos
    local posx, posy = interest_GetPos(zonas_interesantes[i]);
    local fp = -get_influence(posx, posy, false, {});
    --fp = fp + fpref;
    if fp < 0 then
      fp = 0;
    end
    
    if zonas_interesantes[i] == interest then
      myfp = fp;
    end
    totalfp = totalfp + fp;
  end

  -- Mayor valor de influencia implica mayor presencia enemiga
  log_RES("  -> FP: "..myfp.." TOTAL: "..totalfp);



  -- Me quedo con el porcentaje de tropas correspondiente a la proporcion
  if myfp == 0 then

    if (num_tipo_tropas.Infanteria == 0) and (num_tipo_tropas.Caballeria == 0) and (num_tipo_tropas.Milicia == 0) then
      -- No hay enemigos. Cojo una infanteria, si hay, sino una caballeria, sino una milicia
      local tropa_cojo = tipo_tropas.Infanteria[1];
      if not tropa_cojo then
        tropa_cojo = tipo_tropas.Caballeria[1];
      end
      if not tropa_cojo then
        tropa_cojo = tipo_tropas.Milicia[1];
      end
      if not tropa_cojo then
        tropa_cojo = tipo_tropas.Artilleria[1];
      end
      
      if tropa_cojo then
        table.insert(tropas, tropa_cojo);
      else
        return false;
      end
    end

  else

    -- TODO: Contemplar el caso de que me quede todas las tropas
    -- por problemas de redondeo  

    -- Me quedo con un porcentaje
    local percent = myfp / totalfp;
    
    -- Infanteria
    coger_porcentaje_tropas_tipo(percent, tipo_tropas.Infanteria, num_tipo_tropas.Infanteria, tropas, yatengo_res)
  
    -- Caballeria
    coger_porcentaje_tropas_tipo(percent, tipo_tropas.Caballeria, num_tipo_tropas.Caballeria, tropas, yatengo_res)

    -- Milicia
    coger_porcentaje_tropas_tipo(percent, tipo_tropas.Milicia, num_tipo_tropas.Milicia, tropas, yatengo_res)

      -- ARTILLERIAS (van separadas)
    local nArtillerias = table.getn(tipo_tropas.Artilleria) + num_tipo_tropas.Artilleria;
    if nArtillerias > 0 then
      -- Tengo artilleria
      -- Cojo el porcentaje que me corresponda
      local puedo_coger = round(nArtillerias / nZonas);
      if puedo_coger <= 0 then
        puedo_coger = 1;
      end
      puedo_coger = puedo_coger - num_tipo_tropas.Artilleria;
      if puedo_coger < 0 then
        puedo_coger = 0;
      end
      --log_RES("Cojo "..puedo_coger.." artillerias");
      
      if puedo_coger > 0 then
        -- Las artillerias siempre las cojo por distancia, dada su poca movilidad
        nArtillerias = nArtillerias - num_tipo_tropas.Artilleria;
        local distancias = {};
        nArtillerias = nArtillerias - num_tipo_tropas.Artilleria;
        for i=1,nArtillerias do
          table.insert(distancias, { dist = interest_DistResource(interest, tipo_tropas.Artilleria[i]), tropa = tipo_tropas.Artilleria[i] } );
        end
    
        table.sort(distancias, comp_dist_tropa);
    
        for i=1,puedo_coger do
          local res = distancias[i].tropa;
          table.insert(tropas, res);
          sacar_recurso(yatengo_res, res);
          log_RES("  Cojo artilleria "..res_GetInfo(res));
        end
      end
    end

  end  
  
  log_RES("  TOTAL: Cojo "..table.getn(tropas).." tropas en total");
  interest_TakeResources(interest, tropas);
  return true;

end