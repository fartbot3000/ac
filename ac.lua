task.wait()

if not game:IsLoaded() then 
    game.Loaded:Wait() 
end

local args = {...}
local controller = args[1].controller
local bots = args[1].bots
local config = args[1].config




if not (game:GetService("Players").LocalPlayer.Name == controller["MainAccount"]) then
    local UserSettings = UserSettings()
    UserSettings.GameSettings.MasterVolume = 0
    task.wait()
    setfpscap(30)
    task.wait()
    game:GetService("RunService"):Set3dRenderingEnabled(false)
    task.wait()
    game:GetService("Players").LocalPlayer.PlayerGui:Destroy()
    task.wait()
    game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.All, false)
    task.wait()
    for i,v in next, workspace:GetDescendants() do
    if v:IsA'Seat' then
    v:Destroy()
    end
    end
    task.wait()
    repeat task.wait() until game:GetService("Players").LocalPlayer
    local connections = getconnections or get_signal_cons
    if connections then
        for _, v in pairs(connections(game:GetService("Players").LocalPlayer.Idled)) do
            if v.Disable then
                v:Disable()
            elseif v.Disconnect then
                v:Disconnect()
            end
        end
    end
end
for i, botName in ipairs(bots) do
    if game:GetService("Players").LocalPlayer.Name == botName and config["SendJoinMsg"] == true then
    ohString1 = "A bot has loaded! [Bot " .. i .. " of " .. #bots .. "]"
    game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(ohString1, "All")
        task.wait()
    end
end

    if not (game:GetService("Players").LocalPlayer.Name == controller["MainAccount"]) then
    game:GetService("Players"):FindFirstChild(controller["MainAccount"]).Chatted:Connect(function(msg)


    local args = string.split(string.lower(msg), " ")
    local cmd = args[1]
    local function chatmsg(message, target)
        target = target or "All"
        game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(message, target)
    end
        
    if cmd == "?say" then
        local say_msg = string.sub(msg, string.len(cmd)+2, string.len(msg))
        ohString1 = say_msg
        chatmsg(ohString1)
    end

    local args = string.split(string.lower(msg), " ")
    local cmd = args[1]
                
    if cmd == "?slowspam" then
        getgenv().LoopSlowSpam = false
        getgenv().LoopFastSpam = false
        local say_msg = string.sub(msg, string.len(cmd)+2, string.len(msg))
        getgenv().LoopSlowSpam = true
        while getgenv().LoopSlowSpam == true do
            task.wait(2)
            ohString1 = say_msg
            chatmsg(ohString1)
        end
    end
    
    if cmd == "?fastspam" then
        getgenv().LoopFastSpam = false
        getgenv().LoopSlowSpam = false
        local say_msg = string.sub(msg, string.len(cmd)+2, string.len(msg))
        getgenv().LoopFastSpam = true
        while getgenv().LoopFastSpam == true do
            task.wait()
            ohString1 = say_msg
            chatmsg(ohString1)
        end
    end
                
    if msg == "?unspam" then
        getgenv().LoopFastSpam = false
        getgenv().LoopSlowSpam = false
    end
                
    if msg == "?rj" then
        game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId,game.JobId,game:GetService("Players").LocalPlayer) 
    end

    if msg == "?rje" then
        local TeleportService = game:GetService("TeleportService")
        local Players = game:GetService("Players")
        local Player = Players.LocalPlayer
        local Character = Player.Character or false
        local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid") or false
        local RootPart = Humanoid and Humanoid.RootPart or false
        local PrimaryPart = Character and Character.PrimaryPart or false
        local BasePart = Character and Character:FindFirstChildWhichIsA("BasePart", true) or false
        local Camera = workspace:FindFirstChildWhichIsA("Camera") or false
        local OldPos
        if RootPart then
            OldPos = RootPart.CFrame
        elseif PrimaryPart then
            OldPos = PrimaryPart.CFrame
        elseif BasePart then
            OldPos = BasePart.CFrame
        elseif Camera then
            OldPos = Camera.Focus
        end
        if #Players:GetPlayers() <= 1 then
            Player:Kick()
            coroutine.wrap(function()
                local PromptGui = CoreGui:WaitForChild("RobloxPromptGui")
                local ErrorTitle = PromptGui:FindFirstChild("ErrorTitle", true)
                local ErrorMessage = PromptGui:FindFirstChild("ErrorMessage", true)
                ErrorTitle.Text = "Rejoining Experience Shortly"
                while true do
                    for i = 1, 3 do
                        ErrorMessage.Text = "You are currently reconnecting to this game" .. string.rep(".", i) .. "\n" .. "PlaceId: " .. game["PlaceId"]
                        wait(1)
                    end
                end
            end)()
            TeleportService:Teleport(game["PlaceId"])
        else
            TeleportService:TeleportToPlaceInstance(game["PlaceId"], game["JobId"])
        end

syn.queue_on_teleport(string.format([[
            game["Loaded"]:wait()
            local Player = game:GetService("Players").LocalPlayer
            local Character = Player.Character or Player.CharacterAdded:wait()
            repeat task.wait() until Character and Character.PrimaryPart
            Character:SetPrimaryPartCFrame(CFrame.new(%s))
        ]],  tostring(OldPos)))
	end
end)

    if msg == "?cmds" then
        if game.Players.LocalPlayer.Name == bots[1] then
        task.wait()
        chatmsg("Cmds With Arguments Pg 1: ?say [args] | ?slowspam [args] | ?fastspam [args] | ?8ball [args] | ?wall [plr] | ?line [plr] | ?swarm [plr] | ?lookat [plr] | ?follow [plr] | ?goto [plr]")
        task.wait(1)
        chatmsg("Cmds With Arguments Pg 2: ?runlua [code] | ?calculate [equation]")
        task.wait(1)
        chatmsg("Cmds Without Arguments List: ?re | ?rj | ?rje |?playercount | ?dance1 | ?dance2 | ?dance3 | ?dance4 | ?laugh | ?wave | ?cheer | ?point | ?jump | ?sv | ?sit | ?unsit")
        task.wait(1)
        chatmsg("Stop Cmds: ?stop (for wall,swarm,line,lookat,follow cmds) | ?unspam (for slowspam,fastspam cmds) | ?stopemotes (self explanatory)")
        elseif game.Players.LocalPlayer.Name ~= bots[1] then
            --
        end
    end
            
    if msg == "?jump" then
        game:GetService("Players").LocalPlayer.Character.Humanoid.Jump = true
    end

    if msg == "?sit" then
        game:GetService("Players").LocalPlayer.Character.Humanoid.Sit = true
    end

    if msg == "?unsit" then
        game:GetService("Players").LocalPlayer.Character.Humanoid.Sit = false
    end

    if msg == "?dance1" then
        game:GetService("Players").LocalPlayer.Character.Animate.Disabled = true
        task.wait()
        game:GetService("Players").LocalPlayer.Character.Animate.Disabled = false
        game:GetService("Players"):Chat("/e dance")
    end 

    if msg == "?dance2" then
        game:GetService("Players").LocalPlayer.Character.Animate.Disabled = true
        task.wait()
        game:GetService("Players").LocalPlayer.Character.Animate.Disabled = false
        game:GetService("Players"):Chat("/e dance2")
    end

    if msg == "?dance3" then
        game:GetService("Players").LocalPlayer.Character.Animate.Disabled = true
        task.wait()
        game:GetService("Players").LocalPlayer.Character.Animate.Disabled = false
        game:GetService("Players"):Chat("/e dance3")
    end

    if msg == "?dance4" then
        local Anim = Instance.new("Animation")
        Anim.AnimationId = "rbxassetid://12874447851"
        local k = game:GetService("Players").LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
        k:Play(0)
        k:AdjustSpeed(1)
        game:GetService("Players").LocalPlayer.Character.Animate.Disabled = true
        game:GetService("Players").LocalPlayer.Character.Humanoid.Running:connect(function(speed)
        if speed > 0 then
            game:GetService("Players").LocalPlayer.Character.Animate.Disabled = false
        k:Stop(0)
        end
        end)
        end

    if msg == "?laugh" then
        game:GetService("Players").LocalPlayer.Character.Animate.Disabled = true
        task.wait()
        game:GetService("Players").LocalPlayer.Character.Animate.Disabled = false
        game:GetService("Players"):Chat("/e laugh")
    end
         
    if msg == "?wave" then
        game:GetService("Players").LocalPlayer.Character.Animate.Disabled = true
        task.wait()
        game:GetService("Players").LocalPlayer.Character.Animate.Disabled = false
        game:GetService("Players"):Chat("/e wave")
    end

    if msg == "?cheer" then
        game:GetService("Players").LocalPlayer.Character.Animate.Disabled = true
        task.wait()
        game:GetService("Players").LocalPlayer.Character.Animate.Disabled = false
        game:GetService("Players"):Chat("/e cheer")
    end

    if msg == "?point" then
        game:GetService("Players").LocalPlayer.Character.Animate.Disabled = true
        task.wait()
        game:GetService("Players").LocalPlayer.Character.Animate.Disabled = false
        game:GetService("Players"):Chat("/e point")
    end

    if msg == "?stopemotes" then
        game:GetService("Players").LocalPlayer.Character.Animate.Disabled = true
        task.wait()
        game:GetService("Players").LocalPlayer.Character.Animate.Disabled = false
    end

    if msg and #msg >= 10 and msg:sub(1, 10) == "?calculate" then
        local equation = msg:sub(12)
        local result = loadstring("return " .. equation)()
        if #equation == 0 then
        chatmsg("There must be a math equation after the ?math command! | Usage: ?math <equation>")
        else
        chatmsg("The answer to the equation you sent: " .. tostring(result))   
    end
    end

    
    if msg and #msg >= 7 and msg:sub(1, 7) == "?runlua" then
        local luaCode = msg:sub(9)
        if #luaCode == 0 then
          chatmsg("There must be code after the ?runlua command! | Usage: ?runlua <code>")
          return
        end
        local success, result = pcall(loadstring(luaCode))
        if success then chatmsg("✅ | Successfully ran the LUA Code you sent!")
          if result ~= nil then
            chatmsg(result)
          end
        else
          chatmsg("❌ | " .. result)
        end
      end

      if msg:sub(1, 6) == "?8ball" then
        local answers = {
            "It is certain.",
            "Without a doubt.",
            "You may rely on it.",
            "Yes, definitely.",
            "It is decidedly so.",
            "As I see it, yes.",
            "Most likely.",
            "Yes.",
            "Outlook good.",
            "Signs point to yes.",
            "Reply hazy, try again.",
            "Better not tell you now.",
            "Ask again later.",
            "Cannot predict now.",
            "Concentrate and ask again.",
            "Don't count on it.",
            "Outlook not so good.",
            "My sources say no.",
            "Very doubtful.",
            "Signs point to no."
        }

        local response = answers[math.random(1, 20)]
        if game.Players.LocalPlayer.Name == bots[1] then
        chatmsg(response)    
        elseif game.Players.LocalPlayer.Name ~= bots[1] then    
        end
        end

if msg:sub(1, 6) == "?wall " then
    getgenv().LoopSwarm, getgenv().LoopLine, getgenv().LoopWall, getgenv().LoopLook, getgenv().LoopFollow, getgenv().LoopGreet = false, false, false, false, false, false
    local player = game:GetService("Players"):GetPlayers()[
        (function()
            for i, plr in ipairs(game:GetService("Players"):GetPlayers()) do
                if string.lower(plr.Name):sub(1, string.len(msg:sub(7))) == string.lower(msg:sub(7)) or
                    string.lower(plr.DisplayName):sub(1, string.len(msg:sub(7))) == string.lower(msg:sub(7)) then
                    return i
                end
            end
            return nil
        end)()
    ]
    if player then
        local botIndex = 1
        for i, botName in pairs(bots) do
            if string.lower(botName) == string.lower(game:GetService("Players").LocalPlayer.Name) then
                botIndex = i
                break
            end
        end
        local offsets = {4, 8, -4, -8, 12, -12, 16, -16, 20, -20, 24, -24, 28, -28, 32, -32, 36, -36, 40, -40}
        local offset = offsets[botIndex] or 0
        if player == game:GetService("Players").LocalPlayer then
            chatmsg("The user you specified is one of your bots!")
        elseif table.find(bots, player.Name) then
            chatmsg("The user you specified is one of your bots!")
        else
            getgenv().LoopWall = true
            while getgenv().LoopWall do
                game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = workspace[player.Name].HumanoidRootPart.CFrame * CFrame.new(offset, 0, 0)
                task.wait()
            end
        end
    end
end

        
        if msg:sub(1, 6) == "?line " then
            getgenv().LoopSwarm, getgenv().LoopLine, getgenv().LoopWall, getgenv().LoopLook, getgenv().LoopFollow, getgenv().LoopGreet = false, false, false, false, false, false
            local player = game:GetService("Players"):GetPlayers()[
                (function()
                    for i, plr in ipairs(game:GetService("Players"):GetPlayers()) do
                        if string.lower(plr.Name):sub(1, string.len(msg:sub(7))) == string.lower(msg:sub(7)) or
                            string.lower(plr.DisplayName):sub(1, string.len(msg:sub(7))) == string.lower(msg:sub(7)) then
                            return i
                        end
                    end
                    return nil
                end)()
            ]
            if player then
                local botIndex = 1
                for i, botName in pairs(bots) do
                    if string.lower(botName) == string.lower(game:GetService("Players").LocalPlayer.Name) then
                        botIndex = i
                        break
                    end
                end
                local offsets = {-2, -4, -6, -8, -10, -12, -14, -16, -18, -20, -22, -24, -26, -28, -30, -32, -34, -36, -38, -40}
                local offset = offsets[botIndex] or 0
            if player == game:GetService("Players").LocalPlayer then
                chatmsg("The user you specified is one of your bots!")
            elseif table.find(bots, player.Name) then
                chatmsg("The user you specified is one of your bots!")
            else
                getgenv().LoopLine = true
                while getgenv().LoopLine do
                    game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = workspace[player.Name].HumanoidRootPart.CFrame * CFrame.new(0, 0, offset)
                    task.wait()
                end
            end
        end
       end

if msg:sub(1, 7) == "?swarm " then
    getgenv().LoopSwarm, getgenv().LoopLine, getgenv().LoopWall, getgenv().LoopFollow, getgenv().LoopGreet = false, false, false, false, false
    for i, plr in ipairs(game:GetService("Players"):GetPlayers()) do
        if string.find(string.lower(plr.Name), string.lower(msg:sub(8))) or string.find(string.lower(plr.DisplayName), string.lower(msg:sub(8))) then
            if plr == game:GetService("Players").LocalPlayer then
                chatmsg("The user you specified is one of your bots!")
            elseif table.find(bots, plr.Name) then
                chatmsg("The user you specified is one of your bots!")
            else
                local playerRootPart = game:GetService("Workspace"):FindFirstChild(plr.Name).HumanoidRootPart
                if table.find(bots, game:GetService("Players").LocalPlayer.Name) then
                    getgenv().LoopSwarm = true
                    while getgenv().LoopSwarm == true do
                        game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = workspace[plr.Name].HumanoidRootPart.CFrame * CFrame.new(math.random(-5,5),0,math.random(-5,5))
                        task.wait()
                    end
                end
            end
        end
    end
end

        
if msg:sub(1, 8) == "?lookat " then
    for _, plr in ipairs(game:GetService("Players"):GetPlayers()) do
        if string.lower(plr.Name):sub(1, string.len(msg:sub(9))) == string.lower(msg:sub(9)) or
           string.lower(plr.DisplayName):sub(1, string.len(msg:sub(9))) == string.lower(msg:sub(9)) then
            if table.find(bots, plr.Name) then
                chatmsg("The user you specified is one of your bots!")
            elseif plr == game:GetService("Players").LocalPlayer then
                chatmsg("The user you specified is one of your bots!")
            else
                local playerRootPart = game:GetService("Workspace"):FindFirstChild(plr.Name).HumanoidRootPart
                getgenv().LoopLook = true
                while getgenv().LoopLook == true do
                    game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.lookAt(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position, workspace[plr.Name].HumanoidRootPart.Position)
                    task.wait()
                end
            end
        end
    end
end


if msg:sub(1, 8) == "?follow " then
    local playerName = msg:sub(9)
    if getgenv().LoopFollow == true then
        getgenv().LoopFollow = false
        task.wait()
    end
    getgenv().LoopSwarm, getgenv().LoopLine, getgenv().LoopWall, getgenv().LoopLook, getgenv().LoopFollow, getgenv().LoopGreet = false, false, false, false, false, false
    
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    
    local function followPlayer(playerName)
        for _, player in ipairs(Players:GetPlayers()) do
            if string.lower(player.Name):sub(1, #playerName) == string.lower(playerName)
                or string.lower(player.DisplayName):sub(1, #playerName) == string.lower(playerName) then
                if player == game:GetService("Players").LocalPlayer then
                    chatmsg("The user you specified is one of your bots!")
                elseif table.find(bots, player.Name) then
                    chatmsg("The user you specified is one of your bots!")
                else
                    local humanoidRootPart = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
                    if humanoidRootPart then
                        getgenv().LoopFollow = true
                        while getgenv().LoopFollow == true do
                            if (LocalPlayer.Character.HumanoidRootPart.Position - humanoidRootPart.Position).Magnitude > 3 then
                                LocalPlayer.Character.Humanoid:MoveTo(humanoidRootPart.Position)
                            end
                            task.wait()
                        end
                    end
                end
            end
        end
    end
    followPlayer(playerName)
end









if msg:sub(1, 6) == "?goto " then
    getgenv().LoopSwarm, getgenv().LoopLine, getgenv().LoopWall, getgenv().LoopLook, getgenv().LoopFollow, getgenv().LoopGreet = false, false, false, false, false, false
    local playerName = msg:sub(7)
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer

    local function gotoPlayer(playerName)
        for _, player in ipairs(Players:GetPlayers()) do
            if (string.lower(player.Name):sub(1, #playerName) == string.lower(playerName)
                or string.lower(player.DisplayName):sub(1, #playerName) == string.lower(playerName)) then
                if player == LocalPlayer then
                    chatmsg("The user you specified is one of your bots!")
                elseif table.find(bots, player.Name) then
                    chatmsg("The user you specified is one of your bots!")
                else
                    local humanoidRootPart = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
                    if humanoidRootPart then
                        LocalPlayer.Character.HumanoidRootPart.CFrame = humanoidRootPart.CFrame * CFrame.new(0, 0, -2)
                        task.wait()
                        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.lookAt(LocalPlayer.Character.HumanoidRootPart.Position, player.Character.HumanoidRootPart.Position)
                        task.wait()
                    end
                end
            end
        end
    end

    gotoPlayer(playerName)
end


            
        if msg == "?stopall" then
        getgenv().LoopSwarm, getgenv().LoopLine, getgenv().LoopWall, getgenv().LoopLook, getgenv().LoopFollow, getgenv().LoopGreet = false, false, false, false, false, false
        end

        if msg == "?re" then
        game.Players.LocalPlayer.Character.Humanoid.Health = 0
        end

        if msg == "?sv" then
        game:GetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents"):WaitForChild("SayMessageRequest"):FireServer(".gg/hear","All")
        end

        if msg == "?unlookat" then
        getgenv().LoopLook = false
        end

        if msg == "?unswarm" then
        getgenv().LoopSwarm = false
        end

        if msg == "?unfollow" then
        getgenv().LoopFollow = false
        end

        if msg == "?unwall" then
        getgenv().LoopWall = false
        end

        if msg == "?unline" then
        getgenv().LoopLine = false
        end

        if msg == "?rotate" then
        local spin =  Instance.new("BodyAngularVelocity", game.Players.LocalPlayer.Character.HumanoidRootPart)
        spin.AngularVelocity = Vector3.new(0, -25, 0)

        local TweenService = game:GetService("TweenService")
        local primaryPart = spin
        local speed = 5
        local rotation = Vector3.new(0, 25, 0) -- put your rotation here

        local tweenInfo = TweenInfo.new(speed, Enum.EasingStyle.Linear, Enum.EasingDirection.In, 0, false, 0)

        local tween = TweenService:Create(primaryPart, tweenInfo, {AngularVelocity = rotation})

        tween:Play() -- Put this line wherever you like.
        tween.Completed:Connect(function(PlaybackState)
        if PlaybackState == Enum.PlaybackState.Completed then
        spin:Destroy()
        end
        end)
        end

        if msg == "?playercount" then
        if game.Players.LocalPlayer.Name == bots[1] then
        local botAmount = 0
        for _, player in pairs(game:GetService("Players"):GetPlayers()) do
        if table.find(bots, player.Name) then
        botAmount = botAmount + 1
        end
        end
        local playerAmount = #game:GetService("Players"):GetPlayers() - botAmount
        chatmsg("There are " .. #game:GetService("Players"):GetPlayers() .. " players currently in the server including " .. botAmount .. " bot(s), " .. playerAmount .. " players without the bot(s) being included!")
        elseif game.Players.LocalPlayer.Name ~= bots[1] then
        --
        end
end
end
