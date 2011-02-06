function GetLowestDurabilityItemAndSlot()
  lowest = 100
  lowest_slot = -1
  durmax, durnow = 100
  slots_to_check = {"HeadSlot", "ShoulderSlot", "ChestSlot", "WristSlot",
    "HandsSlot", "WaistSlot", "LegsSlot", "FeetSlot", "MainHandSlot", "SecondaryHandSlot" }

  for i, slot in ipairs(slots_to_check) do
    durmax, durnow = GetInventoryItemDurability(GetInventorySlotInfo(slot))
    if durmax then -- Check if it return a nil value, happens if no item
      print(durmax.." now "..durnow)
      percent = (durmax / durnow) * 100
      if (percent < lowest) then
        lowest = percent
        lowest_slot = slot
      end
    end
  end
  return lowest, slot
end

function CalculateRepairCost()
  print "TO BE IMPLEMETED"
  -- TODO: Implement this placeholder
end

function SlashCmdList.IREPAIR()
  lowest, slot = GetLowestDurabilityItemAndSlot()

  if (slot > -1) then
    print("Lowest item has "..lowest.."%")
    print(slot)
  else
    print "All items are at 100%"
  end
end




SLASH_IREPAIR1 = '/irepair' -- Assign the slash command to a variable
SlashCmdList["SLASH_IREPAIR"] = SlashCmdList.IREPAIR -- Add the variable to slash commands
