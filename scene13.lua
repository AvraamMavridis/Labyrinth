---------------------------------------------------------------------------------
--
-- scene1.lua
--
---------------------------------------------------------------------------------


local storyboard = require( "storyboard" )
local scene = storyboard.newScene()


system.setIdleTimer( false )

local physics = require "physics"
local physicsData = (require "myphysics").physicsData(1.0)
physics.setReportCollisionsInContentCoordinates( true )
---------------------------------------------------------------------------------
-- BEGINNING OF  IMPLEMENTATION
---------------------------------------------------------------------------------
local displayTime,background,planetSprite,maze,maze2,borders,exitscn
local startTime=0
local levelTime = 240
local score=0
local now
local exitSound = audio.loadSound("exit.wav")
local backgroundMusicSound = audio.loadStream ( "background.mp3" )
local explosionSprite = 0
local screenGroup

-- local function onGyroscopeDataReceived( event )
--     local deltaRadiansX = event.xRotation * event.deltaTime
--     local deltaDegreesX = deltaRadiansX * (180 / math.pi)
--     local deltaRadiansY = event.yRotation * event.deltaTime
--     local deltaDegreesY = deltaRadiansY * (180 / math.pi)
--     ball:applyForce( -deltaDegreesX*6, -deltaDegreesY*6, ball.x, ball.y )
-- end


function onTilt( event )
	physics.setGravity( (-9.8*event.yGravity), (-9.8*event.xGravity) ) --Το σωστό
end


function nextScene()
	audio.stop()
	audio.play( exitSound  )
	physics.stop()
    storyboard.state.score = storyboard.state.score+ (levelTime - (now - startTime))*100
    storyboard.state2.level = 14
    storyboard.gotoScene( "loadscene14")
end

local function gameOver()
	audio.stop()
	storyboard.gotoScene( "gameover", "fade", 300)
end

local function onCollision( event )
	if ( event.phase == "began" ) then
       if(event.object1.name=="exitscn" or event.object2.name=="exitscn") then
       		timer.performWithDelay ( 200, nextScene )
        end 
         if((event.object1.name =="blackholeSprite" and event.object2.name =="planet") or (event.object2.name =="blackholeSprite" and event.object1.name =="planet")) then
        	planetSprite.isVisible = false
        	explosionSprite.x=event.x
        	explosionSprite.y=event.y
			explosionSprite:play()
			timer.performWithDelay( 1500, gameOver )	    
        end 
          if((event.object1.name =="maze" and event.object2.name =="planet") or (event.object2.name =="maze" and event.object1.name =="planet")) then
        	local myCircle = display.newCircle( event.x, event.y, 4 )
			myCircle:setFillColor(math.random(0, 255),math.random(0, 255),math.random(0, 255))  
			screenGroup:insert( myCircle )
			--maze.isVisible
        end 
	end
end
 

local function checkTime(event)
  now = os.time()
  displayTime.text = levelTime - (now - startTime)
  if ( levelTime - (now - startTime)==0) then
	gameOver()
  end
end







-- Called when the scene's view does not exist:
function scene:createScene( event )
	screenGroup = self.view
	physics.start(); 
	physics.setGravity( 0,0 )
	
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
    		name="planetflashing",
		    start=1,
		    count=5,
		    time=500,        -- Optional. In ms.  If not supplied, then sprite is frame-based.
		    loopCount = 0,    -- Optional. Default is 0 (loop indefinitely)
		    loopDirection = "bounce"    -- Optional. Values include: "forward","bounce"
			}

	planetSprite = display.newSprite( planetSheet, planetSequenceData )
	planetSprite.x = 30
	planetSprite.y = display.contentCenterY
	planetSprite.name = "planet"
	planetSprite:play()

	
	
	maze=display.newImage( "maze13.png" )
	maze.x=display.contentCenterX
	maze.y=display.contentCenterY
	maze.name="maze"
	maze.isVisible = false

	
	maze2=display.newImage( "maze13.png" )
	maze2.x=display.contentCenterX
	maze2.y=display.contentCenterY
	maze2.name="maze"
	maze2.isVisible = false

	local blackholeoptions = {
   		width = 32,
   		height = 24,
   		numFrames = 4
		}

	local blackholeSheet = graphics.newImageSheet( "blackholesheet.png", blackholeoptions )

	local blackholeSequenceData =
			{
    		name="blackholeflashing",
		    start=1, --Starting loop
		    count=4,
		    time=800,        -- Optional. In ms.  If not supplied, then sprite is frame-based.
		    loopCount = 0,    -- Optional. Default is 0 (loop indefinitely)
		    loopDirection = "forward"    -- Optional. Values include: "forward","bounce"
			}

	blackholeSprite = display.newSprite( blackholeSheet, blackholeSequenceData )
	blackholeSprite.x = display.contentCenterX+30
	blackholeSprite.y = display.contentCenterY
	blackholeSprite.name = "blackholeSprite"
	blackholeSprite:play()

	blackholeSprite2 = display.newSprite( blackholeSheet, blackholeSequenceData )
	blackholeSprite2.x = 175
	blackholeSprite2.y = display.contentCenterY+45
	blackholeSprite2.name = "blackholeSprite"
	blackholeSprite2:play()

	blackholeSprite3 = display.newSprite( blackholeSheet, blackholeSequenceData )
	blackholeSprite3.x = display.contentCenterX-35
	blackholeSprite3.y = display.contentCenterY
	blackholeSprite3.name = "blackholeSprite"
	blackholeSprite3:play()

	blackholeSprite4 = display.newSprite( blackholeSheet, blackholeSequenceData )
	blackholeSprite4.x = display.contentCenterX-10
	blackholeSprite4.y = display.contentCenterY-100
	blackholeSprite4.name = "blackholeSprite"
	blackholeSprite4:play()

	blackholeSprite5 = display.newSprite( blackholeSheet, blackholeSequenceData )
	blackholeSprite5.x = display.contentCenterX+50
	blackholeSprite5.y = display.contentCenterY-105
	blackholeSprite5.name = "blackholeSprite"
	blackholeSprite5:play()

	-- blackholeSprite6 = display.newSprite( blackholeSheet, blackholeSequenceData )
	-- blackholeSprite6.x = display.contentCenterX+50
	-- blackholeSprite6.y = display.contentCenterY-10
	-- blackholeSprite6.name = "blackholeSprite"
	-- blackholeSprite6:play()

	-- blackholeSprite7 = display.newSprite( blackholeSheet, blackholeSequenceData )
	-- blackholeSprite7.x = display.contentCenterX+100
	-- blackholeSprite7.y = display.contentCenterY+50
	-- blackholeSprite7.name = "blackholeSprite"
	-- blackholeSprite7:play()

	-- blackholeSprite8 = display.newSprite( blackholeSheet, blackholeSequenceData )
	-- blackholeSprite8.x = display.contentCenterX+120
	-- blackholeSprite8.y = display.contentCenterY-50
	-- blackholeSprite8.name = "blackholeSprite"
	-- blackholeSprite8:play()


	
	
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

	local explosionoptions = {
   		width = 32,
   		height = 32,
   		numFrames = 24
		}
		
	local explosionSheet = graphics.newImageSheet( "explosion.png", explosionoptions )

	local explosionSequenceData =
		{
    		name="explosionsequence",
		    start=1,
		    count=24,
		    time=2000,        -- Optional. In ms.  If not supplied, then sprite is frame-based.
		    loopCount = 1,    -- Optional. Default is 0 (loop indefinitely)
		    loopDirection = "forward"    -- Optional. Values include: "forward","bounce"
		}


	explosionSprite = display.newSprite( explosionSheet, explosionSequenceData )
	explosionSprite.x = 100
	explosionSprite.y = 50
	explosionSprite.name = "explosion"


	
	physics.addBody (planetSprite, "dynamic",physicsData:get("earthphysics"))
	planetSprite.isSleepingAllowed = false
	physics.addBody (blackholeSprite, "static",physicsData:get("blackhole"))
	blackholeSprite.isSleepingAllowed = false
	physics.addBody (blackholeSprite2, "static",physicsData:get("blackhole"))
	blackholeSprite2.isSleepingAllowed = false
	physics.addBody (blackholeSprite3, "static",physicsData:get("blackhole"))
	blackholeSprite3.isSleepingAllowed = false
	physics.addBody (blackholeSprite4, "static",physicsData:get("blackhole"))
	blackholeSprite4.isSleepingAllowed = false
	physics.addBody (blackholeSprite5, "static",physicsData:get("blackhole"))
	blackholeSprite5.isSleepingAllowed = false
	-- physics.addBody (blackholeSprite6, "static",physicsData:get("blackhole"))
	-- blackholeSprite6.isSleepingAllowed = false
	-- physics.addBody (blackholeSprite7, "static",physicsData:get("blackhole"))
	-- blackholeSprite7.isSleepingAllowed = false
	-- physics.addBody (blackholeSprite8, "static",physicsData:get("blackhole"))
	-- blackholeSprite8.isSleepingAllowed = false
	physics.addBody (maze, "static",physicsData:get("mazelevel13_1"))
	physics.addBody (maze2, "static",physicsData:get("mazelevel13_2"))
	physics.addBody (borderleft, "static",{ friction=0.5, bounce=0 })
    physics.addBody (borderright, "static",{ friction=0.5, bounce=0 })
    physics.addBody (borderup, "static",{ friction=0.5, bounce=0 })
    physics.addBody (borderdown, "static",{ friction=0.5, bounce=0 })
	physics.addBody (exitscn, "static",physicsData:get("exitscn"))
	
	planetSprite:addEventListener ( "touch", nextScene )
	Runtime:addEventListener("enterFrame", checkTime)

	--Runtime:addEventListener( "enterFrame", mazeRotate)
	--Runtime:addEventListener( "gyroscope", onGyroscopeDataReceived )
	Runtime:addEventListener( "collision", onCollision )
	Runtime:addEventListener( "accelerometer", onTilt )

	
	screenGroup:insert( background )
	screenGroup:insert(displayTime)
	screenGroup:insert( planetSprite )
	screenGroup:insert( maze )
	screenGroup:insert( maze2 )
	screenGroup:insert( blackholeSprite )
	screenGroup:insert( blackholeSprite2 )
	screenGroup:insert( blackholeSprite3 )
	screenGroup:insert( blackholeSprite4 )
	screenGroup:insert( blackholeSprite5 )
	-- screenGroup:insert( blackholeSprite6 )
	-- screenGroup:insert( blackholeSprite7 )
	-- screenGroup:insert( blackholeSprite8 )
	screenGroup:insert( borderleft )
	screenGroup:insert( borderright )
	screenGroup:insert( borderdown)
	screenGroup:insert( borderup)
	screenGroup:insert( exitscn )
	screenGroup:insert( explosionSprite )

	
	
end




-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )

	print( "1: enterScene event" )
	physics.start()
    audio.play(backgroundMusicSound)
	startTime = os.time()
	transition.to ( displayTime, {alpha=1,time=500} )
	
	
end


-- Called when scene is about to move offscreen:
function scene:exitScene( event )
	
	print( "1: exitScene event" )
	physics.stop( )
    audio.stop()

	Runtime:removeEventListener( "enterFrame", checkTime )
	
	-- Runtime:removeEventListener( "enterFrame", mazeRotate )

    -- Runtime:removeEventListener( "gyroscope", onGyroscopeDataReceived )
    Runtime:removeEventListener( "collision", onCollision )
    Runtime:removeEventListener( "accelerometer", onTilt )

end


-- Called prior to the removal of scene's "view" (display group)
function scene:destroyScene( event )

	print( "((destroying scene 1's view))" )
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