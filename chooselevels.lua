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

	local positionX = 10+display.contentWidth/7

	
	

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

	planet1.x = positionX
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

	planet2.x = 2*positionX
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

	planet2.x = 2*positionX
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

	planet3.x = 3*positionX
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

	planet3.x = 3*positionX
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

	planet4.x = 4*positionX
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

	planet4.x = 4*positionX
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

	planet5.x = 5*positionX
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

	planet5.x = 5*positionX
	planet5.y = 60
	group:insert( planet5 )
    end


   

	------------------------level 6 -----------------------------------------
    if(highestlevel >= 6) then

    	planet6 = widget.newButton{
	label="6",
		labelColor = { default={255}, over={128} },
		fontSize=25,
		defaultFile="levelplanet.png",
		overFile="levelplanet-over.png",
		width=62, height=62,
		onRelease = function() onPlayBtnRelease('scene6') end
	}

	planet6.x = positionX
	planet6.y = 140
	group:insert( planet6 )

    else
    		planet6 = widget.newButton{
		label="6",
		labelColor = { default={255}, over={128} },
		fontSize=25,
		defaultFile="levelplanet-over.png",
		overFile="levelplanet-over.png",
		width=62, height=62,
	}

	planet6.x = positionX
	planet6.y = 140
	group:insert( planet6 )
    end


    ------------------------level 7 -----------------------------------------
    if(highestlevel >= 7) then

    	planet7 = widget.newButton{
	label="7",
		labelColor = { default={255}, over={128} },
		fontSize=25,
		defaultFile="levelplanet.png",
		overFile="levelplanet-over.png",
		width=62, height=62,
		onRelease = function() onPlayBtnRelease('scene7') end
	}

	planet7.x = 2*positionX
	planet7.y = 140
	group:insert( planet7 )

    else
    		planet7 = widget.newButton{
		label="7",
		labelColor = { default={255}, over={128} },
		fontSize=25,
		defaultFile="levelplanet-over.png",
		overFile="levelplanet-over.png",
		width=62, height=62,
	}

	planet7.x = 2*positionX
	planet7.y = 140
	group:insert( planet7 )
    end

    ------------------------level 8 -----------------------------------------
    if(highestlevel >= 8) then

    	planet8 = widget.newButton{
	label="8",
		labelColor = { default={255}, over={128} },
		fontSize=25,
		defaultFile="levelplanet.png",
		overFile="levelplanet-over.png",
		width=62, height=62,
		onRelease = function() onPlayBtnRelease('scene8') end
	}

	planet8.x = 3*positionX
	planet8.y = 140
	group:insert( planet8 )

    else
    		planet8 = widget.newButton{
		label="8",
		labelColor = { default={255}, over={128} },
		fontSize=25,
		defaultFile="levelplanet-over.png",
		overFile="levelplanet-over.png",
		width=62, height=62,
	}

	planet8.x = 3*positionX
	planet8.y = 140
	group:insert( planet8 )
    end

    ------------------------level 9 -----------------------------------------
    if(highestlevel >= 9) then

    	planet9 = widget.newButton{
	label="9",
		labelColor = { default={255}, over={128} },
		fontSize=25,
		defaultFile="levelplanet.png",
		overFile="levelplanet-over.png",
		width=62, height=62,
		onRelease = function() onPlayBtnRelease('scene9') end
	}

	planet9.x = 4*positionX
	planet9.y = 140
	group:insert( planet9 )

    else
    	planet9 = widget.newButton{
		label="9",
		labelColor = { default={255}, over={128} },
		fontSize=25,
		defaultFile="levelplanet-over.png",
		overFile="levelplanet-over.png",
		width=62, height=62,
	}

	planet9.x = 4*positionX
	planet9.y = 140
	group:insert( planet9 )
    end

    ------------------------level 10 -----------------------------------------
    if(highestlevel >= 10) then

    	planet10 = widget.newButton{
	label="10",
		labelColor = { default={255}, over={128} },
		fontSize=25,
		defaultFile="levelplanet.png",
		overFile="levelplanet-over.png",
		width=62, height=62,
		onRelease = function() onPlayBtnRelease('scene10') end
	}

	planet10.x = 5*positionX
	planet10.y = 140
	group:insert( planet10 )

    else
    	planet10 = widget.newButton{
		label="10",
		labelColor = { default={255}, over={128} },
		fontSize=25,
		defaultFile="levelplanet-over.png",
		overFile="levelplanet-over.png",
		width=62, height=62,
	}

	planet10.x = 5*positionX
	planet10.y = 140
	group:insert( planet10 )
    end

    ------------------------level 11 -----------------------------------------
    if(highestlevel >= 11) then

    	planet11 = widget.newButton{
	label="11",
		labelColor = { default={255}, over={128} },
		fontSize=25,
		defaultFile="levelplanet.png",
		overFile="levelplanet-over.png",
		width=62, height=62,
		onRelease = function() onPlayBtnRelease('scene11') end
	}

	planet11.x = positionX
	planet11.y = 220
	group:insert( planet11 )

    else
    	planet11 = widget.newButton{
		label="11",
		labelColor = { default={255}, over={128} },
		fontSize=25,
		defaultFile="levelplanet-over.png",
		overFile="levelplanet-over.png",
		width=62, height=62,
	}

	planet11.x = positionX
	planet11.y = 220
	group:insert( planet11 )
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

	backBtn:setReferencePoint( display.CenterReferencePoint )
	backBtn.x = display.contentWidth*0.5
	backBtn.y = display.contentHeight - 35

	group:insert( backBtn )






 --    backBtn = widget.newButton{
	-- 	label="Menu",
	-- 	labelColor = { default={255}, over={128} },
	-- 	fontSize=25,
	-- 	defaultFile="button3.png",
	-- 	overFile="button-over3.png",
	-- 	width=154, height=40,
	-- 	onRelease = onBackBtnRelease	-- event listener function
	-- }

	-- backBtn:setReferencePoint( display.CenterReferencePoint )
	-- backBtn.x = display.contentWidth*0.5
	-- backBtn.y = display.contentHeight - 75

	-- group:insert( backBtn )
	


	



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