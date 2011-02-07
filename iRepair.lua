function GetLowestDurabilityItemAndSlot()
  lowest_slot = nil
  durmax, durnow = nil
  lowest, percent = 100
  slots_to_check = {"HeadSlot", "ShoulderSlot", "ChestSlot", "WristSlot",
    "HandsSlot", "WaistSlot", "LegsSlot", "FeetSlot", "MainHandSlot", "SecondaryHandSlot" }

  for i, slot in ipairs(slots_to_check) do
    durmax, durnow = GetInventoryItemDurability(GetInventorySlotInfo(slot))
    if(durmax and durnow) then -- Check if it return a nil value, happens if no item present
      -- print(slot.." "..durmax.." now "..durnow) -- used for debugging
      percent = (durmax / durnow) * 100
      if (percent < lowest) then
        lowest = percent
        lowest_slot = slot
      end
    end
  end
  return lowest, lowest_slot
end

function CalculateRepairCost()
  print "TO BE IMPLEMETED"
  -- TODO: Implement this placeholder
end

function SlashCmdList.IREPAIR()
  lowest, slot = GetLowestDurabilityItemAndSlot()
  if slot then
    item_link  = GetInventoryItemLink("Player", GetInventorySlotInfo(slot))
    print("Lowest item is "..item_link.." at "..string.format("%.0f" ,lowest).."% durability.")
  else
    print "All items are at 100% durability."
  end
end

function IRepair_OnEvent(self, event) --self, event, ...
  --SlashCmdList.IREPAIR()
  print(event)
  if (event == "LFG_UPDATE") then
   print("Event happened! You joined the queve")
  end
  if (event == "PARTY_INVITE") then
    print "PARTY Invite happened"
  end
  print "function ran atleast"
end

local function AddEventHandlers()
  local IRepair = CreateFrame("Frame")
  --IRepair:RegisterEvent("JoinLFG")
  IRepair:RegisterEvent("LFG_UPDATE") -- WoRKS
  --IRepair:RegisterEvent("LFG_ROLE_CHECK_UPDATE")
  ----IRepair:RegisterEvent("LFG_ROLE_UPDATE")
  IRepair:RegisterEvent("LFG_UPDATE_RANDOM_INFO")
  IRepair:RegisterEvent("PARTY_INVITE")
  IRepair:SetScript("OnEvent", IRepair_OnEvent)
  --print("Listeners set.")
end

function InitIRepair()
  print "iRepair succesfully loaded, use /irepair to manually get a durability report."
  AddEventHandlers()
  SlashCmdList.IREPAIR()
end

SLASH_IREPAIR1 = '/irepair' -- Assign the slash command to a variable
SlashCmdList["SLASH_IREPAIR"] = SlashCmdList.IREPAIR -- Add the variable to slash commands
