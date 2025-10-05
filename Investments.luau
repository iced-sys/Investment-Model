export type Investment = {
	Name: string,
	Description: string,

	Risk: number,
	Alpha: number,		-- Market price increase likelihood in the range: [0, 1]
	Beta: number,		-- Market price decrease likelihood in the range: [0, 1]
	Volatility: number, -- Market "noise" (sort of artifical)
	Dividend: number,
	ListDate: DateTime,

	InitialValue: number,-- Initial market price
	CurrentValue: number,-- Current market price
	History: {number},	 -- Record of market prices

	Trait: string
}

local InitialInvestmentValues: {[string]: number} = {
	["Apartment #1"] = 20000,
	["Grocery Store"] = 50000,
}

local Investments : {Investment} = {
	{
		Name = 'Apartment #1',
		Description = "Located in the outskirts of the city, this apartment is perfectly for a small family of six.",
		
		Risk = 0.1,
		Alpha = 0.6,
		Beta = 0.4,
		Volatility = 0.05,
		Dividend = 0.01,
		ListDate = DateTime.now().UnixTimestamp,

		InitialValue = InitialInvestmentValues["Apartment #1"],
		CurrentValue = InitialInvestmentValues["Apartment #1"],
		History = {InitialInvestmentValues["Apartment #1"]},

		Trait = 'BulletResistance'
	},
	{
		Name = 'Grocery Store',
		Description = "Sells food and other essentials - a variety of items - including some that are not typically found in a grocery store. Like Soko.",
		
		Risk = 0.1,
		Alpha = 0.4,
		Beta = 0.6,
		Volatility = 0.05,
		Dividend = 0.01,
		ListDate = DateTime.now().UnixTimestamp,

		InitialValue = InitialInvestmentValues["Grocery Store"],
		CurrentValue = InitialInvestmentValues["Grocery Store"],
		History = {InitialInvestmentValues["Grocery Store"]},

		Trait = 'BulletResistance'
	},
}

return Investments
