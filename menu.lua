module( ..., package.seeall )

local storyboard = require "storyboard"

local menu = storyboard.newScene()

local bNewPicture, bPicture, textbNew, textbPicture
local W = display.contentWidth
local H = display.contentHeight

local function trataFoto( event )

	storyboard.gotoScene( "effect" , { effects="fade", time=500, params = { photo=event.target } } )
	storyboard.purgeScene( "menu" )

end

local function selectPicture( event )
	if event.phase == "ended" then
		if event.target.name == "new" then
			media.show( media.Camera, trataFoto )
		elseif event.target.name == "old" then
			media.show( media.PhotoLibray, trataFoto )
		end
	end
	return true
end

function menu:createScene( event )
	bNewPicture = display.newRoundedRect( 0,0,150,40,10 )
	bNewPicture.x = W * 0.5
	bNewPicture.y = H * 0.4
	bNewPicture.name = "new"
	textbNew = display.newText( "Take Picture",bNewPicture.x, bNewPicture.y, nil, 15 )
	textbNew:setFillColor( 0,0,0 )

	bPicture = display.newRoundedRect( 0,0,150,40,10 )
	bPicture.x = W * 0.5
	bPicture.y = H * 0.6
	bPicture.name = "old"
	textbPicture = display.newText( "Picture from...",bPicture.x, bPicture.y, nil, 15 )
	textbPicture:setFillColor( 0,0,0 )

	bNewPicture:addEventListener( "touch", selectPicture )
	bPicture:addEventListener( "touch", selectPicture )

end

function menu:destroyScene( event )
	bNewPicture:removeEventListener( "touch", selectPicture )
	bPicture:removeEventListener( "touch", selectPicture )

	display.remove( bNewPicture )
	bNewPicture = nil

	display.remove( textbNew )
	textbNew = nil

	display.remove( textbPicture )
	textbPicture = nil

	display.remove( bPicture )
	bPicture = nil
end

menu:addEventListener( "createScene", menu )
menu:addEventListener( "destroyScene", menu )

return menu
