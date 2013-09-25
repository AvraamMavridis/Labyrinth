-----------------------------------------------------------------------------------------
--
-- menu.lua
--
-----------------------------------------------------------------------------------------

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()


-- include Corona's "widget" library

local widget = require "widget"


local sqlite3 = require "sqlite3"
local path = system.pathForFile("data.db", system.DocumentsDirectory)
db = sqlite3.open( path )   





	
--------------------------------------------

-- forward declarations and other locals
local playBtn
local scoreText
local buttonClickSound = audio.loadSound("button_click.wav")


local function onPlayBtnRelease(level)
    audio.play(buttonClickSound)
	storyboard.gotoScene( level, "fade", 500 )
	return true	
end

local function onBackBtnRelease()
	print(10)
	-- go to level1.lua scene
	audio.stop()
	audio.play(buttonClickSound)
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
	group:insert( background )
    --local minotaur=display.newImage( "minotaur.png" )
    --minotaur.x=display.contentCenterX
    --minotaur.y=display.contentCenterY-80
	
	



    highestlevel = 0
    for row in db:nrows("SELECT * FROM levelstable WHERE content=(SELECT max(content) FROM levelstable)") do
	 highestlevel = row.content
	end

	--print(highestlevel)

    ------------------------level 1 -----------------------------------------
    if(highestlevel >= 1) then

    	planet1 = widget.newButton{
	label="1",
		labelColor = { default={255}, over={128} },
		fontSize=25,
		defaultFile="levelplanet.png",
		overFile="levelplanet-over.png",
		width=62, height=62,
		onRelease = function() onPlayBtnRelease('scene1') end
	}

	planet1.x = 40
	planet1.y = 60
	group:insert( planet1 )
    end

	------------------------level 2 -----------------------------------------
    if(highestlevel >= 2) then

    	planet2 = widget.newButton{
	label="2",
		labelColor = { default={255}, over={128} },
		fontSize=25,
		defaultFile="levelplanet.png",
		overFile="levelplanet-over.png",
		width=62, height=62,
		onRelease = function() onPlayBtnRelease('scene2') end
	}

	planet2.x = 120
	planet2.y = 60
	group:insert( planet2 )

    else
    		planet2 = widget.newButton{
		label="2",
		labelColor = { default={255}, over={128} },
		fontSize=25,
		defaultFile="levelplanet-over.png",
		overFile="levelplanet-over.png",
		width=62, height=62,
	}

	planet2.x = 120
	planet2.y = 60
	group:insert( planet2 )
    end


    ------------------------level 3 -----------------------------------------
    if(highestlevel >= 3) then

    	planet3 = widget.newButton{
	label="3",
		labelColor = { default={255}, over={128} },
		fontSize=25,
		defaultFile="levelplanet.png",
		overFile="levelplanet-over.png",
		width=62, height=62,
		onRelease = function() onPlayBtnRelease('scene3') end
	}

	planet3.x = 200
	planet3.y = 60
	group:insert( planet3 )

    else
    		planet3 = widget.newButton{
		label="3",
		labelColor = { default={255}, over={128} },
		fontSize=25,
		defaultFile="levelplanet-over.png",
		overFile="levelplanet-over.png",
		width=62, height=62,
	}

	planet3.x = 200
	planet3.y = 60
	group:insert( planet3 )
    end


     ------------------------level 4 -----------------------------------------
    if(highestlevel >= 4) then

    	planet4 = widget.newButton{
	label="4",
		labelColor = { default={255}, over={128} },
		fontSize=25,
		defaultFile="levelplanet.png",
		overFile="levelplanet-over.png",
		width=62, height=62,
		onRelease = function() onPlayBtnRelease('scene4') end
	}

	planet4.x = 280
	planet4.y = 60
	group:insert( planet4 )

    else
    		planet4 = widget.newButton{
		label="4",
		labelColor = { default={255}, over={128} },
		fontSize=25,
		defaultFile="levelplanet-over.png",
		overFile="levelplanet-over.png",
		width=62, height=62,
	}

	planet4.x = 280
	planet4.y = 60
	group:insert( planet4 )
    end

    ------------------------level 5 -----------------------------------------
    if(highestlevel >= 5) then

    	planet5 = widget.newButton{
	label="5",
		labelColor = { default={255}, over={128} },
		fontSize=25,
		defaultFile="levelplanet.png",
		overFile="levelplanet-over.png",
		width=62, height=62,
		onRelease = function() onPlayBtnRelease('scene5') end
	}

	planet5.x = 360
	planet5.y = 60
	group:insert( planet5 )

    else
    		planet5 = widget.newButton{
		label="5",
		labelColor = { default={255}, over={128} },
		fontSize=25,
		defaultFile="levelplanet-over.png",
		overFile="levelplanet-over.png",
		width=62, height=62,
	}

	planet5.x = 360
	planet5.y = 60
	group:insert( planet5 )
    end


    backBtn = widget.newButton{
		label="Menu",
		labelColor = { default={255}, over={128} },
		fontSize=25,
		defaultFile="button3.png",
		overFile="button-over3.png",
		width=154, height=40,
		onRelease = onBackBtnRelease	-- event listener function
	}

	

	------------------------level 6 -----------------------------------------
    if(highestlevel >= 6) then

    	planet5 = widget.newButton{
	label="6",
		labelColor = { default={255}, over={128} },
		fontSize=25,
		defaultFile="levelplanet.png",
		overFile="levelplanet-over.png",
		width=62, height=62,
		onRelease = function() onPlayBtnRelease('scene6') end
	}

	planet5.x = 440
	planet5.y = 60
	group:insert( planet5 )

    else
    		planet5 = widget.newButton{
		label="6",
		labelColor = { default={255}, over={128} },
		fontSize=25,
		defaultFile="levelplanet-over.png",
		overFile="levelplanet-over.png",
		width=62, height=62,
	}

	planet5.x = 440
	planet5.y = 60
	group:insert( planet5 )
    end


	backBtn:setReferencePoint( display.CenterReferencePoint )
	backBtn.x = display.contentWidth*0.5
	backBtn.y = display.contentHeight - 75

	group:insert( backBtn )

    backBtn = widget.newButton{
		label="Menu",
		labelColor = { default={255}, over={128} },
		fontSize=25,
		defaultFile="button3.png",
		overFile="button-over3.png",
		width=154, height=40,
		onRelease = onBackBtnRelease	-- event listener function
	}

	backBtn:setReferencePoint( display.CenterReferencePoint )
	backBtn.x = display.contentWidth*0.5
	backBtn.y = display.contentHeight - 75

	group:insert( backBtn )
	


	



	-- planet2 = widget.newButton{
	-- label="1",
	-- 	labelColor = { default={255}, over={128} },
	-- 	fontSize=25,
	-- 	defaultFile="levelplanet.png",
	-- 	overFile="levelplanet-over.png",
	-- 	width=62, height=62,
	-- 	onRelease = function() onPlayBtnRelease('scene2') end
	-- }

	-- planet2.defaultFile = "levelplanet-over..png"

	-- planet2.x = 120
	-- planet2.y = 40
	

	
	
	
	-- all display objects must be inserted into group
	
	--group:insert( minotaur )
	
	



end

-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	local group = self.view
    storyboard.removeAll()
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