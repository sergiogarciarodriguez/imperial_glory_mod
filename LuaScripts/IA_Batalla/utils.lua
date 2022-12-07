
-----------------------------------------------
-- Devuelve una cadena de texto que describe el interes
-----------------------------------------------
function get_interest_text(interest)

  x, y = interest_GetPos(interest);
  text = string.format("Interes %d, %s, (%.0f, %.0f)", interest_GetId(interest), interest_GetType(interest), x, y);
  return text;
  
end

-----------------------------------------------
-- Devuelve "atacante" si el player es atacante y "defensor" en caso contrario
-----------------------------------------------
function get_attacker_text()

  text = nil;
  
  if(iam_attacker())then
    text = "atacante";
  else
    text = "defensor";
  end
  
  return text;
end

-----------------------------------------------
-- Devuelve true si la CPU está en "clara" superioridad o false en caso contrario
-----------------------------------------------
function is_clearly_superior()

  local myRes = res_GetResources();
  local enemyRes = res_GetEnemyResources();

  local myFP = calc_fightpower(myRes);
  local enemyFP = calc_fightpower(enemyRes);

  -- consideraré que es claramente superior una cosa u otra dependiendo del nivel de dificultad
  local difficultyLevel = get_GameDifficulty();
  local bSuperior = nil;
  
  if(difficultyLevel == 0)then
    -- estamos en el nivel fácil: es claramente superior si soy el doble que él en global
    bSuperior = (fp_get_global(myFP)>2*fp_get_global(enemyFP));
  elseif(difficultyLevel == 1)then
    -- nivel medio, somos claramente superiores si somos 3 veces más fuertes que él en melee y distancia
    bSuperior = (fp_get_melee(myFP)>3*fp_get_melee(enemyFP)) and (fp_get_distance(myFP)>3*fp_get_distance(enemyFP));
  else
    -- nivel difícil, hay que ser 4 veces el enemigo en melee y distancia
    bSuperior = (fp_get_melee(myFP)>4*fp_get_melee(enemyFP)) and (fp_get_distance(myFP)>4*fp_get_distance(enemyFP));
  end
  
  return bSuperior;
  
end