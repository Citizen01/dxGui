-------------------------------
--- dxGui System by Citizen ---
--- File: dxButton.lua		---
-------------------------------

function dxCreateButton(x, y, w, h, txt, relative, parent)
	if not (x and y and w and h) then
		outputDebugString("[DXGUI] dxCreateButton function needs at least 4 parameters.")
		return
	end
	if not txt then txt = "" end
	if relative == nil then relative = false end

	local dxe = createElement("dxButton")
	setElementData(dxe, "x", x)
	setElementData(dxe, "y", y)
	setElementData(dxe, "w", w)
	setElementData(dxe, "h", h)
	setElementData(dxe, "text", txt)
	setElementData(dxe, "relative", relative)
	if parent then 
		setElementData(dxe, "parent", parent)
		setElementParent(dxe, parent)
	end
	setElementData(dxe, "renderer", "renderButton")
end

function renderButton(dxe)
	local t = dxThemes[getElementData(localPlayer, "dxTheme") or "Default"]
	local x, y = getElementData(dxe, "x", x), getElementData(dxe, "y", y)
	local w, h = getElementData(dxe, "w", w), getElementData(dxe, "h", h)
	local relative = getElementData(dxe, "relative")
	local parent = getElementData(dxe, "parent")

	if relative and not parent then
		x, y = relativeToAbsolute(x, y)
		w, h = relativeToAbsolute(w, h)
	end

	local topLeft, topRight = t.Frame2TopLeft, t.Frame2TopRight
	local bottomLeft, bottomRight = t.Frame2BottomLeft, t.Frame2BottomRight
	local sideLeft, sideRight = t.Frame2Left, t.Frame2Right
	local sideTop, sideBottom = t.Frame2Top, t.Frame2Bottom
	local bckgrnd = t.Frame2Background

	local color = tocolor(255, 255, 255) -- mouse over
	color = tocolor(80, 80, 80) -- mouse out
	
	-- outputChatBox("("..x..", "..y..", "..topLeft.w..", "..topLeft.h..", "..topLeft.x..", "..topLeft.y..", "..topLeft.w..", "..topLeft.h..", "..t.img..")")
	
	-- corners
	-- TL
	dxDrawImageSection(x, y, topLeft.w, topLeft.h, topLeft.x, topLeft.y, topLeft.w, topLeft.h, t.img, 0, 0, 0, color)
	-- TR
	dxDrawImageSection(x+w-topRight.w, y, topRight.w, topRight.h, topRight.x, topRight.y, topRight.w, topRight.h, t.img, 0, 0, 0, color)
	-- BL
	dxDrawImageSection(x, y+h-bottomLeft.h, bottomLeft.w, bottomLeft.h, bottomLeft.x, bottomLeft.y, bottomLeft.w, bottomLeft.h, t.img, 0, 0, 0, color)
	-- BR
	dxDrawImageSection(x+w-topRight.w, y+h-bottomRight.h, bottomRight.w, bottomRight.h, bottomRight.x, bottomRight.y, bottomRight.w, bottomRight.h, t.img, 0, 0, 0, color)

	-- sides
	-- SL
	dxDrawImageSection(x, y+topLeft.h, sideLeft.w, h-topLeft.h-bottomLeft.h, sideLeft.x, sideLeft.y, sideLeft.w, sideLeft.h, t.img, 0, 0, 0, color)
	-- ST
	dxDrawImageSection(x+topLeft.w, y, w-topLeft.w-topRight.h, sideTop.h, sideTop.x, sideTop.y, sideTop.w, sideTop.h, t.img, 0, 0, 0, color)
	-- SR
	dxDrawImageSection(x+w-topRight.w, y+topRight.h, sideRight.w, h-topRight.h-bottomRight.h, sideRight.x, sideRight.y, sideRight.w, sideRight.h, t.img, 0, 0, 0, color)
	-- SB
	dxDrawImageSection(x+topLeft.w, y+h-bottomLeft.h, w-topLeft.w-topRight.h, sideBottom.h, sideBottom.x, sideBottom.y, sideBottom.w, sideBottom.h, t.img, 0, 0, 0, color)

	-- background
	dxDrawImageSection(x+topLeft.w, y+topLeft.h, w-topLeft.w-topRight.h, h-topRight.h-bottomRight.h, bckgrnd.x, bckgrnd.y, bckgrnd.w, bckgrnd.h, t.img, 0, 0, 0, color)
end


------------------- TEST -------------------

addEventHandler("onClientResourceStart", resourceRoot,
function ()
	dxCreateButton(0.5, 0.5, 0.1, 0.1, "", true)
	guiCreateButton(0.6, 0.5, 0.1, 0.1, "", true)
end)