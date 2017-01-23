

gQxEffectMgr = nil

local function toVector2(vec)
    return Laputan.LVector2(vec.x,vec.y)
end

function initQxEffectManager()
    gQxEffectMgr = {} 
    gQxEffectMgr._rootGo = Laputan.gRootObject
    
    function gQxEffectMgr:setRootGameObject(go)
        gQxEffectMgr._rootGo = go
    end

    function gQxEffectMgr:destroyEffect(handle) 
        if( handle._tbGo ) then
            for index,value in ipairs(handle._tbGo) do
                if( value:isValid() ) then
                    value:destroy()
                end
            end
        end

        if( handle._tbThread ) then
            for index,value in ipairs(handle._tbThread) do
                Laputan.killThread(value)
            end
        end

    end

    function gQxEffectMgr:explosionFragment(position, distance, timeSecond, fragmentCount, tbSpriteId)              
        local handle = {}
        handle._tbGo ={}

        local spriteCount = table.getn(tbSpriteId)
        for i=1, fragmentCount do
            local fragmentGo = gQxEffectMgr._rootGo:createChild()            
            fragmentGo:createSpriteQuad()
    	    fragmentGo:setSpriteTexture(tbSpriteId[ ( (i-1) % spriteCount) + 1 ],Laputan.SPRITE_ORIGIN_MIDDLE_MIDDLE)
                        
            local dir = Laputan.LQuaternion((360/fragmentCount)*i,Laputan.LVector3(0,0,1)) * Laputan.LVector3(1,0,0)          
            dir = (dir) * distance

            fragmentGo:setPosition( position )
            fragmentGo:pushMoveLinear(toVector2(dir), timeSecond, true)
            fragmentGo:destroy(timeSecond*60)
            
            fragmentGo:pushRotation(720,timeSecond,true)
            
            fragmentGo:pushAlpha(1,timeSecond/2,false)
            fragmentGo:pushAlpha(0,timeSecond/2,false)

            handle._tbGo[i] = fragmentGo
        end

        return handle
    end

    function gQxEffectMgr:explosionArea(targetPos, spriteId, width, height, timeSecond)         
        local handle = {}
        handle._tbGo = {}
        handle._tbThread = {}

        local threadTable = {}
        threadTable._targetPos = targetPos
        threadTable._spriteId = spriteId
        threadTable._width = width
        threadTable._height = height
        threadTable._timeSecond = timeSecond
        threadTable._totalTick = math.floor(60 * timeSecond)
      
        function threadTable:run()
            local index = 0
            while (threadTable._totalTick >= 0) do
                local explositionGo = gQxEffectMgr._rootGo:createChild()            
                explositionGo:createSpriteQuad()
    	        explositionGo:setSpriteTexture(spriteId,Laputan.SPRITE_ORIGIN_MIDDLE_MIDDLE)                
                
                local randPos = Laputan.LVector2(math.random(0,width) - width/2, math.random(0,height) - height/2)
                local myPos = threadTable._targetPos + randPos
                explositionGo:setPosition(myPos)
                explositionGo:setScaleXY( math.random(2, 5) )
                explositionGo:setSpriteFiltering(Laputan.TEXTURE_FILTERING_BILINEAR)
                local destroyTick = math.floor(60 * explositionGo:getSpriteTime())
                explositionGo:destroy(destroyTick)
                
                handle._tbGo[index+1] = explositionGo

                Laputan.sleepThread(5)	
                threadTable._totalTick = threadTable._totalTick - 5
            end
            
	end
        

        handle._tbThread[1] = Laputan.createThread(threadTable.run)
        return handle
    end
    
    function gQxEffectMgr:shootLine(spriteId, startPos, endPos, timeSecond)
        local handle = {}
        handle._tbGo = {}
 
        local go = gQxEffectMgr._rootGo:createChild()            
        go:createSpriteQuad()
        go:setSpriteTexture(spriteId,Laputan.SPRITE_ORIGIN_MIDDLE_MIDDLE)                
        go:setPosition(startPos)
        go:pushMoveLinear(endPos, timeSecond, false)
        go:destroy( timeSecond * 60 )

        handle._tbGo[1] = go
        return handle
    end
    
    function gQxEffectMgr:shootBezier()

    end

end


function test_QxEffectMgr()
    initQxEffectManager()

    gQxEffectMgr:shootLine("beam",Laputan.LVector2(100,100),Laputan.LVector2(500,300),0.5)
    
    function MyExplosion()
        gQxEffectMgr:explosionArea(Laputan.LVector2(500,300),"explosion1",150,150,1) 
        gQxEffectMgr:explosionFragment( Laputan.LVector2(500,300), 500, 1, 10,{"button2","panel","beam"} )    
    end

    Laputan.registerCallBackFunc(30,MyExplosion)

end