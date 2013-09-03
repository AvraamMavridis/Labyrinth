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
local displayTime,background,ball,maze,maze2,borders,exitscn
local startTime=0
local levelTime = 20

local now
local exitSound = audio.loadSound("exit.wav")
local backgroundMusicSound = audio.loadStream ( "background.mp3" )


local function onGyroscopeDataReceived( event )
    local deltaRadiansX = event.xRotation * event.deltaTime
    local deltaDegreesX = deltaRadiansX * (180 / math.pi)
    local deltaRadiansY = event.yRotation * event.deltaTime
    local deltaDegreesY = deltaRadiansY * (180 / math.pi)
    ball:applyForce( -deltaDegreesX*3, -deltaDegreesY*3, ball.x, ball.y )
end



function nextScene()
	audio.stop()
	audio.play( exitSound  )
	physics.stop()
    storyboard.state.score =storyboard.state.score+ (levelTime - (now - startTime))*10
    storyboard.gotoScene( "loadscene2")
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





-- Called when the scene's view does not exist:
function scene:createScene( event )
	local screenGroup = self.view
	physics.start(); 
	physics.setGravity( 0,0 )
	
	displayTime = display.newText(levelTime, display.contentWidth-30, 5)
	displayTime.alpha=0
	displayTime:setTextColor( 188,33, 33 )

	background = display.newImageRect( "background.png", display.contentWidth, display.contentHeight )
	background:setReferencePoint( display.TopLeftReferencePoint )
	background.x, background.y = 0, 0
		
	ball=display.newImage("ball1.png")
	ball.x=30
	ball.y=display.contentCenterY
	ball.name="ball"

	maze=display.newImage( "maze1.png" )
	maze.x=display.contentCenterX
	maze.y=display.contentCenterY
	maze.name="maze"
	
	maze2=display.newImage( "maze1.png" )
	maze2.x=display.contentCenterX
	maze2.y=display.contentCenterY
	maze2.name="maze2"
	
	borders=display.newImage( "borders.png" , display.contentWidth, display.contentHeight )
	borders:setReferencePoint( display.TopLeftReferencePoint )
	borders.x, borders.y = 0, 0
	borders.name="borders"
	borders.alpha=0.7
	
	exitscn=display.newImage("exit.png")
	exitscn.x=display.contentWidth-30
	exitscn.y=display.contentCenterY
	exitscn.name="exitscn"
	
	physics.addBody (ball, "dynamic",physicsData:get("ball"))
	physics.addBody (maze, "static",physicsData:get("mazelevel1_1"))
	physics.addBody (maze2, "static",physicsData:get("mazelevel1_2"))
	physics.addBody (borders, "static",physicsData:get("borders"))
	physics.addBody (exitscn, "static",physicsData:get("exitscn"))
	
	ball:addEventListener ( "touch", nextScene )
	Runtime:addEventListener("enterFrame", checkTime)
	Runtime:addEventListener( "gyroscope", onGyroscopeDataReceived )
	Runtime:addEventListener( "collision", onCollision )
	
	screenGroup:insert( background )
	screenGroup:insert(displayTime)
	screenGroup:insert( ball )
	screenGroup:insert( maze )
	screenGroup:insert( maze2 )
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