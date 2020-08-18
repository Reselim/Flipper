local ReplicatedStorage = game:GetService("ReplicatedStorage")

local TestEZ = require(ReplicatedStorage.TestEZ)

TestEZ.TestBootstrap:run({ ReplicatedStorage.Flipper }, TestEZ.Reporters.TextReporter)