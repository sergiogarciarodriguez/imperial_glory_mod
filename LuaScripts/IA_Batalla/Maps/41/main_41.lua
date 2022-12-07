-- Lombardy Map

log("Now loading Venice Map");

---------------------------------------------------------
-- Deshabilitamos el uso de ca�ones en elevaciones ya
-- que no queda bien
---------------------------------------------------------
change_ConquestZone_UseElevatedCannons( false );

---------------------------------------------------------
-- Reescribimos esta funci�n porque s�lo nos interesa una ZI
---------------------------------------------------------
function evaluate_resources_ZI(interest, free_res, extra_res, busy_res)
  
  if iam_attacker() then
    return false;
  end
  
  if interest_GetId(interest)==437 then
    log_RES("  COGE TODO " .. get_interest_text(interest));
    interest_TakeResources(interest, free_res);
    interest_TakeResources(interest, extra_res);
    interest_TakeResources(interest, busy_res);    
    return true;  
  end

  return false;
  
end

---------------------------------------------------------
-- Nos interesa la zona alta aunque estemos m�s lejos
---------------------------------------------------------
function find_winner_interest(interests)

  local retInterest = nil;
  local zonasInteresantes = sacar_por_tipo(interests, TI_ZONA_INTERESANTE);

  if not iam_attacker() then
    if table.getn(zonasInteresantes)>0 then
      -- s�lo puede haber 1, la 437
      retInterest = zonasInteresantes[1];
      log_SE("Sacamos la zona interesante: "..get_interest_text(retInterest));
      return retInterest;
    end
  end
  
  -- si estamos aqu� es porque, probablemente, seamos el atacante, as� q devolvemos un ej�rcito enemigo
  local ejercitosEnemigos = sacar_por_tipo(interests, TI_EJERCITO_ENEMIGO);
  
  if table.getn(ejercitosEnemigos)>0 then
    retInterest = select_best_sequential(ejercitosEnemigos);
    log_SE("Seleccionamos un ej�rcito enemigo: "..get_interest_text(retInterest));
  end
  
  return retInterest;

end