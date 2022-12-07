-- Lua Script

------------------------------------------
-- Gestión de incidencias de diplomacia
------------------------------------------

-------------------------------------------------------------------------------
-- Función de ayuda para generar un mensaje diplomático.
-------------------------------------------------------------------------------
function generar_mensaje_permiso_paso(receptor, ultimatum)
  local mensaje = 
        {
          MD_PERMISOPASO,         -- tipo
          CT_DIPLOMACIA_OFRECER,  -- contexto
          MY_PLAYER_ID,           -- emisor
          receptor,               -- receptor
          0,                      -- tercero
          ultimatum,              -- ultimátum
          1,                      -- número de ofertas
          0,                      -- oferta: dinero
          0,                      -- oferta: materias primas
          0,                      -- oferta: comida
          0,                      -- intercambio: dinero
          0,                      -- intercambio: materias primas
          0,                      -- intercambio: comida
          {},                     -- oferta: batallones
          {},                     -- oferta: barcos
          {},                     -- oferta: provincias
          {},                     -- intercambio: batallones
          {},                     -- intercambio: barcos
          {}                      -- intercambio: provincias
        }

  local precio = get_precio_of_tratado(mensaje)
  mensaje[MD_INDEX_OFERTA_DINERO] = 2*precio

  return mensaje
end

function generar_mensaje_mejora_relaciones(receptor)
  local mensaje = 
        {
          MD_MEJORARELACIONES,    -- tipo
          CT_DIPLOMACIA_OFRECER,  -- contexto
          MY_PLAYER_ID,           -- emisor
          receptor,               -- receptor
          0,                      -- tercero
          false,                  -- ultimátum
          1,                      -- número de ofertas
          0,                      -- oferta: dinero
          0,                      -- oferta: materias primas
          0,                      -- oferta: comida
          0,                      -- intercambio: dinero
          0,                      -- intercambio: materias primas
          0,                      -- intercambio: comida
          {},                     -- oferta: batallones
          {},                     -- oferta: barcos
          {},                     -- oferta: provincias
          {},                     -- intercambio: batallones
          {},                     -- intercambio: barcos
          {}                      -- intercambio: provincias
        }

  local precio = get_precio_of_tratado(mensaje)
  mensaje[MD_INDEX_OFERTA_DINERO] = 2*precio

  return mensaje
end

function generar_mensaje_declaracion_guerra(receptor)
  local mensaje = 
        {
          MD_DECLARACIONGUERRA,   -- tipo
          CT_DIPLOMACIA_OFRECER,  -- contexto
          MY_PLAYER_ID,           -- emisor
          receptor,               -- receptor
          0,                      -- tercero
          false,                  -- ultimátum
          1,                      -- número de ofertas
          0,                      -- oferta: dinero
          0,                      -- oferta: materias primas
          0,                      -- oferta: comida
          0,                      -- intercambio: dinero
          0,                      -- intercambio: materias primas
          0,                      -- intercambio: comida
          {},                     -- oferta: batallones
          {},                     -- oferta: barcos
          {},                     -- oferta: provincias
          {},                     -- intercambio: batallones
          {},                     -- intercambio: barcos
          {}                      -- intercambio: provincias
        }

  return mensaje
end

function generar_mensaje_ayuda_militar(receptor)
  local mensaje = 
        {
          MD_SOLICITUD_AYUDA_MILITAR,   -- tipo
          CT_DIPLOMACIA_OFRECER,  -- contexto
          MY_PLAYER_ID,           -- emisor
          receptor,               -- receptor
          0,                      -- tercero
          false,                  -- ultimátum
          1,                      -- número de ofertas
          0,                      -- oferta: dinero
          0,                      -- oferta: materias primas
          0,                      -- oferta: comida
          0,                      -- intercambio: dinero
          0,                      -- intercambio: materias primas
          0,                      -- intercambio: comida
          {},                     -- oferta: batallones
          {},                     -- oferta: barcos
          {},                     -- oferta: provincias
          {},                     -- intercambio: batallones
          {},                     -- intercambio: barcos
          {}                      -- intercambio: provincias
        }

  return mensaje
end

function generar_mensaje_alianza_defensiva(receptor)
  local mensaje = 
        {
          MD_PROTECCIONMUTUA,     -- tipo
          CT_DIPLOMACIA_OFRECER,  -- contexto
          MY_PLAYER_ID,           -- emisor
          receptor,               -- receptor
          0,                      -- tercero
          false,                  -- ultimátum
          1,                      -- número de ofertas
          0,                      -- oferta: dinero
          0,                      -- oferta: materias primas
          0,                      -- oferta: comida
          0,                      -- intercambio: dinero
          0,                      -- intercambio: materias primas
          0,                      -- intercambio: comida
          {},                     -- oferta: batallones
          {},                     -- oferta: barcos
          {},                     -- oferta: provincias
          {},                     -- intercambio: batallones
          {},                     -- intercambio: barcos
          {}                      -- intercambio: provincias
        }

  local precio = get_precio_of_tratado(mensaje)
  mensaje[MD_INDEX_OFERTA_DINERO] = 2*precio

  return mensaje;
end

function generar_mensaje_paz(receptor, oferta_provincias)
  local mensaje = 
        {
          MD_PROPOSICIONARMISTICIO,     -- tipo
          CT_DIPLOMACIA_OFRECER,  -- contexto
          MY_PLAYER_ID,           -- emisor
          receptor,               -- receptor
          0,                      -- tercero
          false,                  -- ultimátum
          1,                      -- número de ofertas
          0,                      -- oferta: dinero
          0,                      -- oferta: materias primas
          0,                      -- oferta: comida
          0,                      -- intercambio: dinero
          0,                      -- intercambio: materias primas
          0,                      -- intercambio: comida
          {},                     -- oferta: batallones
          {},                     -- oferta: barcos
          oferta_provincias,      -- oferta: provincias
          {},                     -- intercambio: batallones
          {},                     -- intercambio: barcos
          {}                      -- intercambio: provincias
        }

  local precio = get_precio_of_tratado(mensaje)
  mensaje[MD_INDEX_OFERTA_DINERO] = 2*precio

  return mensaje;
end

function generar_mensaje_coalicion(receptor, tercero, ultimatum, oferta_provincias)
  local mensaje = 
        {
          MD_ALIANZASCONTRATERCEROS, -- tipo
          CT_DIPLOMACIA_OFRECER,  -- contexto
          MY_PLAYER_ID,           -- emisor
          receptor,               -- receptor
          tercero,                -- tercero
          ultimatum,              -- ultimátum
          1,                      -- número de ofertas
          0,                      -- oferta: dinero
          0,                      -- oferta: materias primas
          0,                      -- oferta: comida
          0,                      -- intercambio: dinero
          0,                      -- intercambio: materias primas
          0,                      -- intercambio: comida
          {},                     -- oferta: batallones
          {},                     -- oferta: barcos
          oferta_provincias,      -- oferta: provincias
          {},                     -- intercambio: batallones
          {},                     -- intercambio: barcos
          {}                      -- intercambio: provincias
        }

  local precio = get_precio_of_tratado(mensaje)
  mensaje[MD_INDEX_OFERTA_DINERO] = 2*precio

  return mensaje;
end

function generar_mensaje_envio_efectivos(receptor, oferta_batallones, oferta_barcos, limitar_por_recursos)
  local mensaje = 
        {
          MD_ENVIO_EFECTIVOS,     -- tipo
          CT_DIPLOMACIA_OFRECER,  -- contexto
          MY_PLAYER_ID,           -- emisor
          receptor,               -- receptor
          0,                      -- tercero
          false,                  -- ultimátum
          1,                      -- número de ofertas
          0,                      -- oferta: dinero
          0,                      -- oferta: materias primas
          0,                      -- oferta: comida
          0,                      -- intercambio: dinero
          0,                      -- intercambio: materias primas
          0,                      -- intercambio: comida
          oferta_batallones,      -- oferta: batallones
          oferta_barcos,          -- oferta: barcos
          {},                     -- oferta: provincias
          {},                     -- intercambio: batallones
          {},                     -- intercambio: barcos
          {}                      -- intercambio: provincias
        }

  local precio = get_precio_of_tratado(mensaje, limitar_por_recursos)
  mensaje[MD_INDEX_INTERCAMBIO_DINERO] = -precio

  return mensaje;
end

function generar_mensaje_matrimonio(receptor)
  local mensaje = 
        {
          MD_PROPOSICIONMATRIMONIO,  -- tipo
          CT_DIPLOMACIA_OFRECER,  -- contexto
          MY_PLAYER_ID,           -- emisor
          receptor,               -- receptor
          0,                      -- tercero
          false,                  -- ultimátum
          1,                      -- número de ofertas
          0,                      -- oferta: dinero
          0,                      -- oferta: materias primas
          0,                      -- oferta: comida
          0,                      -- intercambio: dinero
          0,                      -- intercambio: materias primas
          0,                      -- intercambio: comida
          {},                     -- oferta: batallones
          {},                     -- oferta: barcos
          {},                     -- oferta: provincias
          {},                     -- intercambio: batallones
          {},                     -- intercambio: barcos
          {}                      -- intercambio: provincias
        }

  local precio = get_precio_of_tratado(mensaje)
  mensaje[MD_INDEX_OFERTA_DINERO] = 2*precio

  return mensaje;
end


function generar_mensaje_intercambio(receptor, oferta_mat_primas, oferta_comida, intercambio_mat_primas, intercambio_comida, oferta_provincias, intercambio_provincias, limitar_por_recursos)
  local mensaje = 
        {
          MD_TRATOCOMERCIALESPECIAL,  -- tipo
          CT_DIPLOMACIA_OFRECER,  -- contexto
          MY_PLAYER_ID,           -- emisor
          receptor,               -- receptor
          0,                      -- tercero
          false,                  -- ultimátum
          1,                      -- número de ofertas
          0,                      -- oferta: dinero
          oferta_mat_primas,      -- oferta: materias primas
          oferta_comida,          -- oferta: comida
          0,                      -- intercambio: dinero
          intercambio_mat_primas, -- intercambio: materias primas
          intercambio_comida,     -- intercambio: comida
          {},                     -- oferta: batallones
          {},                     -- oferta: barcos
          oferta_provincias,      -- oferta: provincias
          {},                     -- intercambio: batallones
          {},                     -- intercambio: barcos
          intercambio_provincias  -- intercambio: provincias
        }

  local precio = get_precio_of_tratado(mensaje, limitar_por_recursos)

  if oferta_mat_primas > 0 or oferta_comida > 0 or table.getn(oferta_provincias) > 0 then
    -- Mensaje de oferta
    mensaje[MD_INDEX_INTERCAMBIO_DINERO] = -precio
  else
    -- Mensaje de demanda
    mensaje[MD_INDEX_OFERTA_DINERO] = 2*precio
  end

  return mensaje;
end

-------------------------------------------------------------------------------
-- Trata los mensajes diplomáticos que se encuentran en la cola de mensajes.
-------------------------------------------------------------------------------
function responder_mensajes_diplomaticos()
end

function responder_mensajes_diplomaticos_old()
  local mensaje

  repeat
    mensaje = pop_mensaje_diplomatico()

    if mensaje[MD_INDEX_TIPO] ~= MD_NINGUNO then
      if mensaje[MD_INDEX_TIPO] == MD_DECLARACIONGUERRA then
        ejecutar_mensaje_diplomatico(mensaje)
      else

        if mensaje[MD_INDEX_CONTEXTO] == CT_DIPLOMACIA_OFRECER then
          -- Si el mensaje es una oferta de un jugador ajeno lo tratamos
          tratar_mensaje_diplomatico(mensaje)
        else
          -- Si no es así, simplemente sacamos un log
          if mensaje[MD_INDEX_CONTEXTO] == CT_DIPLOMACIA_ACEPTAR then
            LOG("Se ha aceptado el mensaje enviado a "..get_name(mensaje[MD_INDEX_RECEPTOR]).."\ndel tipo "..mensaje_str(mensaje[MD_INDEX_TIPO]))
          elseif mensaje[MD_INDEX_CONTEXTO] == CT_DIPLOMACIA_RECHAZAR then
            LOG("Se ha rechazado el mensaje enviado a "..get_name(mensaje[MD_INDEX_RECEPTOR]).."\ndel tipo "..mensaje_str(mensaje[MD_INDEX_TIPO]))
          end
        end 

      end
    end
  until mensaje[MD_INDEX_TIPO] == MD_NINGUNO
end


-------------------------------------------------------------------------------
-- Lleva a cabo el tratamiento específico de cada mensaje diplomático.
-------------------------------------------------------------------------------
function tratar_mensaje_diplomatico(mensaje)
  local respuesta

  respuesta = responder_mensaje_diplomatico(mensaje)
  ejecutar_mensaje_diplomatico(respuesta)
  ENVIAR_MENSAJE_DIPLOMATICO(TINC_RESPONDER_MENSAJE_DIPLOMATICO, 1.0, 1.0, respuesta)
end



-------------------------------------------------------------------------------
-- Genera la respuesta a un mensaje diplomático específico.
-- Los pasos que lleva a cabo son los siguientes:
--    - Calcula el precio del tratado.
--      Para más información ver CAIGestion_Diplomatic::getPrecioTratado.
--    - Si el precio del tratado es positivo:
--      - Compara el precio del tratado con la oferta del jugador:
--        - Si la oferta es menor que el precio del tratado, el tratado se rechaza
--        - Si la oferta es mayor que el doble del precio del tratado, el tratado
--          se acepta.
--        - Si la oferta cae entre estos dos valores, la probabilidad de ser
--          aceptada es proporcional a lo cerca que se encuentra la oferta
--          del valor máximo.
--    - Si el precio del tratado es negativo:
--        - Si la demanda es menor que la demanda estimada, el tratado se acepta
--        - Si la demanda es mayor que el doble de la estimada, se rechaza
--        - Si la demanda cae entre estos dos valores, la probabilidad de ser
--          aceptada es proporcional a lo cerca que se encuentra la demanda
--          del valor máximo (en valor absoluto).
-------------------------------------------------------------------------------
function responder_mensaje_diplomatico(mensaje)
  local precio_estipulado = get_precio_of_tratado(mensaje)
  local valor             = get_valor_of_tratado(mensaje)

  local aceptar      = false
  local probabilidad = 0

  if precio_estipulado > 0 then
    -- El precio es mayor que cero, es decir, consideramos que nos tienen que
    -- ofrecer dinero para aceptar este tratado.

    -- Calculamos la probabilidad de aceptar este tratado, dado el valor ofrecido
    -- en comparación con el estipulado
    probabilidad = math.max(0, math.min(1, (valor - precio_estipulado) / precio_estipulado))

  elseif precio_estipulado < 0 then
    -- El precio es menor que cero, es decir, consideramos que estamos dispuestos
    -- a pagar cierta cantidad por aceptar este trato, ya que en cierta medida nos interesa.

    -- Calculamos la probabilidad de aceptarlo, teniendo en cuenta que el valor
    -- absoluto de lo devuelto por get_precio_of_tratado es la cantidad máxima 
    -- que nos pueden exigir para que aceptemos con seguridad el tratado, y la
    -- mitad de este valor absoluto es lo máximo que nos pueden exigir para que
    -- aceptemos siempre el tratado.
    precio_estipulado = -precio_estipulado
    valor             = -valor    

    probabilidad = math.max(0, math.min(1, 0.5 + (precio_estipulado - valor) / precio_estipulado))

  else
    -- El precio estipulado es exactamente cero, así que aceptamos el tratado
    probabilidad = 1

  end

  -- Tiramos un dado
  local dado = math.random()
  if dado < probabilidad then
    aceptar = true
  else
    aceptar = false
  end

  -- Generamos la respuesta al mensaje
  if aceptar then
    LOG("Se ha aceptado el tratado de " .. get_name(mensaje[MD_INDEX_EMISOR]) .. " [ precio = " .. precio_estipulado .. ", valor = " 
        .. valor .. ", probabilidad = " .. probabilidad .. ", dado = " .. dado .. " ]")

    mensaje[MD_INDEX_CONTEXTO] = CT_DIPLOMACIA_ACEPTAR
  else
    LOG("Se ha rechazado el tratado de " .. get_name(mensaje[MD_INDEX_EMISOR]) .. " [ precio = " .. precio_estipulado .. ", valor = " 
        .. valor .. ", probabilidad = " .. probabilidad .. ", dado = " .. dado .. " ]")

    mensaje[MD_INDEX_CONTEXTO] = CT_DIPLOMACIA_RECHAZAR
  end

  return mensaje
end


function tiene_tecnologia_requerida_por_mensaje(tipo)
  local idx_tecnologia_requerida = get_idx_tecnologia_requerida_por_mensaje(tipo)

  if idx_tecnologia_requerida == 0 then
    return true
  else
    return ha_investigado_tecnologia(idx_tecnologia_requerida)
  end
end


function es_orden_vetada(preferencia)
  return preferencia <= UMBRAL_PRIORIDAD_RECHAZO_INMEDIATO
end















--------------------
-- GLOBALS
--------------------

-- en porcentaje de produccion
PRECIO_BASE_TRATADOS = { [MD_MEJORARELACIONES] = 6, [MD_TRATOCOMERCIALESPECIAL] = 0.1, [MD_PROPOSICIONTREGUA] = 4.2, [MD_PROPOSICIONARMISTICIO] = 8.0, 
                         [MD_PERMISOPASO] = 5.5, [MD_PROTECCIONMUTUA] = 5, [MD_ALIANZASCONTRATERCEROS] = 7.5, [MD_PROPOSICIONMATRIMONIO] = 15.0, 
                         [MD_DECLARACIONGUERRA] = 0 }

INCREMENTO_POR_TURNO = 0.1
INCREMENTO_POR_POTENCIA_MILITAR = 1.0
INCREMENTO_POR_AFINIDAD_POLITICA = 1.0
-------------------------------
-- Responde a todos lo mensajes
-- diplomaticos
-------------------------------
function responder_mensajes()
  repeat
    mensaje = pop_mensaje_diplomatico()
    
    if(mensaje[MD_INDEX_TIPO] ~= MD_NINGUNO ) then
      if mensaje[MD_INDEX_TIPO] == MD_DECLARACIONGUERRA then
        ejecutar_mensaje(mensaje)
      elseif(mensaje[MD_INDEX_CONTEXTO] == CT_DIPLOMACIA_OFRECER) then
        responder_mensaje(mensaje)
        if mensaje[MD_INDEX_CONTEXTO] == CT_DIPLOMACIA_ACEPTAR then
          ejecutar_mensaje(mensaje)
        end
      elseif(mensaje[MD_INDEX_CONTEXTO] == CT_DIPLOMACIA_ACEPTAR) then
        LOG("Se ha aceptado el mensaje enviado a "..get_name(mensaje[MD_INDEX_RECEPTOR]).."\ndel tipo "..mensaje_str(mensaje[MD_INDEX_TIPO]))
      elseif(mensaje[MD_INDEX_CONTEXTO] == CT_DIPLOMACIA_RECHAZAR) then
        LOG("Se ha rechazado el mensaje enviado a "..get_name(mensaje[MD_INDEX_RECEPTOR]).."\ndel tipo "..mensaje_str(mensaje[MD_INDEX_TIPO]))
      end
    end
    
  until mensaje[MD_INDEX_TIPO] == MD_NINGUNO
end

----------------------------------
-- responder mensaje
----------------------------------
function responder_mensaje(mensaje)
  
  local vr = get_vr()
  local produccion = get_produccion()  
  local valor_propuesta = calcular_valor_base_propuesta(mensaje)
  local valor_oferta = calcular_valor_oferta(mensaje)
  
  LOG("Produccion oro "..produccion[3])
  LOG("VR oro "..vr[RC_INDEX_DINERO])
  LOG("Se ha recibido un mensaje de "..get_name(mensaje[MD_INDEX_EMISOR]).."\ndel tipo "..mensaje_str(mensaje[MD_INDEX_TIPO]).."\n con un valor de "..valor_propuesta.." de oro y ofreciendo "..valor_oferta.." de oro")
  
  respuesta = generar_resultado_tratado(valor_propuesta, valor_oferta, mensaje)
    
  ENVIAR_MENSAJE_DIPLOMATICO(TINC_RESPONDER_MENSAJE_DIPLOMATICO, 1.0, 1.0,  respuesta)
  
end


function ejecutar_mensaje(mensaje)
  ejecutar_mensaje_diplomatico(mensaje)
end

---------------------------------------
-- calcular valor ofertado
---------------------------------------
function calcular_valor_oferta(mensaje)
  local vr = get_vr()
  local produccion = get_produccion()  
  
  local valor_oferta = vr[RC_INDEX_COMIDA]*mensaje[MD_INDEX_OFERTA_COMIDA]/produccion[RC_INDEX_COMIDA] + 
                       vr[RC_INDEX_DINERO]*mensaje[MD_INDEX_OFERTA_DINERO]/produccion[RC_INDEX_DINERO] + 
                       vr[RC_INDEX_MATPRIMAS]*mensaje[MD_INDEX_OFERTA_MATPRIMAS]/produccion[RC_INDEX_MATPRIMAS];

  LOG("Valor oferta "..valor_oferta)                       
  if(mensaje[MD_INDEX_TIPO] == MD_TRATOCOMERCIALESPECIAL) then  
    valor_oferta = valor_oferta -
                   vr[RC_INDEX_COMIDA]*mensaje[MD_INDEX_INTERCAMBIO_COMIDA]/produccion[RC_INDEX_COMIDA]-
                   vr[RC_INDEX_DINERO]*mensaje[MD_INDEX_INTERCAMBIO_DINERO]/produccion[RC_INDEX_DINERO]-
                   vr[RC_INDEX_MATPRIMAS]*mensaje[MD_INDEX_INTERCAMBIO_MATPRIMAS]/produccion[RC_INDEX_MATPRIMAS]
  elseif(true == mensaje[MD_INDEX_EXIGENCIA]) then
    valor_oferta = -valor_oferta
  end  
  local valor_intercambio = vr[RC_INDEX_COMIDA]*mensaje[MD_INDEX_INTERCAMBIO_COMIDA]/produccion[RC_INDEX_COMIDA]-
                   vr[RC_INDEX_DINERO]*mensaje[MD_INDEX_INTERCAMBIO_DINERO]/produccion[RC_INDEX_DINERO]-
                   vr[RC_INDEX_MATPRIMAS]*mensaje[MD_INDEX_INTERCAMBIO_MATPRIMAS]/produccion[RC_INDEX_MATPRIMAS]
  LOG("Valor itercambio "..valor_intercambio)
  return valor_oferta
end

-----------------------------------------------------------------
-- genera resultado del tratado
-----------------------------------------------------------------
function generar_resultado_tratado(valor_tratado, valor_oferta, mensaje)
  local resultado_tratado = true
  local dentro_de_precio_minimo = true
  
  if(valor_oferta < 0 and valor_tratado > 0) then
    resultado_tratado = false
    dentro_de_precio_minimo = false
  elseif(valor_oferta > 0 and valor_tratado < 0) then
    resultado_tratado = true
    dentro_de_precio_minimo = false
  elseif(valor_oferta < 0 and valor_tratado < 0) then
    local porcentaje_exito = 2.0 - (valor_oferta/valor_tratado) 
    resultado_tratado = math.random() < porcentaje_exito
    dentro_de_precio_minimo = porcentaje_exito > 0.0
  else
    local porcentaje_exito = (valor_oferta/valor_tratado) - 1.0
    resultado_tratado = math.random() < porcentaje_exito
    dentro_de_precio_minimo = porcentaje_exito > 0.0
  end
  
  local respuesta = mensaje    
  if(mensaje[MD_INDEX_TIPO] == MD_TRATOCOMERCIALESPECIAL) then
    if(true == resultado_tratado) then
      respuesta[MD_INDEX_CONTEXTO] = CT_DIPLOMACIA_ACEPTAR  
    else
      if(true == dentro_de_precio_minimo) then
        respuesta = generar_contra_oferta(valor_tratado, valor_oferta, mensaje)
      else
        respuesta[MD_INDEX_CONTEXTO] = CT_DIPLOMACIA_RECHAZAR
      end
    end
  else
    if(true == resultado_tratado) then
      respuesta[MD_INDEX_CONTEXTO] = CT_DIPLOMACIA_ACEPTAR;    
    else  
      respuesta[MD_INDEX_CONTEXTO] = CT_DIPLOMACIA_RECHAZAR
    end  
  end    
    
  return respuesta
end

-----------------------------------------
-- calcula el valor de un mensaje
-----------------------------------------
function calcular_valor_base_propuesta(mensaje)
  local  valor_hostilidad = calcular_valor_hostilidad(mensaje[MD_INDEX_EMISOR], mensaje[MD_INDEX_TIPO])  
  local  valor_turnos = calcular_valor_turnos(mensaje[MD_INDEX_TURNOS], mensaje[MD_INDEX_TIPO])
  local  valor_ultimatum = 0
  if(true == mensaje[MD_INDEX_ULTIMATUM]) then
    valor_ultimatum = calcular_valor_ultimatum(mensaje[MD_INDEX_EMISOR], mensaje[MD_INDEX_TIPO])
  end  
  local valor_afinidad = calcular_valor_afinidad_politica(mensaje[MD_INDEX_EMISOR],mensaje[MD_INDEX_TIPO])

  LOG("Valor hostilidad "..valor_hostilidad)
  LOG("Valor turnos "..valor_turnos)
  LOG("Valor afinidad "..valor_afinidad)
  LOG("Valor ultimatum "..valor_ultimatum)
  LOG("Precio base tratado "..PRECIO_BASE_TRATADOS[mensaje[MD_INDEX_TIPO]] )

  return valor_hostilidad+valor_turnos+valor_afinidad+valor_ultimatum+PRECIO_BASE_TRATADOS[mensaje[MD_INDEX_TIPO]] 
end

---------------------------------------------
-- calcula el valor por grado de hostilidad
---------------------------------------------
function calcular_valor_hostilidad(emisor, tipo_tratado)
  local hostilidad =  1.0 - get_grado_hostilidad(get_my_id(), emisor)
  return hostilidad*PRECIO_BASE_TRATADOS[tipo_tratado]
end


---------------------------------------------
-- calcula el valor por grado de hostilidad
---------------------------------------------
function calcular_valor_turnos(turnos, tipo_tratado)
  if(turnos > 0) then
    return((turnos-1)*INCREMENTO_POR_TURNO*PRECIO_BASE_TRATADOS[tipo_tratado])
  else
    return 0.0
  end
end

---------------------------------------------
-- calcula el valor añadido de un ultimatum
---------------------------------------------
function calcular_valor_ultimatum(jugador_emisor, tipo_tratado)
  local potencia_militar = get_potencia_militar_relativa(jugador_emisor)
  local nivel_defensivo = get_nivel_defensivo(get_my_id())
  if(nivel_defensivo < NIVEL_MEDIO) then
    potencia_militar = potencia_militar - 1.0
  end
  return potencia_militar*INCREMENTO_POR_POTENCIA_MILITAR*PRECIO_BASE_TRATADOS[tipo_tratado]
end

---------------------------------------------
-- calcula el valor de afinidad politica
---------------------------------------------
function calcular_valor_afinidad_politica(jugador_emisor, tipo_tratado)
  return -get_afinidad_politica_receptor(jugador_emisor)* INCREMENTO_POR_POTENCIA_MILITAR * PRECIO_BASE_TRATADOS[tipo_tratado]
end

--------------------------------------------
-- genera una contra oferta
--------------------------------------------
function generar_contra_oferta(valor_tratado, valor_oferta, mensaje)
  local vr = get_vr()
  local produccion = get_produccion()  
  local incremento = 0.0
  if(valor_tratado < 0.0) then
    incremento = valor_tratado - valor_oferta 
  else
    incremento = 2.0*valor_tratado - valor_oferta
  end
  
  LOG("Se ha decidido contraofertar con un incremento de "..incremento)
  local respuesta = mensaje
  respuesta[MD_INDEX_RECEPTOR] = mensaje[MD_INDEX_EMISOR]
  respuesta[MD_INDEX_EMISOR] = get_my_id()
  respuesta[MD_INDEX_OFERTA_COMIDA] = mensaje[MD_INDEX_INTERCAMBIO_COMIDA]
  respuesta[MD_INDEX_OFERTA_DINERO] = mensaje[MD_INDEX_INTERCAMBIO_DINERO]
  respuesta[MD_INDEX_OFERTA_MATPRIMAS] = mensaje[MD_INDEX_INTERCAMBIO_MATPRIMAS]
  respuesta[MD_INDEX_INTERCAMBIO_COMIDA] = mensaje[MD_INDEX_OFERTA_COMIDA]
  respuesta[MD_INDEX_INTERCAMBIO_DINERO] = mensaje[MD_INDEX_OFERTA_DINERO]
  respuesta[MD_INDEX_INTERCAMBIO_MATPRIMAS] = mensaje[MD_INDEX_OFERTA_MATPRIMAS]
  if(es_compra(mensaje)) then
    respuesta[MD_INDEX_INTERCAMBIO_DINERO] = mensaje[MD_INDEX_OFERTA_DINERO] + incremento*produccion[RC_INDEX_DINERO]/vr[RC_INDEX_DINERO]
  else
    respuesta[MD_INDEX_OFERTA_DINERO] = mensaje[MD_INDEX_INTERCAMBIO_DINERO] - incremento*produccion[RC_INDEX_DINERO]/vr[RC_INDEX_DINERO]
  end
  
  return respuesta
end

--------------------------
-- devuelve true si es una
-- compra de recursos
--------------------------
function es_compra(mensaje)
  assert(mensaje[MD_INDEX_TIPO] == MD_TRATOCOMERCIALESPECIAL)
  
  return mensaje[MD_INDEX_OFERTA_DINERO] > 0 or (mensaje[MD_INDEX_OFERTA_COMIDA] == 0 and mensaje[MD_INDEX_OFERTA_MATPRIMAS] == 0 )
end