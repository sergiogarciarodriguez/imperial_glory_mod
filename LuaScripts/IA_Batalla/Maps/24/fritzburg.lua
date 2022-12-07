-- Aquí tenemos que scriptar el comportamienot específico de la IA en la batalla
-- histórica de Friedland

--uTimeToGetBored = 100*10;   -- en 100 segundos su único interés será atacar (y masacrar) al enemigo

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
    -- en Fritzburg hay una zona interesante que está al otro lado del río para ambos (¿?)
    suficientes = evaluate_resources_ZI(interest, free_res, extra_res, busy_res, interests);
  elseif interest_type == TI_PUENTE then
    suficientes = evaluate_resources_PU(interest, free_res, extra_res, busy_res);
  elseif interest_type == TI_SAN_PETERSBURGO then
    -- no tiene sentido
    suficientes = false;
  end

  return suficientes;

end

--------------------------------------------------------------------------------
--
--------------------------------------------------------------------------------
function evaluate_resources_ZI(interest, free_res, extra_res, busy_res, interests)

  if(not iam_attacker() and interest_GetId(interest) == 406)then
    log("*EVALRES:  COGE TODO " .. get_interest_text(interest));
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
function evaluate_resources_PU(interest, free_res, extra_res, busy_res, interests)

  local myResources = res_GetResources();
  if(iam_attacker() and interest_GetId(interest)==398 and table.getn(myResources)>17)then
    local resForInt = {};
    local uTotalResToInt = 0;
  
    -- solamente nos interesa el puente a los atacantes y si hay tropas cerca
    local uSizeFree = table.getn(free_res);
    
    for i=1,uSizeFree do
      local fDist = interest_DistResource(interest, free_res[i]);
      
      if(uTotalResToInt < 2 and fDist < 10000)then
        table.insert(resForInt, free_res[i]);
        uTotalResToInt = uTotalResToInt + 1;
      end
    end
    
    -- hacemos lo mismo para las tropas extra
    local uSizeExtra = table.getn(extra_res);
    
    for i=1,uSizeExtra do
      local fDist = interest_DistResource(interest, resextra_res[i]);
      
      if(uTotalResToInt < 2 and fDist < 10000)then
        table.insert(resForInt, extra_res[i]);
        uTotalResToInt = uTotalResToInt + 1;
      end
    end
    
    -- y para las tropas busy
    local uSizeBusy = table.getn(busy_res);
    
    for i=1,uSizeBusy do
      local fDist = interest_DistResource(interest, busy_res[i]);
      
      if(uTotalResToInt < 2 and fDist < 10000)then
        table.insert(resForInt, busy_res[i]);
        uTotalResToInt = uTotalResToInt + 1;
      end
    end
    
    -- ahora asignamos los recursos al interés
    interest_TakeResources(interest, resForInt);
    
    return uTotalResToInt>0;
  end

  return false;
end

--------------------------------------------------------------------------------
--
--------------------------------------------------------------------------------
function esmejor_EE_PU(interest1, interest2)

  -- se supone que sólo vamos a querer antes un puente que un ejército enemigo en el caso inicial de las
  -- dos tropas del atacante: es decir, sólo nos interesa si somos atacante ya que suponemos que sólo vamos
  -- a preguntar cuando somos atacantes
  local myResources = res_GetResources();
  local bBetter = (iam_attacker() or (table.getn(myResources)<=17));

  return bBetter;
  
end

--------------------------------------------------------------------------------
--
--------------------------------------------------------------------------------
function filter_interests(interests)

  
  log_SE("--------------------------------------------------------------------------");
  log_SE("El filtrado de intereses en esta batalla histórica (Fritzburg) deja todos los intereses");
  log_SE("--------------------------------------------------------------------------");

  return interests;
  
end

--------------------------------------------------------------------------------
--
--------------------------------------------------------------------------------
function actions_with_objective(objective)

  if(not iam_attacker())then
    -- queremos que vayan a colocarse enseguida
    change_ConquestZone_MinTroopPercentEsperando(0.05);
    
    -- y queremos que tengan como centro el punto que nosotros pongamos
    objective_setCZ_IFCenter(objective, 52500.0, 54000.0);
  else
    -- no queremos que haya grupo de caballería
    objective_setATFlankTroopsPer(objective, 0.0);
  end
  
end