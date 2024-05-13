-- Constant for active storage state
local ACTIVE_STORAGE_ID = 1000

-- Releases the storage for player
local function releaseStorage(player)
    player:setStorageValue(ACTIVE_STORAGE_ID, -1)
end

-- Determines if the player should release their storage
local function shouldReleaseStorage(player)
    return player:getStorageValue(ACTIVE_STORAGE_ID) == 1
end

-- Handler for player logging out
function onLogout(player)
    -- Check if player object is valid
    if not player then
        return true
    end

    -- Determine if need to release player storage
    if shouldReleaseStorage(player) then
        addEvent(releaseStorage, ACTIVE_STORAGE_ID, player)
    end
    return true
end

-- Changed the implementation to use a constant for the logout id for better maintainability.
-- Created new function shouldReleaseStorage for better readbility.
-- Depending on implementation, added a check to make sure player is valid before attempting logging out.