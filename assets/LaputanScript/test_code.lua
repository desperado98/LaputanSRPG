

-- ���� Ű �̺�Ʈ �ݹ� �Լ�
function callbackKeyEvent(virtualKey, up)
    local state
    if up then 
            state = "UP"
    else
            state = "Down"
    end

    local controlGo = gMeshRazor
    if virtualKey == Laputan.L_VK_Y then
    -- ������ ���带 �ٽ� �÷����Ѵ�.
		Laputan.gAudioManager:play2DEffect(gSoundEffectForControl)
    elseif virtualKey == Laputan.L_VK_U then
		-- ���带 �����.
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

-- ����ũ�� �����带 �̿��� �׽�Ʈ
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
    -- ��׶��� ���带 �����Ѵ� (�ݺ���)
    Laputan.gAudioManager:playBackground("AMemoryAway.ogg",10)
end

function test_effectSound()
    -- ����Ʈ ���带 �����Ѵ�. ���ϵ� ���� ���̵� ���� ����Ʈ ���带 �����ϱ� ���� ���δ�  
    gSoundEffectForControl = Laputan.gAudioManager:play2DEffectForControl("nice_music.ogg",30)
    -- gSoundEffectForControl ���̵��� ���带 �����.
    -- Laputan.L_VK_Y Laputan.L_VK_U Ű�� �÷��� ��Ű�� ����� �ִ�
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
    -- ���� ��� ����
    --addModeTestGo:setSpriteBlendMode(Laputan.BLENDMODE_TRANSPARENT_ALPHA)
    addModeTestGo:setSpriteBlendMode(Laputan.BLENDMODE_ADD)

    -- ���콺 �巡�� ���
    addModeTestGo:setEnableDrag(true)
end

function test_moveTest()
    local moveTestGo1 = Laputan.gRootObject:createChild()
    moveTestGo1:setPosition(530,360)
    moveTestGo1:createSpriteQuad()
    moveTestGo1:setSpriteTexture("explosionPack",Laputan.SPRITE_ORIGIN_LEFT_TOP)

    -- �������� ����� ������ �� 3�� 1,2 ��° ���� �߰��� 3��°�� ���� ��ġ��
    local bezierMove = {Laputan.LVector2(75,50),Laputan.LVector2(150,-50),Laputan.LVector2(200,0)}
    moveTestGo1:pushMoveBezier(bezierMove,10,true)
    bezierMove = {Laputan.LVector2(-75,50),Laputan.LVector2(-150,-50),Laputan.LVector2(-200,0)}
    moveTestGo1:pushMoveBezier(bezierMove,10,true)
  --moveTestGo1:pushMoveLinear(Laputan.LVector2(-200,0),5,true)

    moveTestGo1:setLoopMove(true)
    moveTestGo1:pushScale(Laputan.LVector2(2,2),10,false)
    moveTestGo1:pushScale(Laputan.LVector2(1,1),10,false)

    -- �ڽ����� ������ ���� ��ü�� �θ��� ��ǥ�踦 ���󰣴�
    local moveTestGo2 = moveTestGo1:createChild()
    -- �������� ��ġ�� moveTestGo1:getPosition() + Laputan.LVector2(0,100) �� ���� ��
    moveTestGo2:setPosition(0,100)
    moveTestGo2:createSpriteQuad()
    moveTestGo2:setSpriteTexture("explosion1", Laputan.SPRITE_ORIGIN_LEFT_TOP)
    moveTestGo2:pushRotation(180,5,true)
    moveTestGo2:pushRotation(180,10,true)
    moveTestGo2:setLoopRotation(true)

    return moveTestGo1
end

function test_serializer(moveTestGo1)
    -- xml doc ��ü�� ����
    local xmlDoc = Laputan.LXmlDocument()
    local testEle = xmlDoc:addChildElement("test")

    -- moveTestGo1 ��ü�� �ø��� ������ �Ѵ�
    local serializedGo = moveTestGo1:serialize()
    -- moveTestGo1 ��ü�� ����
    moveTestGo1:destroy()
    -- �ø��� ������ ��ü�� �����͸� xml element�� ����Ѵ�
    serializedGo:outputXml(testEle)
    -- �ø��� ������ ��ü ���
    serializedGo:clear()
    -- �ø��� ������ ��ü�� xml doc�� ���� ������Ʈ �����͸� �Է��Ѵ�
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

    -- ���̺� �̺�Ʈ �Լ��� �����
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

    -- �̺�Ʈ ���� ��ü��  ������ ������ ���̺��� �̺�Ʈ �Լ��� ����Ѵ�.
    -- �׽�Ʈ �ϱ� ���� �ּ��� �����غ��� �׽�Ʈ �غ����� ���� 
    --eventTestGo:registerFuncOnMouseLButtonClick(clickTable.doClick)	
--	eventTestGo:registerFuncOnMouseLButtonDown(clickTable.doDown)
--	eventTestGo:registerFuncOnMouseLButtonUp(clickTable.doUp)
    eventTestGo:setEnableDrag(true)
    eventTestGo:registerFuncOnMouseDrag(clickTable.doDrag)
--	eventTestGo:registerFuncOnMouseEnter(clickTable.doDown)
--	eventTestGo:registerFuncOnMouseLeave(clickTable.doUp)
    
    -- ���콺 �巡�װ� ������ ������ �����Ѵ�
    eventTestGo:setMouseDragMinMax(Laputan.LUIntRect(800,200,1100,400))
    -- �־��� ���� ������ ���� ��� ©���� �����Ѵ�
    eventTestGo:setScissorRect(Laputan.LUIntRect(800,200,1200,450))
end

function test_gameObjectColor()
    local colorTestGo = Laputan.gRootObject:createChild()
    colorTestGo:setPosition(630,360)
    colorTestGo:createSpriteQuad()
    colorTestGo:setSpriteTexture("monkey",Laputan.SPRITE_ORIGIN_LEFT_TOP)

    -- �ּ��� �ĺ��ų� ��ü �Ͽ� �׽�Ʈ �غ���
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
    -- �ּ��� �ĺ��ų� ��ü �Ͽ� �׽�Ʈ �غ���
    filterTestGo:setRotationZ(20)
    filterTestGo:setScaleXY(2)
--	filterTestGo:setSpriteFiltering(Laputan.TEXTURE_FILTERING_BILINEAR)	
--	filterTestGo:setSpriteFiltering(Laputan.TEXTURE_FILTERING_ANISOTROPIC)
--	filterTestGo:setSpriteFiltering(Laputan.TEXTURE_FILTERING_NONE)

end

function test_spriteAnimation(aniTestGo)
    -- �ּ��� �ĺ��ų� ��ü �Ͽ� �׽�Ʈ �غ���
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
    -- ��ư�� ��������Ʈ 4���� �����ǰ�  
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
    --���� ���� ���̱� �ּ����� �׽�Ʈ 
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

    -- �巡�� ����
    panelGo:setEnableDrag(true)

--	panelGo:setPanelWidth(300)
--	panelGo:setPanelHeight(200)	
    panelGo:setPanelRect(300,100)

--	panelGo:pushMoveLinear(Laputan.LVector2(1000,0),40,true)

    -- ��޷� ����� �ڽİ�ü�� ������  ���콺 �̺�Ʈ�� ��� ��ü�� �޴´�
--	panelGo:doModal()

    local panelBtnGo = panelGo:createChild()
    panelBtnGo:createSpriteButton()
    panelBtnGo:setSpriteTexture("button2",Laputan.SPRITE_ORIGIN_LEFT_TOP)
    panelBtnGo:setPosition(50,50)
    
    local panelSpriteGo = panelGo:createChild()
    panelSpriteGo:createSpriteQuad()
    panelSpriteGo:setSpriteTexture("button2",Laputan.SPRITE_ORIGIN_LEFT_TOP)
    panelSpriteGo:setPosition(150,70)

    -- ��ư Ŭ�� �̺�Ʈ��  ��� �����Լ��� ȣ���ϵ��� �����
    panelBtnGo:registerFuncOnMouseLButtonClick( function ()
             Laputan.LGameObject:ReleaseModal() 
    end)

    return panelGo
end

function test_spriteText(panelGo)
    -- �����ڵ�� �Ǿ� �ִ� xml ������ ����.
    -- (�ѱ�)���ڴ� �ݵ�� LaputanText ������Ʈ�� �ڽ� ������Ʈ ���� �νĵȴ�
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
    -- �����ڵ�� print �Լ��δ� ���� ����. �Ƚ�(Ansi)�� �ٲ������
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
    -- ���� ���� ��ü ���¸� �߰��ϱ� ���ѿ뵵 
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

    -- ���� ��ü�� ���� ������� �ʰ� �������� ���� �Է��Ѵ�
    collectionGo:setSpriteQuadCollection(4, Laputan.LVector2(300,400),
            25, Laputan.LVector2(1,1), "monkey", Laputan.SPRITE_ORIGIN_LEFT_TOP,3,
            Laputan.LColor(1,1,0,1))

			
    -- �߰��� ���� ��ü�� �߰��ɶ� ���͸� ȿ���� �ݿ����� �ʱ⿡ 
    -- �ʿ��ϴٸ� �ݷ��� ��ü���� 
    collectionGo:setSpriteFiltering(Laputan.TEXTURE_FILTERING_NONE)
--	collectionGo:setSpriteFiltering(Laputan.TEXTURE_FILTERING_BILINEAR)

--	collectionGo:setColor(1,0,0)
--	collectionGo:setFogColor(1,1,1,0.5)

--	collectionGo:setSpriteQuadCollection()

    -- �ݷ��ǿ� �߰� ��Ȱ�� �������� ����
    collectionPartGo:destroy()

    -- ���� ��������Ʈ 
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

    -- ���� ��ü�� ����
    gMeshGo2Child = meshGo2:createChild()
    gMeshGo2Child:setPosition(25,0)
    gMeshGo2Child:createSpriteMesh("robot.mesh")
    -- ���� ������ ������ ���̴� ���� ���� �ٲپ� ���� ������
    gMeshGo2Child:setMeshMaterial("Test/CustomParameter")	
    -- 0�� �ε����� �������� ����
    gMeshGo2Child:setMeshCustomParameter(0,Laputan.LVector4(1,0,0,1))
    gMeshGo2Child:setRotationZ(180)
    gMeshGo2Child:yaw(180)
    gMeshGo2Child:setScale(Laputan.LVector3(3,3,3))

    -- �ȱ� ���ϸ��̼����� ����
    -- �ٸ� �ִϸ��̼����� �����ϱ� ���ؼ� callbackKeyEvent �Լ��� ����
    gMeshGo2Child:makeMeshMainAnimationBlender("Walk",true)
--	local qRotation = Laputan.LQuaternion()
--	qRotation:fromAngleAxis(130,Laputan.LVector3(1,1,0))
--	gMeshGo2Child:setRotation(qRotation)
    

    -- ������ ������ ����
--	gMeshGo2Child:setScissorRect(Laputan.LUIntRect(100,100,700,550))
--	gMeshGo2Child:setScissorRect(Laputan.LUIntRect())

    -- Laputan.moveGameObject(meshGo,meshGo2,false)
end

function test_customVertexAndUV()
    local customGo = Laputan.gRootObject:createChild()	
    customGo:setPosition(100,450)
    customGo:createSpriteQuad()
    customGo:setSpriteTexture("test_rect",Laputan.SPRITE_ORIGIN_LEFT_TOP)

    -- ���ý��� ���� �����Ѵ�	
    local customVertex = {
            Laputan.LVector2(0,0),
            Laputan.LVector2(23,0),
            Laputan.LVector2(23,23),
            Laputan.LVector2(0,23),
    }

    -- �ý��� UV�� �ȼ� ���� ������ �����Ѵ� 
    local customUV = {
            Laputan.LVector2(0,28),
            Laputan.LVector2(23,28),
            Laputan.LVector2(23,51),
            Laputan.LVector2(0,51),
    }
--	customGo:setSpriteCustomVertex(customVertex)
--	customGo:setSpriteCustomPixelUV(customUV)
    customGo:setScaleXY(3)

    -- �ݷ��� ��ü�� �־ �׽�Ʈ ���غ���
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
    -- ��� �ı�
    sortChildGo1:destroy(0)

    local sortChildGo2 = gSortParentGo:createChild()
    sortChildGo2:setPosition(100,530)
    sortChildGo2:createSpriteQuad()
    sortChildGo2:setSpriteTexture("monkey",Laputan.SPRITE_ORIGIN_LEFT_BOTTOM)
    -- 60ƽ (1��) �� �ı�
    sortChildGo2:destroy(3)

    local sortChildGo3 = gSortParentGo:createChild()
    sortChildGo3:setPosition(100,500)
    sortChildGo3:createSpriteQuad()
    sortChildGo3:setSpriteTexture("monkey",Laputan.SPRITE_ORIGIN_LEFT_BOTTOM)
    -- 120 ƽ (2��) �� �ı�
    sortChildGo3:destroy(4)

    -- __LaputanFixedTickFunctionEnd �Լ����� sort ��Ų��
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
    -- �������� ������ http://www.ogre3d.org/docs/manual/manual_34.html#Particle-Scripts
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
   
    -- ���̾ �����ϰ� �ű涧 Ÿ���� �Ǵ� ���̾��� �θ��� �ڽ����� �ű�� Ÿ���� �� Ȥ�� �ڷ� ��ġ�Ѵ�
    -- 6�� ���Ӱ�ü�� 5�� ���� ��ü�� ������ �̵���Ų�� 
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

    -- ���� �θ� ���� ���� ��ü�� �̵�
    local node1 = Laputan.registerCallBackFunc(2.5,arg.func1)
    -- �θ� �ٸ� ���� ��ü�� �̵��� ��� ���̾� �̵��� ���� ��ǥ�谡 ���Ѵ�

    -- (�ű�� �θ��� ��ǥ�踦 ���󰡱⿡ ���� ��ǥ�� ���ϰԵȴ�)
    local node2 = Laputan.registerCallBackFunc(5,arg.func2)
    
    local node3 = Laputan.registerCallBackFunc(7.5,arg.func3)
    -- ���� �θ�� ���ư�
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



