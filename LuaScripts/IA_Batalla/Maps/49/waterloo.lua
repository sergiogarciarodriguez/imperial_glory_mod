-- Aquí tenemos que scriptar el comportamienot específico de la IA en la batalla
-- histórica de Waterloo

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
    suficientes = evaluate_resources_for_ZI(interest, free_res, extra_res, busy_res, interests);
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
--
--------------------------------------------------------------------------------
function evaluate_resources_for_ZI(interest, free_res, extra_res, busy_res, interests)

  return evaluate_resources_for_several_ZI(interest, free_res, extra_res, busy_res, interests);

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
      if(idInterest == 478 or idInterest == 485)then
        table.insert(retInterests, interest);
      end
    end
  end

  log_SE("--------------------------------------------------------------------------");

  return retInterests;
  
end

--------------------------------------------------------------
-- Funcion llamada tras crear cada objetivo
-- Permite realizar acciones concretas con el objetivo. De esta
-- forma, se pueden "personalizar" los objetivos por mapa, etc
--------------------------------------------------------------
function actions_with_objective(objective)

  if(iam_attacker())then
    objective_setATFlankTroopsPer(objective, 0);
    objective_setATOnlyFlanks(true);
  end

end
