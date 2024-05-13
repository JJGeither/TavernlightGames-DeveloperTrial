// Add an item to a player, handling memory properly
void Game::addItemToPlayer(const std::string& recipient, uint16_t itemId)
{
    Player* player = g_game.getPlayerByName(recipient);
    bool playerAllocated = false;
    if (!player) {
        player = new Player(nullptr);
        playerAllocated = true;
        if (!IOLoginData::loadPlayerByName(player, recipient)) {
            delete player; // Clean up if loading failed
            return;
        }
    }

    Item* item = Item::CreateItem(itemId);
    if (!item) {
        if (playerAllocated) { // Clean up player if item creation failed
            delete player;
        }
        return;
    }

    g_game.internalAddItem(player->getInbox(), item, INDEX_WHEREEVER, FLAG_NOLIMIT);

    if (player->isOffline()) {
        IOLoginData::savePlayer(player);
    } else {
        if (playerAllocated) { // Clean up if player is not offline
            delete player;
        }
    }
}

// Code initally ran into issue where attempting to delete a non-heap player object.
// This could cause adverse effects where delete is called twice for the player object, causing issues or crashes.
// The variable playerAllocated prevents this memory issue by checking if dynamically allocated before deleting.