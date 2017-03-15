
local sGameMap = nil
local tbKeyPress = {}  


function callBackMapKeyEvent(virtualKey, up) 
    --print("virtualKey",virtualKey,"up", up)
    tbKeyPress[virtualKey] = not up  

    if( Laputan.L_VK_0 <= virtualKey and virtualKey <= Laputan.L_VK_9) then
        local num = virtualKey - Laputan.L_VK_0
        print("sGameMap._pathCost ",sGameMap._pathCost )

        sGameMap._pathCost = num
    elseif( virtualKey == Laputan.L_VK_Q ) then   
        sGameMap._pathfindStart.x,sGameMap._pathfindStart.y = sGameMap:getSelectedTileOnCursor()        
    elseif( virtualKey == Laputan.L_VK_W ) then    
        sGameMap._pathfindEnd.x,sGameMap._pathfindEnd.y = sGameMap:getSelectedTileOnCursor()     
    elseif( virtualKey == Laputan.L_VK_E ) then   
        print("path finding")
        local timer = makeHighResolutionTimer()
        timer:startTime()
        local map = initPathFindingQuadMap(sGameMap._mapQuadGrid)
        if( sGameMap._pathfindStart == sGameMap._pathfindEnd ) then
            Laputan.Win32.messageBox(Laputan.LOG_NORMAL, "pathfindStart == pathfindEnd")
            return 
        end

        print("test time", timer:getTime())

        local list = map:findPath(sGameMap._pathfindStart.x,sGameMap._pathfindStart.y,
            sGameMap._pathfindEnd.x,sGameMap._pathfindEnd.y)

        print("this._Found", map._Found)
        print("complete time", map._CompletedTime)
        for i=0, list:size()-1 do
           print("close list : ",list:get(i).X,list:get(i).Y)
        end    

        sGameMap._doRedrawGrid = true
    end


end

function mapUpdateThread()

    while true do
        -------------------------------------------------------
        -- 키보드 이벤트 처리 --------------------
        local moveScale = 5
        local posXY = sGameMap._mapRoot:getPositionXY()            
        if tbKeyPress[Laputan.L_VK_LEFT] then
            posXY.x = posXY.x + moveScale
        end
        if tbKeyPress[Laputan.L_VK_RIGHT] then
            posXY.x = posXY.x - moveScale
        end
        if tbKeyPress[Laputan.L_VK_UP] then
            posXY.y = posXY.y + moveScale
        end
        if tbKeyPress[Laputan.L_VK_DOWN] then
            posXY.y = posXY.y - moveScale
        end
        
        sGameMap._mapRoot:setPosition(posXY)
        -------------------------------------------------------
        
        -------------------------------------------------------
        -------------------------------------------------------
        if( sGameMap._isMouseDown ) then
            local tileX,tileY = sGameMap:getSelectedTileOnCursor()
            --print("path cost change : ",tileX,tileY,sGameMap._pathCost)
            if( tileX >= 0 and tileY >= 0 ) then
                sGameMap._mapQuadGrid:set(tileX,tileY,sGameMap._pathCost)    
                sGameMap._doRedrawGrid = true
            end
        end

        -------------------------------------------------------
        -------------------------------------------------------
   
        if( sGameMap._doRedrawGrid ) then    
            sGameMap:makeQuadTile()
            sGameMap._doRedrawGrid = false
        end
        
        -------------------------------------------------------
        -------------------------------------------------------
        Laputan.sleepThread()
    end
end
   


function initGameQuadMap(loadFileName,widthCountX,widthCountY,tileSize)
    local this = {}
    if( loadFileName ) then
        local tbMapData = table.load(loadFileName)        
        --this._mapQuadGrid
    else
        
        this._mapQuadGrid = makeZeroBaseArray2D(widthCountX,widthCountY,1)
    end
    
    this._tileSize = tileSize
    if this._tileSize == nil then
        this._tileSize = 50
    end

    this._widthCountX = widthCountX
    this._widthCountY = widthCountY

    this._doRedrawGrid = true
    
    this._pathfindStart = Laputan.LVector2(0,0)
    this._pathfindEnd = Laputan.LVector2(0,0)
    -------------------------------------------------------
    -- 큰 사각형내에 분할된 사각형
    this._mapRoot = Laputan.gRootObject:createChild()

    this._quadTileCollectionGo = this._mapRoot:createChild()
    this._quadTileCollectionGo:createSpriteQuadCollection()    

    function this:makeQuadTile()
        local tempQuadGo = this._mapRoot:createChild()
        tempQuadGo:createSpriteQuad()

        local whiteTextureSize = Laputan.gPreloadSpriteManager:getTextureSize("white")    
        this._tileScaleX = this._tileSize/whiteTextureSize.x
        this._tileScaleY = this._tileSize/whiteTextureSize.y
        tempQuadGo:setSpriteTexture("white",Laputan.SPRITE_ORIGIN_LEFT_TOP)
        tempQuadGo:setScale( Laputan.LVector2(this._tileScaleX,this._tileScaleY) )
        --tempQuadGo:setColor(0,0,1)
        --tempQuadGo:setAlpha(0)
        this._quadTileCollectionGo:clearSpriteQuadCollection()
        for yi=0 , widthCountY - 1 do   
            for xi=0 , widthCountX - 1 do   
                local pathCost = sGameMap._mapQuadGrid:get(xi,yi)
                local costColor
                if (pathCost == 0) then
                    costColor = Laputan.LColor(1,0,0,0.5)
                elseif (pathCost == 0) then
                    costColor = Laputan.LColor(1,0,0,0.5)
                elseif (pathCost == 0) then
                    costColor = Laputan.LColor(1,0,0,0.5)                    
                elseif (pathCost == 0) then
                    costColor = Laputan.LColor(1,0,0,0.5)              
                elseif (pathCost == 1) then
                    costColor = Laputan.LColor(1,1,1,0.5) 
                else
                    costColor = Laputan.LColor(1,1,1-(pathCost*0.1),0.5)
                end
                
                tempQuadGo:setColor(costColor)
                local pos = Laputan.LVector2(xi*this._tileSize,yi*this._tileSize) - this._mapRoot:getPositionXY()
                tempQuadGo:setPosition(pos)
                this._quadTileCollectionGo:addSpriteQuadCollection(tempQuadGo)    
            end
        end

        tempQuadGo:destroy()
    end

    -------------------------------------------------------
    -- 사각형 분할한 라인
    local quadLineCollectionGo = this._mapRoot:createChild()
    quadLineCollectionGo:createSpriteLine()
    quadLineCollectionGo:setColor(1,0,0,1)
    
    local totalWidthSize = this._tileSize * widthCountX
    local totalHeightSize = this._tileSize * widthCountY
    
    for yi=0 , widthCountY  do   
        quadLineCollectionGo:addLine(
            Laputan.LVector2(0,yi*this._tileSize),
            Laputan.LVector2(totalWidthSize,yi*this._tileSize))    
    end

    for xi=0 , widthCountX  do   
        quadLineCollectionGo:addLine(
            Laputan.LVector2(xi*this._tileSize,0),
            Laputan.LVector2(xi*this._tileSize,totalHeightSize))    
    end

    -------------------------------------------------------
    local gridEventGo = this._mapRoot:createChild()
    gridEventGo:createSpriteQuad()
    gridEventGo:setSpriteTexture("white",Laputan.SPRITE_ORIGIN_LEFT_TOP)
    gridEventGo:setColor(0,0,1,0)
    gridEventGo:setScale( Laputan.LVector2(5000,5000))
    gridEventGo:setPosition(-2500,-2500)
 
    this._pathCost = 0
    this._isMouseDown = false
    function this:onMouseDown()
        this._isMouseDown = true
    end
    function this:onMouseUp()
        this._isMouseDown = false
    end
    gridEventGo:registerFuncOnMouseLButtonDown(this.onMouseDown)
    gridEventGo:registerFuncOnMouseLButtonUp(this.onMouseUp)
   
    -------------------------------------------------------
    
    function this:getSelectedTileOnCursor()
        local mousePos = Laputan.getCurrentMousePointer()
        local mapRootPos = this._mapRoot:getPositionXY()

        local posInMap = mousePos - mapRootPos
        local tileX = math.floor(posInMap.x / sGameMap._tileSize)
        local tileY = math.floor(posInMap.y / sGameMap._tileSize)
        return tileX,tileY
    end


    -------------------------------------------------------
 
    local keyTable = {}  

    keyTable[Laputan.L_VK_0] = Laputan.KEY_TEST_DOWN
    keyTable[Laputan.L_VK_1] = Laputan.KEY_TEST_DOWN
    keyTable[Laputan.L_VK_2] = Laputan.KEY_TEST_DOWN
    keyTable[Laputan.L_VK_3] = Laputan.KEY_TEST_DOWN
    keyTable[Laputan.L_VK_4] = Laputan.KEY_TEST_DOWN
    keyTable[Laputan.L_VK_5] = Laputan.KEY_TEST_DOWN
    keyTable[Laputan.L_VK_6] = Laputan.KEY_TEST_DOWN
    keyTable[Laputan.L_VK_7] = Laputan.KEY_TEST_DOWN
    keyTable[Laputan.L_VK_8] = Laputan.KEY_TEST_DOWN
    keyTable[Laputan.L_VK_9] = Laputan.KEY_TEST_DOWN

    keyTable[Laputan.L_VK_Q] = Laputan.KEY_TEST_DOWN
    keyTable[Laputan.L_VK_W] = Laputan.KEY_TEST_DOWN
    keyTable[Laputan.L_VK_E] = Laputan.KEY_TEST_DOWN

    keyTable[Laputan.L_VK_LEFT] = Laputan.KEY_TEST_UP_DOWN
    keyTable[Laputan.L_VK_UP] = Laputan.KEY_TEST_UP_DOWN
    keyTable[Laputan.L_VK_RIGHT] = Laputan.KEY_TEST_UP_DOWN
    keyTable[Laputan.L_VK_DOWN] = Laputan.KEY_TEST_UP_DOWN
    
    -- 키보드 다시 설정    
    Laputan.registerCallBackKeyboard(keyTable, callBackMapKeyEvent)    
    Laputan.createThread(mapUpdateThread)



    
    ---------------------------------------------------------
    sGameMap = this
end








