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
    storyboard.state.score =storyboard.state.score+ (levelTime - (now - startTime))*60
    storyboard.gotoScene( "menu")
end

local function onCollision( event )
	if ( event.phase == "ended" ) then
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
  if ( levelTime - (now - startTime)==0) then
	gameOver()
  end
end

local function changeGravity()
	if(planetSprite.y>display.contentCenterY)then
	physics.setGravity( 0,2.5 )
	end
	if(planetSprite.y<display.contentCenterY)then
	physics.setGravity( 0,0)
	end
end





-- Called when the scene's view does not exist:
function scene:createScene( event )
	local screenGroup = self.view
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
    		name="blackholeflashing",
		    start=1,
		    count=5,
		    time=500,        -- Optional. In ms.  If not supplied, then sprite is frame-based.
		    loopCount = 0,    -- Optional. Default is 0 (loop indefinitely)
		    loopDirection = "bounce"    -- Optional. Values include: "forward","bounce"
			}

	planetSprite = display.newSprite( planetSheet, planetSequenceData )
	planetSprite.x = 75
	planetSprite.y = 15
	planetSprite.x = 30
	planetSprite.y = display.contentCenterY
	planetSprite.name = "planet"
	planetSprite:play()

	maze=display.newImage( "maze5.png" )
	maze.x=display.contentCenterX
	maze.y=display.contentCenterY
	maze.name="maze"
	
	maze2=display.newImage( "maze5.png" )
	maze2.x=display.contentCenterX
	maze2.y=display.contentCenterY
	maze2.name="maze2"
	
	wave=display.newImageRect( "wave.png", display.contentWidth, display.contentHeight )
	wave.x=display.contentCenterX
	wave.y=display.contentCenterY
	wave.name="wave"
	wave.alpha=0.6
	
	borders=display.newImage( "borders.png" )
	borders.x=display.contentCenterX
	borders.y=display.contentCenterY
	borders.name="borders"
	borders.alpha=0.1
	
	exitscn=display.newImage("exit.png")
	exitscn.x=display.contentWidth-30
	exitscn.y=display.contentCenterY
	exitscn.name="exitscn"
	
	physics.addBody (planetSprite, "dynamic",physicsData:get("earthphysics"))
	physics.addBody (maze, "static",physicsData:get("mazelevel6_1"))
	physics.addBody (maze2, "static",physicsData:get("mazelevel6_2"))
	physics.addBody (borders, "static",physicsData:get("borders"))
	physics.addBody (exitscn, "static",physicsData:get("exitscn"))
	
	planetSprite:addEventListener ( "touch", nextScene )
	Runtime:addEventListener("enterFrame", checkTime)
	Runtime:addEventListener("enterFrame", changeGravity)
	--Runtime:addEventListener( "enterFrame", mazeRotate)
	--Runtime:addEventListener( "gyroscope", onGyroscopeDataReceived )
	Runtime:addEventListener( "collision", onCollision )
	
	screenGroup:insert( background )
	screenGroup:insert(displayTime)
	screenGroup:insert( planetSprite )
	screenGroup:insert( maze )
	screenGroup:insert( maze2 )
	screenGroup:insert( wave )
	screenGroup:insert( borders )
	screenGroup:insert( exitscn )
	

	print( "\n1: createScene event")
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
	Runtime:removeEventListener( "enterFrame", changeGravity )
	Runtime:removeEventListener( "enterFrame", mazeRotate )
    Runtime:removeEventListener( "gyroscope", onGyroscopeDataReceived )
    Runtime:removeEventListener( "collision", onCollision )
	
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