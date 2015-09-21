-- #################### 外部データ読み込み (始まり) ####################
local composer = require("composer")
local resources = require("Resources")
-- #################### 外部データ読み込み (終わり) ####################



-- #################### 外部プログラム設定 (始まり) ####################
-- シーンを新規作成
local scene = composer.newScene()
-- #################### 外部プログラム設定 (終わり) ####################



-- #################### ファイル内宣言 (始まり) ########################
-- # ファイル内で使用する変数、ファンクションを設定します
-- ####################################################################
-- 幅を取得し変数に代入
local w = display.contentWidth
-- 高さを取得し変数に代入
local h = display.contentHeight

local fortuneImage

-- タッチした時の動作
local function onTouch(event)
	if (event.phase == "ended")then
		composer.gotoScene("MainScene", {effect = "fade", time = 1000})
		return true
	end
end

-- キーを押した時の動作
local function onKeyEvent(event)
    if ( event.keyName == "back" ) then
        local platformName = system.getInfo( "platformName" )
        if ( platformName == "Android" ) then
			-- バックボタンを押したなおかつAndroid
			-- MainScene起動
        	composer.gotoScene( "MainScene", { effect = "fade", time = 300 } )

            return true
        end
    end
    return false
end
-- #################### ファイル内宣言 (終わり) ########################



-- #################### シーン設定 (始まり) ############################
-- # シーン(画面)の動作を設定します
-- ####################################################################
function scene:create(event)
	local index = event.params.index
	local margin = w/20

	-- 背景オブジェクトの作成
	local bg = {}
	-- 下地の背景
    bg[0] = display.newRect(self.view, w/2, h/2, w, h)
	-- 手前の背景
	bg[1] = display.newRect(self.view, w/2, h/2, w-margin, h-margin)
	bg[1]:setFillColor(0.95, 0.9, 0.9)

	-- 画像表示
	fortuneImage = display.newImageRect(self.view, ImagePath.fortune[index], w/2, w/2)
	fortuneImage.x = w/2
	fortuneImage.y = h/4

	-- テキスト表示
	local message = display.newText(self.view, String.message[index], w/2, h*(3/4), w - margin*4, h/2, nil, w/20)
	message:setFillColor(0, 0, 0)
end

function scene:show(event)
    local phase = event.phase

    if phase == "did" then
        -- シーン表示への切り替え完了
        -- ここにタイマーの開始、オブジェクトのアニメーションの開始、BGMの再生、オブジェクトを
        -- タッチイベントの対象に設定する記述をする
        fortuneImage:addEventListener("touch", onTouch)
		Runtime:addEventListener( "key", onKeyEvent )

    end
end

scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
-- #################### シーン設定 (終わり) ############################



return scene
