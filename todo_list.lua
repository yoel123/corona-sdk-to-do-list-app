ye = require("ye")
composer = require( "composer" )

btn_bg = {"btns/buttonRed.png","btns/buttonRedOver.png"}

-----------init vars-----------
local data_to_do_file = nil--these are for the table data
local data_to_do = nil --init data

----------------event funcs--------------

local function get_data(  )-- add click event

data_to_do_file = ye:get_txt_file("todo2.txt")--try to call txt file
if(data_to_do_file==nil)then -- check if file not nil
  defult_data = "todo1#todo2#todo3";--defult data
  ye:save_txt(defult_data,"todo2.txt")--save defult data on a ile
  data_to_do =ye:split(defult_data,"#")-- split defult data where #
  print("file dosnt exist")
else
  data_to_do =ye:split(data_to_do_file,"#") --if file exists split its data by # to create an array
end--if

--print(data_to_do_file.." -data from file")
end--get data

--------add click
local function yadd( event )-- add click event
  local options = { effect = "fade", time = 200, params = { } }
  composer.gotoScene( "add",options)
end--add

--------edit click
local function yedit( event )--edit click event
  local options = { effect = "fade", time = 200, params = { } }
  composer.gotoScene( "edit" ,options)
end--edit

--------ydelete click
local function ydelete( event )--ydelete click event
  local options = { effect = "fade", time = 200, params = { } }
  composer.gotoScene( "delete" ,options)
end--edit


--table row render
local function list_render( event )
 
    -- Get reference to the row group
    local row = event.row
    local data = event.row.params[1]
  
    local rowHeight = row.contentHeight
    local rowWidth = row.contentWidth
     
    local rowTitle = display.newText( row,  row.index..") "..data , 0, 0, nil, 14 )
    rowTitle:setFillColor( 0 )
 
    -- Align the label left and vertically centered
    rowTitle.anchorX = 0
    rowTitle.x = 10
    rowTitle.y = rowHeight * 0.5
end--list_render

----------------end event funcs--------------


-----------scene------------

local scene = composer.newScene()
-------|create|----------------
function scene:create( event )

    local sceneGroup = self.view
    add = ye:btn(155,20,{df=btn_bg[1],of=btn_bg[2],txt="add",func = yadd})
    edit = ye:btn(155,80,{df=btn_bg[1],of=btn_bg[2],txt="edit",func = yedit})
    delete = ye:btn(155,140,{df=btn_bg[1],of=btn_bg[2],txt="delete",func = ydelete})
    add.parent = sceneGroup
    
    get_data( )--get tabe data
    list = ye:ytable(10,180,{row_render = list_render , data=data_to_do })
    list:deleteAllRows()
    sceneGroup:insert(add)
    sceneGroup:insert(edit)
    sceneGroup:insert(delete)
    
end--end create

-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		
	elseif ( phase == "did" ) then
    if( list ) then
      get_data()--re call data
      ye:set_rows(list,data_to_do)--reset rows with data
      list.isVisible = true
    
    end--if list
	end
end


-- hide()
function scene:hide( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then

	elseif ( phase == "did" ) then
     if( list ) then
      list.isVisible = false
    end--if list
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