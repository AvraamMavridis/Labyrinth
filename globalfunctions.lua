local globalfunctions = {}

globalfunctions.onTilt = function ( event )
	physics.setGravity( (-9.8*event.yGravity), (-9.8*event.xGravity) ) 
end


globalfunctions.gameOver = function()
	audio.stop()
	storyboard.gotoScene( "gameover", "fade", 300)
end

globalfunctions.nextScene = function (loadscene,scene,levelTime,now,startTime)
	physics.stop()
    storyboard.state.score = storyboard.state.score + (levelTime - (now - startTime)) * 10
    storyboard.state2.level = scene
    storyboard.gotoScene( loadscene)
end


--function to display the time
globalfunctions.checkTime = function(displayTime,levelTime,now,startTime)
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
	globalfunctions.gameOver()
  end
end


globalfunctions.onCollision = function ( event,loadscene,scene,levelTime,now,startTime )
	if ( event.phase == "began" ) then
       if(event.object1.name=="exitscn" or event.object2.name=="exitscn") then
       		timer.performWithDelay ( 200, function() globalfunctions.nextScene(loadscene,scene,levelTime,now,startTime) end)
        end 
	end
end

globalfunctions.test = function ( event,loadscene,scene,levelTime,now,startTime )
	-- if ( event.phase == "began" ) then
 --       if(event.object1.name=="exitscn" or event.object2.name=="exitscn") then
 --       		timer.performWithDelay ( 200, function() globalfunctions.nextScene(loadscene,scene,levelTime,now,startTime) end)
 --        end 
	-- end

	timer.performWithDelay ( 200, function() globalfunctions.nextScene(loadscene,scene,levelTime,now,startTime) end)
end




return globalfunctions