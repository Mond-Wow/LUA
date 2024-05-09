--[[
    Created by Redline (Discord: @mondwow)

    This script automatically exchanges a player's gold for Gold Items after killing a mob if the player possesses over 200k gold.
    For example, if a player has 199k gold and gains an additional 2k gold from looting that mob, their gold will not be converted to items. However, upon killing the next mob, their gold will be exchanged for Gold Items.    
    Mond-Wow utilizes an Auto Loot system. As a result, after killing a mob, gold is instantly added to the player's inventory, enabling the script to operate immediately upon the first kill.


 Mond-wow website -> https://mond-wow.com
 Discord -> https://discord.gg/mond-wow

 feel free to use and share this script
 
]]--


local ITEM_ID = 111111  --Enter you Item ID
local itemCountToAdd = 4 -- Enter the amount of item
local GOLD_THRESHOLD = 2000000000 
local goldToRemove= GOLD_THRESHOLD


local function SendGoldThroughMail(player, goldToRemove)
    local playerGuid1 = player:GetGUIDLow()
    local mailSubject = "Gold Exchange"
    local mailBody = " You've reached the gold threshold. gold has been exchanged for gold items."
    
    -- Send gold through mailbox
    SendMail(mailSubject, mailBody, playerGuid1, 0, 0, 0, 0, 0, ITEM_ID, itemCountToAdd) -- Send gold Item
    player:SendBroadcastMessage("|cffFFA500Your inventory is full! The gold has been sent to you through the mailbox.|r")
end

local function OnPlayerKillCreature(event, killer, killed)
    local gold = killer:GetCoinage()
    
    if gold >= GOLD_THRESHOLD then
        killer:ModifyMoney(-goldToRemove)       
        local success = killer:AddItem(ITEM_ID, itemCountToAdd) -- Attempt to add items
        
        if success then
            -- Remove gold if items added successfully
            killer:SendBroadcastMessage("|cffFFA500You've reached the gold threshold. 200k gold has been exchanged for gold items.|r")
        else
            -- Send gold through mailbox if inventory is full
            SendGoldThroughMail(killer, goldToRemove)
        end
    end
end

RegisterPlayerEvent(7, OnPlayerKillCreature) -- PLAYER_EVENT_ON_KILL_CREATURE

