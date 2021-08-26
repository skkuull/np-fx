local ActiveParticles = {}
local BlacklistedParticles = {}

TriggerEvent("particles:player:ready")

RegisterNetEvent("particle:sync:entity")
TriggerClientEvent("particle:sync:entity", function(serverID, targetID, ptDict, ptName, looped, target, bone, position, duration, ptID)
AddEventHandler("particle:sync:entity", TriggerParticalOnEntity)
    local entity = NetworkGetEntityFromNetworkId(target)

    if IsParticleBlacklisted(ptDict, ptName) then return end

    if type(bone) == "table" then
        local particles = {}

        for _, boneName in ipairs(bone) do
            local particle = promise:new()

            Citizen.CreateThread(function()
                local particleHandle = StartParticleOnEntity(ptDict, ptName, looped, entity, boneName, position.offset, position.rot, position.scale, position.alpha, position.color, position.evolution, duration)
                particle:resolve(particleHandle)
            end)

            particles[#particles + 1] = particle
        end

        if not duration and ptID then
            ActiveParticles[ptID] = particles
        end
    else
        local particleHandle = StartParticleOnEntity(ptDict, ptName, looped, entity, bone, position.offset, position.rot, position.scale, position.alpha, position.color, position.evolution, duration)

        if not duration and ptID then
            ActiveParticles[ptID] = particleHandle
        end
    end
end)