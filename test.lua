-- cocos贝塞尔曲线拟合四分之一圆
-- float halfRadx = CC_DEGREES_TO_RADIANS(_rotationX / 2.f), 
-- halfRady = CC_DEGREES_TO_RADIANS(_rotationY / 2.f), 
-- halfRadz = _rotationZ_X == _rotationZ_Y ? -CC_DEGREES_TO_RADIANS(_rotationZ_X / 2.f) : 0;
-- float coshalfRadx = cosf(halfRadx), 
-- sinhalfRadx = sinf(halfRadx), 
-- coshalfRady = cosf(halfRady), 
-- sinhalfRady = sinf(halfRady), 
-- coshalfRadz = cosf(halfRadz), 
-- sinhalfRadz = sinf(halfRadz);
-- _rotationQuat.x = sinhalfRadx * coshalfRady * coshalfRadz - coshalfRadx * sinhalfRady * sinhalfRadz;
-- _rotationQuat.y = coshalfRadx * sinhalfRady * coshalfRadz + sinhalfRadx * coshalfRady * sinhalfRadz;
-- _rotationQuat.z = coshalfRadx * coshalfRady * sinhalfRadz - sinhalfRadx * sinhalfRady * coshalfRadz;
-- _rotationQuat.w = coshalfRadx * coshalfRady * coshalfRadz + sinhalfRadx * sinhalfRady * sinhalfRadz;

-- -- 简单测试试验
-- local value = {"yoyo", yoyo = "yoyou"}
-- print(string.sub("123456", 1))
-- print("----")


-- -- 元表和元方法的简单创建
-- Set = {}  -- 一个空的table
-- local metatable = {}

-- function Set.new(params)
--     local set = {}
--     setmetatable(set, metatable)
--     if params then
--     for _,v in pairs(params) do
--         set[v] = true
--     end
-- end
--     return set
-- end

-- -- 取两个集合并集的函数
-- function Set.union( a,b )
--     local res = Set.new({}) -- 结果
    
--     for k,v in pairs(a) do
--         res[k] = true
--     end

--     for k,v in pairs(b) do
--         res[k] = true
--     end

--     return res
-- end

-- -- 取交集函数
-- function Set.intersection(a,b)
--     local res = Set.new()

--     for k,v in pairs(a) do
--         res[k] = b[k]
--     end

--     return res
-- end

-- function Set.tostring( set )
--     local l = {}

--     for k,v in pairs(set) do
--         l[#l + 1] = k
--     end

--     return "{" .. table.concat( l, ", ") .. "}"
-- end

-- function Set.print( s )
--     print(Set.tostring( s ))
-- end

-- metatable.__add = Set.union
-- metatable.__mul = Set.intersection

-- s1 = Set.new({10, 11, 12, 15})
-- s2 = Set.new({1, 2, 20, 10, 11})
-- Set.print(s1)
-- Set.print(s2)
-- s3 = s1 + s2
-- Set.print(s3)
-- Set.print(s1 * s2)


-- -- 给table新建字段设置默认值
-- function setDefault(table,default)
--     local mt = {__index = function() return default end }
--     setmetatable(table,mt)
-- end
-- tab = {x = 10, y = 20}
-- print(tab.x,tab.z)  --10    nil
-- setDefault(tab,0)
-- print(tab.x,tab.z)  --10    0

-- print(tab.x,rawget(tab,tab.z))  --10    0
-- print(tab.x,tab.a)  --10    0
-- print(tab.x,tab.b)  --10    0
-- function length( tab )
--     local i = 0
--     for k,v in pairs(tab) do
--         i = i + 1
--     end
--     return i
-- end
-- print("length ===", length(tab))

-- -- 只读table的创建
-- function readOnly( t )
--     local result = {}

--     local mt = {
--         __index = t,
--         __newindex = function ( t,k,v )
--             error("readOnly")
--         end
--     }
--     setmetatable(result, mt)

--     return result
-- end

-- local tab = readOnly{"1", "2", "3"}
-- print(tab[1])
-- tab[1] = 4

-- 类的简单实现
local Person = {}
Person.__index = Person
function Person:create( name )
    local p = {}
    p.name = name
    setmetatable(p, Person)
    return p
end

function Person:say(s)
    print(self.name .. "：" .. s)
end

local p = Person:create("张三")
p:say("哈哈哈哈")

-- 类继承的简单实现
local Student = {}
Student.__index = Student
setmetatable(Student, Person)
function Student:create( name )
    local s = {}
    s.name = name
    setmetatable(s, Student)
    return s
end
function Student:showName( )
    print(self.name)
end
local s = Student:create("李四")
s:showName()
s:say("哈哈哈哈")

-- 总结一下实现class函数
function class(className, baseCls)
    local cls = {__clsname = className}
    cls.__index = cls
    if baseCls and (type(baseCls) == "function" or type(baseCls) == "table")then
        setmetatable(cls, baseCls)
    end
    function cls:create(params)
        local res = {}
        setmetatable(res,cls)
        if cls.ctor then
            cls.ctor(self, params)
        else
            error("ctor function not found")
        end
        return res
    end
    return cls
end
local Teacher = class("teacher", Person)
function Teacher:ctor( params )
    self.name = params.name
end
function Teacher:talk( s )
    print(self.name .. ":" .. s)
end
local t = Teacher:create({name = "王五"})
t:talk("哈哈哈哈哈哈哈") -- 自己的方法
t:say("哈哈哈哈哈") -- 继承父类的方法