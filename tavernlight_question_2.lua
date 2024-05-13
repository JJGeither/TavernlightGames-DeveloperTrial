-- Print names of guilds with less than memberCount members
function printSmallGuildNames(memberCount)
    -- Query to select guilds with max members less than specified count
    local selectGuildQuery = "SELECT name FROM guilds WHERE max_members < %d;"
    local resultSet = db.storeQuery(string.format(selectGuildQuery, memberCount))

    -- Iterates through results to print names of guilds
    if resultSet then
        print("Guilds with less than " .. memberCount .. " members:")
        while resultSet:next() do
            local guildName = resultSet:getString("name")
            print(guildName)
        end
    else
        print("No results found.")
    end

    -- Close the database connection
    resultSet:close()
end

-- Return from database assumes one reult, modified it to print out every guild name along with descriptive print beforehand.
-- Closes the database connection to prevent any malicious or accidental SQL injection.
-- Handles the event of no guilds returning.