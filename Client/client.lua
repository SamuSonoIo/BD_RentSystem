-- Funzione per generare le opzioni del menu basate sui veicoli
function generaOpzioniMenu()
  local opzioni = {}
  for k, v in pairs(Config.Veicoli) do
      table.insert(opzioni, {
          title = v.displayName or k,
          description = string.format('Costo: %d', v.costo),
          icon = 'car',
          onSelect = function()
              TriggerServerEvent('bd:hasoldi', k, v.costo)
          end
      })
  end
  return opzioni
end

-- Registrazione del menu per il noleggio veicoli
lib.registerContext({
  id = 'menu_noleggio',
  title = 'Menù Noleggio',
  options = generaOpzioniMenu()
})

function apriMenuNoleggio()
  lib.showContext('menu_noleggio')
end

RegisterNetEvent('bd:spawnveicolo')
AddEventHandler('bd:spawnveicolo', function(modello)
  local ped = PlayerPedId()
  local coords = GetEntityCoords(ped)
  local vehicleHash = GetHashKey(modello)

  RequestModel(vehicleHash)
  while not HasModelLoaded(vehicleHash) do
      Wait(500)
  end
  local veicoloEsistente = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, vehicleHash, 70)
  if veicoloEsistente then
      DeleteVehicle(veicoloEsistente)
  end
  local vehicle = CreateVehicle(vehicleHash, coords.x, coords.y, coords.z, GetEntityHeading(ped), true, false)
  TaskWarpPedIntoVehicle(ped, vehicle, -1)
  SetModelAsNoLongerNeeded(vehicleHash)
end)

-- Configurazione marker
TriggerEvent('gridsystem:registerMarker', {
    name = 'markernoleggio',
    pos = vector3(Config.PosizioneMarker),
    scale = vector3(0.45, 0.45, 0.45),
    msg = 'NOLEGGIO VEICOLO',
    control = 'E',
    type = 36,
    color = { r = 0, g = 0, b = 0 },
    action = function()
        apriMenuNoleggio()
    end
})
