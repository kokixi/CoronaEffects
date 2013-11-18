module( ..., package.seeall )

local storyboard = require "storyboard"

local effect = storyboard.newScene()

local W = display.contentWidth
local H = display.contentHeight

local imageStars
local imageStars2

local photo
local photo2
local group
local y,x
local moved = false
local l1Cuad, l2Cuad, l1, l2
local effectEnabled = "none"
local effects = {}
local scale = 1
local p1 = 1
local p2 = 1
local p3 = 1
local p4 = 1
local p5 = 1
local p6 = 1
local n = 1
local back

local valueExposure = 0
local valueSwirl = 0

local mod1 = false

local effectsApplied = {}
local effectDeleted = "b0"
local savedP = false

local mainGroup = display.newGroup()

local function changeSwirl( event )
	if event.phase == "began" then
		display.getCurrentStage():setFocus(event.target)
	end
	if event.phase == "moved" then
		if event.target.x < W*0.8 and event.x > event.target.x then
			event.target.x = event.x
			photo.fill.effect.intensity = ( event.x-W*0.3 )/( ( W*0.5 )/4 )
		elseif event.target.x > W*0.3 and event.x < event.target.x then
			event.target.x = event.x
			photo.fill.effect.intensity = ( event.x-W*0.3 )/( ( W*0.5 )/4 )
		end
		valueSwirl = ( event.x-W*0.3 )/( ( W*0.5 )/4 )
	end
	if event.phase == "ended" then
		display.getCurrentStage():setFocus(nil)
	end
	return true
end

local valueHue = 0

local function changeHue( event )
	if event.phase == "began" then
		display.getCurrentStage():setFocus(event.target)
	end
	if event.phase == "moved" then
		if event.target.x < W*0.8 and event.x > event.target.x then
			event.target.x = event.x
			photo.fill.effect.angle = ( event.x-W*0.3 )/( ( W*0.5 )/320 )
		elseif event.target.x > W*0.3 and event.x < event.target.x then
			event.target.x = event.x
			photo.fill.effect.angle = ( event.x-W*0.3 )/( ( W*0.5 )/320 )
		end
		valueHue = ( event.x-W*0.3 )/( ( W*0.5 )/320 )
	end
	if event.phase == "ended" then
		display.getCurrentStage():setFocus(nil)
	end
	return true
end

local valueEmboss = 1

local function changeEmboss( event )
	if event.phase == "began" then
		display.getCurrentStage():setFocus(event.target)
	end
	if event.phase == "moved" then
		if event.target.x < W*0.8 and event.x > event.target.x then
			event.target.x = event.x
			photo.fill.effect.intensity = ( event.x-W*0.3 )/( ( W*0.5 )/4 )
		elseif event.target.x > W*0.3 and event.x < event.target.x then
			event.target.x = event.x
			photo.fill.effect.intensity = ( event.x-W*0.3 )/( ( W*0.5 )/4 )
		end
		valueEmboss = ( event.x-W*0.3 )/( ( W*0.5 )/4 )
	end
	if event.phase == "ended" then
		display.getCurrentStage():setFocus(nil)
	end
	return true
end

local valueContrast = 1

local function changeContrast( event )
	if event.phase == "began" then
		display.getCurrentStage():setFocus(event.target)
	end
	if event.phase == "moved" then
		if event.target.x < W*0.8 and event.x > event.target.x then
			event.target.x = event.x
			photo.fill.effect.contrast = ( event.x-W*0.3 )/( ( W*0.5 )/4 )
		elseif event.target.x > W*0.3 and event.x < event.target.x then
			event.target.x = event.x
			photo.fill.effect.contrast = ( event.x-W*0.3 )/( ( W*0.5 )/4 )
		end
		valueContrast = ( event.x-W*0.3 )/( ( W*0.5 )/4 )
	end
	if event.phase == "ended" then
		display.getCurrentStage():setFocus(nil)
	end
	return true
end

local valueSepia = 1

local function changeSepia( event )
	if event.phase == "began" then
		display.getCurrentStage():setFocus(event.target)
	end
	if event.phase == "moved" then
		if event.target.x < W*0.8 and event.x > event.target.x then
			event.target.x = event.x
			photo.fill.effect.intensity = ( event.x-W*0.3 )/( ( W*0.5 ) )
		elseif event.target.x > W*0.3 and event.x < event.target.x then
			event.target.x = event.x
			photo.fill.effect.intensity = ( event.x-W*0.3 )/( ( W*0.5 ) )
		end
		valueSepia = ( event.x-W*0.3 )/( ( W*0.5 ) )
	end
	if event.phase == "ended" then
		display.getCurrentStage():setFocus(nil)
	end
	return true
end

local valueVignette = 0.1

local function changeVignete( event )
	if event.phase == "began" then
		display.getCurrentStage():setFocus(event.target)
	end
	if event.phase == "moved" then
		if event.target.x < W*0.8 and event.x > event.target.x then
			event.target.x = event.x
			photo.fill.effect.radius = ( event.x-W*0.3 )/( ( W*0.5 )/0.9 )
		elseif event.target.x > W*0.3 and event.x < event.target.x then
			event.target.x = event.x
			photo.fill.effect.radius = ( event.x-W*0.3 )/( ( W*0.5 )/0.9 )
		end
		valueVignette = ( event.x-W*0.3 )/( ( W*0.5 )/0.9 )
	end
	if event.phase == "ended" then
		display.getCurrentStage():setFocus(nil)
	end
	return true
end

local valuePixelate = 4

local function changePixelate( event )
	if event.phase == "began" then
		display.getCurrentStage():setFocus(event.target)
	end
	if event.phase == "moved" then
		if event.target.x < W*0.8 and event.x > event.target.x then
			event.target.x = event.x
			photo.fill.effect.numPixels = ( event.x-W*0.3 )/( ( W*0.5 )/50 )
		elseif event.target.x > W*0.3 and event.x < event.target.x then
			event.target.x = event.x
			photo.fill.effect.numPixels = ( event.x-W*0.3 )/( ( W*0.5 )/50 )
		end
		valuePixelate = ( event.x-W*0.3 )/( ( W*0.5 )/50 )
	end
	if event.phase == "ended" then
		display.getCurrentStage():setFocus(nil)
	end
	return true
end

local duotoneBlue = {0,0,0.5}
local duotoneRed = {0.5,0,0}

local function changeDuotone( event )
	if event.phase == "began" then
		display.getCurrentStage():setFocus(event.target)
	end
	if event.phase == "moved" then
		if event.target.name == "l1" then
			if event.target.x < W*0.8 and event.x > event.target.x then
				event.target.x = event.x
				photo.fill.effect.darkColor = { 0,0, ( event.x-W*0.3 )/( ( W*0.5 ) ),1 }
			elseif event.target.x > W*0.3 and event.x < event.target.x then
				event.target.x = event.x
				photo.fill.effect.darkColor = { 0,0, ( event.x-W*0.3 )/( ( W*0.5 ) ),1 }
			end
			duotoneBlue = { 0,0, ( event.x-W*0.3 )/( ( W*0.5 ) ),1 }
		end
		if event.target.name == "l2" then
			if event.target.x < W*0.8 and event.x > event.target.x then
				event.target.x = event.x
				photo.fill.effect.lightColor = { ( event.x-W*0.3 )/( ( W*0.5 ) ),0, 0,1 }
			elseif event.target.x > W*0.3 and event.x < event.target.x then
				event.target.x = event.x
				photo.fill.effect.lightColor = { ( event.x-W*0.3 )/( ( W*0.5 ) ),0, 0,1 }
			end
			duotoneRed = { ( event.x-W*0.3 )/( ( W*0.5 ) ),0, 0,1 }
		end
	end
	if event.phase == "ended" then
		display.getCurrentStage():setFocus(nil)
	end
	return true
end

local valueDesaturate = 0.5

local function changeDesaturate( event )
	if event.phase == "began" then
		display.getCurrentStage():setFocus(event.target)
	end
	if event.phase == "moved" then
		if event.target.name == "l1" then
			if event.target.x < W*0.8 and event.x > event.target.x then
				event.target.x = event.x

				photo.fill.effect.intensity = ( event.x-W*0.3 )/( ( W*0.5 ) )
			elseif event.target.x > W*0.3 and event.x < event.target.x then
				event.target.x = event.x
				photo.fill.effect.intensity = ( event.x-W*0.3 )/( ( W*0.5 ) )
			end
			valueDesaturate = ( event.x-W*0.3 )/( ( W*0.5 ) )
		end
	end
	if event.phase == "ended" then
		display.getCurrentStage():setFocus(nil)
	end
	return true
end

local valueSaturate = 1

local function changeSaturate( event )
	if event.phase == "began" then
		display.getCurrentStage():setFocus(event.target)
	end
	if event.phase == "moved" then
		if event.target.name == "l1" then
			if event.target.x < W*0.8 and event.x > event.target.x then
				event.target.x = event.x
				photo.fill.effect.intensity = ( event.x-W*0.3 )/( ( W*0.5 )/8 )
			elseif event.target.x > W*0.3 and event.x < event.target.x then
				event.target.x = event.x
				photo.fill.effect.intensity = ( event.x-W*0.3 )/( ( W*0.5 )/8 )
			end
			valueSaturate = ( event.x-W*0.3 )/( ( W*0.5 )/8 )
		end
	end
	if event.phase == "ended" then
		display.getCurrentStage():setFocus(nil)
	end
	return true
end

local function changeExposure( event )
	if event.phase == "began" then
		display.getCurrentStage():setFocus(event.target)
	end
	if event.phase == "moved" then
		if event.target.name == "l1" then
			if event.target.x < W*0.8 and event.x > event.target.x then
				event.target.x = event.x
				photo.fill.effect.exposure = ( event.x-W*0.55 )/( ( W*0.25 )/10 )
			elseif event.target.x > W*0.3 and event.x < event.target.x then
					event.target.x = event.x
					photo.fill.effect.exposure = ( event.x-W*0.55 )/( ( W*0.25 )/10 )
			end
			valueExposure = ( event.x-W*0.55 )/( ( W*0.25 )/10 )
		end
	end
	if event.phase == "ended" then
		display.getCurrentStage():setFocus(nil)
	end
	return true
end

local valueTile = 8

local function changeopTile( event )
	if event.phase == "began" then
		display.getCurrentStage():setFocus(event.target)
	end
	if event.phase == "moved" then
		if event.target.x < W*0.8 and event.x > event.target.x then
			event.target.x = event.x
			photo.fill.effect.numPixels = (event.x - W*0.3)
			valueTile = (event.x - W*0.3)
		elseif event.target.x > W*0.3 and event.x < event.target.x then
			event.target.x = event.x
			if (event.x - W*0.3) > 0 then
				photo.fill.effect.numPixels = (event.x - W*0.3)
				valueTile = (event.x - W*0.3)
			end
		end
	end
	if event.phase == "ended" then
		display.getCurrentStage():setFocus(nil)
	end
	return true
end


local function remove( )
	if l1Cuad then
		if effectEnabled == "swirl" then
			l1Cuad:removeEventListener( "touch", changeSwirl )
		end
		if effectEnabled == "sepia" then
			l1Cuad:removeEventListener( "touch", changeSepia )
		end
		if effectEnabled == "hue" then
			l1Cuad:removeEventListener( "touch", changeHue )
		end
		if effectEnabled == "emboss" then
			l1Cuad:removeEventListener( "touch", changeEmboss )
		end
		if effectEnabled == "contrast" then
			l1Cuad:removeEventListener( "touch", changeContrast )
		end
		if effectEnabled == "bulge" then
			l1Cuad:removeEventListener( "touch", changeBulge )
		end
		if effectEnabled == "duotone" then
			l1Cuad:removeEventListener( "touch", changeDuotone )
		end
		if effectEnabled == "vignette" then
			l1Cuad:removeEventListener( "touch", changeVignete )
		end
		if effectEnabled == "pixelate" then
			l1Cuad:removeEventListener( "touch", changePixelate )
		end
		if effectEnabled == "desaturate" then
			l1Cuad:removeEventListener( "touch", changeDesaturate )
		end
		if effectEnabled == "saturate" then
			l1Cuad:removeEventListener( "touch", changeSaturate )
		end
		if effectEnabled == "exposure" then
			l1Cuad:removeEventListener( "touch", changeExposure )
		end
		if effectEnabled == "opTile" then
			l1Cuad:removeEventListener( "touch", changeopTile )
		end
	end
	if l2Cuad then
		l2Cuad:removeEventListener( "touch", changeDuotone )
	end

	display.remove( l1Cuad )
	l1Cuad = nil
	display.remove( l2Cuad )
	l2Cuad = nil

	display.remove( l1 )
	l1 = nil

	display.remove( l2 )
	l2 = nil
end

local entra = false

local function selectEffect( effect )
	if effect.name == "b0" then
		remove()
		photo.fill.effect = ""
	elseif effect.name == "exposure" then
		remove()
		photo.fill.effect = "filter.exposure"
		photo.fill.effect.exposure = valueExposure
		effectEnabled = "exposure"
		l1 = display.newLine( W*0.3,H*0.7,W*0.7,H*0.7 )
		l1.strokeWidth = 3

		l1Cuad = display.newRect( 0,0,10,20 )
		l1Cuad.x = W*0.55
		l1Cuad.y = H*0.7
		l1Cuad.name = "l1"
		l1Cuad:addEventListener( "touch", changeExposure )

	elseif effect.name == "saturate" then
		remove()
		photo.fill.effect = "filter.saturate"
		photo.fill.effect.intensity = valueSaturate
		effectEnabled = "saturate"
		l1 = display.newLine( W*0.3,H*0.7,W*0.7,H*0.7 )
		l1.strokeWidth = 3

		l1Cuad = display.newRect( 0,0,10,20 )
		l1Cuad.x = W*0.4
		l1Cuad.y = H*0.7
		l1Cuad.name = "l1"
		l1Cuad:addEventListener( "touch", changeSaturate )

	elseif effect.name == "opTile" then
		remove()
		photo.fill.effect = "filter.opTile"
		photo.fill.effect.numPixels = valueTile
		effectEnabled = "opTile"
		l1 = display.newLine( W*0.3,H*0.7,W*0.7,H*0.7 )
		l1.strokeWidth = 3

		l1Cuad = display.newRect( 0,0,10,20 )
		l1Cuad.x = W*0.32
		l1Cuad.y = H*0.7
		l1Cuad:addEventListener( "touch", changeopTile )

	elseif effect.name == "invert" then
		remove()
		photo.fill.effect = "filter.invert"
		effectEnabled = "invert"
	elseif effect.name == "desaturate" then
		remove()
		photo.fill.effect = "filter.desaturate"
		photo.fill.effect.intensity = valueDesaturate
		effectEnabled = "desaturate"
		l1 = display.newLine( W*0.3,H*0.7,W*0.7,H*0.7 )
		l1.strokeWidth = 3

		l1Cuad = display.newRect( 0,0,10,20 )
		l1Cuad.x = W*0.55
		l1Cuad.y = H*0.7
		l1Cuad.name = "l1"
		l1Cuad:addEventListener( "touch", changeDesaturate )

	elseif effect.name == "duotone" then
		remove()
		photo.fill.effect = "filter.duotone"
		photo.fill.effect.darkColor = duotoneBlue
		photo.fill.effect.lightColor = duotoneRed
		effectEnabled = "duotone"
		l1 = display.newLine( W*0.3,H*0.7,W*0.7,H*0.7 )
		l1.strokeWidth = 3

		l1Cuad = display.newRect( 0,0,10,20 )
		l1Cuad.x = W*0.55
		l1Cuad.y = H*0.7
		l1Cuad.name = "l1"
		l1Cuad:addEventListener( "touch", changeDuotone )

		l2 = display.newLine( W*0.3,H*0.75,W*0.7,H*0.75 )
		l2.strokeWidth = 3

		l2Cuad = display.newRect( 0,0,10,20 )
		l2Cuad.x = W*0.55
		l2Cuad.y = H*0.75
		l2Cuad.name = "l2"
		l2Cuad:addEventListener( "touch", changeDuotone )

	elseif effect.name == "pixelate" then
		remove()
		photo.fill.effect = "filter.pixelate"
		photo.fill.effect.numPixels = valuePixelate
		effectEnabled = "pixelate"
		l1 = display.newLine( W*0.3,H*0.7,W*0.7,H*0.7 )
		l1.strokeWidth = 3

		l1Cuad = display.newRect( 0,0,10,20 )
		l1Cuad.x = W*0.32
		l1Cuad.y = H*0.7
		l1Cuad.name = "l1"
		l1Cuad:addEventListener( "touch", changePixelate )

	elseif effect.name == "vignette" then
		remove()
		photo.fill.effect = "filter.vignette"
		photo.fill.effect.radius = valueVignette
		effectEnabled = "vignette"
		l1 = display.newLine( W*0.3,H*0.7,W*0.7,H*0.7 )
		l1.strokeWidth = 3

		l1Cuad = display.newRect( 0,0,10,20 )
		l1Cuad.x = W*0.4
		l1Cuad.y = H*0.7
		l1Cuad.name = "l1"
		l1Cuad:addEventListener( "touch", changeVignete )

	elseif effect.name == "sepia" then
		remove()
		photo.fill.effect = "filter.sepia"
		photo.fill.effect.intensity = valueSepia
		effectEnabled = "sepia"
		l1 = display.newLine( W*0.3,H*0.7,W*0.7,H*0.7 )
		l1.strokeWidth = 3

		l1Cuad = display.newRect( 0,0,10,20 )
		l1Cuad.x = W*0.7
		l1Cuad.y = H*0.7
		l1Cuad.name = "l1"
		l1Cuad:addEventListener( "touch", changeSepia )

	elseif effect.name == "blurGaussian" then
		remove()
		photo.fill.effect = "filter.blurGaussian"
		effectEnabled = "bulge"

	elseif effect.name == "contrast" then
		remove()
		photo.fill.effect = "filter.contrast"
		photo.fill.effect.contrast = valueContrast
		effectEnabled = "contrast"
		l1 = display.newLine( W*0.3,H*0.7,W*0.7,H*0.7 )
		l1.strokeWidth = 3

		l1Cuad = display.newRect( 0,0,10,20 )
		l1Cuad.x = W*0.43
		l1Cuad.y = H*0.7
		l1Cuad.name = "l1"
		l1Cuad:addEventListener( "touch", changeContrast )

	elseif effect.name == "emboss" then
		remove()
		photo.fill.effect = "filter.emboss"
		photo.fill.effect.intensity = valueEmboss
		effectEnabled = "emboss"
		l1 = display.newLine( W*0.3,H*0.7,W*0.7,H*0.7 )
		l1.strokeWidth = 3

		l1Cuad = display.newRect( 0,0,10,20 )
		l1Cuad.x = W*0.43
		l1Cuad.y = H*0.7
		l1Cuad.name = "l1"
		l1Cuad:addEventListener( "touch", changeEmboss )

	elseif effect.name == "grayscale" then
		remove()
		photo.fill.effect = "filter.grayscale"
		effectEnabled = "grayscale"
	elseif effect.name == "hue" then
		remove()
		photo.fill.effect = "filter.hue"
		photo.fill.effect.angle = valueHue
		effectEnabled = "hue"
		l1 = display.newLine( W*0.3,H*0.7,W*0.7,H*0.7 )
		l1.strokeWidth = 3

		l1Cuad = display.newRect( 0,0,10,20 )
		l1Cuad.x = W*0.3
		l1Cuad.y = H*0.7
		l1Cuad.name = "l1"
		l1Cuad:addEventListener( "touch", changeHue )

	elseif effect.name == "sobel" then
		remove()
		photo.fill.effect = "filter.sobel"
		effectEnabled = "sobel"
	elseif effect.name == "swirl" then
		remove()
		photo.fill.effect = "filter.swirl"
		photo.fill.effect.intensity = valueSwirl
		effectEnabled = "swirl"
		l1 = display.newLine( W*0.3,H*0.7,W*0.7,H*0.7 )
		l1.strokeWidth = 3

		l1Cuad = display.newRect( 0,0,10,20 )
		l1Cuad.x = W*0.3
		l1Cuad.y = H*0.7
		l1Cuad.name = "l1"
		l1Cuad:addEventListener( "touch", changeSwirl )
	elseif effect.name == "hojas" then
		remove()
		photo.fill = imageStars
		photo.fill.effect = "composite.screen"
		effectEnabled = "screen"
	elseif effect.name == "stars" then
		remove()
		photo.fill = imageStars2
		photo.fill.effect = "composite.screen"
		effectEnabled = "screen"
	end

end


--[[
local function deletingEffect( )
	display.remove( photo )
	photo = nil
	photo = photo2
	photo.alpha = 1
	for i = 1, #effectsApplied do
		if effectsApplied[i] ~= effectDeleted and effectsApplied[i] ~= "b0" then
			selectEffect( effectsApplied[i] )
			n = n+1
			display.save( photo, "photo"..n..".jpg", system.TemporaryDirectory )
			display.remove( photo )
			photo = nil
			photo = display.newImage( "photo"..n..".jpg", system.TemporaryDirectory )
			photo.x = W*0.5
			photo.y = H*0.5
			photo.xScale = 0.5
			photo.yScale = 0.5
			--mainGroup:insert( photo )
			--mainGroup:insert( group )
		else
			effectsApplied[i] = "b0"
		end
	end
end--]]


local function applyEffect( event )
	if event.phase == "began" then
		moved = false
		entra = false
		x = group.x
		y = event.x
		if savedP then
			display.remove( photo )
			photo = nil
			photo = display.newImage( "photo"..n..".jpg", system.TemporaryDirectory )
			photo.x = W*0.5
			photo.y = H*0.5
			photo.xScale = 320/photo.width
			photo.yScale = 480/photo.height
		end
		mainGroup:insert( photo )
		mainGroup:insert( group )
	end
	if event.phase == "moved" then
		moved = true
		if ( event.x > y and effects[1].x < W*0.5 ) or ( event.x < y and effects[#effects].x>W*0.5 ) then
			for i=1, #effects do
				if event.x > y then
					effects[i].x = effects[i].x + W*0.01
				elseif event.x < y then
					effects[i].x = effects[i].x - W*0.01
				end
				if effects[i].x < W*0.52 and effects[i].x > W*0.48 then
					mod1 = true
					scale = 1.8
					p1 = i
					transition.to( effects[i], { xScale = scale, yScale = scale, time = 30 } )
				end
				if ( effects[i].x < W*0.48 and effects[i].x > W*0.43 ) or ( effects[i].x < W*0.57 and effects[i].x > W*0.52 ) then
					scale = 1.6
					p2 = i
					transition.to( effects[i], { xScale = scale, yScale = scale, time = 30 } )
				end
				if ( effects[i].x < W*0.43 and effects[i].x > W*0.36 ) or ( effects[i].x < W*0.65 and effects[i].x > W*0.57 ) then
					scale = 1.4
					p3 = i
					transition.to( effects[i], { xScale = scale, yScale = scale, time = 30 } )
				end
				if ( effects[i].x < W*0.36 and effects[i].x > W*0.25 ) or ( effects[i].x < W*0.76 and effects[i].x > W*0.65 ) then
					scale = 1.25
					p4 = i
					transition.to( effects[i], { xScale = scale, yScale = scale, time = 30 } )
				end
				if ( effects[i].x < W*0.25 and effects[i].x > W*0.1 ) or ( effects[i].x < W*0.9 and effects[i].x > W*0.76 ) then
					scale = 1.12
					p5 = i
					transition.to( effects[i], { xScale = scale, yScale = scale, time = 30 } )
				end
				if ( effects[i].x < W*0.1 ) or ( effects[i].x > W*0.9 ) then
					scale = 1
					p6 = i
					transition.to( effects[i], { xScale = scale, yScale = scale, time = 30 } )
				end
				group:insert( effects[p6] )
				group:insert( effects[p5] )
				group:insert( effects[p4] )
				group:insert( effects[p3] )
				group:insert( effects[p2] )
				if mod1 == true then
					mod1 = false
					group:insert( effects[p1] )
				end
			end
			y = event.x
		end
	end
	if event.phase == "ended" then
		if moved == true then
 			if effects[p1].colorStroke == "white" then
				selectEffect( effects[p1] )
			end
		elseif moved == false then

			if event.target.colorStroke == "white" then
				if event.target.name ~= "b0" then
					if savedP then
						display.remove( photo )
						photo = nil
						photo = display.newImage( "photo"..n..".jpg", system.TemporaryDirectory )
						photo.x = W*0.5
						photo.y = H*0.5
						photo.xScale = 320/photo.width
						photo.yScale = 480/photo.height
					end
					selectEffect( event.target )
					effectsApplied[#effectsApplied + 1] = event.target.name
					n = n+1
					display.save( photo, "photo"..n..".jpg" , system.TemporaryDirectory )
					savedP = true

					event.target:setStrokeColor( 0,0,0 )
					event.target.colorStroke = "black"

					mainGroup:insert( photo )
					mainGroup:insert( group )

				end
			--[[else
				effectDeleted = event.target.name
				deletingEffect()
				event.target:setStrokeColor( 255,255,255 )
				event.target.colorStroke = "white"
				mainGroup:insert( photo )
				mainGroup:insert( group )--]]

			end
		end
	end
	return true
end


local function hide( event )
	if event.phase == "ended" then
		if group.alpha == 1 then
			group.alpha = 0
			if l1 then
				l1.alpha = 0
			end
			if l1Cuad then
				l1Cuad.alpha = 0
			end
			if l2 then
				l2.alpha = 0
			end
			if l2Cuad then
				l2Cuad.alpha = 0
			end
		elseif group.alpha == 0 then
			group.alpha = 1
			if l1 then
				l1.alpha = 1
			end
			if l1Cuad then
				l1Cuad.alpha = 1
			end
			if l2 then
				l2.alpha = 1
			end
			if l2Cuad then
				l2Cuad.alpha = 1
			end
		end
	end
end

local function backScene( event )
	if event.phase == "ended" then
		storyboard.gotoScene( "menu" )
		storyboard.purgeScene( "effect" )
	end
end

function effect:createScene( event )

	back = display.newRoundedRect( 0,0,35,25,5 )
	back.x = W*0.08
	back.y = H*0.05
	back.text = display.newText( "Back", back.x, back.y, nil, 12 )
	back.text:setFillColor( 0,0,0 )

	back:addEventListener( "touch", backScene )

	photo = event.params.photo

	photo.x = W * 0.5
	photo.y = H * 0.5
	if photo.width > photo.height then
		photo.rotation = 90
	end
	photo.xScale = 320/photo.width
	photo.yScale = 480/photo.height

	local imagePaint = { type="image",
		filename="julio01_3.jpg"
	}

	--[[
	imageStars = { type="composite",
		paint1={ type="image", filename="julio01_3.jpg" },
		paint2={ type="image", filename="stars.png" }
	}

	imageStars2 = { type="composite",
		paint1={ type="image", filename="julio01_3.jpg" },
		paint2={ type="image", filename="stars2.png" }
	}--]]


	effects[1] = display.newRect( 0,0,40,40 )
	effects[1].x = W * 0.12
	effects[1].y = H * 0.1
	effects[1].name = "b0"
	effects[1].fill = imagePaint
	effects[1].strokeWidth = 2


	effects[2] = display.newRect( 0,0,40,40 )
	effects[2].x = W * 0.12
	effects[2].y = H * 0.25
	effects[2].name = "exposure"
	effects[2].fill = imagePaint
	effects[2].fill.effect = "filter.exposure"
	effects[2].fill.effect.exposure = 0.5
	effects[2].strokeWidth = 2

	effects[3] = display.newRect( 0,0,40,40 )
	effects[3].x = W * 0.12
	effects[3].y = H * 0.4
	effects[3].name = "saturate"
	effects[3].fill = imagePaint
	effects[3].fill.effect = "filter.saturate"
	effects[3].fill.effect.intensity = 2
	effects[3].strokeWidth = 2

	effects[4] = display.newRect( 0,0,40,40 )
	effects[4].x = W * 0.12
	effects[4].y = H * 0.55
	effects[4].name = "opTile"
	effects[4].fill = imagePaint
	effects[4].fill.effect = "filter.opTile"
	effects[4].fill.effect.numPixels = 100
	effects[4].strokeWidth = 2

	effects[5] = display.newRect( 0,0,40,40 )
	effects[5].x = W * 0.12
	effects[5].y = H * 0.7
	effects[5].name = "invert"
	effects[5].fill = imagePaint
	effects[5].fill.effect = "filter.invert"
	effects[5].strokeWidth = 2

	effects[6] = display.newRect( 0,0,40,40 )
	effects[6].x = W * 0.12
	effects[6].y = H * 0.85
	effects[6].name = "desaturate"
	effects[6].fill = imagePaint
	effects[6].fill.effect = "filter.desaturate"
	effects[6].strokeWidth = 2

	effects[7] = display.newRect( 0,0,40,40 )
	effects[7].x = W * 0.12
	effects[7].y = H
	effects[7].name = "duotone"
	effects[7].fill = imagePaint
	effects[7].fill.effect = "filter.duotone"
	effects[7].strokeWidth = 2

	effects[8] = display.newRect( 0,0,40,40 )
	effects[8].x = W * 0.12
	effects[8].y = H + H*0.15
	effects[8].name = "pixelate"
	effects[8].fill = imagePaint
	effects[8].fill.effect = "filter.pixelate"
	effects[8].fill.effect.numPixels = 80
	effects[8].strokeWidth = 2

	effects[9] = display.newRect( 0,0,40,40 )
	effects[9].x = W * 0.12
	effects[9].y = H + H * 0.3
	effects[9].name = "vignette"
	effects[9].fill = imagePaint
	effects[9].fill.effect = "filter.vignette"
	effects[9].strokeWidth = 2

	effects[10] = display.newRect( 0,0,40,40 )
	effects[10].x = W * 0.12
	effects[10].y = H + H * 0.45
	effects[10].name = "sepia"
	effects[10].fill = imagePaint
	effects[10].fill.effect = "filter.sepia"
	effects[10].strokeWidth = 2

	effects[11] = display.newRect( 0,0,40,40 )
	effects[11].x = W * 0.12
	effects[11].y = H + H * 0.6
	effects[11].name = "blurGaussian"
	effects[11].fill = imagePaint
	effects[11].fill.effect = "filter.blurGaussian"
	effects[11].fill.effect.intensity = 0.8
	effects[11].strokeWidth = 2

	effects[12] = display.newRect( 0,0,40,40 )
	effects[12].x = W * 0.12
	effects[12].y = H + H * 0.75
	effects[12].name = "contrast"
	effects[12].fill = imagePaint
	effects[12].fill.effect = "filter.contrast"
	effects[12].fill.effect.contrast = 2
	effects[12].strokeWidth = 2

	effects[13] = display.newRect( 0,0,40,40 )
	effects[13].x = W * 0.12
	effects[13].y = H + H * 0.9
	effects[13].name = "emboss"
	effects[13].fill = imagePaint
	effects[13].fill.effect = "filter.emboss"
	effects[13].fill.effect.intensity = 0.5
	effects[13].strokeWidth = 2

	effects[14] = display.newRect( 0,0,40,40 )
	effects[14].x = W * 0.12
	effects[14].y = H + H + H * 0.05
	effects[14].name = "grayscale"
	effects[14].fill = imagePaint
	effects[14].fill.effect = "filter.grayscale"
	effects[14].strokeWidth = 2

	effects[15] = display.newRect( 0,0,40,40 )
	effects[15].x = W * 0.12
	effects[15].y = H + H + H*0.2
	effects[15].name = "hue"
	effects[15].fill = imagePaint
	effects[15].fill.effect = "filter.hue"
	effects[15].strokeWidth = 2

	effects[16] = display.newRect( 0,0,40,40 )
	effects[16].x = W * 0.12
	effects[16].y = H + H + H*0.35
	effects[16].name = "sobel"
	effects[16].fill = imagePaint
	effects[16].fill.effect = "filter.sobel"
	effects[16].strokeWidth = 2

	effects[17] = display.newRect( 0,0,40,40 )
	effects[17].x = W * 0.12
	effects[17].y = H + H + H * 0.5
	effects[17].name = "swirl"
	effects[17].fill = imagePaint
	effects[17].fill.effect = "filter.swirl"
	effects[17].strokeWidth = 2

	--[[
	effects[18] = display.newRect( 0,0,40,40 )
	effects[18].x = W * 0.12
	effects[18].y = H + H + H * 0.65
	effects[18].name = "hojas"
	effects[18].fill = imageStars
	effects[18].fill.effect = "composite.screen"
	effects[18].strokeWidth = 2

	effects[19] = display.newRect( 0,0,40,40 )
	effects[19].x = W * 0.12
	effects[19].y = H + H + H * 0.80
	effects[19].name = "stars"
	effects[19].fill = imageStars2
	effects[19].fill.effect = "composite.screen"
	effects[19].strokeWidth = 2--]]

	local step = 0.5
	for i = 1, #effects do
		effects[i].x = W*step
		effects[i].y = H*0.9
		if step == 0.5 then
			effects[i].xScale = 1.45
			effects[i].yScale = 1.45
		end
		if step == 0.65 or step == 0.35 then
			effects[i].xScale = 1.3
			effects[i].yScale = 1.3
		end
		if step == 0.8 or step == 0.2 then
			effects[i].xScale = 1.1
			effects[i].yScale = 1.1
		end
		step = step + 0.15
		effects[i].colorStroke = "white"
		effects[i]:addEventListener( "touch", applyEffect )
	end


	group = display.newGroup()

	mainGroup:insert( photo )
	for i = 1, #effects do
		group:insert( effects[i] )
	end
	group:insert( effects[1] )
	mainGroup:insert( group )

end

function effect:destroyScene( event )

	remove()

	display.remove( photo )
	photo = nil

	display.remove( photo2 )
	photo2 = nil

	for i = 1, #effects do
		display.remove( effects[i] )
		effects[i] = nil
	end

	if back then
		back:removeEventListener( "touch", backScene )
	end
	display.remove( back )
	back = nil
end

effect:addEventListener( "createScene", effect )
effect:addEventListener( "destroyScene", effect )

return effect
