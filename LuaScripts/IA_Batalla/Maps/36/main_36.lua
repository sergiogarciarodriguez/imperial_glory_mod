-- "Naples" Map

log("Now loading Naples Map");

--------------------------------------------------------------------------

-----------------------------------------------
-- Reescribo la función para evaluar recursos en los objetivos de mapa
-- para evitar problemas con los 3 objetivos 
-----------------------------------------------
function evaluate_resources_OM(interest, free_res, extra_res, busy_res)

  -- Dependiendo del numero de objetivos de mapa a conquistar, elijo
  -- ese porcentaje de las tropas
  
  if is_total_victory() then
    log_RES("ERROR, un Total Victory no puede tener Objetivos de Mapa!!!!");
  end
  
  -- EDU!!!: Si es el objetivo de id = 3 devuelvo false a pelo
  local notInteresting = get_unique_random(1, 3);
  if interest_GetId(interest)==notInteresting then 
    log("El interes OBJETIVO DE MAPA de id ".. interest_GetId(interest) .." me lo pulo siempre para evitar problemas");
    return false;
  end
  
  -- Obtengo los objetivos de mapa que deben ir con el mio, para dividir las tropas
  local map_objs = get_map_objectives_36(interest);
  table.insert(map_objs, interest);
  
  -- Elimino los ratificados
  -- Si he ratificado alguno en una pasada anterior, ya tiene sus tropas, con lo cual no cuenta
  -- en esta pasada
  local i=1;
  while map_objs[i] do
    if interest_Ratified(map_objs[i]) then
      table.remove(map_objs, i);
    -- EDU!!!: Este es el cambio, elimino el objetivo de ID 3 "A PELO" (porque sí, porque me 
    elseif interest_GetId(map_objs[i])==notInteresting then
      table.remove(map_objs, i);
    -- EDU!!!: Fin de las modificaciones
    else
      i = i + 1;
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
      
      -- Las artillerias siempre las cojo por distancia, dada su poca movilidad
      nArtillerias = nArtillerias - num_tipo_tropas.Artilleria;
      local distancias = {};
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
  
  log_RES("  TOTAL: Cojo "..table.getn(tropas).." tropas en total");
  interest_TakeResources(interest, tropas);
  return true;
  
end
