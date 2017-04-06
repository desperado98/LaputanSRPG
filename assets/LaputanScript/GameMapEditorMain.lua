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
	
	
	
-- Ű���忡 ������ �̺�Ʈ�� �ݹ��Լ��� ����Ѵ�
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

    -- ���̺� Ȯ��
    --Laputan.print_table(keyTable)
    
    -- �̺�Ʈ�� ������ keyTable�� ����ϰ� , callbackKeyEvent �Լ��� �ݹ��Լ��� ����Ѵ�
    --Laputan.registerCallBackKeyboard(keyTable, callbackKeyEvent)

--===========================================================================================================
    -- setup	
    -- ��������Ʈ�� ��������ϰ� ��������Ʈ �ؽ��� ���� ����Ÿ�� �ε��Ѵ�
    Laputan.initSprite("editorTextureLoadingData.xml")

    ------------------------------------------------------------------------------
    -- ��������Ʈ �ؽ��� ���� ����Ÿ�� ���̵� �ش��ϴ� �ؽ��ĸ� �̸� �ε��Ѵ�.
    -- ��������Ʈ �ý��Ĵ� �� ����� ��� ���� ��ü���� ���� �� �ִ�.
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

    -- �Ž��� ���� �ؽ��ĸ� �̸� �ε��Ѵ�. ���� �̸� �ε� ���ϸ� �ؽ��İ� ���ɶ� �ε� �ȴ�.
    -- load �Լ��� �ε��� ����Ʈ�� �ָ� ������ �ε�Ǿ� �ִ� ��ü�� �������� ���ܵȴ�.
--	Laputan.gPreloadTextureManager:load({"bigSize.tga"})
    Laputan.gPreloadTextureManager:load({})

    -- �Ž��� �̸� �ε� �Ѵ�. ���� �̸� �ε� ���ϸ� �޽��� ���ɶ� �ε� �ȴ�.
    Laputan.gPreloadMeshManager:load({"robot.mesh","penguin.mesh", "razor.mesh"})
--	Laputan.gPreloadMeshManager:load({})

    -- ��ƼŬ ��ũ��Ʈ�� ��ε��Ѵ�
--	Laputan.reloadParticleTemplate()
    -- ���� ��ũ��Ʈ�� ��ε��Ѵ�.(����� ���ҽ�������)
--	Laputan.reloadMaterial()

    -- ��������Ʈ �� �޽��� ���� �ؽ����� �������� �ʴ� �ؽ��Ĵ� ��ε� �Ѵ�.
    Laputan.unloadUnreferencedResourcesInTexture()
    -- �������� �ʴ� �޽��� ��ε� �Ѵ�.
    Laputan.unloadUnreferencedResourcesInMesh()

    -- ###################################################################################
    -- �߿��Ѱ��� �ý��Ŀ� �޽��� load �ѵڿ� load�� �ٽ��ϸ�  ���� �ε� ����Ʈ�� �ִ� ���߿� �ٽ� �ε���� ����
    -- �͵��� ��ε� ����� �ȴ�
    -- ###################################################################################


    -- ����� ������ �ε��Ѵ�.
    -- ������� ���� ���� Laputan.unloadUnreferencedResources ���� �Լ��� �ʿ� ���� load�� �ٸ� �ε���� �ʴ°��� ��ε� �ȴ�.
--	Laputan.gAudioManager:load({"nice_music.ogg","ball.wav"})
    Laputan.gAudioManager:load({"AMemoryAway.ogg","nice_music.ogg", "cello.wav", "ball.wav"})
    

end




