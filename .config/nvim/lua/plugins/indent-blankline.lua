return {
	"lukas-reineke/indent-blankline.nvim",
	event = "VeryLazy",
	opts = {},
	main = "ibl",
	config = function()
		require("ibl").setup()
	end,
}
