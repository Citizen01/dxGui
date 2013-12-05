-------------------------------
--- dxGui System by Citizen ---
--- File: dxShared.lua		---
-------------------------------

screenWidth, screenHeight = guiGetScreenSize()
DBG_CUSTOM = 0
DBG_ERROR = 1
DBG_WARNING = 2
DBG_INFO = 3

function relativeToAbsolute(x, y)
	return x*screenWidth, y*screenHeight
end

function getAllDxElems()
	local elems = {}
	local dxTypes = {"dxButton"}
	for k, t in ipairs(dxTypes) do 
		for k, i in ipairs(getElementsByType(t)) do
			-- outputChatBox(tostring(i))
			table.insert(elems, i)
		end
	end
	return elems
end