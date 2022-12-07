-- Aquí tenemos que scriptar el comportamienot específico de la IA en la batalla
-- histórica de Arapiles

objective_setATOnlyFlanks(true);
change_ConquestZone_DetectOpportunities(false);

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
    if(iam_attacker())then
      suficientes = evaluate_resources_EE(interest, free_res, extra_res, busy_res);
    end
  elseif interest_type == TI_ZONA_INTERESANTE then
    -- en waterloo queremos 2 zonas interesantes: la Haye Sainte y el Hugomont
    suficientes = evaluate_resources_ZI(interest, free_res, extra_res, busy_res, interests);
  elseif interest_type == TI_PUENTE then
    -- no queremos que haya puentes (hay puentes siquiera en el mapa?)
    suficientes = false;
  elseif interest_type == TI_SAN_PETERSBURGO then
    -- no tiene sentido
    suficientes = false;
  end

  return suficientes;

end

--------------------------------------------------------------------------------
-- Queremos que haya 2 objetivos y uno de ellos se lleve todas las tropas menos 5 infanterías,
-- 2 caballerías Y una artillería
-------------------------------------------------------------------------------
function evaluate_resources_ZI(interest, free_res, extra_res, busy_res, interests)

  if(interest_GetId(interest) == 457)then
    -- Este es un objetivo secundario que solo quiere 4 tropas (que huyen y se atrincheran al final del mapa)
    -- Por eso, no estaremos "robando" tropas a otros objetivos, sino que simplemente cogeremos las 4 más
    -- cercanas (al principio) del enemigo, para esto usamos los free_res unicamente y los que ya tenemos, claro
    local yatengo_res = {};
    local nCabFaltan = 2;
    local nInfFaltan = 5;
    local nArtFaltan = 1;
        
    if(interest_HasObjective(interest))then
      sacar_tropas_ya_tengo(interest, free_res, yatengo_res);
      sacar_tropas_ya_tengo(interest, extra_res, yatengo_res);
      sacar_tropas_ya_tengo(interest, busy_res, yatengo_res);
    end
    
    -- quito las tropas que ya tengo de las que necesito
    local uSize = table.getn(yatengo_res);
    for i = 1,uSize do
      log_RES("  Cojo la tropa que ya poseo "..res_GetInfo(yatengo_res[i]));
      if(res_IsCavalry(yatengo_res[i]))then
        nCabFaltan = nCabFaltan - 1;
      elseif(res_IsInfantry(yatengo_res[i]))then
        nInfFaltan = nInfFaltan - 1;
      elseif(res_IsArtillery(yatengo_res[i]))then
        nArtFaltan = nArtFaltan - 1;
      end
    end

    -- cogemos los recursos que ya tenemos
    interest_TakeResources(interest, yatengo_res);
    
    local tipo_tropas = { 
        Artilleria = {}, 
        Infanteria = {}, -- no milicia
        Milicia = {},
        Caballeria = {}
    };

    local vTropasCojo = {};
    
    clasificar_tropas(free_res, tipo_tropas, interest);

    -- ahora voy cogiendo tropas mientras queden y necesite
    while nInfFaltan>0 and table.getn(tipo_tropas.Infanteria)>0 do
      local tropa = tipo_tropas.Infanteria[1];
      log_RES("  Cojo por fuerza la infanteria "..res_GetInfo(tropa));
      table.insert(vTropasCojo, tropa);
      table.remove(tipo_tropas.Infanteria, 1);
      nInfFaltan = nInfFaltan - 1;
    end
    
    while nCabFaltan>0 and table.getn(tipo_tropas.Caballeria)>0 do
      local tropa = tipo_tropas.Caballeria[1];
      log_RES("  Cojo por fuerza la caballeria "..res_GetInfo(tropa));
      table.insert(vTropasCojo, tropa);
      table.remove(tipo_tropas.Caballeria, 1);
      nCabFaltan = nCabFaltan - 1;
    end
    
    while nArtFaltan>0 and table.getn(tipo_tropas.Artilleria)>0 do
      local tropa = tipo_tropas.Artilleria[1];
      log_RES("  Cojo por fuerza la artilleria "..res_GetInfo(tropa));
      table.insert(vTropasCojo, tropa);
      table.remove(tipo_tropas.Artilleria, 1);
      nArtFaltan = nArtFaltan - 1;
    end

    -- y por último asigno las tropas que he cogido
    interest_TakeResources(interest, vTropasCojo);
    
    return (table.getn(yatengo_res)+table.getn(vTropasCojo) > 0);
    
  elseif(interest_GetId(interest) == 454)then
    -- Cojo todo
    log_RES("  COGE TODO " .. get_interest_text(interest));
    interest_TakeResources(interest, free_res);
    interest_TakeResources(interest, extra_res);
    interest_TakeResources(interest, busy_res);    
    return true;  
    
  end
  
  return false;
  
end
--------------------------------------------------------------------------------
--
--------------------------------------------------------------------------------
function filter_interests(interests)

  local nInterests = table.getn(interests);
  local retInterests = {};
  
  log_SE("--------------------------------------------------------------------------");
  log_SE("Filtrando Intereses para dejar únicamente 2 Zonas Interesantes y todos los Ejércitos Enemigos");
  
  local bestZI = nil;
  local nextZI = nil;
  
  for i=1,nInterests do
    local interest = interests[i];

    if interest_GetType(interest) == TI_EJERCITO_ENEMIGO or interest_GetType(interest) == TI_OBJETIVO_MAPA then
      table.insert(retInterests, interest);
    elseif interest_GetType(interest) == TI_ZONA_INTERESANTE then
      local idInterest = interest_GetId(interest);
      if(idInterest == 454 or idInterest == 457)then
        table.insert(retInterests, interest);
      end
    end
  end

  log_SE("--------------------------------------------------------------------------");

  return retInterests;
  
end

function esmejor_ZI_ZI(interest1, interest2)

  local bMejor = (interest_GetId(interest1)==457);
  if(bMejor)then
    log_SE(""..get_interest_text(interest1) .. " > " .. get_interest_text(interest2));
    return 1;
  else
    log_SE(""..get_interest_text(interest2) .. " > " .. get_interest_text(interest1));
    return 2;
  end

end