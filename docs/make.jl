using GeneDrive
using Documenter

makedocs(;
    modules=[GeneDrive],
    authors="Valeri Vasquez",
    repo="https://github.com/vnvasquez/GeneDrive.jl/blob/{commit}{path}#L{line}",
    sitename="GeneDrive.jl",
    format=Documenter.HTML(;
        prettyurls=prettyurls = get(ENV, "CI", nothing) == "true",
    ),
    pages=[
        "Home" => "index.md",
        "Syntax Reference" => "syntax.md",
    ],
)

deploydocs(;
    repo="github.com/vnvasquez/GeneDrive.jl",
)