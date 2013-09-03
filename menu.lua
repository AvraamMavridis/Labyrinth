-----------------------------------------------------------------------------------------
--
-- menu.lua
--
-----------------------------------------------------------------------------------------

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
storyboard.state = {}
storyboard.state.score = 0

-- include Corona's "widget" library
local widget = require "widget"

	
--------------------------------------------

-- forward declarations and other locals
local playBtn
local creditsBtn
local buttonClickSound = audio.loadSound("button_click.wav")

local titleLogo

local function onPlayBtnRelease()
     audio.play ( buttonClickSound  )
	storyboard.gotoScene( "loadscene1", "fade", 500 )
	return true	
end

local function onCreditsBtnRelease()
	audio.play ( buttonClickSound  )
	storyboard.gotoScene( "credits_scene", "fade", 500 )
	return true
end

local function onHighscoreBtnRelease()
	audio.play ( buttonClickSound  )
	storyboard.gotoScene( "highscore", "fade", 500 )
	return true
end


function scene:createScene( event )
	local group = self.view

	-- display a background image
	local background = display.newImageRect( "background.png", display.contentWidth, display.contentHeight )
	background:setReferencePoint( display.TopLeftReferencePoint )
	background.x, background.y = 0, 0
	
	-- create/position logo/title image on upper-half of the screen
    titleLogo = display.newImageRect( "logo.png", 528, 84 )
	titleLogo:setReferencePoint( display.CenterReferencePoint )
	titleLogo.x = -300
	titleLogo.y = 100
	
	-- create a widget button (which will loads level1.lua on release)
	playBtn = widget.newButton{
		label="Play",
		fontSize=30,
		labelColor = { default={255}, over={128} },
		defaultFile="button.png",
		overFile="button-over.png",
		width=154, height=40,
		onRelease = onPlayBtnRelease	-- event listener function
	}
	playBtn:setReferencePoint( display.CenterReferencePoint )
	playBtn.x = display.contentWidth+100
	playBtn.y = display.contentHeight - 150
	
	creditsBtn = widget.newButton{
		label="Credits",
		fontSize=25,
		labelColor = { default={255}, over={128} },
		defaultFile="button2.png",
		overFile="button-over2.png",
		width=154, height=40,
		onRelease = onCreditsBtnRelease	-- event listener function
	}
	creditsBtn:setReferencePoint( display.CenterReferencePoint )
	creditsBtn.x = -100
	creditsBtn.y = display.contentHeight - 100
	
	highscoreBtn = widget.newButton{
		label="Highscore",
		fontSize=25,
		labelColor = { default={255}, over={128} },
		defaultFile="button3.png",
		overFile="button-over3.png",
		width=154, height=40,
		onRelease = onHighscoreBtnRelease	-- event listener function
	}
	highscoreBtn:setReferencePoint( display.CenterReferencePoint )
	highscoreBtn.x = display.contentWidth+100
	highscoreBtn.y = display.contentHeight - 50
	
	
	
	-- all display objects must be inserted into group
	group:insert( background )
	group:insert( titleLogo )
	group:insert( playBtn )
	group:insert(creditsBtn)
	group:insert(highscoreBtn)
end

-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	local group = self.view
	transition.to(titleLogo,{x=display.contentWidth * 0.5,time=3000})
	transition.to(playBtn,{x=display.contentWidth*0.5,time=3000})
	transition.to(creditsBtn,{x=display.contentWidth*0.5,time=3000})
	transition.to(highscoreBtn,{x=display.contentWidth*0.5,time=3000})
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
	
	if creditsBtn then
		creditsBtn:removeSelf()
		creditsBtn=nil
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