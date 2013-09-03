-----------------------------------------------------------------------------------------
--
-- menu.lua
--
-----------------------------------------------------------------------------------------

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()


-- include Corona's "widget" library

local widget = require "widget"







	
--------------------------------------------

-- forward declarations and other locals
local playBtn
local scoreText
local buttonClickSound = audio.loadSound("button_click.wav")


local function onPlayBtnRelease()
     audio.play(buttonClickSound)
	storyboard.gotoScene( "scene2", "fade", 500 )

	return true	
end



function scene:createScene( event )
	local group = self.view
	
	

	-- display a background image
	local background = display.newImageRect( "background.png", display.contentWidth, display.contentHeight )
	background:setReferencePoint( display.TopLeftReferencePoint )
	background.x, background.y = 0, 0
	
    local minotaur=display.newImage( "minotaur.png" )
    minotaur.x=display.contentCenterX
    minotaur.y=display.contentCenterY-80
	
	
	-- create a widget button (which will loads level1.lua on release)
	playBtn = widget.newButton{
		label="Επόμενη πίστα",
		labelColor = { default={255}, over={128} },
		font="Aka-AcidGR-Atomic",
		fontSize=25,
		defaultFile="button.png",
		overFile="button-over.png",
		width=154, height=40,
		onRelease = onPlayBtnRelease	-- event listener function
	}
	playBtn:setReferencePoint( display.CenterReferencePoint )
	playBtn.x = display.contentWidth*0.5
	playBtn.y = display.contentHeight - 75
	

	
	
	
	-- all display objects must be inserted into group
	group:insert( background )
	group:insert( minotaur )
	group:insert( playBtn )


end

-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	local group = self.view
	local scoreText=display.newText("Συνολικό σκορ: " .. storyboard.state.score, 0, 0, "Aka-AcidGR-Atomic", 35)
	scoreText:setReferencePoint( display.CenterReferencePoint )
	scoreText:setTextColor (0, 0, 0 )
	scoreText.x = display.contentWidth * 0.5
	scoreText.y = 150
	
	local wikiText=display.newText("Στην Ελληνική μυθολογία, ο Μινώταυρος ήταν ένα ον \nμε σώμα ανθρώπου και κεφάλι ταύρου.", 0, 0, "GFS Bodoni Rg", 14)
	wikiText:setReferencePoint( display.CenterReferencePoint )
	wikiText:setTextColor (0, 0, 0 )
	wikiText.x = display.contentWidth * 0.5
	wikiText.y = 185
	
	group:insert(scoreText)
	group:insert(wikiText)
    storyboard.removeAll()
  
	-- INSERT code here (e.g. start timers, load audio, start listeners, etc.)
	
end

-- Called when scene is about to move offscreen:
function scene:exitScene( event )
	local group = self.view
     print("exit menu")
     
end

-- If scene's view is removed, scene:destroyScene() will be called just prior to:
function scene:destroyScene( event )
	local group = self.view
	
    print("destroy menu")
	if playBtn then
		playBtn:removeSelf()	-- widgets must be manually removed
		playBtn = nil
	end
	
	
	
	
	
end

-----------------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
-----------------------------------------------------------------------------------------

-- "createScene" event is dispatched if scene's view does not exist
scene:addEventListener( "createScene", scene )

-- "enterScene" event is dispatched whenever scene transition has finished
scene:addEventListener( "enterScene", scene )

-- "exitScene" event is dispatched whenever before next scene's transition begins
scene:addEventListener( "exitScene", scene )

-- "destroyScene" event is dispatched before view is unloaded, which can be
-- automatically unloaded in low memory situations, or explicitly via a call to
-- storyboard.purgeScene() or storyboard.removeScene().
scene:addEventListener( "destroyScene", scene )

-----------------------------------------------------------------------------------------

return scene