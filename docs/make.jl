using Documenter, Flavio

makedocs(
    format = Documenter.HTML(),
    modules = [Flavio],
    pages = [
        "Home" => "index.md",
        "Constitutive" => "constitutive.md",
        "Index" => "genindex.md",
    ],
    sitename = "Flavio.jl",
)
