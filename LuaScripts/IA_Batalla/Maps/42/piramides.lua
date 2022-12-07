----------------------------------------------------------------------------------
--
----------------------------------------------------------------------------------

function actions_with_objective(objective)

  -- en un principio no queremos que el atacante haga ataques por los flancos
  objective_setATFlankTroopsProb(0.0);
  
  -- también queremos que el atacante utilice el "ataque sergi"
  objective_setATUseSergiAttack(true);

  -- y no queremos que vaya a las "zonas interesantes" por el ataque, queremos un ataque frontal
  objective_setATOnlyFlanks(true);

end
