-------------------------------
--- dxGui System by Citizen ---
--- File: dxShared.lua		---
-------------------------------

screenWidth, screenHeight = guiGetScreenSize()
----- DebugScript types -----
DBG_CUSTOM = 0
DBG_ERROR = 1
DBG_WARNING = 2
DBG_INFO = 3
-----------------------------
dxTypes = {"dxButton"}
canHoldTextTypes = {"dxButton"}

_G.table.find = function (t, e)
	if type(t) == "table" and #t > 0 then 
		for k, i in ipairs(t) do
			if i == e then return k end
		end
	end
	return nil
end

--[[
_G.table.delete = function (t, e)
	if type(t) == "table" and #t > 0 then 
		for k, i in ipairs(t) do
			if i == e then
				local re = table.remove(t, k)
				return t, re
			end
		end
	end
	return t, nil
end
]] --Something wrong with the table reference I think

function relativeToAbsolute(a, b, parent)
	local rfw, rfh = screenWidth, screenHeight
	if isDXElement(parent) then rfw, rfh = dxGetSize(parent) end
	return a*rfw, b*rfh
end

function absoluteToRelative(a, b, parent)
	local rfw, rfh = screenWidth, screenHeight
	if isDXElement(parent) then rfw, rfh = dxGetSize(parent) end
	return a/rfw, b/rfh
end

function isDXElement(dxe)
	if not dxe then return false end
	return table.find(dxTypes, getElementType(dxe))
end

function canHoldText(dxe)
	return getElementData(dxe, "canHoldText") == true
end

function isPosInElement(dxe, px, py)
	local x, y = dxGetPosition(dxe)
	local w, h = dxGetSize(dxe)
	return px >= x and px <= x+w and py >= y and py <= y+h
end

function isCursorOver(dxe)
	if not isCursorShowing() then return false end
	local mx, my = getCursorPosition()
	mx, my = relativeToAbsolute(mx, my)
	return isPosInElement(dxe, mx, my)
end

function getAllDxElements()
	local elems = {}
	for k, t in ipairs(dxTypes) do 
		for k, i in ipairs(getElementsByType(t)) do
			table.insert(elems, i)
		end
	end
	return elems
end

function dxSetParent(dxe, odxe)
	if isDXElement(dxe) and isDXElement(odxe) then
		return setElementData(dxe, "parent", odxe)
	end
	return false
end

function dxGetParent(dxe)
	return getElementData(dxe, "parent") or nil
end

function dxGetPosition(dxe, rel)
	if rel then
		return getElementData(dxe, "x"), getElementData(dxe, "y")
	else
		return getElementData(dxe, "X"), getElementData(dxe, "Y")
	end
end

function dxSetPosition(dxe, x, y, rel)
	local x, y, X, Y = x, y, x, y
	if rel then
		X, Y = relativeToAbsolute(x, y, dxGetParent(dxe))
	else
		x, y = absoluteToRelative(X, Y, dxGetParent(dxe))
	end
	setElementData(dxe, "x", x); setElementData(dxe, "y", y)
	setElementData(dxe, "X", X); setElementData(dxe, "Y", Y)
end

function dxGetSize(dxe, rel)
	if rel then
		return getElementData(dxe, "w"), getElementData(dxe, "h")
	else
		return getElementData(dxe, "W"), getElementData(dxe, "H")
	end
end

function dxSetSize(dxe, w, h, rel)
	local w, h, W, H = w, h, w, h
	if rel then
		W, H = relativeToAbsolute(w, h, dxGetParent(dxe))
	else
		w, h = absoluteToRelative(W, H, dxGetParent(dxe))
	end
	setElementData(dxe, "w", w); setElementData(dxe, "h", h)
	setElementData(dxe, "W", W); setElementData(dxe, "H", H)
end

function dxSetColor(dxe, r, g, b, a)
	if not isDXElement(dxe) then return end
	setElementData(dxe, "r", r or 255)
	setElementData(dxe, "g", g or 255)
	setElementData(dxe, "b", b or 255)
	setElementData(dxe, "a", a or 255)
	return true
end

function dxGetColor(dxe)
	if not isDXElement(dxe) then return end
	local r = getElementData(dxe, "r") or 255
	local g = getElementData(dxe, "g") or 255
	local b = getElementData(dxe, "b") or 255
	return tocolor(r, g, b, a)
end

function dxSetText(dxe, text)
	if not isDXElement(dxe) then return end
	return setElementData(dxe, "text", text)
end

function dxGetText(dxe)
	if not isDXElement(dxe) then return end
	return getElementData(dxe, "text") or ""
end

function isPressed(dxe)
	return getElementData(dxe, "isPressed")
end

function dxSetVisible(dxe, bool)
	if bool == true then
		setElementData(dxe, "isVisible", bool)
	end
end

function dxGetVisible(dxe)
	return getElementData(dxe, "isVisible")
end