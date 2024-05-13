-- Checks if a player is a member of the party
-- Assummes party class
function Party:isPlayerMember(removeMember)
    for _, member in ipairs(self.members) do
        if member == removeMember then
            return true
        end
    end
    return false
end

-- Remove a member from a player's party by name
function removeMemberFromParty(playerId, membername)
    -- Error handling for non-existant player
    local player = Player(playerId)
    if not player then
        return nil, "No player found"
    end

    -- Error handling if player is not in a party
    local party = player:getParty()
    if not party then
        return nil, "No party found"
    end

    -- Error handling if party has no members
    local members = party:getMembers()
    if not members then
        return nil, "No party members"
    end

    -- Determines if player is in the party
    local member = Player(membername)
    if party:isPlayerMember(member) then
        party:removeMember(member)
    else
        print(memberName .. " is not a member")
    end
end

-- Handles the cases where player, party, or members are non-existant by returning with an error.
-- Changed variable names to be more descriptive.
-- Creates function in party class in order to check for member instead of having functionality in removeMemberFromParty.
-- ... This allows for better readability and maintainability.
