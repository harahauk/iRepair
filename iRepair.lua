function GetLowestDurabilityItemAndSlot()
  lowest = 100
  slot = -1
  durmax, durnow = 100
  for c = 0, 19, 1 do
    durmax, durnow = GetInventoryItemDurability(c)
    if durmax then -- Check if it return a nil value
      -- print(durmax.." now "..durnow)
      percent = (durmax / durnow) * 100
      if (percent < lowest) then
        lowest = percent
        slot = c
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
