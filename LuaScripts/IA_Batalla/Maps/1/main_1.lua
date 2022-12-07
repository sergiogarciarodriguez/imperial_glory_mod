-- "London" Map

log("Now loading London Map");

local iObjMapID = 0;
if is_total_victory() then
  iObjMapID = 21;
end;

--change_ConquestZone_FeaturesRadius(20000);
--log("ConquesZone Features Radius changed to 20000");

-- No queremos que salga a por el enemigo
change_ConquestZone_DetectOpportunities( false );
log("Disabling ConquestZone_DetectOpportunities Feature");

-- Creamos algún interés de zona estratégica y eso...
log("Creating strategic zone interests:");

create_StrategicZoneInterest(1, 23500.0, 38250.0, 225.0, true, false, true, iObjMapID); -- por poner algo... es para probar qué tal
log("  - First strategic zone: pos = (25000.0, 25000.0), pri = 1, inf = true, cav = false, art = true");

--create_StrategicZoneInterest(2, 23750.0, 42500.0, 270.0, true, true, false, iObjMapID); -- por poner algo... es para probar qué tal
create_StrategicZoneInterest(2, 21000.0, 42500.0, 270.0, true, true, false, iObjMapID); -- por poner algo... es para probar qué tal
log("  - First strategic zone: pos = (25000.0, 25000.0), pri = 1, inf = true, cav = false, art = true");

create_StrategicZoneInterest(3, 46000.0, 43500.0, 135.0, true, false, true, iObjMapID); -- por poner algo... es para probar qué tal
log("  - First strategic zone: pos = (25000.0, 25000.0), pri = 1, inf = true, cav = false, art = true");

--------------------------------------------------------------------------

-----------------------------------------------
-- No queremos que se haga ningún puente
-----------------------------------------------
function evaluate_resources_PU(interest, free_res, extra_res, busy_res)

  return false;
  
end