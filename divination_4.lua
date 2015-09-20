---------------------------------------------------------------------------------
--
-- scene.lua
--
---------------------------------------------------------------------------------

local sceneName = ...

local composer = require( "composer" )

-- Load scene with same root filename as this file
local scene = composer.newScene( sceneName )

---------------------------------------------------------------------------------
--ここからfunction scene:create(event)までの間にこのシーン内で使用する、変数・functionを宣言


--幅を取得し変数に代入
local _W = display.contentWidth
--高さを取得し変数に代入
local _H = display.contentHeight
local rect
local _rect
local text
local unlucky_image

--タッチした時の動作
local function onTouch(event)
	if (event.phase == "ended")then
		composer.gotoScene("scene1", {effect = "fade", time = 1000})
		composer.removeScene("divination_4", false)
		return true
	end
end

---------------------------------------------------------------------------------
--ここまで


function scene:create( event )
    local sceneGroup = self.view
    
    -- Called when the scene's view does not exist
    -- ここにオブジェクトの作成、グループへの追加を記述します。
    
	--背景オブジェクトの作成  
    rect = display.newRect(_W/2, _H/2, _W, _H)
	_rect = display.newRect(_W/2, _H/2, _W-20, _H-20)
	_rect:setFillColor(0.95, 0.9, 0.9)
	
	--画像表示
	unlucky_image = display.newImage("unlucky.png", _W/2, _H/4)
	unlucky_image:scale(0.2, 0.2)
	
	--テキスト表示
	text = 
		display.newText("今日のあなたの運勢は不調！！外に出ると危険がそこかしこにあるかも",
		 _W/2, _H*3/4, 300, 300, nil, 20)
	text:setFillColor(0, 0, 0)
	
end

-------------------------------------------------------------------------------


function scene:show( event )
    local sceneGroup = self.view
    local phase = event.phase

    if phase == "will" then
        --シーン表示切り替え中
		--ここには何も書かない
    elseif phase == "did" then
        --シーン表示への切り替え完了
        --ここにタイマーの開始、オブジェクトのアニメーションの開始、BGMの再生、オブジェクトを
        --タッチイベントの対象に設定する記述をする
        -- Add the key event listener
        unlucky_image:addEventListener("touch", onTouch)

    end 
end

-------------------------------------------------------------------------------


function scene:hide( event )
    local sceneGroup = self.view
    local phase = event.phase

    if event.phase == "will" then
        --シーン非表示へ切り替え中
        --ここにタイマーの停止、オブジェクトのアニメーションの停止、BGMの停止、
        --オブジェクトをタッチイベントの対象から解除する記述をする
    elseif phase == "did" then
        --シーン非表示への切り替え完了
        --ここにはなにも書かない
		
    end 
end

-------------------------------------------------------------------------------


function scene:destroy( event )
    local sceneGroup = self.view

    --次の画面に遷移するためにシーンを破棄する直前に呼び出される
    --ここにオブジェクトの削除、スコアの保存などを記述してシーンを削除する
end

-------------------------------------------------------------------------------


-------------------------------------------------------------------------------

local function onKeyEvent( event )
    -- Print which key was pressed down/up
    local message = "Key '" .. event.keyName .. "' was pressed " .. event.phase
    print( message )

    -- If the "back" key was pressed on Android or Windows Phone, prevent it from backing out of the app
    if ( event.keyName == "back" ) then
        local platformName = system.getInfo( "platformName" )
        if ( platformName == "Android" ) then
        display.newCircle(100, 100, 100)
        	composer.gotoScene( "scene1", { effect = "fade", time = 300 } )
            return true
        end
    end

    -- IMPORTANT! Return false to indicate that this app is NOT overriding the received key
    -- This lets the operating system execute its default handling of the key
    return false
end

-- Add the key event listener
Runtime:addEventListener( "key", onKeyEvent )

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

---------------------------------------------------------------------------------

return scene
