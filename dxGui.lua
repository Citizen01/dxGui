-------------------------------
--- dxGui System by Citizen ---
--- File: dxGui.lua			---
-------------------------------

function renderEverything()
	local dxElems = getAllDxElems()
	for k, e in ipairs(dxElems) do
		local f = _G[getElementData(e, "renderer")]
		if f and type(f) == "function" then f(e) end
	end
end
addEventHandler("onClientRender", root, renderEverything)