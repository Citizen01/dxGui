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
	if relative ~= true then relative = false end

	local dxe = createElement("dxButton")
	dxSetPosition(dxe, x, y, relative)
	dxSetSize(dxe, w, h, relative)
	dxSetText(dxe, txt)
	setElementData(dxe, "relative", relative)
	dxSetVisible(dxe, true)
	if parent then 
		dxSetParent(dxe, "parent", parent)
		dxSetVisible(dxe, dxGetVisible(dxe))
	end

	setElementData(dxe, "renderer", "renderButton")
end

function renderButton(dxe)
	local t = dxThemes[getElementData(localPlayer, "dxTheme") or "Default"]
	local x, y = dxGetPosition(dxe)
	local w, h = dxGetSize(dxe)
	local parent = getElementData(dxe, "parent")

	local topLeft, topRight = t.Frame2TopLeft, t.Frame2TopRight
	local bottomLeft, bottomRight = t.Frame2BottomLeft, t.Frame2BottomRight
	local sideLeft, sideRight = t.Frame2Left, t.Frame2Right
	local sideTop, sideBottom = t.Frame2Top, t.Frame2Bottom
	local bckgrnd = t.Frame2Background

	local btnColor = tocolor(100, 100, 100) -- mouse out
	local txtcolor = tocolor(100, 100, 100)

	if isCursorOver(dxe) then
		btnColor = tocolor(255, 255, 255)
		if not isPressed(dxe) then
			txtcolor = tocolor(255, 255, 255)
		end
	end
	
	-- outputChatBox("("..x..", "..y..", "..topLeft.w..", "..topLeft.h..", "..topLeft.x..", "..topLeft.y..", "..topLeft.w..", "..topLeft.h..", "..t.img..")")
	
	-- corners
	-- TL
	dxDrawImageSection(x, y, topLeft.w, topLeft.h, topLeft.x, topLeft.y, topLeft.w, topLeft.h, t.img, 0, 0, 0, btnColor)
	-- TR
	dxDrawImageSection(x+w-topRight.w, y, topRight.w, topRight.h, topRight.x, topRight.y, topRight.w, topRight.h, t.img, 0, 0, 0, btnColor)
	-- BL
	dxDrawImageSection(x, y+h-bottomLeft.h, bottomLeft.w, bottomLeft.h, bottomLeft.x, bottomLeft.y, bottomLeft.w, bottomLeft.h, t.img, 0, 0, 0, btnColor)
	-- BR
	dxDrawImageSection(x+w-topRight.w, y+h-bottomRight.h, bottomRight.w, bottomRight.h, bottomRight.x, bottomRight.y, bottomRight.w, bottomRight.h, t.img, 0, 0, 0, btnColor)

	-- sides
	-- SL
	dxDrawImageSection(x, y+topLeft.h, sideLeft.w, h-topLeft.h-bottomLeft.h, sideLeft.x, sideLeft.y, sideLeft.w, sideLeft.h, t.img, 0, 0, 0, btnColor)
	-- ST
	dxDrawImageSection(x+topLeft.w, y, w-topLeft.w-topRight.h, sideTop.h, sideTop.x, sideTop.y, sideTop.w, sideTop.h, t.img, 0, 0, 0, btnColor)
	-- SR
	dxDrawImageSection(x+w-topRight.w, y+topRight.h, sideRight.w, h-topRight.h-bottomRight.h, sideRight.x, sideRight.y, sideRight.w, sideRight.h, t.img, 0, 0, 0, btnColor)
	-- SB
	dxDrawImageSection(x+topLeft.w, y+h-bottomLeft.h, w-topLeft.w-topRight.h, sideBottom.h, sideBottom.x, sideBottom.y, sideBottom.w, sideBottom.h, t.img, 0, 0, 0, btnColor)

	-- background
	dxDrawImageSection(x+topLeft.w, y+topLeft.h, w-topLeft.w-topRight.h, h-topRight.h-bottomRight.h, bckgrnd.x, bckgrnd.y, bckgrnd.w, bckgrnd.h, t.img, 0, 0, 0, btnColor)

	-- text
	local text = dxGetText(dxe, "text") or ""
	dxDrawText(text, x+sideLeft.w, y+sideTop.h, x+w-sideRight.w, y+h-sideBottom.h, txtcolor, 1, "default", "center", "center", true )
end


------------------- TEST -------------------

addEventHandler("onClientResourceStart", resourceRoot,
function ()
	dxCreateButton(0.5, 0.5, 0.1, 0.1, "test", true)
	guiCreateButton(0.6, 0.5, 0.1, 0.1, "test", true)
	showCursor(true)
end)