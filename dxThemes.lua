-------------------------------
--- dxGui System by Citizen ---
--- File: themes.lua		---
-------------------------------

dxThemes = {}

function loadAllThemes()
	local root = xmlLoadFile("themes.xml")
	if root then
		local childs = xmlNodeGetChildren(root)
		for k, node in ipairs (childs) do
			if xmlNodeGetName(node) == "theme" then
				local name = xmlNodeGetAttribute(node, "name")
				if k == 1 then setElementData(localPlayer, "dxTheme", name) end
				loadTheme(name)
			end
		end
		xmlUnloadFile(root)
	else
		outputDebugString("[DXGUI] Couldn't load themes.xml !", DBG_ERROR)
	end
end
addEventHandler("onClientResourceStart", resourceRoot, loadAllThemes, true, "high")

function loadTheme(tname)
	if not tname then return end
	dxThemes[tname] = {}
	local root = xmlLoadFile("themes/"..tname.."/CGUI.is.xml")
	if root then
		local childs = xmlNodeGetChildren(root)
		for k, node in ipairs (childs) do
			if xmlNodeGetName(node) == "Image" then
				local Name = xmlNodeGetAttribute(node, "Name")
				dxThemes[tname]["img"] = "themes/"..tname.."/CGUI.png"
				dxThemes[tname][Name] = {}
				dxThemes[tname][Name]["x"] = xmlNodeGetAttribute(node, "XPos")
				dxThemes[tname][Name]["y"] = xmlNodeGetAttribute(node, "YPos")
				dxThemes[tname][Name]["w"] = xmlNodeGetAttribute(node, "Width")
				dxThemes[tname][Name]["h"] = xmlNodeGetAttribute(node, "Height")
			end
		end
		xmlUnloadFile(root)
		outputDebugString("[DXGUI] Theme '"..tostring(tname).."' loaded.", DBG_INFO)
	else
		outputDebugString("[DXGUI] Couldn't load imageset for "..tostring(tname).." !", DBG_ERROR)
	end
end