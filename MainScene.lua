-- #################### 外部プログラム読み込み (始まり) ################
local composer = require("composer")
local resources = require("Resources")
local physics = require("physics")
-- #################### 外部プログラム読み込み (終わり) ################



-- #################### 外部プログラム設定 (始まり) ####################
-- 画面自動削除を有効
composer.recycleOnSceneChange = true

-- シーンを新規作成
local scene = composer.newScene()

-- 物理演算スタート
physics.start()
physics.setGravity(0, 0)
-- #################### 外部プログラム設定 (終わり) ####################



-- #################### ファイル内宣言 (始まり) ########################
-- # ファイル内で使用する変数、ファンクションを設定します
-- ####################################################################
-- 幅を取得し変数に代入
local w = display.contentWidth
-- 高さを取得し変数に代入
local h = display.contentHeight

local balls = {}

-- ボールをタッチした時の動作
local function onBallTouch(event)
	if (event.phase == "ended") then
		-- ResultScene起動
		composer.gotoScene("ResultScene", {effect = "fade", time = 1000, params = {index = event.target.tag}})
		return true
	end
end

-- 端末が動いた時の動作
function onAccelerometer(event)
	if event.isShake then
		-- 端末が振られた
		for index, ball in pairs(balls) do
			-- すべてのボールにランダムな力を加える
			ball:applyLinearImpulse(math.random(-w, w), math.random(-w, w), ball.x, ball.y)
		end
	end
end
-- #################### ファイル内宣言 (終わり) ########################



-- #################### シーン設定 (始まり) ############################
-- # シーン(画面)の動作を設定します
-- ####################################################################
function scene:create( event )

    -- 背景オブジェクトの作成
    local bg = display.newImageRect(self.view, ImagePath.bg, w, h)
	bg.x = w/2
	bg.y = h/2

	-- 四方に壁を作る
	local walls = {
		display.newRect(self.view, 0, h/2, 10, h),
		display.newRect(self.view, w/2, 0, w, 10),
		display.newRect(self.view, w, h/2, 10, h),
		display.newRect(self.view, w/2, h, w, 10)
	}

	-- 物理エンジンに壁を追加する
	for index, wall in pairs(walls) do
		physics.addBody(wall, "static", {})
	end

	-- 5個ボールを作る
	local ballNum = 5
	local i
	for i = 1, ballNum, 1 do
		balls[i] = display.newCircle(self.view, math.random(display.contentWidth), math.random(display.contentHeight), w/10)
		balls[i]:setFillColor(math.random(), math.random(), math.random(), 0.1)
		balls[i].tag = i
		physics.addBody(balls[i], {bounce = 0.75, radius = balls[i].width/2})
	end
end

function scene:show(event)
    local phase = event.phase

    if phase == "did" then
        --シーン表示への切り替え完了
        --ここにタイマーの開始、オブジェクトのアニメーションの開始、BGMの再生、オブジェクトを
        --タッチイベントの対象に設定する記述をする

        --リスナーを登録する
		Runtime:addEventListener("accelerometer", onAccelerometer)

		for index, ball in pairs(balls) do
			--ボールオブジェクトをタッチイベントの対象に設定する
			ball:addEventListener("touch", onBallTouch)
		end
    end
end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
-- #################### シーン設定 (終わり) ############################



return scene
