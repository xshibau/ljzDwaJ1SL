local a=2^32;local b=a-1;local function c(d,e)local f,g=0,1;while d~=0 or e~=0 do local h,i=d%2,e%2;local j=(h+i)%2;f=f+j*g;d=math.floor(d/2)e=math.floor(e/2)g=g*2 end;return f%a end;local function k(d,e,l,...)local m;if e then d=d%a;e=e%a;m=c(d,e)if l then m=k(m,l,...)end;return m elseif d then return d%a else return 0 end end;local function n(d,e,l,...)local m;if e then d=d%a;e=e%a;m=(d+e-c(d,e))/2;if l then m=n(m,l,...)end;return m elseif d then return d%a else return b end end;local function o(p)return b-p end;local function q(d,r)if r<0 then return lshift(d,-r)end;return math.floor(d%2^32/2^r)end;local function s(p,r)if r>31 or r<-31 then return 0 end;return q(p%a,r)end;local function lshift(d,r)if r<0 then return s(d,-r)end;return d*2^r%2^32 end;local function t(p,r)p=p%a;r=r%32;local u=n(p,2^r-1)return s(p,r)+lshift(u,32-r)end;local v={0x428a2f98,0x71374491,0xb5c0fbcf,0xe9b5dba5,0x3956c25b,0x59f111f1,0x923f82a4,0xab1c5ed5,0xd807aa98,0x12835b01,0x243185be,0x550c7dc3,0x72be5d74,0x80deb1fe,0x9bdc06a7,0xc19bf174,0xe49b69c1,0xefbe4786,0x0fc19dc6,0x240ca1cc,0x2de92c6f,0x4a7484aa,0x5cb0a9dc,0x76f988da,0x983e5152,0xa831c66d,0xb00327c8,0xbf597fc7,0xc6e00bf3,0xd5a79147,0x06ca6351,0x14292967,0x27b70a85,0x2e1b2138,0x4d2c6dfc,0x53380d13,0x650a7354,0x766a0abb,0x81c2c92e,0x92722c85,0xa2bfe8a1,0xa81a664b,0xc24b8b70,0xc76c51a3,0xd192e819,0xd6990624,0xf40e3585,0x106aa070,0x19a4c116,0x1e376c08,0x2748774c,0x34b0bcb5,0x391c0cb3,0x4ed8aa4a,0x5b9cca4f,0x682e6ff3,0x748f82ee,0x78a5636f,0x84c87814,0x8cc70208,0x90befffa,0xa4506ceb,0xbef9a3f7,0xc67178f2}local function w(x)return string.gsub(x,".",function(l)return string.format("%02x",string.byte(l))end)end;local function y(z,A)local x=""for B=1,A do local C=z%256;x=string.char(C)..x;z=(z-C)/256 end;return x end;local function D(x,B)local A=0;for B=B,B+3 do A=A*256+string.byte(x,B)end;return A end;local function E(F,G)local H=64-(G+9)%64;G=y(8*G,8)F=F.."\128"..string.rep("\0",H)..G;assert(#F%64==0)return F end;local function I(J)J[1]=0x6a09e667;J[2]=0xbb67ae85;J[3]=0x3c6ef372;J[4]=0xa54ff53a;J[5]=0x510e527f;J[6]=0x9b05688c;J[7]=0x1f83d9ab;J[8]=0x5be0cd19;return J end;local function K(F,B,J)local L={}for M=1,16 do L[M]=D(F,B+(M-1)*4)end;for M=17,64 do local N=L[M-15]local O=k(t(N,7),t(N,18),s(N,3))N=L[M-2]L[M]=(L[M-16]+O+L[M-7]+k(t(N,17),t(N,19),s(N,10)))%a end;local d,e,l,P,Q,R,S,T=J[1],J[2],J[3],J[4],J[5],J[6],J[7],J[8]for B=1,64 do local O=k(t(d,2),t(d,13),t(d,22))local U=k(n(d,e),n(d,l),n(e,l))local V=(O+U)%a;local W=k(t(Q,6),t(Q,11),t(Q,25))local X=k(n(Q,R),n(o(Q),S))local Y=(T+W+X+v[B]+L[B])%a;T=S;S=R;R=Q;Q=(P+Y)%a;P=l;l=e;e=d;d=(Y+V)%a end;J[1]=(J[1]+d)%a;J[2]=(J[2]+e)%a;J[3]=(J[3]+l)%a;J[4]=(J[4]+P)%a;J[5]=(J[5]+Q)%a;J[6]=(J[6]+R)%a;J[7]=(J[7]+S)%a;J[8]=(J[8]+T)%a end;local function Z(F)F=E(F,#F)local J=I({})for B=1,#F,64 do K(F,B,J)end;return w(y(J[1],4)..y(J[2],4)..y(J[3],4)..y(J[4],4)..y(J[5],4)..y(J[6],4)..y(J[7],4)..y(J[8],4))end;local e;local l={["\\"]="\\",["\""]="\"",["\b"]="b",["\f"]="f",["\n"]="n",["\r"]="r",["\t"]="t"}local P={["/"]="/"}for Q,R in pairs(l)do P[R]=Q end;local S=function(T)return"\\"..(l[T]or string.format("u%04x",T:byte()))end;local B=function(M)return"null"end;local v=function(M,z)local _={}z=z or{}if z[M]then error("circular reference")end;z[M]=true;if rawget(M,1)~=nil or next(M)==nil then local A=0;for Q in pairs(M)do if type(Q)~="number"then error("invalid table: mixed or invalid key types")end;A=A+1 end;if A~=#M then error("invalid table: sparse array")end;for a0,R in ipairs(M)do table.insert(_,e(R,z))end;z[M]=nil;return"["..table.concat(_,",").."]"else for Q,R in pairs(M)do if type(Q)~="string"then error("invalid table: mixed or invalid key types")end;table.insert(_,e(Q,z)..":"..e(R,z))end;z[M]=nil;return"{"..table.concat(_,",").."}"end end;local g=function(M)return'"'..M:gsub('[%z\1-\31\\"]',S)..'"'end;local a1=function(M)if M~=M or M<=-math.huge or M>=math.huge then error("unexpected number value '"..tostring(M).."'")end;return string.format("%.14g",M)end;local j={["nil"]=B,["table"]=v,["string"]=g,["number"]=a1,["boolean"]=tostring}e=function(M,z)local x=type(M)local a2=j[x]if a2 then return a2(M,z)end;error("unexpected type '"..x.."'")end;local a3=function(M)return e(M)end;local a4;local N=function(...)local _={}for a0=1,select("#",...)do _[select(a0,...)]=true end;return _ end;local L=N(" ","\t","\r","\n")local p=N(" ","\t","\r","\n","]","}",",")local a5=N("\\","/",'"',"b","f","n","r","t","u")local m=N("true","false","null")local a6={["true"]=true,["false"]=false,["null"]=nil}local a7=function(a8,a9,aa,ab)for a0=a9,#a8 do if aa[a8:sub(a0,a0)]~=ab then return a0 end end;return#a8+1 end;local ac=function(a8,a9,J)local ad=1;local ae=1;for a0=1,a9-1 do ae=ae+1;if a8:sub(a0,a0)=="\n"then ad=ad+1;ae=1 end end;error(string.format("%s at line %d col %d",J,ad,ae))end;local af=function(A)local a2=math.floor;if A<=0x7f then return string.char(A)elseif A<=0x7ff then return string.char(a2(A/64)+192,A%64+128)elseif A<=0xffff then return string.char(a2(A/4096)+224,a2(A%4096/64)+128,A%64+128)elseif A<=0x10ffff then return string.char(a2(A/262144)+240,a2(A%262144/4096)+128,a2(A%4096/64)+128,A%64+128)end;error(string.format("invalid unicode codepoint '%x'",A))end;local ag=function(ah)local ai=tonumber(ah:sub(1,4),16)local aj=tonumber(ah:sub(7,10),16)if aj then return af((ai-0xd800)*0x400+aj-0xdc00+0x10000)else return af(ai)end end;local ak=function(a8,a0)local _=""local al=a0+1;local Q=al;while al<=#a8 do local am=a8:byte(al)if am<32 then ac(a8,al,"control character in string")elseif am==92 then _=_..a8:sub(Q,al-1)al=al+1;local T=a8:sub(al,al)if T=="u"then local an=a8:match("^[dD][89aAbB]%x%x\\u%x%x%x%x",al+1)or a8:match("^%x%x%x%x",al+1)or ac(a8,al-1,"invalid unicode escape in string")_=_..ag(an)al=al+#an else if not a5[T]then ac(a8,al-1,"invalid escape char '"..T.."' in string")end;_=_..P[T]end;Q=al+1 elseif am==34 then _=_..a8:sub(Q,al-1)return _,al+1 end;al=al+1 end;ac(a8,a0,"expected closing quote for string")end;local ao=function(a8,a0)local am=a7(a8,a0,p)local ah=a8:sub(a0,am-1)local A=tonumber(ah)if not A then ac(a8,a0,"invalid number '"..ah.."'")end;return A,am end;local ap=function(a8,a0)local am=a7(a8,a0,p)local aq=a8:sub(a0,am-1)if not m[aq]then ac(a8,a0,"invalid literal '"..aq.."'")end;return a6[aq],am end;local ar=function(a8,a0)local _={}local A=1;a0=a0+1;while 1 do local am;a0=a7(a8,a0,L,true)if a8:sub(a0,a0)=="]"then a0=a0+1;break end;am,a0=a4(a8,a0)_[A]=am;A=A+1;a0=a7(a8,a0,L,true)local as=a8:sub(a0,a0)a0=a0+1;if as=="]"then break end;if as~=","then ac(a8,a0,"expected ']' or ','")end end;return _,a0 end;local at=function(a8,a0)local _={}a0=a0+1;while 1 do local au,M;a0=a7(a8,a0,L,true)if a8:sub(a0,a0)=="}"then a0=a0+1;break end;if a8:sub(a0,a0)~='"'then ac(a8,a0,"expected string for key")end;au,a0=a4(a8,a0)a0=a7(a8,a0,L,true)if a8:sub(a0,a0)~=":"then ac(a8,a0,"expected ':' after key")end;a0=a7(a8,a0+1,L,true)M,a0=a4(a8,a0)_[au]=M;a0=a7(a8,a0,L,true)local as=a8:sub(a0,a0)a0=a0+1;if as=="}"then break end;if as~=","then ac(a8,a0,"expected '}' or ','")end end;return _,a0 end;local av={['"']=ak,["0"]=ao,["1"]=ao,["2"]=ao,["3"]=ao,["4"]=ao,["5"]=ao,["6"]=ao,["7"]=ao,["8"]=ao,["9"]=ao,["-"]=ao,["t"]=ap,["f"]=ap,["n"]=ap,["["]=ar,["{"]=at}a4=function(a8,a9)local as=a8:sub(a9,a9)local a2=av[as]if a2 then return a2(a8,a9)end;ac(a8,a9,"unexpected character '"..as.."'")end;local aw=function(a8)if type(a8)~="string"then error("expected argument of type string, got "..type(a8))end;local _,a9=a4(a8,a7(a8,1,L,true))a9=a7(a8,a9,L,true)if a9<=#a8 then ac(a8,a9,"trailing garbage")end;return _ end;
local lEncode, lDecode, lDigest = a3, aw, Z;
local service = 7503;  -- your service id, this is used to identify your service.
local secret = "ec9c20a6-fea9-4dea-b78f-2dadea323fb2";  -- make sure to obfuscate this if you want to ensure security.
local useNonce = true;  -- use a nonce to prevent replay attacks and request tampering.
local onMessage = function(message) end;
repeat task.wait(1) until game:IsLoaded();

--! functions
local requestSending = false;
local fSetClipboard, fRequest, fStringChar, fToString, fStringSub, fOsTime, fMathRandom, fMathFloor, fGetHwid = setclipboard or toclipboard, request or http_request or syn_request, string.char, tostring, string.sub, os.time, math.random, math.floor, gethwid or function() return game:GetService("Players").LocalPlayer.UserId end
local cachedLink, cachedTime = "", 0;

--! pick host
local host = "https://api.platoboost.com";
local hostResponse = fRequest({
    Url = host .. "/public/connectivity",
    Method = "GET"
});
if hostResponse.StatusCode ~= 200 or hostResponse.StatusCode ~= 429 then
    host = "https://api.platoboost.net";
end

--!optimize 2
function cacheLink()
    if cachedTime + (10*60) < fOsTime() then
        local response = fRequest({
            Url = host .. "/public/start",
            Method = "POST",
            Body = lEncode({
                service = service,
                identifier = lDigest(fGetHwid())
            }),
            Headers = {
                ["Content-Type"] = "application/json"
            }
        });

        if response.StatusCode == 200 then
            local decoded = lDecode(response.Body);

            if decoded.success == true then
                cachedLink = decoded.data.url;
                cachedTime = fOsTime();
                return true, cachedLink;
            else
                onMessage(decoded.message);
                return false, decoded.message;
            end
        elseif response.StatusCode == 429 then
            local msg = "you are being rate limited, please wait 20 seconds and try again.";
            onMessage(msg);
            return false, msg;
        end

        local msg = "Failed to cache link.";
        onMessage(msg);
        return false, msg;
    else
        return true, cachedLink;
    end
end

cacheLink();

--!optimize 2
local generateNonce = function()
    local str = ""
    for _ = 1, 16 do
        str = str .. fStringChar(fMathFloor(fMathRandom() * (122 - 97 + 1)) + 97)
    end
    return str
end

--!optimize 1
for _ = 1, 5 do
    local oNonce = generateNonce();
    task.wait(0.2)
    if generateNonce() == oNonce then
        local msg = "platoboost nonce error.";
        onMessage(msg);
        error(msg);
    end
end

--!optimize 2
local copyLink = function()
    local success, link = cacheLink();
    
    if success then
        fSetClipboard(link);
    end
end

--!optimize 2
local redeemKey = function(key)
    local nonce = generateNonce();
    local endpoint = host .. "/public/redeem/" .. fToString(service);

    local body = {
        identifier = lDigest(fGetHwid()),
        key = key
    }

    if useNonce then
        body.nonce = nonce;
    end

    local response = fRequest({
        Url = endpoint,
        Method = "POST",
        Body = lEncode(body),
        Headers = {
            ["Content-Type"] = "application/json"
        }
    });

    if response.StatusCode == 200 then
        local decoded = lDecode(response.Body);

        if decoded.success == true then
            if decoded.data.valid == true then
                if useNonce then
                    if decoded.data.hash == lDigest("true" .. "-" .. nonce .. "-" .. secret) then
                        return true;
                    else
                        onMessage("failed to verify integrity.");
                        return false;
                    end    
                else
                    return true;
                end
            else
                onMessage("key is invalid.");
                return false;
            end
        else
            if fStringSub(decoded.message, 1, 27) == "unique constraint violation" then
                onMessage("you already have an active key, please wait for it to expire before redeeming it.");
                return false;
            else
                onMessage(decoded.message);
                return false;
            end
        end
    elseif response.StatusCode == 429 then
        onMessage("you are being rate limited, please wait 20 seconds and try again.");
        return false;
    else
        onMessage("server returned an invalid status code, please try again later.");
        return false; 
    end
end

--!optimize 2
local verifyKey = function(key)
    if requestSending == true then
        onMessage("a request is already being sent, please slow down.");
        return false;
    else
        requestSending = true;
    end

    local nonce = generateNonce();
    local endpoint = host .. "/public/whitelist/" .. fToString(service) .. "?identifier=" .. lDigest(fGetHwid()) .. "&key=" .. key;

    if useNonce then
        endpoint = endpoint .. "&nonce=" .. nonce;
    end

    local response = fRequest({
        Url = endpoint,
        Method = "GET",
    });

    requestSending = false;

    if response.StatusCode == 200 then
        local decoded = lDecode(response.Body);

        if decoded.success == true then
            if decoded.data.valid == true then
                if useNonce then
                    if decoded.data.hash == lDigest("true" .. "-" .. nonce .. "-" .. secret) then
                        return true;
                    else
                        onMessage("failed to verify integrity.");
                        return false;
                    end
                else
                    return true;
                end
            else
                if fStringSub(key, 1, 4) == "KEY_" then
                    return redeemKey(key);
                else
                    onMessage("key is invalid.");
                    return false;
                end
            end
        else
            onMessage(decoded.message);
            return false;
        end
    elseif response.StatusCode == 429 then
        onMessage("you are being rate limited, please wait 20 seconds and try again.");
        return false;
    else
        onMessage("server returned an invalid status code, please try again later.");
        return false;
    end
end

--!optimize 2
local getFlag = function(name)
    local nonce = generateNonce();
    local endpoint = host .. "/public/flag/" .. fToString(service) .. "?name=" .. name;

    if useNonce then
        endpoint = endpoint .. "&nonce=" .. nonce;
    end

    local response = fRequest({
        Url = endpoint,
        Method = "GET",
    });

    if response.StatusCode == 200 then
        local decoded = lDecode(response.Body);

        if decoded.success == true then
            if useNonce then
                if decoded.data.hash == lDigest(fToString(decoded.data.value) .. "-" .. nonce .. "-" .. secret) then
                    return decoded.data.value;
                else
                    onMessage("failed to verify integrity.");
                    return nil;
                end
            else
                return decoded.data.value;
            end
        else
            onMessage(decoded.message);
            return nil;
        end
    else
        return nil;
    end
end
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
--! platoboost usage documentation
-- copyLink() -> string
-- verifyKey(key: string) -> boolean
-- getFlag(name: string) -> boolean, string | boolean | number

-- use copyLink() to copy a link to the clipboard, in which the user will paste it into their browser and complete the keysystem.
-- use verifyKey(key) to verify a key, this will return a boolean value, true means the key was valid, false means it is invalid.
-- use getFlag(name) to get a flag from the server, this will return nil if an error occurs, if no error occurs, the value configured in the platoboost dashboard will be returned.

-- IMPORTANT: onMessage is a callback, it will be called upon status update, use it to provide information to user.
-- EXAMPLE: 
--[[
onMessage = function(message)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Platoboost status",
        Text = message
    })
end
]]--

-- NOTE: PLACE THIS ENTIRE SCRIPT AT THE TOP OF YOUR SCRIPT, ADD THE LOGIC, THEN OBFUSCATE YOUR SCRIPT.

--! example usage
--[[
copyButton.MouseButton1Click:Connect(function()
    copyLink();
end)

verifyButton.MouseButton1Click:Connect(function()
    local key = keyBox.Text;
    local success = verifyKey(key);

    if success then
        print("key is valid.");
    else
        print("key is invalid.");
    end
end)

local flag = getFlag("example_flag");
if flag ~= nil then
    print("flag value: " .. flag);
else
    print("failed to get flag.");
end
]]--
-------------------------------------------------------------------------------

local KeySystem = loadstring(game:HttpGet("https://raw.githubusercontent.com/OopssSorry/LuaU-Free-Key-System-UI/main/source.lua"))()
local KeyValid = false
local response = KeySystem:Init({
	Debug=false,
	Title="Aura Hub | Key System",
	Description=nil,
	Link=copyLink(),
	Discord="test",
	SaveKey=false,
	Verify=function(key)
		local success = redeemKey(key)
        if success then
        game.StarterGui:SetCore("SendNotification", {
                Title = "Aura Hub",
                Text = "Key Redeemed Successfully",
                Duration = 5
            })
		else
			game.StarterGui:SetCore("SendNotification", {
                Title = "Aura Hub",
                Text = "Invalid Key",
                Duration = 5
            })
		end
	end,
	GuiParent = game.CoreGui,
})

if not response or not success then return end
game.StarterGui:SetCore("SendNotification", {
    Title = "Aura Hub",
    Text = "Success Loading",
    Icon = "rbxthumb://type=Asset&id=131484641795167&w=420&h=420",
    Duration = 5,
    Callback = function()
    end
})
game.StarterGui:SetCore("SendNotification", {
    Title = "Aura Hub",
    Text = "Keybind: RightShift",
    Icon = "rbxthumb://type=Asset&id=131484641795167&w=420&h=420",
    Duration = 5,
    Callback = function()
    end
})
repeat wait() until game:IsLoaded() and game.Players.LocalPlayer
getgenv().Image = "rbxthumb://type=Asset&id=106019376492019&w=420&h=420"
getgenv().ToggleUI = "LeftControl"

task.spawn(function()
    if not getgenv().LoadedMobileUI then
        getgenv().LoadedMobileUI = true
        local OpenUI = Instance.new("ScreenGui")
        local ImageButton = Instance.new("ImageButton")
        local UICorner = Instance.new("UICorner")
        OpenUI.Name = "OpenUI"
        OpenUI.Parent = game:GetService("CoreGui")
        OpenUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        ImageButton.Parent = OpenUI
        ImageButton.BackgroundColor3 = Color3.fromRGB(105, 105, 105)
        ImageButton.BackgroundTransparency = 0.8
        ImageButton.Position = UDim2.new(0, 20, 0, 25)
        ImageButton.Size = UDim2.new(0, 50, 0, 50)
        ImageButton.Image = getgenv().Image
        ImageButton.Draggable = true
        ImageButton.Transparency = 1
        UICorner.CornerRadius = UDim.new(0,13)
        UICorner.Parent = ImageButton
        ImageButton.MouseButton1Click:Connect(function()
            game:GetService("VirtualInputManager"):SendKeyEvent(true, getgenv().ToggleUI, false, game)
        end)
    end
end)
local Library = loadstring(game:HttpGetAsync("https://github.com/ActualMasterOogway/Fluent-Renewed/releases/latest/download/Fluent.luau"))()
local SaveManager = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/ActualMasterOogway/Fluent-Renewed/master/Addons/SaveManager.luau"))()
local InterfaceManager = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/ActualMasterOogway/Fluent-Renewed/master/Addons/InterfaceManager.luau"))()
 
local Window = Library:CreateWindow{
    Title = `Aura Hub | {Library.Version}`,
    SubTitle = "by Ziugpro",
    TabWidth = 130,
    Size = UDim2.fromOffset(505, 350),
    Acrylic = true, 
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
}

local Tabs = {
    Esp = Window:CreateTab{
        Title = "Esp",
        Icon = "map-pin"
    },
    Main = Window:CreateTab{
        Title = "Main",
        Icon = "phosphor-users-bold"
    },
    Visual = Window:CreateTab{
        Title = "Visuals",
        Icon = "file"
    },
    Settings = Window:CreateTab{
        Title = "Settings",
        Icon = "settings"
    }
}
local Options = Library.Options
local Main = Tabs.Main:AddSection("Tree")
local AutoTree = Tabs.Main:CreateToggle("AutoTree", {Title = "Auto Cut Tree", Default = false })
AutoTree:OnChanged(function()
_G.AutoChopTP = v
        if v then
            local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
            local originalPos = hrp and hrp.CFrame
            while _G.AutoChopTP do
                task.wait(0.3)
                local trees = {}
                for _, tree in pairs(workspace:GetDescendants()) do
                    if tree:IsA("Model") and tree.Name == "Small Tree" and tree.PrimaryPart then
                        table.insert(trees, tree)
                    end
                end
                for _, tree in ipairs(trees) do
                    if not _G.AutoChopTP then break end
                    if hrp and tree.PrimaryPart then
                        hrp.CFrame = tree.PrimaryPart.CFrame + Vector3.new(0,0,-3)
                        UIS.InputBegan:Fire({UserInputType=Enum.UserInputType.MouseButton1, Position=tree.PrimaryPart.Position}, false)
                        task.wait(0.1)
                        UIS.InputEnded:Fire({UserInputType=Enum.UserInputType.MouseButton1, Position=tree.PrimaryPart.Position}, false)
                        task.wait(0.5)
                    end
                end
            end
            if hrp and originalPos then
                hrp.CFrame = originalPos
            end
        else
            _G.AutoChopTP = false
    end
end)
Options.AutoTree:SetValue(false)
local Main = Tabs.Main:AddSection("Chest")

local AutoOpenChestNearToggle = Tabs.Main:CreateToggle("AutoChestNearby", {Title = "Auto Open Chest", Default = false })

AutoOpenChestNearToggle:OnChanged(function(value)
    local Players = game:GetService("Players")
    local player = Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

    if not _G.AutoChestNearby then
        _G.AutoChestNearby = {running = false}
    end

    local function getPromptsInRange(range)
        local prompts = {}
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("Model") and string.find(obj.Name, "Item Chest") then
                local part = obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")
                if part then
                    local dist = (humanoidRootPart.Position - part.Position).Magnitude
                    if dist <= range then
                        for _, p in ipairs(obj:GetDescendants()) do
                            if p:IsA("ProximityPrompt") then
                                table.insert(prompts, p)
                            end
                        end
                    end
                end
            end
        end
        return prompts
    end

    if value then
        if _G.AutoChestNearby.running then return end
        _G.AutoChestNearby.running = true
        task.spawn(function()
            while _G.AutoChestNearby.running do
                local prompts = getPromptsInRange(chestRange)
                for _, prompt in ipairs(prompts) do
                    fireproximityprompt(prompt, math.huge)
                end
                task.wait(0.5)
            end
        end)
    else
        _G.AutoChestNearby.running = false
    end
end)

Options.AutoChestNearby:SetValue(false)

local Main = Tabs.Main:AddSection("Cooked")
local AutoCookedTeleportToggle = Tabs.Main:CreateToggle("AutoMorsel", {Title = "Auto Cooked (Teleport)", Default = false })

AutoCookedTeleportToggle:OnChanged(function(value)
    if value then
        _G.AutoMorsel = true
        local hrp = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        local originalPos = hrp and hrp.CFrame
        task.spawn(function()
            while _G.AutoMorsel do
                task.wait()
                for _, m in pairs(workspace:GetDescendants()) do
                    if not _G.AutoMorsel then break end
                    if m:IsA("Model") and m.Name == "Morsel" and m.PrimaryPart then
                        if hrp then
                            hrp.CFrame = m.PrimaryPart.CFrame
                            m:SetPrimaryPartCFrame(CFrame.new(0.5406733155250549, 12.499372482299805, -0.718663215637207))
                            task.wait(0.2)
                        end
                    end
                end
            end
            if hrp and originalPos then
                hrp.CFrame = originalPos
            end
        end)
    else
        _G.AutoMorsel = false
    end
end)

Options.AutoMorsel:SetValue(false)

local AutoCookedBringToggle = Tabs.Main:CreateToggle("BringMorsels", {Title = "Auto Cooked (Bring)", Default = false })

AutoCookedBringToggle:OnChanged(function(value)
    if value then
        _G.BringMorsels = true
        task.spawn(function()
            while _G.BringMorsels do
                task.wait()
                for _, m in pairs(workspace:GetDescendants()) do
                    if not _G.BringMorsels then break end
                    if m:IsA("Model") and m.Name == "Morsel" and m.PrimaryPart then
                        m:SetPrimaryPartCFrame(CFrame.new(-0.5468149185180664, 7.632332801818848, 0.11174965649843216))
                        task.wait(0.2)
                    end
                end
            end
        end)
    else
        _G.BringMorsels = false
    end
end)

Options.BringMorsels:SetValue(false)

local Main = Tabs.Main:AddSection("Camp")
local AutoFireTeleportLogToggle = Tabs.Main:CreateToggle("AutoLog", {Title = "Auto Fire (Teleport)", Default = false })

AutoFireTeleportLogToggle:OnChanged(function(value)
    if value then
        _G.AutoLog = true
        local hrp = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        local originalPos = hrp and hrp.CFrame
        task.spawn(function()
            while _G.AutoLog do
                task.wait()
                for _, m in pairs(workspace:GetDescendants()) do
                    if not _G.AutoLog then break end
                    if m:IsA("Model") and m.Name == "Log" and m.PrimaryPart then
                        if hrp then
                            hrp.CFrame = m.PrimaryPart.CFrame
                            m:SetPrimaryPartCFrame(CFrame.new(0.5406733155250549, 12.499372482299805, -0.718663215637207))
                            task.wait(0.2)
                        end
                    end
                end
            end
            if hrp and originalPos then
                hrp.CFrame = originalPos
            end
        end)
    else
        _G.AutoLog = false
    end
end)

Options.AutoLog:SetValue(false)
local AutoFireTeleportCoalToggle = Tabs.Main:CreateToggle("AutoCoal", {Title = "Auto Fire (Teleport - Coal)", Default = false })

AutoFireTeleportCoalToggle:OnChanged(function(value)
    if value then
        _G.AutoCoal = true
        local player = game.Players.LocalPlayer
        local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
        local originalPos = hrp and hrp.CFrame
        task.spawn(function()
            while _G.AutoCoal do
                task.wait()
                for _, m in pairs(workspace:GetDescendants()) do
                    if not _G.AutoCoal then break end
                    if m:IsA("Model") and m.Name == "Coal" and m.PrimaryPart then
                        if hrp then
                            hrp.CFrame = m.PrimaryPart.CFrame
                            m:SetPrimaryPartCFrame(CFrame.new(0.5406733155250549, 12.499372482299805, -0.718663215637207))
                            task.wait(0.2)
                        end
                    end
                end
            end
            if hrp and originalPos then
                hrp.CFrame = originalPos
            end
        end)
    else
        _G.AutoCoal = false
    end
end)

Options.AutoCoal:SetValue(false)
local AutoFireBringToggle = Tabs.Main:CreateToggle("BringLogs", {Title = "Auto Fire (Bring)", Default = false })

AutoFireBringToggle:OnChanged(function(value)
    if value then
        _G.BringLogs = true
        task.spawn(function()
            while _G.BringLogs do
                task.wait()
                for _, m in pairs(workspace:GetDescendants()) do
                    if not _G.BringLogs then break end
                    if m:IsA("Model") and m.Name == "Log" and m.PrimaryPart then
                        m:SetPrimaryPartCFrame(CFrame.new(-0.5468149185180664, 7.632332801818848, 0.11174965649843216))
                        task.wait(0.2)
                    end
                end
            end
        end)
    else
        _G.BringLogs = false
    end
end)

Options.BringLogs:SetValue(false)

local Main = Tabs.Visual:AddSection("Fly Up")

local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local player = game.Players.LocalPlayer

local flyUpLoop = false
local flyUpNightLoop = false
local connAllTime
local connNightOnly

local FlyUpAllTimeToggle = Tabs.Visual:CreateToggle("FlyUpAllTime", {Title = "Fly Up (All Time)", Default = false })

FlyUpAllTimeToggle:OnChanged(function(value)
    local character = player.Character
    if not character then return end
    local hrp = character:FindFirstChild("HumanoidRootPart")
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if not hrp or not humanoid then return end

    flyUpLoop = value
    humanoid.PlatformStand = value

    if value then
        local ray = Ray.new(hrp.Position, Vector3.new(0, -1000, 0))
        local part, pos = workspace:FindPartOnRay(ray, hrp.Parent)
        local targetY = (part and pos.Y or hrp.Position.Y) + 30
        connAllTime = RunService.Heartbeat:Connect(function()
            if not flyUpLoop or not hrp.Parent then return end
            hrp.Velocity = Vector3.new(0, 0, 0)
            hrp.CFrame = CFrame.new(hrp.Position.X, targetY, hrp.Position.Z)
        end)
    else
        if connAllTime then connAllTime:Disconnect() end
    end
end)

Options.FlyUpAllTime:SetValue(false)

local FlyUpNightOnlyToggle = Tabs.Visual:CreateToggle("FlyUpNightOnly", {Title = "Fly Up (Night Only)", Default = false })

FlyUpNightOnlyToggle:OnChanged(function(value)
    local character = player.Character
    if not character then return end
    local hrp = character:FindFirstChild("HumanoidRootPart")
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if not hrp or not humanoid then return end

    flyUpNightLoop = value

    if value then
        local currentTime = Lighting.ClockTime
        if currentTime >= 18 or currentTime < 6 then
            humanoid.PlatformStand = true
            local ray = Ray.new(hrp.Position, Vector3.new(0, -1000, 0))
            local part, pos = workspace:FindPartOnRay(ray, hrp.Parent)
            local targetY = (part and pos.Y or hrp.Position.Y) + 30
            connNightOnly = RunService.Heartbeat:Connect(function()
                if not flyUpNightLoop or not hrp.Parent then return end
                local t = Lighting.ClockTime
                if t >= 18 or t < 6 then
                    hrp.Velocity = Vector3.new(0, 0, 0)
                    hrp.CFrame = CFrame.new(hrp.Position.X, targetY, hrp.Position.Z)
                end
            end)
        else
            FlyUpNightOnlyToggle:SetValue(false)
        end
    else
        if connNightOnly then connNightOnly:Disconnect() end
        humanoid.PlatformStand = false
    end
end)

Options.FlyUpNightOnly:SetValue(false)
local Main = Tabs.Visual:AddSection("Visual")

Tabs.Visual:CreateButton{
    Title = "Through Wall",
    Description = "",
    Callback = function()
        local Players = game:GetService("Players")
        local Workspace = game:GetService("Workspace")
        local RunService = game:GetService("RunService")

        local LocalPlayer = Players.LocalPlayer
        if not LocalPlayer then return end

        local Character = LocalPlayer.Character
        if not Character then
            Character = LocalPlayer.CharacterAdded:Wait()
        end

        local RootPart = Character:FindFirstChild("HumanoidRootPart")
        if not RootPart then return end

        local CurrentPosition = RootPart.Position
        local CurrentCFrame = RootPart.CFrame
        local FacingDirection = CurrentCFrame.LookVector

        local DashMagnitude = 30
        local DashOffset = Vector3.new(0, 1.25, 0)
        local DashVector = FacingDirection * DashMagnitude
        local Destination = CurrentPosition + DashVector + DashOffset

        local BodyPosition = Instance.new("BodyPosition")
        BodyPosition.MaxForce = Vector3.new(1e9, 1e9, 1e9)
        BodyPosition.P = 1e5
        BodyPosition.D = 2000
        BodyPosition.Position = Destination
        BodyPosition.Parent = RootPart

        local DashDuration = 0.2
        local Connection = nil
        local StartTime = tick()

        Connection = RunService.RenderStepped:Connect(function()
            if tick() - StartTime >= DashDuration then
                BodyPosition:Destroy()
                if Connection then
                    Connection:Disconnect()
                end
            end
        end)
    end
}

local InfinityJumpToggle = Tabs.Visual:CreateToggle("InfinityJump", {Title = "Infinity Jump", Default = false})

InfinityJumpToggle:OnChanged(function(value)
    if _G.infinityJumpConn then
        _G.infinityJumpConn:Disconnect()
        _G.infinityJumpConn = nil
    end

    if value then
        _G.infinityJumpConn = game:GetService("UserInputService").JumpRequest:Connect(function()
            local player = game.Players.LocalPlayer
            if player and player.Character then
                local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                end
            end
        end)
    end
end)

Options.InfinityJump:SetValue(false)
local Main = Tabs.Visual:AddSection("Speed")
local Speed = 50

local SpeedSlider = Tabs.Visual:CreateSlider("SpeedSlider", {
    Title = "Speed",
    Description = "",
    Default = 50,
    Min = 1,
    Max = 300,
    Rounding = 1,
    Callback = function(val)
        Speed = val
    end
})

local SetSpeedButton = Tabs.Visual:CreateButton{
    Title = "Set Speed",
    Description = "",
    Callback = function()
        local player = game.Players.LocalPlayer
        if not player or not player.Character then return end

        local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = Speed
        end
    end
}

local SpeedBoostToggle = Tabs.Visual:CreateToggle("SpeedBoost", {Title = "Speed Boost", Default = false})

SpeedBoostToggle:OnChanged(function(Value)
    _G.Speed100 = Value

    local player = game:GetService("Players").LocalPlayer
    if not player then return end

    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if not humanoid then return end

    if _G.Speed100 then
        humanoid.WalkSpeed = 100
    else
        humanoid.WalkSpeed = 16
    end
end)

Options.SpeedBoost:SetValue(false)

local ESP_Toggle = Tabs.Esp:CreateToggle("ESP_Toggle", {Title = "ESP Player", Default = false})

ESP_Toggle:OnChanged(function()
    if ESP_Toggle.Value then
        for i, player in pairs(game.Players:GetPlayers()) do
            if player ~= game.Players.LocalPlayer and player.Character then
                local head = player.Character:FindFirstChild("Head")
                local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
                if head and humanoid then
                    local billboard = Instance.new("BillboardGui")
                    billboard.Adornee = head
                    billboard.AlwaysOnTop = true
                    billboard.Size = UDim2.new(0,120,0,50)
                    billboard.MaxDistance = math.huge
                    billboard.StudsOffset = Vector3.new(0,2,0)
                    billboard.Parent = game.CoreGui

                    local frame = Instance.new("Frame")
                    frame.Size = UDim2.new(1,0,0,5)
                    frame.Position = UDim2.new(0,0,1,0)
                    frame.BackgroundColor3 = Color3.new(0,1,0)
                    frame.BorderSizePixel = 0
                    frame.Parent = billboard

                    local textLabel = Instance.new("TextLabel")
                    textLabel.Text = player.Name
                    textLabel.Size = UDim2.new(1,0,1,0)
                    textLabel.BackgroundTransparency = 1
                    textLabel.TextColor3 = Color3.new(1,0,0)
                    textLabel.TextScaled = true
                    textLabel.Parent = billboard

                    game:GetService("RunService").RenderStepped:Connect(function()
                        if humanoid.Health > 0 then
                            frame.Size = UDim2.new(humanoid.Health/humanoid.MaxHealth,0,0,5)
                        else
                            billboard:Destroy()
                        end
                    end)
                end
            end
        end
    else
        for _, gui in pairs(game.CoreGui:GetChildren()) do
            if gui:IsA("BillboardGui") then
                gui:Destroy()
            end
        end
    end
end)
Options.ESP_Toggle:SetValue(false)
local MobESP = Tabs.Esp:CreateToggle("MobESP", {Title = "ESP Mob", Default = false})

MobESP:OnChanged(function()
    if MobESP.Value then
        for i, mob in pairs(workspace:GetDescendants()) do
            if mob:IsA("Model") and mob:FindFirstChild("Humanoid") and mob:FindFirstChild("HumanoidRootPart") then
                local hrp = mob.HumanoidRootPart
                local humanoid = mob.Humanoid

                local billboard = Instance.new("BillboardGui")
                billboard.Adornee = hrp
                billboard.AlwaysOnTop = true
                billboard.Size = UDim2.new(0,120,0,50)
                billboard.MaxDistance = math.huge
                billboard.StudsOffset = Vector3.new(0,2,0)
                billboard.Parent = game.CoreGui

                local frame = Instance.new("Frame")
                frame.Size = UDim2.new(1,0,0,5)
                frame.Position = UDim2.new(0,0,1,0)
                frame.BackgroundColor3 = Color3.new(0,1,0)
                frame.BorderSizePixel = 0
                frame.Parent = billboard

                local textLabel = Instance.new("TextLabel")
                textLabel.Text = mob.Name
                textLabel.Size = UDim2.new(1,0,1,0)
                textLabel.BackgroundTransparency = 1
                textLabel.TextColor3 = Color3.new(1,0,0)
                textLabel.TextScaled = true
                textLabel.Parent = billboard

                game:GetService("RunService").RenderStepped:Connect(function()
                    if humanoid.Health > 0 then
                        frame.Size = UDim2.new(humanoid.Health/humanoid.MaxHealth,0,0,5)
                    else
                        billboard:Destroy()
                    end
                end)
            end
        end
    else
        for _, gui in pairs(game.CoreGui:GetChildren()) do
            if gui:IsA("BillboardGui") then
                gui:Destroy()
            end
        end
    end
end)
Options.MobESP:SetValue(false)
local LogESP = Tabs.Esp:CreateToggle("LogESP", {Title = "ESP Log", Default = false})
LogESP:OnChanged(function()
    if LogESP.Value then
        for i, model in pairs(workspace:GetDescendants()) do
            if model:IsA("Model") and model.Name == "Log" and model:FindFirstChild("Humanoid") and model:FindFirstChild("HumanoidRootPart") then
                local hrp = model.HumanoidRootPart
                local humanoid = model.Humanoid

                local billboard = Instance.new("BillboardGui")
                billboard.Adornee = hrp
                billboard.AlwaysOnTop = true
                billboard.Size = UDim2.new(0,120,0,50)
                billboard.MaxDistance = math.huge
                billboard.StudsOffset = Vector3.new(0,2,0)
                billboard.Parent = game.CoreGui

                local frame = Instance.new("Frame")
                frame.Size = UDim2.new(1,0,0,5)
                frame.Position = UDim2.new(0,0,1,0)
                frame.BackgroundColor3 = Color3.new(0,1,0)
                frame.BorderSizePixel = 0
                frame.Parent = billboard

                local textLabel = Instance.new("TextLabel")
                textLabel.Text = model.Name
                textLabel.Size = UDim2.new(1,0,1,0)
                textLabel.BackgroundTransparency = 1
                textLabel.TextColor3 = Color3.new(1,0,0)
                textLabel.TextScaled = true
                textLabel.Parent = billboard

                game:GetService("RunService").RenderStepped:Connect(function()
                    if humanoid.Health > 0 then
                        frame.Size = UDim2.new(humanoid.Health/humanoid.MaxHealth,0,0,5)
                    else
                        billboard:Destroy()
                    end
                end)
            end
        end
    else
        for _, gui in pairs(game.CoreGui:GetChildren()) do
            if gui:IsA("BillboardGui") then
                gui:Destroy()
            end
        end
    end
end)

Options.LogESP:SetValue(false)
local BoltESP = Tabs.Esp:CreateToggle("BoltESP", {Title = "ESP Bolt", Default = false})
BoltESP:OnChanged(function()
    if BoltESP.Value then
        for i, model in pairs(workspace:GetDescendants()) do
            if model:IsA("Model") and model.Name == "Bolt" and model:FindFirstChild("Humanoid") and model:FindFirstChild("HumanoidRootPart") then
                local hrp = model.HumanoidRootPart
                local humanoid = model.Humanoid

                local billboard = Instance.new("BillboardGui")
                billboard.Adornee = hrp
                billboard.AlwaysOnTop = true
                billboard.Size = UDim2.new(0,120,0,50)
                billboard.MaxDistance = math.huge
                billboard.StudsOffset = Vector3.new(0,2,0)
                billboard.Parent = game.CoreGui

                local frame = Instance.new("Frame")
                frame.Size = UDim2.new(1,0,0,5)
                frame.Position = UDim2.new(0,0,1,0)
                frame.BackgroundColor3 = Color3.new(0,1,0)
                frame.BorderSizePixel = 0
                frame.Parent = billboard

                local textLabel = Instance.new("TextLabel")
                textLabel.Text = model.Name
                textLabel.Size = UDim2.new(1,0,1,0)
                textLabel.BackgroundTransparency = 1
                textLabel.TextColor3 = Color3.new(1,0,0)
                textLabel.TextScaled = true
                textLabel.Parent = billboard

                game:GetService("RunService").RenderStepped:Connect(function()
                    if humanoid.Health > 0 then
                        frame.Size = UDim2.new(humanoid.Health/humanoid.MaxHealth,0,0,5)
                    else
                        billboard:Destroy()
                    end
                end)
            end
        end
    else
        for _, gui in pairs(game.CoreGui:GetChildren()) do
            if gui:IsA("BillboardGui") then
                gui:Destroy()
            end
        end
    end
end)

Options.BoltESP:SetValue(false)
--{ Lưu Conifg }--
SaveManager:SetLibrary(Library)
InterfaceManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes{}
InterfaceManager:SetFolder("FluentScriptHub")
SaveManager:SetFolder("FluentScriptHub/specific-game")
InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)

SaveManager:LoadAutoloadConfig()

