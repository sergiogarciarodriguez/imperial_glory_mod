----------------------
-- Lua Script
----------------------


-----------------------------------
-- Concatena dos tablas
-----------------------------------
function table_concat(table0, table1)
  for item in table1 do
    table.insert(table0, table1[item])
  end
  
  return table0
end


----------------------------------------------
-- busca la existencia de un item en una tabla
----------------------------------------------
function table_exist(table, value)
  for item_table in table do
    if(table[item_table] == value) then
      return true
    end
  end
  
  return false
end

----------------------------------------------
-- Util para logear tablas enteras
----------------------------------------------
function table_log(table, title, item_text)
  LOG(title)
  for item in table do
    LOG(item_text..table[item])
  end
end

----------------------------------------------
-- devuelve el valor máximo de una tabla
----------------------------------------------
function table_max(table)
  local max_val = NIL
  local max_iterator = NIL
  for iterator in table do
    if(max_val == NIL ) then
      max_val = table[iterator]
      max_iterator = iterator
    elseif (table[iterator] > max_val) then
      max_val = table[iterator]
      max_iterator = iterator
    end    
  end  
  return max_iterator
end

----------------------------------------------
-- devuelve el valor máximo de una tabla
----------------------------------------------
function table_min(table)
  local min_val = NIL
  local min_iterator = NIL
  
  for iterator in table do
    if(min_val == NIL ) then
      min_val = table[iterator]
      min_iterator = iterator
    elseif (table[iterator] < min_val) then
      min_val = table[iterator]
      min_iterator = iterator
    end    
  end  
  return min_iterator
end

-----------------------------------
-- devuelve el valor sumado
-- de todos los items de una table
-----------------------------------
function table_accum(table)
  local val = 0
  
  for iterador in table do
    val = val + table[iterador]
  end
  
  return val
end


----------------------------
-- dado un predicado te 
-- filtra los que lo cumplen
----------------------------
function table_filter_one(_table, pred)
  local item_ok = {}
  local item_ko = {}
  
  for iterator in _table do
    if(true == pred(_table[iterator])) then
      table.insert(item_ok, _table[iterator])
    else
      table.insert(item_ko, _table[iterator])
    end
  end
  
  return item_ok, item_ko
end

----------------------------------------------
-- dado un predicado te filtra los que lo cumplen
----------------------------------------------
function table_filter_two(_table, pred, param1)
  local item_ok = {}
  local item_ko = {}
  
  for iterator in _table do
    if(true == pred(_table[iterator], param1)) then
      table.insert(item_ok, _table[iterator])
    else
      table.insert(item_ko, _table[iterator])
    end
  end
  
  return item_ok, item_ko
end


function pred_is_true(b)
  return b
end


function pred_is_false(b)
  return not b
end


-------------------------------------------
-- dada una funcion de generacion transforma 
-- los datos de una tabla por los devueltos 
-- por la funcion
-------------------------------------------
function table_transform_one(_table, func)
  local generated = {}
  
  for iterator in _table do
    table.insert(generated, func(_table[iterator]))
  end
  
  return generated
end

-------------------------------------------
-- dada una funcion de generacion transforma 
-- los datos de una tabla por los devueltos 
-- por la funcion, con el segundo parámetro
-- fijado
-------------------------------------------
function table_transform_two(_table, func, param1)
  local generated = {}
  
  for iterator in _table do
    table.insert(generated, func(_table[iterator], param1))
  end
  
  return generated
end

-----------------------------------------------
-- Util para generar strings de Niveles
-----------------------------------------------
function nivel_str(nivel)
  if(nivel == NIVEL_MUY_BAJO) then
    return "NIVEL MUY BAJO"
  elseif(nivel == NIVEL_BAJO) then
    return "NIVEL BAJO"
  elseif(nivel == NIVEL_MEDIO) then
    return "NIVEL MEDIO"
  elseif(nivel == NIVEL_ALTO) then
    return "NIVEL ALTO"
  elseif(nivel == NIVEL_MUY_ALTO) then
    return "NIVEL MUY ALTO"
  else
    return ""
  end
end

-----------------------------------------------
-- Util para generar strings de Prioridades
-----------------------------------------------
function prioridad_str(prioridad)
  if(prioridad == GRAVEDAD_ALTA) then
    return "GRAVEDAD_ALTA"
  elseif(prioridad == GRAVEDAD_MEDIA) then
    return "GRAVEDAD_MEDIA"
  elseif(prioridad == GRAVEDAD_BAJA) then
    return "PRIORIDAD BAJA"
  else
    return ""
  end
end


-----------------------------------------------
-- Genera strings de tipos de mensaje diplomatico
-----------------------------------------------
function mensaje_str(mensaje)
  if(mensaje == MD_PERMISOPASO) then
    return "Permiso de paso"
  elseif(mensaje == MD_MEJORARELACIONES) then
    return "Mejora de relaciones" 
  elseif(mensaje == MD_DECLARACIONGUERRA) then
    return "Declaración de Guerra" 
  elseif(mensaje == MD_PROPOSICIONTREGUA) then
    return "Proposicion de tregua"
  elseif(mensaje == MD_PROPOSICIONARMISTICIO) then
    return "Proposicion de Armisticio" 
  elseif(mensaje == MD_PROTECCIONMUTUA) then
    return "Proteccion Mutua"
  elseif(mensaje == MD_TRATOCOMERCIALESPECIAL) then
    return "Trato Comercial"
  elseif(mensaje == MD_PROPOSICIONMATRIMONIO) then
    return "Proposicion Matrimonio"
  elseif(mensaje == MD_ALIANZASCONTRATERCEROS) then
    return "Alianza contra terceras"
  end
end


----------------------------
-- genera string de un recurso
----------------------------
function recurso_str(recurso)
  if(recurso == MEJORA_CIENCIA) then
    return "CIENCIA"
  elseif(recurso == MEJORA_PRODUCCION_COMIDA) then
    return "COMIDA"
  elseif(recurso == MEJORA_PRODUCCION_DINERO) then
    return "DINERO"
  elseif(recurso == MEJORA_PRODUCCION_MATPRIMAS) then
    return "MATERIAS PRIMAS"    
  elseif(recurso == MEJORA_POBLACION) then
    return "POBLACION"    
  end
  
  return ""
end