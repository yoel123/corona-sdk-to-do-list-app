ye = require("ye")
local composer = require( "composer" )

btn_bg = {"btns/buttonRed.png","btns/buttonRedOver.png"}

--init the text field as local (so we can access it)

local text_input

---------event handlers-----------

local function yback( event )
  composer.gotoScene( "todo_list" )
end--add

local function yadd( event )

  input_get = "#"..text_input.text--get text
  --print(input_get)
  data_to_do_file = ye:get_txt_file("todo2.txt")..input_get --get data file and append new task to it
  ye:save_txt(data_to_do_file,"todo2.txt")--save new data
  composer.gotoScene( "todo_list" )--go back after add
  
end--add


---------------scene---------

local scene = composer.newScene()


function scene:create( event )

    local sceneGroup = self.view
    back = ye:btn(155,20,{df=btn_bg[1],of=btn_bg[2],txt="back",func = yback})
    back.parent = sceneGroup
    
    add = ye:btn(155,80,{df=btn_bg[1],of=btn_bg[2],txt="add",func = yadd})
    add.parent = sceneGroup
    
    text_input = ye:txtbox(150,150,180,40)
    
    
    sceneGroup:insert(back)
    sceneGroup:insert(add)
    
end--end create

-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

	elseif ( phase == "did" ) then
     if( text_input ) then
              text_input.isVisible = true
        end--if text_input
	end
end


-- hide()
function scene:hide( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then

	elseif ( phase == "did" ) then
    if( text_input ) then
          text_input.isVisible = false
    end--if text_input
	end
end


-- destroy()
function scene:destroy( event )

	local sceneGroup = self.view

end


-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------



return scene