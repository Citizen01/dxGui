
addEvent("onClientDXClick")
function onClientDXClick( btn, state, X, Y )
	for k, i in ipairs (getAllDxElements()) do
		if dxGetVisible(i) and isCursorOver(i) then
			setElementData(i, "isPressed", state == "down")
			triggerEvent("onClientDXClick", i, btn, state, X, Y)
		end
	end
end
addEventHandler("onClientClick", root, onClientDXClick)

addEvent("onClientDXDoubleClick")
function onClientDXDoubleClick( btn, state, X, Y )
	for k, i in ipairs (getAllDxElements()) do
		if dxGetVisible(i) and isCursorOver(i) then
			triggerEvent("onClientDXDoubleClick", i, btn, state, X, Y)
		end
	end
end
addEventHandler("onClientDoubleClick", root, onClientDXDoubleClick)

--------- TESTS ----------
function test_onClientDXClick(btn, state, X, Y)
	local e = source
	local t = tostring
	outputChatBox("onClientDXClick - src: "..t(getElementType(e))..", btn: "..t(btn)..", state: "..t(state)..", X:"..t(X)..", Y:"..t(Y))
end
-- addEventHandler("onClientDXClick", resourceRoot, test_onClientDXClick)

function test_onClientDXDoubleClick(btn, X, Y)
	local e = source
	local t = tostring
	outputChatBox("onClientDXDoubleClick - src: "..t(getElementType(e))..", btn: "..t(btn)..", X:"..t(X)..", Y:"..t(Y))
end
-- addEventHandler("onClientDXDoubleClick", resourceRoot, test_onClientDXDoubleClick)