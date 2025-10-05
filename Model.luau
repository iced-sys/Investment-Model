--[[
    References:

    https://en.wikipedia.org/wiki/Geometric_Brownian_motion
    https://lucien-east.github.io/2021/07/27/Brownian-motion/
]]


local Module = {}
Module.TimePeriod = 1   -- in years
Module.Steps = 1460     -- intervals (in hours)

-- Get the next price of a stock using Geometric Brownian Motion
--[=[
@param	number	currentPrice - The current price of the stock
@param  number	mean - The mean of the stock
@param  number	stdDev - The standard deviation of the stock

@return number - The next price of the stock
]=]
function Module:GetNextPrice(currentPrice: number, rng: Random, mu: number, alpha: number, beta: number, dt: number): number
    -- Determine direction: 1 = up, -1 = down, 0 = flat
    local roll: Random = rng:NextNumber()

    local direction: number = 0
    if roll < alpha then
        direction = 1
    elseif roll < alpha + beta then
        direction = -1
    end

    -- Sample noise magnitude proportional to dt in the range: [0, mu * dt]
    local magnitude: number = rng:NextNumber() * (mu * math.sqrt(dt))

	-- Percentage change applied per step
    local delta: number = direction * magnitude
    local price: number = currentPrice * math.exp(delta)--math.floor(currentPrice * math.exp(delta))

    return price
end

-- Simulate path of a stock
--[=[
@param 	seed 	number - The seed for the random number generator
@param 	S0 		number - Initial price
@param 	mu 		number - The volatility
@param 	alpha 	number - Upward drift probability per unit time
@param 	beta 	number - Downward drift probability per unit time

@return table - A table of prices
]=]
function Module:SimulatePath(seed: number, S0: number, mu: number, alpha: number,  beta: number): {number}
	local prices: {number} = {}
	prices[1] = S0

    local rng: Random = Random.new(seed)
	local dt: number = Module.TimePeriod / Module.Steps

	for i = 2, Module.Steps do
		local previousPrice: number = prices[i - 1]

		prices[i] = Module:GetNextPrice(previousPrice, rng, mu, alpha, beta, dt)
	end

	return prices
end

return Module
