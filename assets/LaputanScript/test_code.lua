

-- 사운드 키 이벤트 콜백 함수
function callbackKeyEvent(virtualKey, up)
    local state
    if up then 
            state = "UP"
    else
            state = "Down"
    end

    local controlGo = gMeshRazor
    if virtualKey == Laputan.L_VK_Y then
    -- 정지된 사운드를 다시 플레이한다.
		Laputan.gAudioManager:play2DEffect(gSoundEffectForControl)
    elseif virtualKey == Laputan.L_VK_U then
		-- 사운드를 멈춘다.
        Laputan.gAudioManager:pauseEffect(gSoundEffectForControl)
    elseif virtualKey == Laputan.L_VK_Q then
        gMeshGo2Child:blendMeshMainAnimation("Idle")
    elseif virtualKey == Laputan.L_VK_W then
        gMeshGo2Child:blendMeshMainAnimation("Walk")
    elseif virtualKey == Laputan.L_VK_E then
        gMeshGo2Child:blendMeshMainAnimation("Slump")
    elseif virtualKey == Laputan.L_VK_R then
        gMeshGo2Child:blendMeshMainAnimation("Shoot")
    elseif virtualKey == Laputan.L_VK_T then
        gMeshGo2Child:blendMeshMainAnimation("Die",Laputan.ANIMATION_BLEND_FADEINOUT,0.5,false)	
    elseif virtualKey == Laputan.L_VK_LEFT then
        local pos = controlGo:getPositionXY()
        pos.x = pos.x - 30 
        controlGo:setPosition(pos)
        Laputan.gAudioManager:play2DEffect("ball.wav")

    elseif virtualKey == Laputan.L_VK_RIGHT then
        if(up == false) then
            local pos = controlGo:getPositionXY()
            pos.x = pos.x + 30 
            controlGo:setPosition(pos)
            Laputan.gAudioManager:play2DEffect("ball.wav")
        end

    elseif virtualKey == Laputan.L_VK_UP then
        local pos = controlGo:getPositionXY()
        pos.y = pos.y - 30 
        controlGo:setPosition(pos)
        Laputan.gAudioManager:play2DEffect("ball.wav")

    elseif virtualKey == Laputan.L_VK_DOWN then
        local pos = controlGo:getPositionXY()
        pos.y = pos.y + 30 
        controlGo:setPosition(pos)
        Laputan.gAudioManager:play2DEffect("ball.wav")
    elseif virtualKey == Laputan.L_VK_L then
        Laputan.gAudioManager:play2DEffect("nice_music.ogg")
    elseif virtualKey == Laputan.L_VK_I then
        controlGo:pitch(45)
    elseif virtualKey == Laputan.L_VK_O then
        controlGo:yaw(45)
    elseif virtualKey == Laputan.L_VK_P then
        controlGo:roll(45)		
    end

    Laputan.printLog(Laputan.LOG_CRITICAL,"virtual key : " .. virtualKey .. "  " .. state)
end

-- 마이크로 쓰레드를 이용한 테스트
function test_microThread(arg)
    Laputan.sleepThread(arg._sleepTick)
    arg.func()
end

function test_LVector2()
    local v1 = Laputan.LVector2(5,1)
    local v2 = Laputan.LVector2(3,2)
    local v3 = v1 + v2
    print( v3.x .. " , "  .. v3.y , "other expression : " , tostring(v3) )
end

function test_LLinkedList()
    print("######### LLinkedList Test ##########################")
    local myList = Laputan.LLinkedList()

    myList:pushBack(25)
    myList:pushFront("str25")
    myList:pushBack(4423)
    myList:pushBack(5555)
    myList:pushFront("str3333")
    myList:pushBack(92)


    -- str3333 str25 25 4423 5555 92
    -- str3333 abc str25 25 4423 5555 92
    -- ccc str3333 abc str25 25 4423 5555 92
    -- ccc abc str25 25 4423 5555 92
    -- abc str25 25 4423 5555 

--	Laputan.print_table(myList:peekFront():getNext():getNext())
    myList:insert(myList:peekFront():getNext(), "abc")
    myList:insert(myList:peekFront(), "ccc")

    myList:erase(myList:peekFront():getNext())
    myList:erase(myList:peekFront())
    myList:erase(myList:peekBack())


    print("LLinkedList_size : " .. myList:getSize())

    local num = 1
    local test_name = "LLinkedList_test"
    print(test_name .. num .. " : " .. myList:peekBack():getValue())
    num = num + 1
    print(test_name .. num .. " : " .. myList:peekBack():getPrev():getValue())
    num = num + 1
    print(test_name .. num .. " : " .. myList:peekBack():getPrev():getPrev():getValue())
    num = num + 1
    print(test_name .. num .. " : " .. myList:peekFront():getValue())
    num = num + 1	
    print(test_name .. num .. " : " .. myList:peekFront():getNext():getValue())
    num = num + 1
    print(test_name .. num .. " : " .. myList:peekFront():getNext():getNext():getValue())
    num = num + 1
    print(test_name .. num .. " : " .. myList:peekFront():getNext():getNext():getNext():getValue())

    print("LLinkedList_size : " .. myList:getSize())

    print("LLinkedList_pop_test")
    while myList:getSize() > 0 do
            print(test_name .. "_pop_data : " .. myList:popFront():getValue())		
    end
    
    print("LLinkedList_size : " .. myList:getSize())
end

function test_LDeque()
    print("######### LDeque Test ##########################")
    local myDeque = Laputan.LDeque()
    myDeque:pushBack(25)
    myDeque:pushFront("str25")
    myDeque:pushBack(4423)
    myDeque:pushBack(5555)
    myDeque:pushFront("str3333")
    myDeque:pushBack(92)

    print("LDeque_size : " .. myDeque:getSize())
    print("LDeque_pop_test")
    while myDeque:getSize() > 0 do
            print("LDeque_pop_data : " .. myDeque:popFront())		
    end

    myDeque:pushBack(25)
    myDeque:pushFront("str25")
    myDeque:pushBack(4423)
    myDeque:pushBack(5555)
    myDeque:pushFront("str3333")
    myDeque:pushBack(92)

    print("--- LDeque pop test ---------------")
    print("LDeque popFornt : " .. myDeque:popFront())
    print("LDeque popBack : " .. myDeque:popBack())
    print("LDeque popFornt : " .. myDeque:popFront())
    print("LDeque popBack : " .. myDeque:popBack())
    print("LDeque popFornt : " .. myDeque:popFront())
    print("LDeque popBack : " .. myDeque:popBack())
    
    print("LDeque_size : " .. myDeque:getSize())
end

function test_showList()
    local configFileList = Laputan.getFileList("./assets/LaputanConfig")
    print("configFileList : \n",configFileList)

    print("sprite id list :",Laputan.gPreloadSpriteManager:getIdListAll())
    print("sprite preload id list :",Laputan.gPreloadSpriteManager:getPreloadedIdList())
end

function test_backgroundSound()
    -- 백그라운드 사운드를 실행한다 (반복됨)
    Laputan.gAudioManager:playBackground("AMemoryAway.ogg",10)
end

function test_effectSound()
    -- 이펙트 사운드를 실행한다. 리턴된 사운드 아이디 값은 이펙트 사운드를 제어하기 위해 쓰인다  
    gSoundEffectForControl = Laputan.gAudioManager:play2DEffectForControl("nice_music.ogg",30)
    -- gSoundEffectForControl 아이디의 사운드를 멈춘다.
    -- Laputan.L_VK_Y Laputan.L_VK_U 키로 플레이 시키고 멈출수 있다
    Laputan.gAudioManager:pauseEffect(gSoundEffectForControl)
end

function test_manyMonkey()	
    for i = 0, 51  do
            local child = Laputan.gRootObject:createChild()
            child:setName("Test_GO_" .. i)
            child:createSpriteQuad()
            child:setSpriteTexture("monkey",Laputan.SPRITE_ORIGIN_LEFT_TOP)
            child:setPosition(Laputan.LVector2(50 + (i)*25, 0))
    end
end

function test_fogMonkey()
    local fogMonkeyGo = Laputan.gRootObject:createChild()
    fogMonkeyGo:setPosition(0,0)
    fogMonkeyGo:createSpriteQuad()
    fogMonkeyGo:setSpriteTexture("monkey",Laputan.SPRITE_ORIGIN_LEFT_TOP)
    fogMonkeyGo:setFogColor(1, 1, 1, 0.5)
    fogMonkeyGo:setPosition(500,210)
    fogMonkeyGo:pushFog(Laputan.LColor(1,1,1,0), 4, false)
    fogMonkeyGo:pushFogExpoIn(Laputan.LColor(1,1,1,1), 4, false, 6)
    --fogMonkeyGo:pushMoveLinear(Laputan.LVector2(200,0),5,true)
    fogMonkeyGo:setLoopFog(true)
--	fogMonkeyGo:setSpriteBlendMode(Laputan.BLENDMODE_ADD)
end

function test_blendMode()
    local addModeTestGo = Laputan.gRootObject:createChild()
    addModeTestGo:setPosition(530,260)
    addModeTestGo:createSpriteQuad()
    addModeTestGo:setSpriteTexture("explosion1",Laputan.SPRITE_ORIGIN_LEFT_TOP)
    -- 블랜드 모드 설정
    --addModeTestGo:setSpriteBlendMode(Laputan.BLENDMODE_TRANSPARENT_ALPHA)
    addModeTestGo:setSpriteBlendMode(Laputan.BLENDMODE_ADD)

    -- 마우스 드래그 허용
    addModeTestGo:setEnableDrag(true)
end

function test_moveTest()
    local moveTestGo1 = Laputan.gRootObject:createChild()
    moveTestGo1:setPosition(530,360)
    moveTestGo1:createSpriteQuad()
    moveTestGo1:setSpriteTexture("explosionPack",Laputan.SPRITE_ORIGIN_LEFT_TOP)

    -- 베이지어 곡선으로 움직일 점 3개 1,2 번째 점은 중간점 3번째는 최종 위치점
    local bezierMove = {Laputan.LVector2(75,50),Laputan.LVector2(150,-50),Laputan.LVector2(200,0)}
    moveTestGo1:pushMoveBezier(bezierMove,10,true)
    bezierMove = {Laputan.LVector2(-75,50),Laputan.LVector2(-150,-50),Laputan.LVector2(-200,0)}
    moveTestGo1:pushMoveBezier(bezierMove,10,true)
  --moveTestGo1:pushMoveLinear(Laputan.LVector2(-200,0),5,true)

    moveTestGo1:setLoopMove(true)
    moveTestGo1:pushScale(Laputan.LVector2(2,2),10,false)
    moveTestGo1:pushScale(Laputan.LVector2(1,1),10,false)

    -- 자식으로 생성된 게임 객체는 부모의 좌표계를 따라간다
    local moveTestGo2 = moveTestGo1:createChild()
    -- 실질적인 위치는 moveTestGo1:getPosition() + Laputan.LVector2(0,100) 과 같은 셈
    moveTestGo2:setPosition(0,100)
    moveTestGo2:createSpriteQuad()
    moveTestGo2:setSpriteTexture("explosion1", Laputan.SPRITE_ORIGIN_LEFT_TOP)
    moveTestGo2:pushRotation(180,5,true)
    moveTestGo2:pushRotation(180,10,true)
    moveTestGo2:setLoopRotation(true)

    return moveTestGo1
end

function test_serializer(moveTestGo1)
    -- xml doc 객체를 생성
    local xmlDoc = Laputan.LXmlDocument()
    local testEle = xmlDoc:addChildElement("test")

    -- moveTestGo1 객체를 시리얼 라이즈 한다
    local serializedGo = moveTestGo1:serialize()
    -- moveTestGo1 객체를 제거
    moveTestGo1:destroy()
    -- 시리얼 라이즈 객체의 데이터를 xml element로 출력한다
    serializedGo:outputXml(testEle)
    -- 시리얼 라이즈 객체 비움
    serializedGo:clear()
    -- 시리얼 라이즈 객체에 xml doc의 게임 오브젝트 데이터를 입력한다
    serializedGo:inputXml(testEle:findChildElement("GameObject"))

    local createdGo = Laputan.LGameObject()
    serializedGo:load(Laputan.gRootObject,createdGo)
    serializedGo:clear()
end

function test_registerGameObjectEvent()
    local eventTestGo = Laputan.gRootObject:createChild()
    eventTestGo:setPosition(900,200)
    eventTestGo:createSpriteQuad()
    eventTestGo:setSpriteTexture("monkey",Laputan.SPRITE_ORIGIN_LEFT_TOP)

    -- 테이블에 이벤트 함수를 만든다
    local clickTable = {}
    clickTable._go = eventTestGo
    clickTable._value = 1.1
    function clickTable:doClick()
            clickTable._go:setScale(clickTable._go:getScaleXY() * clickTable._value)
    end

    function clickTable:doDown()
            clickTable._go:setScale(clickTable._go:getScaleXY() * clickTable._value)
    end

    function clickTable:doUp()
            clickTable._go:setScale(clickTable._go:getScaleXY() / clickTable._value)
    end

    function clickTable:doDrag()
            local pos = clickTable._go:getPositionXY()
            print("pos : " .. pos.x .. ", " .. pos.y)
    end

    -- 이벤트 게임 객체에  위에서 설정한 테이블의 이벤트 함수를 등록한다.
    -- 테스트 하기 위해 주석을 제거해보고 테스트 해보도록 하자 
    --eventTestGo:registerFuncOnMouseLButtonClick(clickTable.doClick)	
--	eventTestGo:registerFuncOnMouseLButtonDown(clickTable.doDown)
--	eventTestGo:registerFuncOnMouseLButtonUp(clickTable.doUp)
    eventTestGo:setEnableDrag(true)
    eventTestGo:registerFuncOnMouseDrag(clickTable.doDrag)
--	eventTestGo:registerFuncOnMouseEnter(clickTable.doDown)
--	eventTestGo:registerFuncOnMouseLeave(clickTable.doUp)
    
    -- 마우스 드래그가 가능한 영역을 지정한다
    eventTestGo:setMouseDragMinMax(Laputan.LUIntRect(800,200,1100,400))
    -- 주어진 영역 밖으로 나갈 경우 짤리게 설정한다
    eventTestGo:setScissorRect(Laputan.LUIntRect(800,200,1200,450))
end

function test_gameObjectColor()
    local colorTestGo = Laputan.gRootObject:createChild()
    colorTestGo:setPosition(630,360)
    colorTestGo:createSpriteQuad()
    colorTestGo:setSpriteTexture("monkey",Laputan.SPRITE_ORIGIN_LEFT_TOP)

    -- 주석을 쳐보거나 해체 하여 테스트 해보자
    --colorTestGo:pushColor(Laputan.LVector3(0,0,1), 5, false)
    --colorTestGo:pushColorExpoIn(Laputan.LVector3(1,0,0), 5, false, 10)
    --colorTestGo:pushColor(Laputan.LVector3(1,1,1), 5, false)
    --colorTestGo:setLoopColor(true)
    --colorTestGo:setColor(0.5,0.5,0.5)
    --print( colorTestGo:getColorRGB() )

    --colorTestGo:pushAlpha(0.3,2,false)
    --colorTestGo:pushAlpha(1,2,false)
    --colorTestGo:setLoopAlpha(true)
    --colorTestGo:setAlpha(0.1)
    --print( colorTestGo:getAlpha() )

--	colorTestGo:pushFog(Laputan.LColor(1,1,1,0),2,false)
--	colorTestGo:pushFogExpoIn(Laputan.LColor(1,1,1,1),2,false,10)
--	colorTestGo:setLoopFog(true)

    --colorTestGo:setFogColor(1,0,0,0.5)
    --colorTestGo:setFogRate(0.8)
    --print("fog : " .. tostring(colorTestGo:getFogColor()))

    return colorTestGo
end

function test_filtering(filterTestGo)
    -- 주석을 쳐보거나 해체 하여 테스트 해보자
    filterTestGo:setRotationZ(20)
    filterTestGo:setScaleXY(2)
--	filterTestGo:setSpriteFiltering(Laputan.TEXTURE_FILTERING_BILINEAR)	
--	filterTestGo:setSpriteFiltering(Laputan.TEXTURE_FILTERING_ANISOTROPIC)
--	filterTestGo:setSpriteFiltering(Laputan.TEXTURE_FILTERING_NONE)

end

function test_spriteAnimation(aniTestGo)
    -- 주석을 쳐보거나 해체 하여 테스트 해보자
    aniTestGo:resetSpriteFrame(3)
    aniTestGo:pauseSprite()
    aniTestGo:playSprite()
    aniTestGo:setSpriteLoop(true)
    aniTestGo:setSpriteSpeed(0.5)
    print("frame cur count : " .. aniTestGo:getSpriteCurrentFrame())
    
    print("sprite pause: " .. tostring(aniTestGo:isPauseSprite()))
    print("sprite isLoop: " .. tostring(aniTestGo:isLoopSprite()))
    print("sprite speed: " .. tostring(aniTestGo:getSpriteSpeed()))	
end

function test_spriteButton()
    -- 버튼은 스프라이트 4개로 구성되고  
    local buttonTestGo = Laputan.gRootObject:createChild()
    buttonTestGo:setPosition(750,460)
    buttonTestGo:createSpriteButton()
    buttonTestGo:setSpriteTexture("button2",Laputan.SPRITE_ORIGIN_LEFT_TOP)
--	buttonTestGo:setButtonStateTexture(Laputan.BUTTON_STATE_MOUSEOVER,2)
--	buttonTestGo:setButtonStateTexture(Laputan.BUTTON_STATE_PRESSED,1)
    buttonTestGo:setButtonDisable(false)
end

function test_spriteCheckBox()
    local checkBoxGo = Laputan.gRootObject:createChild()
    --checkBoxGo:setPosition(750,360)
    checkBoxGo:setPosition(400,660)
    checkBoxGo:createSpriteCheckBox()
    checkBoxGo:setSpriteTexture("button2",Laputan.SPRITE_ORIGIN_LEFT_TOP)
--	checkBoxGo:setCheckBoxStateTexture(Laputan.CHECKBOX_STATE_EMPTY_MOUSEOVER,0)
--	checkBoxGo:setCheckBoxStateTexture(Laputan.CHECKBOX_STATE_EMPTY_PRESSED,0)
    
--	checkBoxGo:setCheckBoxStateTexture(Laputan.CHECKBOX_STATE_CHECKED_MOUSEOVER,3)
--	checkBoxGo:setCheckBoxStateTexture(Laputan.CHECKBOX_STATE_CHECKED_PRESSED,3)

--	checkBoxGo:setCheckBoxDisable(true)
    checkBoxGo:setCheckBoxCheck(false);
    print("check is " .. tostring(checkBoxGo:isCheckedCheckBox()))
end

function test_spriteNumber()
    local numberGo = Laputan.gRootObject:createChild()
    numberGo:setPosition(400,660)
    numberGo:createSpriteNumber()
    numberGo:setNumberTexture("test_number")
    print("numberTexture : " .. numberGo:getNumberTextureId())
    numberGo:setNumber(111919232323233)
    print("number num : " .. tostring(numberGo:getNumber()))
    --숫자 간격 줄이기 주석으로 테스트 
    numberGo:setNumberCharacterMinusSize(1,4)
    print("number num at minusSize: " .. numberGo:getNumberCharacterMinusSize(1))
    numberGo:setNumberSign(true,Laputan.NUMBER_SIGN_POS_FIRST)
    numberGo:setNumberLeftAlign(false)
end

function test_spritePanel()
    local panelGo = Laputan.gRootObject:createChild()
    panelGo:setPosition(450,460)
    panelGo:createSpritePanel()
    panelGo:setPanelTexture("panel")
    print("panelTexture : " .. panelGo:getPanelTextureId())

    -- 드래그 설정
    panelGo:setEnableDrag(true)

--	panelGo:setPanelWidth(300)
--	panelGo:setPanelHeight(200)	
    panelGo:setPanelRect(300,100)

--	panelGo:pushMoveLinear(Laputan.LVector2(1000,0),40,true)

    -- 모달로 만들면 자식객체를 포함해  마우스 이벤트는 모달 객체만 받는다
--	panelGo:doModal()

    local panelBtnGo = panelGo:createChild()
    panelBtnGo:createSpriteButton()
    panelBtnGo:setSpriteTexture("button2",Laputan.SPRITE_ORIGIN_LEFT_TOP)
    panelBtnGo:setPosition(50,50)
    
    local panelSpriteGo = panelGo:createChild()
    panelSpriteGo:createSpriteQuad()
    panelSpriteGo:setSpriteTexture("button2",Laputan.SPRITE_ORIGIN_LEFT_TOP)
    panelSpriteGo:setPosition(150,70)

    -- 버튼 클릭 이벤트에  모달 해제함수를 호출하도록 만든다
    panelBtnGo:registerFuncOnMouseLButtonClick( function ()
             Laputan.LGameObject:ReleaseModal() 
    end)

    return panelGo
end

function test_spriteText(panelGo)
    -- 유니코드로 되어 있는 xml 파일을 연다.
    -- (한글)문자는 반드시 LaputanText 엘레멘트의 자식 엘레멘트 여야 인식된다
    local textXmlDoc = Laputan.LXmlDocument()
    textXmlDoc:openFile("myText5.xml")
    local mainEle = textXmlDoc:findChildElement("Main")
    local characterEle = mainEle:findChildElement("Character7")
    local laputanTextEle = characterEle:findChildElement("LaputanText")
    local strText1 = laputanTextEle:getChildElementData("Smile")
    local strText2 = laputanTextEle:getChildElementData("Rage")
             
    local TextGo = panelGo:createChild()
    TextGo:createSpriteText()
    TextGo:setPosition(10,10)
    TextGo:setText("Modal Window ," .. strText1 .. " \n" .. strText2)
    TextGo:setColor(1,1,1)
    TextGo:setScale(1,1)
    -- 유니코드는 print 함수로는 볼수 없다. 안시(Ansi)로 바꿔줘야함
    Laputan.printLog(Laputan.LOG_CRITICAL, "TextGo(not convert ansi): " .. TextGo:getText())
    Laputan.printLog(Laputan.LOG_CRITICAL, Laputan.convertUtf8ToAnsi(strText2))

end



function test_spriteScrollBar()
    local scrollbarGo = Laputan.gRootObject:createChild()
    scrollbarGo:createSpriteScrollBar()
    scrollbarGo:setPosition(300,150)
--	scrollbarGo:settingScrollBar(Laputan.SCROLL_TYPE_VERTICAL, "button2", "panel", 300, 100, 20)
    scrollbarGo:settingScrollBar(Laputan.SCROLL_TYPE_HORIZONTAL, "button2", "panel", 250, 100, 20)
    scrollbarGo:resetScrollBarMax(50,10)
            
    scrollbarGo:registerScrollBarOnTrackPosition(function(arg) print("scrollbar pos : " .. arg)	end)
    scrollbarGo:setScrollBarTrackPosition(250)
    print("getScrollBarMaxValue : " .. scrollbarGo:getScrollBarMaxValue())
end

function test_spriteListBox()	
    local listBoxGo = Laputan.gRootObject:createChild()
    listBoxGo:createSpriteListBox()
    listBoxGo:settingListBox(200, 26, 8, "panel", "button2", "panel")
    listBoxGo:addListBoxItem();
    listBoxGo:addListBoxItem();
    listBoxGo:addListBoxItem();
    print("listBox size : " .. listBoxGo:sizeListBox())
    listBoxGo:addSpriteQuadInListBoxItem(0,Laputan.LVector2(10,0),"button2")
    listBoxGo:addSpriteTextInListBoxItem(0,Laputan.LVector2(50,0),"ace1",Laputan.TEXT_ALIGNMENT_V_ABOVE)

    listBoxGo:addSpriteQuadInListBoxItem(1,Laputan.LVector2(10,0),"button2")
    listBoxGo:addSpriteTextInListBoxItem(1,Laputan.LVector2(50,0),"ace2",Laputan.TEXT_ALIGNMENT_V_ABOVE)
    
    listBoxGo:addSpriteQuadInListBoxItem(2,Laputan.LVector2(10,0),"button2")
    listBoxGo:addSpriteTextInListBoxItem(2,Laputan.LVector2(50,0),"ace3",Laputan.TEXT_ALIGNMENT_V_ABOVE)

    print("listBox select index : " .. listBoxGo:getListBoxSelectIndex())
    
    listBoxGo:emptySpriteInListBoxItem(1)
end

function test_spriteLine(panelGo)
    local lineGo = panelGo:createChild()
    lineGo:createSpriteLine()
    lineGo:setPosition(0,0)
    lineGo:setScaleXY(1)

--	lineGo:addLine(Laputan.LVector2(0,0),Laputan.LVector2(300,0));
--	lineGo:addLine(Laputan.LVector2(300,0),Laputan.LVector2(300,100));
--	lineGo:addLine(Laputan.LVector2(300,100),Laputan.LVector2(0,100));
--	lineGo:addLine(Laputan.LVector2(0,100),Laputan.LVector2(0,0));

    lineGo:addLineQuad(400,100,Laputan.SPRITE_ORIGIN_LEFT_TOP)
    lineGo:addLineCircle(100)

    lineGo:setColor(Laputan.LColor(1,0,0,1))
--	lineGo:clearLine()
end

function test_spriteCollection()
    -- 현재 게임 객체 상태를 추가하기 위한용도 
    local collectionPartGo = Laputan.gRootObject:createChild()
    collectionPartGo:createSpriteQuad()
    collectionPartGo:setSpriteTexture("monkey",Laputan.SPRITE_ORIGIN_LEFT_TOP)
    collectionPartGo:setPosition(200,310)
    

    local collectionGo = Laputan.gRootObject:createChild()
    collectionGo:createSpriteQuadCollection()
    collectionGo:addSpriteQuadCollection(collectionPartGo)
    collectionPartGo:setPosition(300,310)
    collectionGo:addSpriteQuadCollection(collectionPartGo)
    collectionPartGo:setPosition(400,310)	
    collectionGo:addSpriteQuadCollection(collectionPartGo)
    collectionPartGo:setPosition(500,310)	
    collectionGo:addSpriteQuadCollection(collectionPartGo)

    collectionGo:addSpriteQuadCollection(Laputan.LVector2(300,400),
        25, Laputan.LVector2(2,2), "monkey", Laputan.SPRITE_ORIGIN_LEFT_TOP,3,
        Laputan.LColor(1,1,0,1))

    collectionPartGo:setPosition(200,310)
    collectionPartGo:setScale(0.5,0.5)
    collectionPartGo:resetSpriteFrame(1)
    collectionGo:setSpriteQuadCollection(0, collectionPartGo)

    collectionPartGo:setPosition(300,310)
    collectionPartGo:setColor(1,0,0)
    collectionPartGo:setScale(0.5,0.5)
    collectionPartGo:resetSpriteFrame(2)
    collectionGo:setSpriteQuadCollection(1, collectionPartGo)
    
    collectionPartGo:setPosition(400,310)
    collectionPartGo:setScale(0.5,0.5)
    collectionPartGo:resetSpriteFrame(3)
    collectionGo:setSpriteQuadCollection(2, collectionPartGo)

    collectionPartGo:setPosition(500,310)
    collectionPartGo:setRotationZ(22)
    collectionPartGo:setColor(1,1,1)
    collectionPartGo:setScale(0.5,0.5)
    collectionPartGo:resetSpriteFrame(0)
    collectionGo:setSpriteQuadCollection(3, collectionPartGo)

    -- 게임 객체를 직접 사용하지 않고 수동으로 직접 입력한다
    collectionGo:setSpriteQuadCollection(4, Laputan.LVector2(300,400),
            25, Laputan.LVector2(1,1), "monkey", Laputan.SPRITE_ORIGIN_LEFT_TOP,3,
            Laputan.LColor(1,1,0,1))

			
    -- 추가된 게임 객체는 추가될때 필터링 효과는 반영되지 않기에 
    -- 필요하다면 콜랙션 객체에서 
    collectionGo:setSpriteFiltering(Laputan.TEXTURE_FILTERING_NONE)
--	collectionGo:setSpriteFiltering(Laputan.TEXTURE_FILTERING_BILINEAR)

--	collectionGo:setColor(1,0,0)
--	collectionGo:setFogColor(1,1,1,0.5)

--	collectionGo:setSpriteQuadCollection()

    -- 콜렉션에 추가 역활를 다했으면 삭제
    collectionPartGo:destroy()

    -- 숫자 스프라이트 
    local collectionNumGo = Laputan.gRootObject:createChild()
    collectionNumGo:createSpriteQuadCollection()

    local collectionNumPartGo = Laputan.gRootObject:createChild()
    collectionNumPartGo:createSpriteNumber()
    collectionNumPartGo:setNumberTexture("test_number")
    collectionNumPartGo:setNumber(2523)
    collectionNumPartGo:setPosition(Laputan.LVector2(400,400))
    collectionNumGo:addSpriteQuadCollection(collectionNumPartGo)

    collectionNumPartGo:setNumber(11113)
    collectionNumPartGo:setPosition(Laputan.LVector2(600,400))
    collectionNumGo:addSpriteQuadCollection(collectionNumPartGo)

    collectionNumPartGo:setNumber(333332)
    collectionNumPartGo:setPosition(Laputan.LVector2(800,400))
    collectionNumGo:addSpriteQuadCollection(collectionNumPartGo)

    collectionNumPartGo:destroy()
end

function test_spriteMesh()
    local meshGo = Laputan.gRootObject:createChild()
    meshGo:setPosition(100,500)
    meshGo:createSpriteMesh("penguin.mesh")
    meshGo:setRotationZ(180)
    meshGo:setScale(Laputan.LVector3(4,4,4))
    
    local meshGo2 = Laputan.gRootObject:createChild()
    meshGo2:setPosition(200,500)
    meshGo2:createSpriteMesh("penguin.mesh")
    meshGo2:setRotationZ(0)
    meshGo2:setScale(Laputan.LVector3(1,1,1))

    -- 전역 객체로 설정
    gMeshGo2Child = meshGo2:createChild()
    gMeshGo2Child:setPosition(25,0)
    gMeshGo2Child:createSpriteMesh("robot.mesh")
    -- 같은 재질을 쓰더라도 쉐이더 변수 값을 바꾸어 쓰고 싶을때
    gMeshGo2Child:setMeshMaterial("Test/CustomParameter")	
    -- 0번 인덱스에 빨간색을 설정
    gMeshGo2Child:setMeshCustomParameter(0,Laputan.LVector4(1,0,0,1))
    gMeshGo2Child:setRotationZ(180)
    gMeshGo2Child:yaw(180)
    gMeshGo2Child:setScale(Laputan.LVector3(3,3,3))

    -- 걷기 에니메이션으로 설정
    -- 다른 애니메이션으로 변경하기 위해선 callbackKeyEvent 함수를 참고
    gMeshGo2Child:makeMeshMainAnimationBlender("Walk",true)
--	local qRotation = Laputan.LQuaternion()
--	qRotation:fromAngleAxis(130,Laputan.LVector3(1,1,0))
--	gMeshGo2Child:setRotation(qRotation)
    

    -- 렌더링 영역을 설정
--	gMeshGo2Child:setScissorRect(Laputan.LUIntRect(100,100,700,550))
--	gMeshGo2Child:setScissorRect(Laputan.LUIntRect())

    -- Laputan.moveGameObject(meshGo,meshGo2,false)
end

function test_customVertexAndUV()
    local customGo = Laputan.gRootObject:createChild()	
    customGo:setPosition(100,450)
    customGo:createSpriteQuad()
    customGo:setSpriteTexture("test_rect",Laputan.SPRITE_ORIGIN_LEFT_TOP)

    -- 버택스를 직접 설정한다	
    local customVertex = {
            Laputan.LVector2(0,0),
            Laputan.LVector2(23,0),
            Laputan.LVector2(23,23),
            Laputan.LVector2(0,23),
    }

    -- 택스쳐 UV를 픽셀 단위 값으로 설정한다 
    local customUV = {
            Laputan.LVector2(0,28),
            Laputan.LVector2(23,28),
            Laputan.LVector2(23,51),
            Laputan.LVector2(0,51),
    }
--	customGo:setSpriteCustomVertex(customVertex)
--	customGo:setSpriteCustomPixelUV(customUV)
    customGo:setScaleXY(3)

    -- 콜랙션 객체에 넣어서 테스트 비교해본다
    local customGoCollection = Laputan.gRootObject:createChild()
    customGoCollection:createSpriteQuadCollection()
    customGoCollection:addSpriteQuadCollection(customGo)

    customGo:setPosition(300,450)
    customGo:setScaleXY(3)
    customUV[3].y = 47
    customUV[4].y = 47

    customGo:setSpriteCustomVertex(customVertex)
    customGo:setSpriteCustomPixelUV(customUV)

    customGoCollection:addSpriteQuadCollection(customGo)
    customGo:destroy()
end

function test_sortAndDestroy()
    gSortParentGo = Laputan.gRootObject:createChild()
    local sortChildGo1 = gSortParentGo:createChild()
    sortChildGo1:setPosition(100,560)
    sortChildGo1:createSpriteQuad()
    sortChildGo1:setSpriteTexture("monkey",Laputan.SPRITE_ORIGIN_LEFT_BOTTOM)
    sortChildGo1:setEnableDrag(true)
    -- 즉시 파괴
    sortChildGo1:destroy(0)

    local sortChildGo2 = gSortParentGo:createChild()
    sortChildGo2:setPosition(100,530)
    sortChildGo2:createSpriteQuad()
    sortChildGo2:setSpriteTexture("monkey",Laputan.SPRITE_ORIGIN_LEFT_BOTTOM)
    -- 60틱 (1초) 후 파괴
    sortChildGo2:destroy(3)

    local sortChildGo3 = gSortParentGo:createChild()
    sortChildGo3:setPosition(100,500)
    sortChildGo3:createSpriteQuad()
    sortChildGo3:setSpriteTexture("monkey",Laputan.SPRITE_ORIGIN_LEFT_BOTTOM)
    -- 120 틱 (2초) 후 파괴
    sortChildGo3:destroy(4)

    -- __LaputanFixedTickFunctionEnd 함수에서 sort 시킨다
end

function test_microThread()
    local customGo = Laputan.gRootObject:createChild()	
    customGo:setPosition(900,450)
    customGo:createSpriteQuad()
    customGo:setSpriteTexture("planet_1",Laputan.SPRITE_ORIGIN_LEFT_TOP)

    customGo:setSpriteCustomUV(0,Laputan.LVector2(0.25,0.25))
    customGo:setSpriteCustomUV(1,Laputan.LVector2(0.75,0.25))
    customGo:setSpriteCustomUV(2,Laputan.LVector2(0.75,0.75))
    customGo:setSpriteCustomUV(3,Laputan.LVector2(0.25,0.75))
    
    local threadTable = {}
    threadTable._go = customGo
    function threadTable:run()	
        local quadUV = {
                Laputan.LVector2(0.25,0.25),
                Laputan.LVector2(0.75,0.25),
                Laputan.LVector2(0.75,0.75),
                Laputan.LVector2(0.25,0.75)
        }
        threadTable._go:setSpriteFiltering(Laputan.TEXTURE_FILTERING_BILINEAR)
        threadTable._go:setSpriteCustomUV(quadUV)
        
        local  addV = 0.001
        while(true) do
            if quadUV[1].x >= 0 and quadUV[1].y >= 0 then
                    quadUV[1].x = quadUV[1].x - addV
                    quadUV[1].y = quadUV[1].y - addV
            end

            if quadUV[2].x <= 1 and quadUV[2].y >= 0 then
                    quadUV[2].x = quadUV[2].x + addV
                    quadUV[2].y = quadUV[2].y - addV
            end

            if quadUV[3].x <= 1 and quadUV[3].y <= 1 then
                    quadUV[3].x = quadUV[3].x + addV
                    quadUV[3].y = quadUV[3].y + addV
            end

            if quadUV[4].x >= 0 and quadUV[4].y <= 1 then
                    quadUV[4].x = quadUV[4].x - addV
                    quadUV[4].y = quadUV[4].y + addV
            end

            Laputan.sleepThread()
            threadTable._go:setSpriteCustomUV(quadUV)
            Laputan.sleepThread()
        end
    end

    threadNode = Laputan.createThread(threadTable.run)
end

function test_spriteParticle()
    gMeshRazor = Laputan.gRootObject:createChild()
    gMeshRazor:setPosition(800,200)
    gMeshRazor:createSpriteMesh("razor.mesh")
    gMeshRazor:setRotationZ(0)
    gMeshRazor:setScale(Laputan.LVector3(1,1,1))
    gMeshRazor:pitch(90)
    gMeshRazor:yaw(90)

    local engineParticle = gMeshRazor:createChild()
    -- 디테일한 정보는 http://www.ogre3d.org/docs/manual/manual_34.html#Particle-Scripts
    engineParticle:createSpriteParticleFx("test/booster")
    engineParticle:setPosition(Laputan.LVector3(0, 0, -73))
    
    local parameterStr = engineParticle:getParticleFxAffectorParameter(0,"red")
    print("parameter : " .. tostring(parameterStr:toString()))
end

function test_layer()
    function funcCreateGo(parentGo,spriteId,pos)
        local planetGo = parentGo:createChild()
        planetGo:setPosition(pos)
        planetGo:createSpriteQuad()
        planetGo:setSpriteTexture(spriteId,Laputan.SPRITE_ORIGIN_LEFT_BOTTOM)    
        return planetGo
    end

    local planet1Go = funcCreateGo(Laputan.gRootObject,"planet_1",Laputan.LVector2(400,250))

    local planet2Go = funcCreateGo(planet1Go,"planet_2",Laputan.LVector2(-150,100))
    local planet3Go = funcCreateGo(planet1Go,"planet_3",Laputan.LVector2(0,100))
    local planet4Go = funcCreateGo(planet1Go,"planet_4",Laputan.LVector2(150,100))
    local planet5Go = funcCreateGo(planet3Go,"planet_8",Laputan.LVector2(-100,100))
    local planet6Go = funcCreateGo(planet3Go,"planet_9",Laputan.LVector2(100,100))

    local arg = {}
    arg._go = {planet1Go,planet2Go,planet3Go,planet4Go,planet5Go,planet6Go}    
   
    -- 레이어를 지정하고 옮길때 타켓이 되는 레이어의 부모의 자식으로 옮기고 타켓의 앞 혹은 뒤로 배치한다
    -- 6번 게임객체를 5번 게임 객체의 앞으로 이동시킨다 
    function arg:func1()
        local goTable = arg._go
        Laputan.moveGameObject(goTable[6],goTable[5],true)
    end

    function arg:func2()
        local goTable = arg._go
        Laputan.moveGameObject(goTable[6],goTable[4],true)
    end

    function arg:func3()
        local goTable = arg._go
        Laputan.moveGameObject(goTable[6],goTable[3],true)
    end

    function arg:func4()
        local goTable = arg._go
        Laputan.moveGameObject(goTable[6],goTable[5],false)
    end

    -- 같은 부모를 가진 게임 객체의 이동
    local node1 = Laputan.registerCallBackFunc(2.5,arg.func1)
    -- 부모가 다른 게임 객체의 이동일 경우 레이어 이동에 따른 좌표계가 변한다

    -- (옮기는 부모의 좌표계를 따라가기에 절대 좌표는 변하게된다)
    local node2 = Laputan.registerCallBackFunc(5,arg.func2)
    
    local node3 = Laputan.registerCallBackFunc(7.5,arg.func3)
    -- 원래 부모로 돌아감
    local node3 = Laputan.registerCallBackFunc(10,arg.func4)


    --Laputan.unregisterCallBackFunc(node)
    --Laputan.clearCallBackFunc()
    

end

function test_win32Gui()
    
    local window = Laputan.Win32.createWindow("test",0,0,700,400)

    local button = window:createButton(10,10,100,30,"Test Btn")
    button:registerFuncOnClick(function() print("Win32 Button Click") end)

    local edit = window:createEditBox(10,40,100,25,true,"myEdit Text")

    local editArg={}
    editArg._edit = edit
    function editArg:onClick()             
        print(editArg._edit:getText()) 
    end

    edit:registerFuncOnEnterKey(editArg.onClick)

    local checkBox = window:createCheckBox(10,70,100,25,"MyCheck")
    local checkBoxArg = {}
    checkBoxArg._checkBox = checkBox
    function checkBoxArg:onClick()
        print("checkBox",checkBoxArg._checkBox:isChecked())    
    end
    checkBox:registerFuncOnClick(checkBoxArg.onClick)        

    local radioArg = {
        Laputan.Win32.LRadioButtonArg(240,10,150,150,"radio group"),
        Laputan.Win32.LRadioButtonArg(250,30,100,25,"radio 1"),
        Laputan.Win32.LRadioButtonArg(250,55,100,25,"radio 2"),
        Laputan.Win32.LRadioButtonArg(250,80,100,25,"radio 3") 
    }

    local radioGroup = window:createRadioButton(true,radioArg)
    print("radioGroup",radioGroup)
    local radioGroupArg = {}
    radioGroupArg._radioGroup = radioGroup
    function radioGroupArg:onClick()
        print("radioGroup Select",radioGroupArg._radioGroup:getSelectedText())
    end
    radioGroup:registerFuncOnClick(radioGroupArg.onClick)

    local listBox = window:createListBox(10,100,200,150,false,false)
    listBox:insert(0,"aaaa")
    listBox:insert(0,"bbbb")
    listBox:insert(0,"cccc")
    listBox:insert(0,"dddd")
    listBox:insert(0,"eeee")

    listBox:pushBack("kkkk")
    listBox:select("bbbb")
    listBox:select(-1)
    listBox:erase("cccc")
    listBox:erase(0)

    local listBoxArg = {}
    listBoxArg._listBox = listBox
    function listBoxArg:onClick()
        print("listBox Select",listBoxArg._listBox:getSelectedIndex(),listBoxArg._listBox:getSelectedText())
    end
    listBox:registerFuncOnClick(listBoxArg.onClick)


    local comboBox = window:createComboBox(10,270,200,200,false)
    comboBox:insert(0,"aaaa")
    comboBox:insert(0,"bbbb")
    comboBox:insert(0,"cccc")
    comboBox:insert(0,"dddd")
    comboBox:insert(0,"eeee")

    comboBox:pushBack("kkkk")
    comboBox:select("bbbb")
    comboBox:erase("cccc")
    comboBox:erase(0)
--    comboBox:select(-1)


    local comboBoxArg = {}
    comboBoxArg._comboBox = comboBox
    function comboBoxArg:onClick()
        print("comboBox Select",comboBoxArg._comboBox:getSelectedIndex(),comboBoxArg._comboBox:getSelectedText())
    end
    comboBox:registerFuncOnClick(comboBoxArg.onClick)

    local scrollBarH = window:createScrollBar(10,300,200,25,false)
    scrollBarH:setRange(0,20)
    scrollBarH:setPosition(0)
    
    local scrollBarHArg = {}
    scrollBarHArg._scrollBarH = scrollBarH
    function scrollBarHArg:onClick()
        print("scrollBarH Select",scrollBarHArg._scrollBarH:getPosition())
    end
    scrollBarH:registerFuncOnClick(scrollBarHArg.onClick)

    ------
    local scrollBarV = window:createScrollBar(250,170,25,150,true)
    scrollBarV:setRange(0,20)
    scrollBarV:setPosition(0)
    
    local scrollBarVArg = {}
    scrollBarVArg._scrollBarV = scrollBarV
    function scrollBarVArg:onClick()
        print("scrollBarV Select",scrollBarVArg._scrollBarV:getPosition())
    end
    scrollBarV:registerFuncOnClick(scrollBarVArg.onClick)
    
    local staticText1 = window:createStaticText(280,170,100,25,"MyStatic1")
  
    local staticText2 = window:createStaticText(280,200,100,25,"MyStatic2")
    staticText2:setText("ziii")
    print("staticText1",staticText1:getText())

    local progress = window:createProgress(280,300,100,25)
    progress:setRange(0,100)
    progress:setPosition(90)

    local openFilePath =Laputan.Win32.openFileDialogBox("C:\\", {"MyText|*.txt","All|*.*"})
    print("openFilePath",openFilePath)
    local saveFilePath =Laputan.Win32.saveFileDialogBox("C:\\", "mySave.tee")
    print("saveFilePath",saveFilePath)
 
end



