repeat wait() until game:IsLoaded() and game.Players.LocalPlayer
local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local screenGui = Instance.new("ScreenGui")
screenGui.Parent = playerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0.5, 0, 0.3, 0)
frame.Position = UDim2.new(0.25, 0, 0.35, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.Parent = screenGui

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 0.2, 0)
titleLabel.Text = "Enter the Key"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextSize = 24
titleLabel.BackgroundTransparency = 1
titleLabel.Parent = frame

local keyInput = Instance.new("TextBox")
keyInput.Size = UDim2.new(0.8, 0, 0.3, 0)
keyInput.Position = UDim2.new(0.1, 0, 0.3, 0)
keyInput.PlaceholderText = "Enter your key"
keyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
keyInput.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
keyInput.TextSize = 18
keyInput.Parent = frame

local submitButton = Instance.new("TextButton")
submitButton.Size = UDim2.new(0.8, 0, 0.2, 0)
submitButton.Position = UDim2.new(0.1, 0, 0.7, 0)
submitButton.Text = "Submit"
submitButton.BackgroundColor3 = Color3.fromRGB(0, 204, 255)
submitButton.TextColor3 = Color3.fromRGB(255, 255, 255)
submitButton.TextSize = 20
submitButton.Parent = frame

local function saveKeyToMemory(key)
    local currentTime = os.time()
    local expirationTime = currentTime + 12 * 60 * 60
    game:SetAttribute("SavedKey", key)
    game:SetAttribute("KeyExpiration", expirationTime)
end

submitButton.MouseButton1Click:Connect(function()
    local inputKey = keyInput.Text
    if inputKey ~= "" then
        saveKeyToMemory(inputKey)
        screenGui:Destroy()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/obiiyeuem/vthangsitink/main/BananaHub.lua"))()
    else
        local errorLabel = Instance.new("TextLabel")
        errorLabel.Size = UDim2.new(1, 0, 0.2, 0)
        errorLabel.Position = UDim2.new(0, 0, 0.9, 0)
        errorLabel.Text = "Please enter a valid key!"
        errorLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
        errorLabel.TextSize = 20
        errorLabel.BackgroundTransparency = 1
        errorLabel.Parent = frame
    end
end)

local function checkKeyExpiration()
    local savedKey = game:GetAttribute("SavedKey")
    local expirationTime = game:GetAttribute("KeyExpiration")
    if savedKey and expirationTime then
        local currentTime = os.time()
        if currentTime > expirationTime then
            game:SetAttribute("SavedKey", nil)
            game:SetAttribute("KeyExpiration", nil)
        end
    end
end

checkKeyExpiration()
