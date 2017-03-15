

function c_index(index)
    return index + 1
end

function bit_lshift(x, by)
  return x * 2 ^ by
end

function bit_rshift(x, by)
  return math.floor(x / 2 ^ by)
end

function bit_or(a,b)--Bitwise or
    local p,c=1,0
    while a+b>0 do
        local ra,rb=a%2,b%2
        if ra+rb>0 then c=c+p end
        a,b,p=(a-ra)/2,(b-rb)/2,p*2
    end
    return c
end

function bit_and(a,b)--Bitwise and
    local p,c=1,0
    while a>0 and b>0 do
        local ra,rb=a%2,b%2
        if ra+rb>1 then c=c+p end
        a,b,p=(a-ra)/2,(b-rb)/2,p*2
    end
    return c
end



function makeZeroBaseArray2D(x,y,defaultValue)
    local this = {}
    this._sizeX = x
    this._sizeY = y
    this._tbMap = {}

    for i=0, y-1 do
        for j=1,x do
            this._tbMap[ i*this._sizeX + j] = defaultValue
        end
    end

    function this:get(x,y)
--        assert(x >= 0,"x >= 0")
--        assert(y >= 0,"y >= 0")
        return this._tbMap[ y*this._sizeX + x + 1 ]
    end

    function this:set(x,y,value)
--        assert(x >= 0,"x >= 0")
--        assert(y >= 0,"y >= 0")
        this._tbMap[ y*this._sizeX + x + 1] = value
    end

    function this:getSize()
        return this._sizeX,this._sizeY
    end

    return this
end

function makeZeroBaseVector()
    local this = {}
    
    function this:set(index,item)
        this[index+1] = item
    end

    function this:get(index)
        return this[index+1]
    end
    
    function this:pushBack(item)
        table.insert(this,item)
    end

    function this:popBack(index)
        table.remove(this,#this)        
    end

    function this:insert(index,item)
        table.insert(this,index+1,item)
    end
    
    function this:erase(index)
        table.remove(this,index+1)        
    end

    function this:size()
        return table.getn(this)
    end

    function this:clear()
        this = {}
    end
    
    return this
end


function makePriorityQueueB( funcComparer )
    local this = {}
    this._innerList = makeZeroBaseVector()

    --c# 비교함수 스타일
    -- compare 함수를 가진 함수 객체로 받는다 , 그래야 함수 객체인지 그냥 함수인지에 따른 인자 갯수에따른 오류를 내지 않는다
    assert(funcComparer ~= nil,"funcComparer ~= nil")
    this._funcComparer = funcComparer
 
    
-- private:
    function this:_switchElements(i,j)
        local h = this._innerList:get(i)
        this._innerList:set(i,this._innerList:get(j))
	this._innerList:set(j,h)
    end

    function this:_onCompare(a,b)
        return this._funcComparer:compare(this._innerList:get(a),this._innerList:get(b))
    end

-- public:
    function this:push(item)
        -- 0번 인데스로 시작하는 배열 자료구조 만들어주자
        local p = this._innerList:size()
        this._innerList:pushBack(item)
                
        local isContinue = true
        while(isContinue) do
            isContinue,p = (function(this,p)            
                if p==0 then
                    return false,p
                end

                local p2 = math.floor((p-1)/2)
                
                if this:_onCompare(p,p2) < 0  then
                    this:_switchElements(p,p2)
                    p = p2
                    return true,p
                end

                return false,p
            end)(this,p)
        end

        return p
    end


    function this:pop()    
        assert(this._innerList:size() > 0)
       	local result = this._innerList:get(0)
        local p = 0
        local pn = 0

        this._innerList:set(0,this._innerList:get(this._innerList:size()-1))
        this._innerList:erase(this._innerList:size()-1)

        local isContinue = true
        while(isContinue) do    
            isContinue,p,pn = (function(this,p,pn)
                pn = p
                local p1 = 2*p+1
                local p2 = 2*p+2
                if(this._innerList:size()>p1 and this:_onCompare(p,p1)>0) then -- links kleiner
                    p = p1
                end
                if(this._innerList:size()>p2 and this:_onCompare(p,p2)>0) then -- rechts noch kleiner
                    p = p2
                end
                
                if(p==pn) then
                    return false
                end

                this:_switchElements(p,pn)
                return true,p,pn

            end)(this,p,pn)
        end
   
        return result
    end

    function this:peek()
        assert(this._innerList:size() > 0,"this._innerList:size()")
        return this._innerList:get(0)
    end
   
    function this:at(index)
        assert(this._innerList:size() > 0,"this._innerList:size()")
         return this._innerList:get(index)
    end
   
    
    function this:clear()
       this._innerList:clear()
    end

    function this:size()
       return this._innerList:size()
    end

    return this
end


function test_PriorityQueueB()

--[[
    for i=0,50 do
        print("i",i)
       
        if( i==10) then
            goto continue
        end
    end

    ::continue::
--]]

    
    local funcObj = {}
    function funcObj:compare(a,b)
        if a._key > b._key then return 1        
        elseif a._key < b._key then return -1 end        
        return 0
    end

    local myQ1 = makePriorityQueueB( funcObj )  
    local myQ2 = makePriorityQueueB( funcObj )
 
    
    local t1 = { _key = 1 }
    local t2 = { _key = 7 }
    local t3 = { _key = 5 }
    local t4 = { _key = 2 }

    local t5 = { _key = 11 }
    local t6 = { _key = 77 }
    local t7 = { _key = 55 }
    local t8 = { _key = 22 }

    myQ1:push(t1)
    myQ1:push(t2)
    myQ1:push(t3)
    myQ1:push(t4)

    myQ2:push(t5)
    myQ2:push(t6)
    myQ2:push(t7)
    myQ2:push(t8)

    print("test myQ")

    while( myQ1:size() > 0) do
        print("myQ1 " , myQ1:pop()._key)        
        print("myQ2 " , myQ2:pop()._key)        
    end

    print("myQ1:size()",myQ1:size())
    print("myQ2:size()",myQ2:size())

    print("bit_lshift", bit_lshift(20,3))
    print("bit_rshift", bit_rshift(20,3))

    print("bit_and", bit_and(9,7))
    print("bit_or", bit_or(2,10))
    

end

function makeHighResolutionTimer()
    local this = {}    
    this._startTime = 0

    function this:startTime()
        this._startTime = os.clock()
    end

    function this:getTime()
        return os.clock() - this._startTime
    end

    return this
end



function initPathFindingQuadMap(grid)
    local this = {}
    this.PathFinderNodeType = {
        Start   = 1,
        End     = 2,
        Open    = 4,
        Close   = 8,
        Current = 16,
        Path    = 32
    }

    this.HeuristicFormula = {
        Manhattan           = 1,
        MaxDXDY             = 2,
        DiagonalShortCut    = 3,
        Euclidean           = 4,
        EuclideanNoSQR      = 5,
        Custom1             = 6
    }
  
    ---------------------------------------------------------------------

    this._Grid                   = nil
    this._Open                   = nil
    this._Close                  = makeZeroBaseVector()  
    this._Stop                   = false
    this._Stopped                = true
    this._Horiz                  = 0
    this._Formula                = this.HeuristicFormula.Manhattan
    --this._Diagonals              = true
    this._HEstimate              = 2
    this._PunishChangeDirection  = false
    this._TieBreaker             = false
    this._HeavyDiagonals         = false
    this._SearchLimit            = 2000
    this._CompletedTime          = 0
    this._DebugProgress          = false
    this._DebugFoundPath         = false
    this._CalcGrid               = nil
    this._OpenNodeValue          = 1
    this._CloseNodeValue         = 2
    

    this._H                      = 0
    this._Location               = 0
    this._NewLocation            = 0
    this._LocationX              = 0
    this._LocationY              = 0
    this._NewLocationX           = 0
    this._NewLocationY           = 0
    this._CloseNodeCounter       = 0
    this._GridX                  = 0
    this._GridY                  = 0
    this._GridXMinus1            = 0
    this._GridYLog2              = 0
    this._Found                  = false
    this._Direction              = nil
    this._EndLocation            = 0
    this._NewG                   = 0    

    this._HighResolutionTime = makeHighResolutionTimer()
    ---------------------------------------------------------------------

    function this:makePathFinerNode(F,G,H,X,Y,PX,PY)
        local node = {}
        node.F = F
        node.G = G
        node.H = H
        node.X = X
        node.Y = Y
        node.PX = PX
        node.PY = PY
        return node
    end

    function this:setDiagonals( value )
        this._isDiagonals = value
        if this._isDiagonals then
            this._Direction = makeZeroBaseArray2D(8,2,0)
            this._Direction:set(0,0,  0)
            this._Direction:set(0,1, -1)
            this._Direction:set(1,0,  1)
            this._Direction:set(1,1,  0)
            this._Direction:set(2,0,  0)
            this._Direction:set(2,1,  1)
            this._Direction:set(3,0, -1)
            this._Direction:set(3,1,  0)
            this._Direction:set(4,0,  1)
            this._Direction:set(4,1, -1)
            this._Direction:set(5,0,  1)
            this._Direction:set(5,1,  1)
            this._Direction:set(6,0, -1)
            this._Direction:set(6,1,  1)
            this._Direction:set(7,0, -1)
            this._Direction:set(7,1, -1)        
        else
            makeZeroBaseArray2D(4,2,0)
            this._Direction:set(0,0,  0)
            this._Direction:set(0,1, -1)
            this._Direction:set(1,0,  1)
            this._Direction:set(1,1,  0)
            this._Direction:set(2,0,  0)
            this._Direction:set(2,1,  1)
            this._Direction:set(3,0, -1)
            this._Direction:set(3,1,  0)
        end
    end
    
    local function makeComparePFNodeMatrix(matrix)
        local this = {}
        this._matrix = matrix

        function this:compare(a,b)
            if( this._matrix:get(a).F > this._matrix:get(b).F ) then
                return 1
            elseif (this._matrix:get(a).F < this._matrix:get(b).F ) then
                return -1
            end
            return 0
        end

        return this
    end


    ---------------------------------------------------------------------
    this._Grid = grid
    this._GridX,this._GridY = this._Grid:getSize()

    this._GridXMinus1    = this._GridX - 1
    this._GridYLog2      = math.floor( math.log(this._GridY, 2) )
    print("this._GridYLog2",this._GridYLog2)
    print("this._GridXMinus1",this._GridXMinus1)

    assert(math.log(this._GridX, 2) == math.floor(math.log(this._GridX, 2)) and
           math.log(this._GridY, 2) == math.floor(math.log(this._GridY, 2)),
           "Invalid Grid, size in X and Y must be power of 2" )
 
    if (this._CalcGrid == nil or this._CalcGrid:size() ~= (this._GridX * this._GridY)) then
        this._CalcGrid = makeZeroBaseVector()  
        for i=0, (this._GridX * this._GridY - 1) do
            this._CalcGrid:pushBack(this:makePathFinerNode(0,0,0,0,0,0,0))
        end
    end
    
    this:setDiagonals(true)  
    
    this._Open = makePriorityQueueB( makeComparePFNodeMatrix(this._CalcGrid) ) 

-- public :
    function this:findPath(startX,startY,endX,endY)
        this._HighResolutionTime:startTime()

        local startPoint = {X = startX, Y = startY}
        local endPoint =   {X = endX,   Y = endY}
        
        this._Found              = false
        this._Stop               = false
        this._Stopped            = false
        this._CloseNodeCounter   = 0
        this._OpenNodeValue      = this._OpenNodeValue + 2
        this._CloseNodeValue     = this._CloseNodeValue + 2
        this._Open:clear()
        this._Close:clear()

        this._Location                      = bit_lshift( startPoint.Y , this._GridYLog2 ) + startPoint.X
        this._EndLocation                   = bit_lshift( endPoint.Y   , this._GridYLog2 ) + endPoint.X
        this._CalcGrid:get(this._Location).G         = 0
        this._CalcGrid:get(this._Location).F         = this._HEstimate
        this._CalcGrid:get(this._Location).PX        = startPoint.X
        this._CalcGrid:get(this._Location).PY        = startPoint.Y
        this._CalcGrid:get(this._Location).Status    = this._OpenNodeValue
       
        this._Open:push(this._Location)

 --       print("start")
  --      print("this._EndLocation",this._EndLocation)

        while(this._Open:size() > 0 and (not this._Stop) ) do
   --         print("while - start")
            
     --       print("check openQ : ------------------------")
      --      for i=0, this._Open._innerList:size()-1 do
       --         local location = this._Open._innerList:get(i)
       --         print("index(" .. i .. ")" .. " Location(" .. location .. ")" .. " F - " , this._CalcGrid:get(location).F ) 
        --    end
        --    print("----------------------------------------")

            this._Location = this._Open:pop()

          --  print("this._Location",this._Location)

            if (this._CalcGrid:get(this._Location).Status == this._CloseNodeValue) then
                goto continue_1
            end

            this._LocationX   = bit_and(this._Location, this._GridXMinus1)
            this._LocationY   = bit_rshift(this._Location, this._GridYLog2)
            
         --   print("this._LocationX",this._LocationX)
        --    print("this._LocationY",this._LocationY)


            if (this._Location == this._EndLocation) then
                this._CalcGrid:get(this._Location).Status = this._CloseNodeValue
                this._Found = true
        --        print("Find Way!!!")
                break
            end

       --     print("this._CloseNodeCounter",this._CloseNodeCounter)
            if (this._CloseNodeCounter > this._SearchLimit) then

            --    print("this._CloseNodeCounter > this._SearchLimit")

                this._Stopped = true
                this._CompletedTime = this._HighResolutionTime:getTime()
                return null
            end
            
            if (this._PunishChangeDirection) then
                this._Horiz = (this._LocationX - this._CalcGrid:get(this._Location).PX)
            end

            
            local checkDirection = 4
            if( this._isDiagonals ) then
                checkDirection = 8
            end

            for i=0,checkDirection-1 do
            --    print("checkDirection",i)
                --Laputan.messageBox(Laputan.LOG_NORMAL, "step : 1")
                this._NewLocationX = this._LocationX + this._Direction:get(i,0)
                this._NewLocationY = this._LocationY + this._Direction:get(i,1)
                this._NewLocation  = bit_lshift(this._NewLocationY, this._GridYLog2) + this._NewLocationX
                
             --   print("this._NewLocationX",this._NewLocationX)
            --    print("this._NewLocationY",this._NewLocationY)
             --   print("this._NewLocation",this._NewLocation)

                if (this._NewLocationX >= this._GridX or this._NewLocationY >= this._GridY) then
                    goto continue_2
                end
                
                if (this._NewLocationX < 0 or this._NewLocationY < 0) then
                    goto continue_2
                end

                if (this._Grid:get(this._NewLocationX, this._NewLocationY) == 0) then
                    goto continue_2
                end
                
                --Laputan.messageBox(Laputan.LOG_NORMAL, "step : 2")

                if (this._HeavyDiagonals and i>3) then
                    this._NewG = this._CalcGrid:get(this._Location).G + math.floor(this._Grid:get(this._NewLocationX, this._NewLocationY) * 2.41)
                else
                    this._NewG = this._CalcGrid:get(this._Location).G + this._Grid:get(this._NewLocationX, this._NewLocationY)
                end
                
             --   print("this._CalcGrid:get(this._Location).G",this._CalcGrid:get(this._Location).G)
             --   print("this._NewG",this._NewG)

                if (this._PunishChangeDirection) then
                    if ((this._NewLocationX - this._LocationX) ~= 0) then
                        if (this._Horiz == 0) then
                            this._NewG = this._NewG + math.abs(this._NewLocationX - endPoint.X) + math.abs(this._NewLocationY - endPoint.Y)
                        end
                    end
                    if ((this._NewLocationY - this._LocationY) ~= 0) then
                        if (this._Horiz ~= 0) then
                            this._NewG = this._NewG+ math.abs(this._NewLocationX - endPoint.X) + math.abs(this._NewLocationY - endPoint.Y)
                        end
                    end
                end
                
                if (this._CalcGrid:get(this._NewLocation).Status == this._OpenNodeValue or this._CalcGrid:get(this._NewLocation).Status == this._CloseNodeValue) then
                    if (this._CalcGrid:get(this._NewLocation).G <= this._NewG) then
                        goto continue_2
                    end
                end
                
                --Laputan.messageBox(Laputan.LOG_NORMAL, "step : 3")

                this._CalcGrid:get(this._NewLocation).PX      = this._LocationX
                this._CalcGrid:get(this._NewLocation).PY      = this._LocationY
                this._CalcGrid:get(this._NewLocation).G       = this._NewG

                if( this._Formula == this.HeuristicFormula.Manhattan ) then
                    this._H = this._HEstimate * (math.abs(this._NewLocationX - endPoint.X) + math.abs(this._NewLocationY - endPoint.Y))
                elseif( this._Formula == this.HeuristicFormula.MaxDXDY ) then
                    this._H = this._HEstimate * (math.max(math.abs(this._NewLocationX - endPoint.X), math.abs(this._NewLocationY - endPoint.Y)))
                elseif( this._Formula == this.HeuristicFormula.DiagonalShortCut ) then
                    local h_diagonal  = math.min(math.abs(this._NewLocationX - endPoint.X), math.abs(this._NewLocationY - endPoint.Y))
                    local h_straight  = (math.abs(this._NewLocationX - endPoint.X) + math.abs(this._NewLocationY - endPoint.Y))
                    this._H = (this._HEstimate * 2) * h_diagonal + this._HEstimate * (h_straight - 2 * h_diagonal)
                elseif( this._Formula == this.HeuristicFormula.Euclidean ) then
                    this._H = math.floor(this._HEstimate * math.sqrt(math.pow((this._NewLocationY - endPoint.X) , 2) + math.pow((this._NewLocationY - endPoint.Y), 2)))           
                elseif( this._Formula == this.HeuristicFormula.EuclideanNoSQR ) then
                    this._H = math.floor(this._HEstimate * (math.pow((this._NewLocationX - endPoint.X) , 2) + math.pow((this._NewLocationY - endPoint.Y), 2)))          
                elseif( this._Formula == this.HeuristicFormula.Custom1 ) then
                     local dxy = {X = math.abs(endPoint.X - this._NewLocationX), Y = math.abs(endPoint.Y - this._NewLocationY)}
                     local Orthogonal  = math.abs(dxy.X - dxy.Y)
                     local Diagonal    = math.floor(math.abs(((dxy.X + dxy.Y) - Orthogonal) / 2))
                     this._H = this._HEstimate * (Diagonal + Orthogonal + dxy.X + dxy.Y);
                else
                    assert(false,"unknown formula")
                end


                if (this._TieBreaker) then
                    local dx1 = this._LocationX - endPoint.X;
                    local dy1 = this._LocationY - endPoint.Y;
                    local dx2 = startPoint.X - endPoint.X;
                    local dy2 = startPoint.Y - endPoint.Y;
                    local cross = math.abs(dx1 * dy2 - dx2 * dy1);
                    this._H = math.floor(this._H + cross * 0.001);
                end

             --   print("this._H",this._H)

                this._CalcGrid:get(this._NewLocation).F = this._NewG + this._H    
                this._CalcGrid:get(this._NewLocation).Status = this._OpenNodeValue

             --   print("this._CalcGrid:get(this._NewLocation).F",this._CalcGrid:get(this._NewLocation).F)
             --   print("this._CalcGrid:get(this._NewLocation).Status",this._CalcGrid:get(this._NewLocation).Status)

                this._Open:push(this._NewLocation)

                ::continue_2::
            end

            this._CloseNodeCounter = this._CloseNodeCounter + 1
            this._CalcGrid:get(this._Location).Status = this._CloseNodeValue

            ::continue_1::
        end

        this._CompletedTime = this._HighResolutionTime:getTime()

        if (this._Found) then
            this._Close:clear()
            local posX = endPoint.X
            local posY = endPoint.Y

            local fNodeTmp = this._CalcGrid:get(bit_lshift(endPoint.Y, this._GridYLog2) + endPoint.X)
            --this:makePathFinerNode(F,G,H,X,Y,PX,PY)
            local fNode = this:makePathFinerNode(fNodeTmp.F,fNodeTmp.G,0,endPoint.X,endPoint.Y,fNodeTmp.PX,fNodeTmp.PY)
           
            while(fNode.X ~= fNode.PX or fNode.Y ~= fNode.PY) do
                this._Close:pushBack(fNode)              
                posX = fNode.PX
                posY = fNode.PY
                fNodeTmp = this._CalcGrid:get(bit_lshift(posY , this._GridYLog2) + posX)
                
                fNode = this:makePathFinerNode(fNodeTmp.F,fNodeTmp.G,0,posX,posY,fNodeTmp.PX,fNodeTmp.PY)

--                fNode.F  = fNodeTmp.F;
--                fNode.G  = fNodeTmp.G;
--                fNode.H  = 0;
--                fNode.PX = fNodeTmp.PX;
--                fNode.PY = fNodeTmp.PY;
--                fNode.X  = posX;
--                fNode.Y  = posY;
                
--                print("fNode X,Y",fNode.X,fNode.Y)
--                print("test : ", this._Close:get(this._Close:size()-1).X,this._Close:get(this._Close:size()-1).Y)
            end
            
            this._Close:pushBack(fNode);
            
            --print("fNode",fNode)

            this._Stopped = true;
            return this._Close;
        end

        this._Stopped = true;
        return nil;
    end

    return this
end



function test_pathFinding()
    --Laputan.messageBox(Laputan.LOG_NORMAL,"test stop")

    local timer = makeHighResolutionTimer()
    timer:startTime()
    local grid = makeZeroBaseArray2D(1024,1024,1)
     
    grid:set(0,4, 0)
    grid:set(1,2, 0)
    grid:set(1,4, 0)
    grid:set(2,1, 0)
    grid:set(2,2, 0)
    grid:set(2,3, 0)
    grid:set(2,4, 0)
    grid:set(3,1, 0)
    grid:set(3,3, 0)
    grid:set(4,1, 0)
    grid:set(4,3, 0)
    
    local map = initPathFindingQuadMap(grid)
    print("test time ", timer:getTime())

    local list = map:findPath(0,0,4,4)
    print("this._Found",map._Found)
    print("complete time",map._CompletedTime)
    for i=0, list:size()-1 do
       print("close list : ",list:get(i).X,list:get(i).Y)

    end
    

    test_serializeTable()
end


