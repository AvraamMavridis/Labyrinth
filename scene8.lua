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
local levelTime = 60
local score=0
local now
local exitSound = audio.loadSound("exit.wav")
local backgroundMusicSound = audio.loadStream ( "background.mp3" )
local alienSprite
local blackholeSprite = 0
local blackholeSprite2 = 0
local explosionSprite = 0
local screenGroup

-- local function onGyroscopeDataReceived( event )
--     local deltaRadiansX = event.xRotation * event.deltaTime
--     local deltaDegreesX = deltaRadiansX * (180 / math.pi)
--     local deltaRadiansY = event.yRotation * event.deltaTime
--     local deltaDegreesY = deltaRadiansY * (180 / math.pi)
--     ball:applyForce( -deltaDegreesX*6, -deltaDegreesY*6, ball.x, ball.y )
-- end

local function blackholeRotate()
	blackholeSprite:rotate(0.8)
	blackholeSprite2:rotate(0.8)
end

function onTilt( event )
	physics.setGravity( (-9.8*event.yGravity), (-9.8*event.xGravity) ) --Το σωστό
end


function nextScene()
	audio.stop()
	audio.play( exitSound  )
	physics.stop()
    storyboard.state.score =storyboard.state.score+ (levelTime - (now - startTime))*80
    storyboard.state2.level = 9
    storyboard.gotoScene( "loadscene9")
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
        if((event.object1.name =="alien" and event.object2.name =="planet") or (event.object2.name =="alien" and event.object1.name =="planet")) then
        	planetSprite.isVisible = false
        	explosionSprite.x=event.x
        	explosionSprite.y=event.y
			explosionSprite:play()
			timer.performWithDelay( 1500, gameOver )	    
        end 
        if((event.object1.name =="blackholeSprite" and event.object2.name =="planet") or (event.object2.name =="blackholeSprite" and event.object1.name =="planet")) then
        	planetSprite.isVisible = false
        	explosionSprite.x=planetSprite.x
        	explosionSprite.y=planetSprite.y
			explosionSprite:play()
			timer.performWithDelay( 1500, gameOver )
			    
        end 
   --      if((event.object1.name =="maze" and event.object2.name =="planet") or (event.object2.name =="maze" and event.object1.name =="planet")) then
   --      	local myCircle = display.newCircle( event.x, event.y, 3 )
			-- myCircle:setFillColor(math.random(0, 255),math.random(0, 255),math.random(0, 255))  
			-- screenGroup:insert( myCircle )
			-- --maze.isVisible
   --      end 
	end

end
 

local function checkTime(event)
  now = os.time()
  displayTime.text = levelTime - (now - startTime)
  if ( levelTime - (now - startTime)==0) then
	gameOver()
  end
end



local function moveAlien()
	alienSprite:applyForce( math.random(-50, 50), math.random(-50, 50), alienSprite.x, alienSprite.y )
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

	local alienoptions = {
   		width = 32,
   		height = 32,
   		numFrames = 8
		}

	local alienSheet = graphics.newImageSheet( "aliensheet.png", alienoptions )

	local alienSequenceData =
			{
    		name="alienflashing",
		    start=1,
		    count=8,
		    time=1000,        -- Optional. In ms.  If not supplied, then sprite is frame-based.
		    loopCount = 0,    -- Optional. Default is 0 (loop indefinitely)
		    loopDirection = "forward"    -- Optional. Values include: "forward","bounce"
			}

	alienSprite = display.newSprite( alienSheet, alienSequenceData )
	alienSprite.x = display.contentCenterX-49
	alienSprite.y = display.contentCenterY+40
	alienSprite.name = "alien"
	alienSprite:play()

	maze=display.newImage( "maze8.png" )
	maze.x=display.contentCenterX
	maze.y=display.contentCenterY
	maze.name="maze"

	
	maze2=display.newImage( "maze8.png" )
	maze2.x=display.contentCenterX
	maze2.y=display.contentCenterY
	maze2.name="maze"
	
	
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
	blackholeSprite.x = display.contentCenterX
	blackholeSprite.y = display.contentHeight-27
	blackholeSprite.name = "blackholeSprite"
	blackholeSprite:play()

	blackholeSprite2 = display.newSprite( blackholeSheet, blackholeSequenceData )
	blackholeSprite2.x = display.contentCenterX+50
	blackholeSprite2.y = display.contentHeight-27
	blackholeSprite2.name = "blackholeSprite"
	blackholeSprite2:play()
	
	physics.addBody (planetSprite, "dynamic",physicsData:get("earthphysics"))
	planetSprite.isSleepingAllowed = false
	physics.addBody (blackholeSprite, "static",physicsData:get("blackhole"))
	blackholeSprite.isSleepingAllowed = false
	physics.addBody (blackholeSprite2, "static",physicsData:get("blackhole"))
	blackholeSprite2.isSleepingAllowed = false
	physics.addBody (alienSprite, "dynamic",physicsData:get("earthphysics"))
	physics.addBody (maze, "static",physicsData:get("mazelevel8_1"))
	physics.addBody (maze2, "static",physicsData:get("mazelevel8_2"))
	physics.addBody (borderleft, "static",{ friction=0.5, bounce=0 })
    physics.addBody (borderright, "static",{ friction=0.5, bounce=0 })
    physics.addBody (borderup, "static",{ friction=0.5, bounce=0 })
    physics.addBody (borderdown, "static",{ friction=0.5, bounce=0 })
	physics.addBody (exitscn, "static",physicsData:get("exitscn"))
	
	planetSprite:addEventListener ( "touch", nextScene )
	Runtime:addEventListener("enterFrame", checkTime)
	Runtime:addEventListener("enterFrame", moveAlien)
	Runtime:addEventListener( "enterFrame", blackholeRotate)
	--Runtime:addEventListener( "enterFrame", mazeRotate)
	--Runtime:addEventListener( "gyroscope", onGyroscopeDataReceived )
	Runtime:addEventListener( "collision", onCollision )
	Runtime:addEventListener( "accelerometer", onTilt )

	
	screenGroup:insert( background )
	screenGroup:insert(displayTime)
	screenGroup:insert( planetSprite )
	screenGroup:insert( maze )
	screenGroup:insert( maze2 )
	screenGroup:insert( borderleft )
	screenGroup:insert( borderright )
	screenGroup:insert( borderdown)
	screenGroup:insert( borderup)
	screenGroup:insert( alienSprite )
	screenGroup:insert( exitscn )
	screenGroup:insert( explosionSprite )
	screenGroup:insert( blackholeSprite )
	screenGroup:insert( blackholeSprite2 )
	
	
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
	Runtime:removeEventListener("enterFrame", moveAlien)
	Runtime:removeEventListener( "enterFrame", blackholeRotate)
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