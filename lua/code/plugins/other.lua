return {
    {
        "mistricky/codesnap.nvim",
        build = "make build_generator",
        opts = {
            save_path = os.getenv("HOME") .. "/Pictures",
            has_breadcrumbs = true,
            has_line_number = true,
            bg_theme = "grape",
            watermark = "",
            code_font_family = "Maple Mono",
        }
    },
}
