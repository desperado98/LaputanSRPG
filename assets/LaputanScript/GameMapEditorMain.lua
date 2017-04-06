function findValue(value,vector)
    for pos = 0, vector:size()-1 do
        if vector[pos] == value then
            return true
        end
    end

    return false
end



function __LaputanMain()
	
	local tbTest = {}
	function 
	
	local ss = Laputan.LXmlElement()	
	
	
	
-- 키보드에 반응할 이벤트와 콜백함수를 등록한다
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

    -- 테이블 확인
    --Laputan.print_table(keyTable)
    
    -- 이벤트에 반응할 keyTable을 등록하고 , callbackKeyEvent 함수로 콜백함수를 등록한다
    --Laputan.registerCallBackKeyboard(keyTable, callbackKeyEvent)

--===========================================================================================================
    -- setup	
    -- 스프라이트를 모두제거하고 스프라이트 텍스쳐 정보 데이타를 로드한다
    Laputan.initSprite("editorTextureLoadingData.xml")

    ------------------------------------------------------------------------------
    -- 스프라이트 텍스쳐 정보 데이타의 아이디에 해당하는 텍스쳐를 미리 로딩한다.
    -- 스프라이트 택스쳐는 이 방법을 써야 게임 객체에서 쓰일 수 있다.
--	Laputan.gPreloadSpriteManager:load({ "panel","beam" ,"monkey" })
    local window = Laputan.Win32.createWindow("test",0,0,700,400)
    
    window:createStaticText(15,80,100,25,"Sprite List")  
    local checkSpriteDelete = window:createCheckBox(150,75,100,25,"Delete")

    local spriteListBox = window:createListBox(10,100,200,150,false,false)  
    local editSpriteAdd = window:createEditBox(10,250,150,25,false,"")
    
    local tbArg = {}
    tbArg._checkSpriteDelete = checkSpriteDelete
    tbArg._editSpriteAdd = editSpriteAdd
    tbArg._spriteListBox = spriteListBox
    function tbArg:eventEnterKey()
        tbArg._editSpriteAdd:getText()
    end

    editSpriteAdd:registerFuncOnEnterKey(tbArg.eventEnterKey)
  
    local tbConfig = table.load("mapEditorSave/config.lua.tbd")
    if( tbConfig == nil ) then
        tbConfig = {}
    end    

    local mainMapData 
    if( tbConfig._currentSaveFile ) then
        assert( type(tbConfig._currentSaveFile) == "string" )
        mainMapData = table.load(tbConfig._currentSaveFile)  
    end
       
    if( mainMapData ~= nil ) then
        print("load mainMapData")
        if( mainMapData._tbSpriteTexture ~= nil ) then            
            print("preload sprite texture")
            Laputan.gPreloadSpriteManager:load(mainMapData._tbSpriteTexture) 
            local declareList = Laputan.gPreloadSpriteManager:getDeclareTextureIdList()
                        
            for i, v in ipairs(mainMapData._tbSpriteTexture) do
                spriteListBox:pushBack(v)
            end       
            
            --print("declareList",tolua.type(declareList))
            if( #mainMapData._tbSpriteTexture ~= declareList:size()) then
                for _,v in pairs(mainMapData._tbSpriteTexture) do
                    if( not findValue(v,declareList) ) then
                        --print("unloaded",v)
                        spriteListBox:erase(v)
                    end
                end
            end
        end
    end



--[[
    tbConfig._currentSaveFile = "mapEditorSave/testSave.lua.tbd"
    local t,e = table.save(tbConfig,"mapEditorSave/config.lua.tbd")

    local tbMain = {}
    tbMain._tbSpriteTexture = {"monkey" , "i_effect_rain_front","button2","beam","white",
      "planet_1","planet_2","planet_3","planet_4","planet_8","planet_9",
      "test_number", "panel" ,"test_rect", "explosionPack" , "explosion1"}
    
    tbMain._dummy = {}

    local t,e = table.save(tbMain,"mapEditorSave/testSave.lua.tbd")
    ]]--

    -- 매쉬에 쓰일 텍스쳐를 미리 로드한다. 만약 미리 로드 안하면 텍스쳐가 사용될때 로드 된다.
    -- load 함수에 로드할 리스트를 주면 기존에 로드되어 있던 객체는 참조에서 제외된다.
--	Laputan.gPreloadTextureManager:load({"bigSize.tga"})
    Laputan.gPreloadTextureManager:load({})

    -- 매쉬를 미리 로드 한다. 만약 미리 로드 안하면 메쉬가 사용될때 로드 된다.
    Laputan.gPreloadMeshManager:load({"robot.mesh","penguin.mesh", "razor.mesh"})
--	Laputan.gPreloadMeshManager:load({})

    -- 파티클 스크립트를 재로딩한다
--	Laputan.reloadParticleTemplate()
    -- 재질 스크립트를 재로딩한다.(현재는 리소스릭있음)
--	Laputan.reloadMaterial()

    -- 스프라이트 와 메쉬에 쓰일 텍스쳐중 참조되지 않는 텍스쳐는 언로드 한다.
    Laputan.unloadUnreferencedResourcesInTexture()
    -- 참조되지 않는 메쉬를 언로드 한다.
    Laputan.unloadUnreferencedResourcesInMesh()

    -- ###################################################################################
    -- 중요한것은 택스쳐와 메쉬를 load 한뒤에 load를 다시하면  이전 로드 리스트에 있던 것중에 다시 로드되지 않은
    -- 것들은 언로드 대상이 된다
    -- ###################################################################################


    -- 오디오 파일을 로드한다.
    -- 오디오에 관한 것은 Laputan.unloadUnreferencedResources 같은 함수가 필요 없이 load시 다리 로드되지 않는것은 언로드 된다.
--	Laputan.gAudioManager:load({"nice_music.ogg","ball.wav"})
    Laputan.gAudioManager:load({"AMemoryAway.ogg","nice_music.ogg", "cello.wav", "ball.wav"})
    

end




