-- "Bradengurg" Map

log("Now loading San Petersburgo Map");

local iObjMapID = 0;
if is_total_victory() then
  iObjMapID = 290;
end;

change_ConquestZone_FeaturesRadius(25000);
log("ConquesZone Features Radius changed to 25000");

-- No queremos que salga a por el enemigo
change_ConquestZone_DetectOpportunities( false );
log("Disabling ConquestZone_DetectOpportunities Feature");

-- Creamos algún interés de zona estratégica y eso...
log("Creating strategic zone interests:");

create_StrategicZoneInterest(1, 45650.0, 18500.0, 270.0, true, false, true, iObjMapID); -- por poner algo... es para probar qué tal
log("  - First strategic zone: pos = (45650.0, 18500.0), pri = 1, inf = true, cav = false, art = true");

create_StrategicZoneInterest(2, 40300.0, 35250.0, 270.0, true, true, false, iObjMapID); -- por poner algo... es para probar qué tal
log("  - First strategic zone: pos = (40300.0, 35250.0), pri = 1, inf = true, cav = false, art = true");

create_StrategicZoneInterest(3, 45400.0, 52500.0, 270.0, true, false, true, iObjMapID); -- por poner algo... es para probar qué tal
log("  - First strategic zone: pos = (45400.0, 52500.0), pri = 1, inf = true, cav = false, art = true");

-- Creamos el interes de ataque de San Petersburgo para el atacante
log("Creating San Petersburgo Attack");
interest_CreateSanPetersburgo();

--------------------------------------------------------------------------

-----------------------------------------------
-- No queremos que se haga ningún puente
-----------------------------------------------
function evaluate_resources_PU(interest, free_res, extra_res, busy_res)

  return false;
  
end

-----------------------------------------------
-- Los OM cogen TODO
-----------------------------------------------
function evaluate_resources_OM(interest, free_res, extra_res, busy_res)

  log("*EVALRES:  COGE TODO " .. get_interest_text(interest));
  interest_TakeResources(interest, free_res);
  interest_TakeResources(interest, extra_res);
  interest_TakeResources(interest, busy_res);
  
  return true;
  
end

-----------------------------------------------
-- Sólo nos interesa la zona interesante 292, y le asignaremos 2 tropas de infantería, si hay al menos 3
-----------------------------------------------
function evaluate_resources_ZI(interest, free_res, extra_res, busy_res)

  if(interest_GetId(interest)==292)then
    local iNInfanteriasNecesito = 2;
    local tropasObjetivo = {};

    if interest_HasObjective(interest) then 
      sacar_tropas_ya_tengo(interest, free_res, tropasObjetivo);
      sacar_tropas_ya_tengo(interest, extra_res, tropasObjetivo);
      sacar_tropas_ya_tengo(interest, busy_res, tropasObjetivo);
      
      iNInfanteriasNecesito = iNInfanteriasNecesito - table.getn(tropasObjetivo);
    end
    
    coger_recursos_292(free_res, tropasObjetivo, iNInfanteriasNecesito);
    
    if(iNInfanteriasNecesito>0)then
      coger_recursos_292(extra_res, tropasObjetivo, iNInfanteriasNecesito);
    end
  
    -- En un principio, este objetivo no manga recursos a ningun otro  
    if(iNInfanteriasNecesito>0)then
      coger_recursos_292(busy_res, tropasObjetivo, iNInfanteriasNecesito);
    end
    
    interest_TakeResources(interest, tropasObjetivo);
    
    -- decido que tengo suficientes tropas si tengo al menos una q apostar ya que nos interesa apostar aunque sólo sea a una tropa
    local suficientes = (table.getn(tropasObjetivo)>0);
  
    return suficientes;
  elseif(is_total_victory() and interest_GetId(interest)==290) then
    log("*EVALRES:  COGE TODO " .. get_interest_text(interest));
    interest_TakeResources(interest, free_res);
    interest_TakeResources(interest, extra_res);
    interest_TakeResources(interest, busy_res);
  
    return true;  
  end
  
  return false;
  
end

-----------------------------------------------
-- cojo 2 infanterias que se puedan apostar si tiene, al menos, otra más para el OM
-----------------------------------------------
function coger_recursos_292(source_res, tropas, infanterias_necesito)

  local n = table.getn(source_res);
  local nInfs = 0;
  for i=1,n do
    if(res_IsShootingInfantry(source_res[i]))then
      if(nInfs>=1 and infanterias_necesito>0)then
        table.insert(tropas, source_res[i]);
        infanterias_necesito = infanterias_necesito - 1;
        log("*EVALRES:ZI 292: cogo el recurso "..res_GetInfo(source_res[i]));
      end
      nInfs = nInfs + 1;
    end
  end
end

-----------------------------------------------
-- Queremos que se seleccione la interesting zone 292 y el OM
-----------------------------------------------
function find_winner_interest(interests)
  
  local best_om = nil;

  -- En este escenario no nos interesan los puentes
  puentes = sacar_por_tipo(interests, TI_PUENTE);
  log("*SE:Bridges: No nos interesan ninguno de los ".. table.getn(puentes) .."los puentes");

  -- Regla: Si soy atacante, busco sólo en los ejércitos enemigos
  if iam_attacker() then
    -- Soy el atacante busco el ejército enemigo mejor
    local ejercitos_enemigos = sacar_por_tipo(interests, TI_SAN_PETERSBURGO);
    local best_ee = nil;
    if table.getn(ejercitos_enemigos) >= 1 then
      best_ee = select_best_sequential(ejercitos_enemigos);
      log("*SE:Best EE: "..get_interest_text(best_ee));
    end
    return best_ee;
  end  


  -- En este escenario se va a elegir primero la zona 292 (el market) y después el objetivo de mapa  
  -- Regla: si defiendo el mapa y hay zonas, las comparo entre ellas, y me quedo solo con una
  local best_zona = nil;
  zonas = sacar_por_tipo(interests, TI_ZONA_INTERESANTE);
  log("*SE:Zonas: "..table.getn(zonas));
  if table.getn(zonas) == 2 then
    -- tenemos 2 zonas interesantes: estamos en victoria total, queremos tomar primero la 292
    if interest_GetId(zonas[1]) == 292 then
      best_zona = zonas[1];
    else
      best_zona = zonas[2];
    end
    log("*SE:Best ZI: "..get_interest_text(best_zona));
  elseif table.getn(zonas) > 0 then
    -- si estamos en victoria total ya hemos tratado la 292 y sino esta será la 292
    best_zona = select_best_sequential(zonas);
    log("*SE:Best ZI: "..get_interest_text(best_zona));
  end

  -- si tenemos una zona interesante es la 292 y la asignamos primero (sino se queda sin recurso 
  -- porque se los lleva todos el OM)  
  if best_zona then
    log("*SE:Seleccionamos la ZI "..interest_GetId(best_zona));
    return best_zona;
  end

  -- Regla: si defiendo el mapa y hay objetivos, son prioritarios
  objetivos_mapa = sacar_por_tipo(interests, TI_OBJETIVO_MAPA);
  if not iam_attacker() then
    if table.getn(objetivos_mapa) >= 1 then
      best_om =  select_best_sequential(objetivos_mapa);
      log("*SE:Best OM: "..get_interest_text(best_om));
    end
  end

  
  if best_om then
    log("*SE:Seleccionamos el OM "..interest_GetId(best_om));
    return best_om;
  end
  
  return nil;

end
