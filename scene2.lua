---------------------------------------------------------------------------------
--
-- scene1.lua
--
---------------------------------------------------------------------------------


local storyboard = require( "storyboard" )
local scene = storyboard.newScene()


system.setIdleTimer( false )
system.setAccelerometerInterval( 100 )

local physics = require "physics"
local physicsData = (require "myphysics").physicsData(1.0)
---------------------------------------------------------------------------------
-- BEGINNING OF  IMPLEMENTATION
---------------------------------------------------------------------------------
local displayTime,background,ball,maze,maze2,borders,exitscn
local startTime=0
local levelTime = 20
local score=0
local now=0
local exitSound = audio.loadSound("exit.wav")
local backgroundMusicSound = audio.loadStream ( "background.mp3" )




function onTilt( event )
	physics.setGravity( (-9.8*event.yGravity), (-9.8*event.xGravity) ) --Το σωστό
end



function nextScene()
	audio.stop()
	audio.play( exitSound  )
	physics.stop()
    storyboard.state.score =storyboard.state.score+ (levelTime - (now - startTime))*20
    storyboard.state2.level = 3
    storyboard.gotoScene( "loadscene3")
end

local function onCollision( event )
	if ( event.phase == "began" ) then
       if(event.object1.name=="exitscn" or event.object2.name=="exitscn") then
       		timer.performWithDelay ( 200, nextScene )
        end 
	end

end
 
local function gameOver()
	audio.stop()
	storyboard.gotoScene( "gameover", "fade", 300)
end

local function checkTime(event)
  now = os.time()
  displayTime.text = levelTime - (now - startTime)
  --change the colour of the timer based on how much time is remaining
  if ( levelTime - (now - startTime)==levelTime/2) then
  	transition.to(displayTime,{time=100,size=30})
  	displayTime:setTextColor( 214,223, 32 )
  end
  if ( levelTime - (now - startTime)==5) then
  	transition.to(displayTime,{time=100,size=40})
  	displayTime:setTextColor( 239,89, 40 )
  end
  --gamve over when there is no remaining time
  if ( levelTime - (now - startTime)==0) then
	gameOver()
  end
end





-- Called when the scene's view does not exist:
function scene:createScene( event )
	local screenGroup = self.view
	physics.start(); 
	physics.setGravity( 0,0)
	
	displayTime = display.newText(levelTime, display.contentWidth-40, 15)
	displayTime.alpha = 0
	displayTime.size = 20
	displayTime:setTextColor( 0,173, 239 )

	background = display.newImageRect( "background2.png", display.contentWidth, display.contentHeight )
	background:setReferencePoint( display.TopLeftReferencePoint )
	background.x, background.y = 0, 0

	local planetoptions = {
   		width = 24,
   		height = 24,
   		numFrames = 5
		}
		
	local planetSheet = graphics.newImageSheet( "earthsprite.png", planetoptions )

	local planetSequenceData =
			{
    		name="planetsequence",
		    start=1,
		    count=5,
		    time=500,        -- Optional. In ms.  If not supplied, then sprite is frame-based.
		    loopCount = 0,    -- Optional. Default is 0 (loop indefinitely)
		    loopDirection = "bounce"    -- Optional. Values include: "forward","bounce"
			}

	local planetSprite = display.newSprite( planetSheet, planetSequenceData )
	planetSprite.x = 75
	planetSprite.y = 15
	planetSprite.x = 30
	planetSprite.y = display.contentCenterY
	planetSprite.name = "planet"
	planetSprite:play()


	maze=display.newImage( "maze2.png" )
	maze.x=display.contentCenterX
	maze.y=display.contentCenterY
	maze.name="maze"
	
	maze2=display.newImage( "maze2.png" )
	maze2.x=display.contentCenterX
	maze2.y=display.contentCenterY
	maze2.name="maze2"
	
	borderleft = display.newImage( "borderleftright.png" )
	borderleft.x = 1
	borderleft.y = display.contentCenterY

	borderright = display.newImage( "borderleftright.png" )
	borderright.x = display.contentWidth-1
	borderright.y = display.contentCenterY

	borderup = display.newImage( "borderupdown.png")
	borderup.x = display.contentCenterX
	borderup.y = 1

	borderdown = display.newImage( "borderupdown.png")
	borderdown.x = display.contentCenterX
	borderdown.y = display.contentHeight - 1 
	
	exitscn=display.newImage("exit.png")
	exitscn.x=display.contentWidth-30
	exitscn.y=display.contentCenterY
	exitscn.name="exitscn"
	
	physics.addBody (planetSprite, "dynamic",physicsData:get("earthphysics"))
	planetSprite.isSleepingAllowed = false
	physics.addBody (maze, "static",physicsData:get("mazelevel2_1"))
	physics.addBody (maze2, "static",physicsData:get("mazelevel2_2"))
	physics.addBody (borderleft, "static",{ friction=0.5, bounce=0 })
    physics.addBody (borderright, "static",{ friction=0.5, bounce=0 })
    physics.addBody (borderup, "static",{ friction=0.5, bounce=0 })
    physics.addBody (borderdown, "static",{ friction=0.5, bounce=0 })
	physics.addBody (exitscn, "static",physicsData:get("exitscn"))
	
	-- planetSprite:addEventListener ( "touch", nextScene )
	Runtime:addEventListener("enterFrame", checkTime)
	--Runtime:addEventListener( "gyroscope", onGyroscopeDataReceived )
	Runtime:addEventListener( "accelerometer", onTilt )
	Runtime:addEventListener( "collision", onCollision )
	
	screenGroup:insert( background )
	screenGroup:insert(displayTime)
	screenGroup:insert( planetSprite )
	screenGroup:insert( maze )
	screenGroup:insert( maze2 )
	screenGroup:insert( borderleft )
	screenGroup:insert( borderright )
	screenGroup:insert( borderdown)
	screenGroup:insert( borderup)
	screenGroup:insert( exitscn )
	
end




-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	physics.start()
    audio.play(backgroundMusicSound,{channel = 1,loops=-1})
	startTime = os.time()
	transition.to ( displayTime, {alpha=1,time=500} )
end


-- Called when scene is about to move offscreen:
function scene:exitScene( event )
	
	print( "1: exitScene event" )
	physics.stop( )
    audio.stop()

	Runtime:removeEventListener( "enterFrame", checkTime )
    Runtime:removeEventListener( "accelerometer", onTilt )
    Runtime:removeEventListener( "collision", onCollision )
	
end


-- Called prior to the removal of scene's "view" (display group)
function scene:destroyScene( event )
	package.loaded[physics] = nil
	physics = nil
end

---------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

-- "createScene" event is dispatched if scene's view does not exist
scene:addEventListener( "createScene", scene )

-- "enterScene" event is dispatched whenever scene transition has finished
scene:addEventListener( "enterScene", scene )

-- "exitScene" event is dispatched before next scene's transition begins
scene:addEventListener( "exitScene", scene )

-- "destroyScene" event is dispatched before view is unloaded, which can be
-- automatically unloaded in low memory situations, or explicitly via a call to
-- storyboard.purgeScene() or storyboard.removeScene().
scene:addEventListener( "destroyScene", scene )

---------------------------------------------------------------------------------

return scene