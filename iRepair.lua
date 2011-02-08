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

--function CalculateRepairCost()
--  print "TO BE IMPLEMETED"
  -- TODO: Implement this placeholder
--end

function SlashCmdList.IREPAIR()
  lowest, slot = GetLowestDurabilityItemAndSlot()
  if slot then
    item_link  = GetInventoryItemLink("Player", GetInventorySlotInfo(slot))
    print("Lowest item is "..item_link.." at "..string.format("%.0f" ,lowest).."% durability.")
  else
    print "All items are at 100% durability."
  end
end

function CreateOptionsFrame()
  irepair = CreateFrame("Frame", "IRepairConfig", InterfaceOptionsFramePanelContainer)
  irepair:Hide()
  irepair.name = "iRepair"
  InterfaceOptions_AddCategory(irepair)

  irepair:SetScript("OnShow", function()

    end)
	local title = irepair:CreateFontString("IRepairConfigTitle", "ARTWORK", "GameFontNormalLarge")
	title:SetPoint("TOPLEFT", 16, -16)
	title:SetText("iRepair")
        
        local sliderlabel = irepair:CreateFontString("IRepairConfigTitle", "ARTWORK", "GameFontNormal")
	sliderlabel:SetPoint("LEFT", 15, 70)
	sliderlabel:SetText("Set the durability treshold for which you want\nconsole spam when entering LFG/group.")

        slider = CreateFrame("Slider", "IRepairConfig", irepair, "OptionsSliderTemplate")
        slider:SetMinMaxValues(0, 100)                                                                                                                     
        slider:SetValue(100)--(IREPAIR_TRESHOLD)
        slider:SetValueStep(1)
        slider:SetScript("OnValueChanged", function(self) getglobal(self:GetName() .. "Text"):SetText(self:GetValue()); IREPAIR_TRESHOLD = self:GetValue()  end) 
        getglobal(slider:GetName() .. "Low"):SetText("0")
        getglobal(slider:GetName() .. "High"):SetText("100")
        getglobal(slider:GetName() .. "Text"):SetText(0)--(IREPAIR_TRESHOLD)
        slider:SetPoint("LEFT", 15, 20) 
end


function IRepair_OnEvent(self, event) --self, event, ...
    if(event == "ADDON_LOADED") then
      LoadSavedVariables()
      VariablesLoaded = True
    end

    if(event == "LFG_UPDATE" and (GetNumPartyMembers() == 0)) then
        lowest, slot = GetLowestDurabilityItemAndSlot()
        if lowest < slider:GetValue() then
            SlashCmdList.IREPAIR()
        end
    end

end

function LoadSavedVariables()
    --Avoid error if you are using the mod for the first time
    if not IREPAIR_TRESHOLD then
        IREPAIR_TRESHOLD = 80
    end
  getglobal(slider:GetName() .. "Text"):SetText(IREPAIR_TRESHOLD)
  slider:SetValue(IREPAIR_TRESHOLD)
end


local function AddEventHandlers()
  local IRepair = CreateFrame("Frame")
  IRepair:RegisterEvent("LFG_UPDATE")
    IRepair:RegisterEvent("ADDON_LOADED")
  IRepair:SetScript("OnEvent", IRepair_OnEvent)
end

function InitIRepair()
  print "Thank you for using iRepair, use /irepair to manually get a durability report."
  CreateOptionsFrame()
  AddEventHandlers()
  SlashCmdList.IREPAIR()
end

SLASH_IREPAIR1 = '/irepair' -- Assign the slash command to a variable
--TRESHOLD = 70

SlashCmdList["SLASH_IREPAIR"] = SlashCmdList.IREPAIR -- Add the variable to slash commands
