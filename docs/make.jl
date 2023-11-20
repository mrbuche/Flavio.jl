using Documenter, Flavio

makedocs(
    format = Documenter.HTML(),
    modules = [Flavio],
    pages = [
        "Home" => "index.md",
    ],
    sitename = "Flavio",
)
