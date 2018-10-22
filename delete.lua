ye = require("ye")
local composer = require( "composer" )

btn_bg = {"btns/buttonRed.png","btns/buttonRedOver.png"}

--init the text field as local (so we can access it)

local text_input_id
local text_input_text

---------event handlers-----------

local function yback( event )
  composer.gotoScene( "todo_list" )
end--add

local function ydelete( event )

  --input_get = text_input_id.text--get text

  data_to_do_file = ye:get_txt_file("todo2.txt")--get data
  data_to_do_file_r = ye:split(data_to_do_file,"#")--convert to array
  data_to_do_file = ""
  del_id = tonumber(text_input_id.text)--deleate id
  --loop and fibd by id and replace with input_get
  for i = 1, #data_to_do_file_r do
   if(i == del_id) then--if i equals input id(convert input_id to int too)
      table.remove(data_to_do_file_r, i) 
      print(i)
   end
  
   item = data_to_do_file_r[i] or ""
   if(i>1 and item>"" )then
      
      data_to_do_file = data_to_do_file.."#"..item
    else
      data_to_do_file = data_to_do_file..item--add # to all exept first element
    end--if
    
  end--for
 --print(data_to_do_file)
  ye:save_txt(data_to_do_file,"todo2.txt")--save new data
  composer.gotoScene( "todo_list" )--go back after add
 
end--add


---------------scene---------

local scene = composer.newScene()


function scene:create( event )

    local sceneGroup = self.view
    back = ye:btn(155,20,{df=btn_bg[1],of=btn_bg[2],txt="back",func = yback})
    back.parent = sceneGroup
    
    edit = ye:btn(155,80,{df=btn_bg[1],of=btn_bg[2],txt="delete",func = ydelete})
    edit.parent = sceneGroup
    
    text_input_id = ye:txtbox(150,180,180,40)
    text_input_id.text ="task id here"
    

    sceneGroup:insert(back)
    sceneGroup:insert(edit)
    
end--end create

-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

	elseif ( phase == "did" ) then
     if( text_input_id ) then
              text_input_id.isVisible = true
     end--if text_input
     

    
	end
end


-- hide()
function scene:hide( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then

	elseif ( phase == "did" ) then
    if( text_input_id ) then
          text_input_id.isVisible = false
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