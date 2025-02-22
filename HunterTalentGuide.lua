local HunterTalentGuide = CreateFrame("Frame", "HunterTalentGuide", UIParent)
HunterTalentGuide:SetWidth(220)  
HunterTalentGuide:SetHeight(160)
HunterTalentGuide:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
HunterTalentGuide:SetBackdrop({
    bgFile = "Interface/Tooltips/UI-Tooltip-Background",  
    edgeFile = "Interface/Tooltips/UI-Tooltip-Border",    
    tile = true,                                         
    tileSize = 16,                                     
    edgeSize = 16,                                       
    insets = { left = 4, right = 4, top = 4, bottom = 4 } 
})
HunterTalentGuide:SetBackdropColor(0, 0, 0, 0.8)
HunterTalentGuide:SetBackdropBorderColor(1, 1, 1, 1)  
HunterTalentGuide:EnableMouse(true)
HunterTalentGuide:SetMovable(true)
HunterTalentGuide:RegisterForDrag("LeftButton")
HunterTalentGuide:SetScript("OnDragStart", function() HunterTalentGuide:StartMoving() end)
HunterTalentGuide:SetScript("OnDragStop", function() HunterTalentGuide:StopMovingOrSizing() end)

-- Sample talent order (Level -> {Talent Name, Icon Path})
local talentOrder = {
    [10] = {"Endurance Training Rank 1", "Interface\\Icons\\spell_nature_reincarnation"},
    [11] = {"Endurance Training Rank 2", "Interface\\Icons\\spell_nature_reincarnation"},
    [12] = {"Endurance Training Rank 3", "Interface\\Icons\\spell_nature_reincarnation"},
    [13] = {"Endurance Training Rank 4", "Interface\\Icons\\spell_nature_reincarnation"},
    [14] = {"Endurance Training Rank 5", "Interface\\Icons\\spell_nature_reincarnation"},
    [15] = {"Thick Hide Rank 1", "Interface\\Icons\\inv_misc_pelt_bear_03"},
    [16] = {"Thick Hide Rank 2", "Interface\\Icons\\inv_misc_pelt_bear_03"},
    [17] = {"Thick Hide Rank 3", "Interface\\Icons\\inv_misc_pelt_bear_03"},
    [18] = {"Improved Revive Pet Rank 1", "Interface\\Icons\\ability_hunter_beastsoothe"},
    [19] = {"Improved Revive Pet Rank 2", "Interface\\Icons\\ability_hunter_beastsoothe"},
    [20] = {"Pathfinding Rank 1", "Interface\\Icons\\ability_mount_jungletiger"},
    [21] = {"Pathfinding Rank 2", "Interface\\Icons\\ability_mount_jungletiger"},
    [22] = {"Bestial Swiftness", "Interface\\Icons\\ability_druid_dash"},
    [23] = {"Unleashed Fury Rank 1", "Interface\\Icons\\ability_bullrush"},
    [24] = {"Unleashed Fury Rank 2", "Interface\\Icons\\ability_bullrush"},
    [25] = {"Unleashed Fury Rank 3", "Interface\\Icons\\ability_bullrush"},
    [26] = {"Unleashed Fury Rank 4", "Interface\\Icons\\ability_bullrush"},
    [27] = {"Unleashed Fury Rank 5", "Interface\\Icons\\ability_bullrush"},
    [28] = {"Ferocity Rank 1", "Interface\\Icons\\inv_misc_monsterclaw_04"},
    [29] = {"Ferocity Rank 2", "Interface\\Icons\\inv_misc_monsterclaw_04"},
    [30] = {"Intimidation", "Interface\\Icons\\ability_hunter_beastsoothe"},
    [31] = {"Ferocity Rank 3", "Interface\\Icons\\inv_misc_monsterclaw_04"},
    [32] = {"Ferocity Rank 4", "Interface\\Icons\\inv_misc_monsterclaw_04"},
    [33] = {"Ferocity Rank 5", "Interface\\Icons\\inv_misc_monsterclaw_04"},
    [34] = {"Improved Mend Pet Rank 1", "Interface\\Icons\\ability_hunter_mendpet"},
    [35] = {"Frenzy Rank 1", "Interface\\Icons\\inv_misc_monsterclaw_03"},
    [36] = {"Frenzy Rank 2", "Interface\\Icons\\inv_misc_monsterclaw_03"},
    [37] = {"Frenzy Rank 3", "Interface\\Icons\\inv_misc_monsterclaw_03"},
    [38] = {"Frenzy Rank 4", "Interface\\Icons\\inv_misc_monsterclaw_03"},
    [39] = {"Frenzy Rank 5", "Interface\\Icons\\inv_misc_monsterclaw_03"},
    [40] = {"Bestial Wrath", "Interface\\Icons\\ability_druid_ferociousbite"},
    [41] = {"Efficiency Rank 1", "Interface\\Icons\\spell_frost_wizardmark"},
    [42] = {"Efficiency Rank 2", "Interface\\Icons\\spell_frost_wizardmark"},
    [43] = {"Efficiency Rank 3", "Interface\\Icons\\spell_frost_wizardmark"},
    [44] = {"Efficiency Rank 4", "Interface\\Icons\\spell_frost_wizardmark"},
    [45] = {"Efficiency Rank 5", "Interface\\Icons\\spell_frost_wizardmark"},
    [46] = {"Lethal Shots Rank 1", "Interface\\Icons\\ability_searingarrow"},
    [47] = {"Lethal Shots Rank 2", "Interface\\Icons\\ability_searingarrow"},
    [48] = {"Lethal Shots Rank 3", "Interface\\Icons\\ability_searingarrow"},
    [49] = {"Lethal Shots Rank 4", "Interface\\Icons\\ability_searingarrow"},
    [50] = {"Lethal Shots Rank 5", "Interface\\Icons\\ability_searingarrow"},
    [51] = {"Aimed Shot", "Interface\\Icons\\inv_spear_07"},
    [52] = {"Hawk Eye Rank 1", "Interface\\Icons\\ability_townwatch"},
    [53] = {"Hawk Eye Rank 2", "Interface\\Icons\\ability_townwatch"},
    [54] = {"Hawk Eye Rank 3", "Interface\\Icons\\ability_townwatch"},
    [55] = {"Improved Hunter's Mark", "Interface\\Icons\\ability_hunter_snipershot"},
    [56] = {"Mortal Shots Rank 1", "Interface\\Icons\\ability_piercedamage"},
    [57] = {"Mortal Shots Rank 2", "Interface\\Icons\\ability_piercedamage"},
    [58] = {"Mortal Shots Rank 3", "Interface\\Icons\\ability_piercedamage"},
    [59] = {"Mortal Shots Rank 4", "Interface\\Icons\\ability_piercedamage"},
    [60] = {"Mortal Shots Rank 5", "Interface\\Icons\\ability_piercedamage"},
}

local function UpdateTalentDisplay()
    local level = UnitLevel("player")
    
    for i = 1, 3 do
        local talentLevel = level + (i - 1)
        local talentInfo = talentOrder[talentLevel]
        
        if talentInfo then
            local talentName, iconPath = unpack(talentInfo)
            
            if not HunterTalentGuide["Talent" .. i] then
                local talentFrame = CreateFrame("Frame", nil, HunterTalentGuide)
                talentFrame:SetWidth(190)
                talentFrame:SetHeight(30)
                talentFrame:SetPoint("TOP", HunterTalentGuide, "TOP", 0, -((i - 1) * 35))

                local levelText = talentFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
                levelText:SetPoint("LEFT", talentFrame, "LEFT", 0, -20)
                levelText:SetText("lvl " .. talentLevel .. " :")

                local icon = talentFrame:CreateTexture(nil, "ARTWORK")
                icon:SetWidth(30)
                icon:SetHeight(30)
                icon:SetPoint("LEFT", levelText, "RIGHT", 5, -5)
                icon:SetTexture(iconPath)

                local text = talentFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
                text:SetPoint("LEFT", icon, "RIGHT", 8, 0)  
                text:SetWidth(120)  
                text:SetJustifyH("LEFT")
                text:SetText(talentName)

                talentFrame.levelText = levelText
                talentFrame.icon = icon
                talentFrame.text = text
                HunterTalentGuide["Talent" .. i] = talentFrame
            else
                local talentFrame = HunterTalentGuide["Talent" .. i]
                talentFrame.levelText:SetText("lvl " .. talentLevel .. " :")
                talentFrame.icon:SetTexture(iconPath)
                talentFrame.text:SetText(talentName)
            end
        end
    end
end

-- Event handling for level-up updates
HunterTalentGuide:RegisterEvent("PLAYER_LEVEL_UP")
HunterTalentGuide:RegisterEvent("PLAYER_ENTERING_WORLD")
HunterTalentGuide:SetScript("OnEvent", function(self, event, ...) 
    UpdateTalentDisplay()
    if event == "PLAYER_LEVEL_UP" or event == "PLAYER_ENTERING_WORLD" then
        UpdateTalentDisplay()
    end 
end)

-- Initial update
UpdateTalentDisplay()
