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

local balls = {}

--ボール1をタッチした時の動作
local function onTouch_1(event)
	if (event.phase == "ended")then
		composer.gotoScene("divination_1", {effect = "fade", time = 1000})
		return true
	end
end
--ボール2をタッチした時の動作
local function onTouch_2(event)
	if (event.phase == "ended")then
		composer.gotoScene("divination_2", {effect = "fade", time = 1000})
		return true
	end
end
--ボール3をタッチした時の動作
local function onTouch_3(event)
	if (event.phase == "ended")then
		composer.gotoScene("divination_3", {effect = "fade", time = 1000})
		return true
	end
end
--ボール4をタッチした時の動作
local function onTouch_4(event)
	if (event.phase == "ended")then
		composer.gotoScene("divination_4", {effect = "fade", time = 1000})
		return true
	end
end
--ボール5をタッチした時の動作
local function onTouch_5(event)
	if (event.phase == "ended")then
		composer.gotoScene("divination_5", {effect = "fade", time = 1000})
		return true
	end
end


--コールバック関数
function onAccelerometer(event)
	--加速度センサーイベント
	if event.isShake then
		--端末が振られた
		for index, ball in pairs(balls) do
			--すべてのボールにランダムな力を加える
			ball:applyForce(math.random(500), math.random(500))
		end
	end
end

-------------------------------------------------------------------------------
--ここまで

function scene:create( event )
    local sceneGroup = self.view

    -- Called when the scene's view does not exist
    -- ここにオブジェクトの作成、グループへの追加を記述します。
    
    --背景オブジェクトの作成    
     local bg = display.newImage("bg.png", _W/2, _H/2)

	--四方に壁を作る
	local walls = {
		display.newRect(0, 0, 10, _H*2),
		display.newRect(0, 0, _W*2, 10),
		display.newRect(_W, 0, 10, _H*2),
		display.newRect(_W, _H, _W*3, 10)
	}
	--5個ボールを作る
	balls[1] = display.newCircle(math.random(display.contentWidth),
		math.random(display.contentHeight), 40)
	balls[1]:setFillColor(math.random(), math.random(), math.random(), 0.1)

	balls[2] = display.newCircle(math.random(display.contentWidth),
		math.random(display.contentHeight), 40)
	balls[2]:setFillColor(math.random(), math.random(), math.random(), 0.1)

	balls[3] = display.newCircle(math.random(display.contentWidth),
		math.random(display.contentHeight), 40)
	balls[3]:setFillColor(math.random(), math.random(), math.random(), 0.1)

	balls[4] = display.newCircle(math.random(display.contentWidth),
		math.random(display.contentHeight), 40)
	balls[4]:setFillColor(math.random(), math.random(), math.random(), 0.1)
	
	balls[5] = display.newCircle(math.random(display.contentWidth),
		math.random(display.contentHeight), 40)
	balls[5]:setFillColor(math.random(), math.random(), math.random(), 0.1)

	--オブジェクトを画面のグループに追加
	sceneGroup:insert(bg)


	--物理演算を開始する
	physics.start()
	physics.setGravity(0, 0)

	--物理エンジンに壁を追加する
	for index, wall in pairs(walls) do
		physics.addBody(wall, "static", {})
	end

	--弾性値を大きめにして物理エンジンにボールを追加する
	for index, ball in pairs(balls) do
		physics.addBody(ball, {bounce = 0.75, radius = 40})
	end
end

---------------------------------------------------------------------------------



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
        
        --リスナーを登録する
		Runtime:addEventListener("accelerometer", onAccelerometer)
		--ボールオブジェクトをタッチイベントの対象に設定する
        balls[1]:addEventListener("touch", onTouch_1)
        --ボールオブジェクト2をタッチイベントの対象に設定する
        balls[2]:addEventListener("touch", onTouch_2)
        --ボールオブジェクト3をタッチイベントの対象に設定する
        balls[3]:addEventListener("touch", onTouch_3)
        --ボールオブジェクト4をタッチイベントの対象に設定する
        balls[4]:addEventListener("touch", onTouch_4)
        --ボールオブジェクト5をタッチイベントの対象に設定する
        balls[5]:addEventListener("touch", onTouch_5)
    end 
end

---------------------------------------------------------------------------------


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

---------------------------------------------------------------------------------


function scene:destroy( event )
    local sceneGroup = self.view

    --次の画面に遷移するためにシーンを破棄する直前に呼び出される
    --ここにオブジェクトの削除、スコアの保存などを記述してシーンを削除する
    
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

---------------------------------------------------------------------------------

return scene
