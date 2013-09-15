-----------------------------------------------------------------------------------------
--
-- Credits
--
-----------------------------------------------------------------------------------------

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

local sqlite3 = require "sqlite3"
local path = system.pathForFile("data.db", system.DocumentsDirectory)
db = sqlite3.open( path )   




local widget = require "widget"
local gameoverSound = audio.loadStream ( "gameover.mp3" )
local buttonClickSound = audio.loadSound("button_click.wav")

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
	


    --insert highscore
	db:exec[[CREATE TABLE highscoretable (id INTEGER PRIMARY KEY, content INTEGER);]]
	local highscorefill =[[INSERT INTO highscoretable VALUES (NULL, ']]..storyboard.state.score..[['); ]]
	db:exec( highscorefill )

	--insert the highest level of the current game
	db:exec[[CREATE TABLE levelstable (id INTEGER PRIMARY KEY, content INTEGER);]]
	local levelfill =[[INSERT INTO levelstable VALUES (NULL, ']]..storyboard.state2.level..[['); ]]
	db:exec( levelfill )
	
	for row in db:nrows("SELECT * FROM highscoretable") do
	 print(row.id .. " " .. row.content)
	end
	
	
		-- display a background image
	local background = display.newImageRect( "background.png", display.contentWidth, display.contentHeight )
	background:setReferencePoint( display.TopLeftReferencePoint )
	background.x, background.y = 0, 0
	

	
	local gameoverText=display.newText("GAME OVER\nScore: " ..  storyboard.state.score,display.contentCenterX-100, display.contentCenterY-50)
	gameoverText:setReferencePoint( display.CenterReferencePoint )
	gameoverText:setTextColor (250, 250, 250 )
	gameoverText.size=40
	--gameover.x = display.contentWidth * 0.5
	--gameoverText.y = 150
	
		backBtn = widget.newButton{
		label="Menu",
		labelColor = { default={255}, over={128} },
		fontSize=25,
		defaultFile="button.png",
		overFile="button-over.png",
		width=154, height=40,
		onRelease = onBackBtnRelease	-- event listener function
	}
	backBtn:setReferencePoint( display.CenterReferencePoint )
	backBtn.x = display.contentWidth*0.5
	backBtn.y = display.contentHeight - 75
	
	group:insert( background )

	group:insert( backBtn )
	group:insert( gameoverText )

	

end

-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	local group = self.view
	--audio.play(gameoverSound)
	
	
	
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