

-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------

function __LaputanMainTemp()
	--- 참고로 모든 변수나 함수는 Laputan 혹은 __Laputan 으로 시작하는 이름으로 쓰지 말것 엔진 내부용으로 쓰인다        
      
        --- 콘솔창에 메세지를 뿌린다
	print("@@  __LaputanMain start  @@ ")
	print()
     
	--- 매 틱마다 마이크로 쓰레드가 시작하기전에 __LaputanFixedTickFunctionBegin 함수를 호출되게 만든다
	---Laputan.setEnableFixedTickFunctionBegin(true)
	--- 매 틱마다 마이크로 쓰레드가 시작한후에 __LaputanFixedTickFunctionEnd 함수를 호출되게 만든다
	Laputan.setEnableFixedTickFunctionEnd(true)

	--- 키보드에 반응할 이벤트와 콜백함수를 등록한다
	local keyTable = {}
	keyTable[Laputan.L_VK_Q] = Laputan.KEY_TEST_DOWN
	keyTable[Laputan.L_VK_W] = Laputan.KEY_TEST_DOWN
	keyTable[Laputan.L_VK_E] = Laputan.KEY_TEST_DOWN
	keyTable[Laputan.L_VK_R] = Laputan.KEY_TEST_DOWN
	keyTable[Laputan.L_VK_T] = Laputan.KEY_TEST_DOWN
	keyTable[Laputan.L_VK_I] = Laputan.KEY_TEST_DOWN
	keyTable[Laputan.L_VK_O] = Laputan.KEY_TEST_DOWN
	keyTable[Laputan.L_VK_P] = Laputan.KEY_TEST_DOWN
	keyTable[Laputan.L_VK_L] = Laputan.KEY_TEST_DOWN
	keyTable[Laputan.L_VK_Y] = Laputan.KEY_TEST_DOWN
	keyTable[Laputan.L_VK_U] = Laputan.KEY_TEST_DOWN

	keyTable[Laputan.L_VK_LEFT] = Laputan.KEY_TEST_UP_DOWN
	keyTable[Laputan.L_VK_UP] = Laputan.KEY_TEST_UP_DOWN
	keyTable[Laputan.L_VK_RIGHT] = Laputan.KEY_TEST_UP_DOWN
	keyTable[Laputan.L_VK_DOWN] = Laputan.KEY_TEST_UP_DOWN

	--- 테이블 확인
	---Laputan.print_table(keyTable)
	
	--- 이벤트에 반응할 keyTable을 등록하고 , callbackKeyEvent 함수로 콜백함수를 등록한다
	Laputan.registerCallBackKeyboard(keyTable, callbackKeyEvent)

---===========================================================================================================
	--- setup	
	--- 스프라이트를 모두제거하고 스프라이트 텍스쳐 정보 데이타를 로드한다
	Laputan.initSprite("editorTextureLoadingData.xml")

	------------------------------------------------------------------------------
	-- 스프라이트 텍스쳐 정보 데이타의 아이디에 해당하는 텍스쳐를 미리 로딩한다.
	--- 스프라이트 택스쳐는 이 방법을 써야 게임 객체에서 쓰일 수 있다.
---	Laputan.gPreloadSpriteManager:load({ "panel","beam" ,"monkey" })
	Laputan.gPreloadSpriteManager:load(
	{ "monkey" , "i_effect_rain_front","button2","beam","white",
          "planet_1","planet_2","planet_3","planet_4","planet_8","planet_9",
	  "test_number", "panel" ,"test_rect", "explosionPack" , "explosion1"
        })

	
	--- 매쉬에 쓰일 텍스쳐를 미리 로드한다. 만약 미리 로드 안하면 텍스쳐가 사용될때 로드 된다.
	--- load 함수에 로드할 리스트를 주면 기존에 로드되어 있던 객체는 참조에서 제외된다.
---	Laputan.gPreloadTextureManager:load({"bigSize.tga"})
	Laputan.gPreloadTextureManager:load({})

	--- 매쉬를 미리 로드 한다. 만약 미리 로드 안하면 메쉬가 사용될때 로드 된다.
	Laputan.gPreloadMeshManager:load({"robot.mesh","penguin.mesh", "razor.mesh"})
---	Laputan.gPreloadMeshManager:load({})

	--- 파티클 스크립트를 재로딩한다
---	Laputan.reloadParticleTemplate()
	--- 재질 스크립트를 재로딩한다.(현재는 리소스릭있음)
---	Laputan.reloadMaterial()

	--- 스프라이트 와 메쉬에 쓰일 텍스쳐중 참조되지 않는 텍스쳐는 언로드 한다.
	Laputan.unloadUnreferencedResourcesInTexture()
	--- 참조되지 않는 메쉬를 언로드 한다.
	Laputan.unloadUnreferencedResourcesInMesh()

	--- ###################################################################################
	--- 중요한것은 택스쳐와 메쉬를 load 한뒤에 load를 다시하면  이전 로드 리스트에 있던 것중에 다시 로드되지 않은
	--- 것들은 언로드 대상이 된다
	--- ###################################################################################


	--- 오디오 파일을 로드한다.
	--- 오디오에 관한 것은 Laputan.unloadUnreferencedResources 같은 함수가 필요 없이 load시 다리 로드되지 않는것은 언로드 된다.
---	Laputan.gAudioManager:load({"nice_music.ogg","ball.wav"})
	Laputan.gAudioManager:load({"AMemoryAway.ogg","nice_music.ogg", "cello.wav", "ball.wav"})

---===========================================================================================================
        
    --[[   
    local fogMonkeyGo = Laputan.gRootObject:createChild()
	fogMonkeyGo:setPosition(0,410)
	fogMonkeyGo:createSpriteQuad()
	fogMonkeyGo:setSpriteTexture("monkey",Laputan.SPRITE_ORIGIN_LEFT_TOP)
	
    local threadTable = {}
	threadTable._go = fogMonkeyGo
	function threadTable:run()
            local step = 0	
            local gameObject = threadTable._go
            while (true) do
                local pos = gameObject:getPositionXY()
                pos.x = pos.x + 1
                print("pos ::::",pos) 
                if( pos.x == 400 ) then
                    Laputan.Debug.breakCode()    
                elseif( pos.x > 600 ) then
                    Laputan.Debug.breakCode()               
                end
                gameObject:setPosition(pos)
                Laputan.sleepThread()	
            end
	end

    local threadHandle = Laputan.createThread(threadTable.run)
    --]]

        
      

	--- 메세지 박스를 뛰운다
	--- Laputan.messageBox(Laputan.LOG_NORMAL,"game Start")
        
        --[[
	test_LLinkedList()
	
        
        test_LDeque()
	
	test_showList()


	--test_backgroundSound()
	--test_effectSound()
	
	test_manyMonkey()

        test_fogMonkey()

	test_blendMode()
	
	local moveTestGo1 = test_moveTest()
	test_serializer(moveTestGo1)
        
       
	test_registerGameObjectEvent()
	local colorTestGO = test_gameObjectColor()	

        test_filtering(colorTestGO)
        test_spriteAnimation(colorTestGO)

       
	test_spriteButton()
	test_spriteCheckBox()
        test_spriteNumber()
  
	local panelGo = test_spritePanel()	
       
	test_spriteText(panelGo)
	test_spriteScrollBar()
        test_spriteListBox()	
        test_spriteLine(panelGo)
	test_spriteCollection()	

        test_spriteMesh()
        test_customVertexAndUV()
        test_sortAndDestroy()
          
	test_microThread()        
	test_spriteParticle()

        

   --[[
        -- 레이어만 보기 위해 다른 게임 객체들은 모두 제거함 (추가로 마이크로 쓰레드 , 콜백함수 제거)
        Laputan.gRootObject:clear()
        Laputan.killThreadAll()
        Laputan.clearCallBackFunc()
	Laputan.setEnableFixedTickFunctionEnd(false)
   
        test_layer()
--]]

        test_win32Gui()
        
        test_QxEffectMgr()
        
        initGameQuadMap(nil,32,32,50)

     






	print()
	print("@@  __LaputanMain end  @@")
end


function __LaputanFixedTickFunctionEnd()
	--gSortParentGo:sortChild(Laputan.COORDINATES_Y,true,false)
end

