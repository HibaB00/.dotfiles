-- Annotations half of herdr-nvim: comment on lines, send them to the agent in herdr.
-- Prefix is <leader>n ("notes") because the default <leader>a collides with the opencode maps.
return {
	"ChmaraX/herdr-nvim",
	event = "VeryLazy",
	opts = { prefix = "<leader>n" },
}
