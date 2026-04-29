local function To(cf)
    pcall(function()
        local hrp = LPl.Character and LPl.Character:FindFirstChild("HumanoidRootPart")
        if not hrp or not cf then return end

        local dist = (hrp.Position - cf.Position).Magnitude
        if dist < 5 then 
            if curT then curT:Cancel() end
            return true 
        end

        -- [RESILIÊNCIA] Se o alvo sumir ou mudar bruscamente, o Tween reinicia
        if curT and curT.PlaybackState == Enum.PlaybackState.Playing then
            -- Verifica se o destino atual é muito diferente do novo (evita jitter)
            if _G.Nexus.CurrentDestination and (_G.Nexus.CurrentDestination.Position - cf.Position).Magnitude < 2 then
                return
            end
        end

        _G.Nexus.CurrentDestination = cf
        if curT then curT:Cancel() end

        local info = TweenInfo.new(dist/_G.Config.TweenSpeed, Enum.EasingStyle.Linear)
        curT = TS:Create(hrp, info, {CFrame = cf * CFrame.new(GetHumanizedOffset())})
        curT:Play()
    end)
end
