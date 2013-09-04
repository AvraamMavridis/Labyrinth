-----------------------------------------------------------------------------------------
--
-- Credits
--
-----------------------------------------------------------------------------------------

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local buttonClickSound = audio.loadSound("button_click.wav")
local widget = require "widget"



local function onBackBtnRelease()
	-- go to menu
	audio.play ( buttonClickSound  )
	storyboard.gotoScene( "menu", "fade", 500 )
	return true	-- indicates successful touch
end

local backBtn

function scene:createScene( event )
	local group = self.view
	
		-- display a background image
	local background = display.newImageRect( "background.png", display.contentWidth, display.contentHeight )
	background:setReferencePoint( display.TopLeftReferencePoint )
	background.x, background.y = 0, 0
	


	
	local developerText=display.newText("Avraam Mavridis \navraammamauridis@gmail.com", 20, 30)
	developerText.size = 20
	developerText:setReferencePoint( display.CenterReferencePoint )
	developerText:setTextColor (241, 89, 40)
	developerText.x = display.contentWidth * 0.5
	developerText.y = 150
	
		backBtn = widget.newButton{
		label="Menu",
		fontSize=25,
		labelColor = { default={255}, over={128} },
		defaultFile="button2.png",
		overFile="button-over2.png",
		width=154, height=40,
		onRelease = onBackBtnRelease	-- event listener function
	}
	backBtn:setReferencePoint( display.CenterReferencePoint )
	backBtn.x = display.contentWidth*0.5
	backBtn.y = display.contentHeight - 75
	
	group:insert( background )

	group:insert( backBtn )
	group:insert( developerText )

	

end

-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	local group = self.view
	
	
	
end

-- Called when scene is about to move offscreen:
function scene:exitScene( event )
	local group = self.view
	

	
end

-- If scene's view is removed, scene:destroyScene() will be called just prior to:
function scene:destroyScene( event )
	local group = self.view

	if backBtn then
		backBtn:removeSelf()
		backBtn=nil
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