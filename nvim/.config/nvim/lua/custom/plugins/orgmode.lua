return {
	"nvim-orgmode/orgmode",
	event = "VeryLazy", -- upstream recommends VeryLazy + ft so agenda/capture keys work without an org buffer open
	ft = { "org" },
	opts = {
		org_agenda_files = "~/orgfiles/**/*",
		org_default_notes_file = "~/orgfiles/refile.org",
	},
}
