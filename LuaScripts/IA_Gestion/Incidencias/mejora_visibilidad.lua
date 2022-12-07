-- Lua Script
-- Gestión de mejoras de visibilidad

------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------- FUNCTIONS ----------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------
-- Genera una mejora relacionada con el aumento de la zona de influencia
-- especificada. Dado que todas las zonas de influencia militar y 
-- expansionista dependen de la geográfica, si ésta no es suficiente para 
-- acomodar el nuevo nivel de zona de influencia entonces se genera una 
-- orden para mejorarla primero
------------------------------------------------------------------------------
function generar_auto_mejora_influencia(origen, mejora_influencia, prioridad_base, prioridad)
  local num_ordenes_generadas = 0

  local nivel_influencia_geografica = get_nivel_influencia_geografica()
  local nivel_influencia = 0

  -- todo: ES UNA GUARRADA!!!!!!!!!! ARREGLAR
  mejora_influencia = MEJORA_INFLUENCIA_GEOGRAFICA
  
  if mejora_influencia == MEJORA_INFLUENCIA_GEOGRAFICA then
    nivel_influencia = get_nivel_influencia_geografica()
  elseif mejora_influencia == MEJORA_INFLUENCIA_MILITAR then
    nivel_influencia = get_nivel_influencia_militar()
  elseif mejora_influencia == MEJORA_INFLUENCIA_EXPANSION then
    nivel_influencia = get_nivel_influencia_expansionista()
  elseif mejora_influencia == MEJORA_INFLUENCIA_DIPLOMATICA then
    nivel_influencia = 0
  else
    assert(false)
  end

  -- Comprobamos si tenemos que mejorar primero la influencia geográfica
  if nivel_influencia >= nivel_influencia_geografica then
    -- Tenemos que aumentar primero la zona de influencia geográfica

    num_ordenes_generadas = generar_auto_mejora(origen,
                                                MEJORA_INFLUENCIA_GEOGRAFICA,
                                                prioridad_base,
                                                prioridad,
                                                prioridad)
  else
    -- Podemos aumentar la zona de influencia seleccionada

    num_ordenes_generadas = generar_auto_mejora(origen,
                                                mejora_influencia,
                                                prioridad_base,
                                                prioridad,
                                                prioridad)
  end

  return num_ordenes_generadas
end

