using WaveUty
using Documenter

DocMeta.setdocmeta!(WaveUty, :DocTestSetup, :(using WaveUty); recursive=true)

makedocs(;
    modules=[WaveUty],
    authors="Naoki Maeda <naoki.maeda.jp@gmail.com> and contributors",
    repo="https://github.com/nmaedajp/WaveUty.jl/blob/{commit}{path}#{line}",
    sitename="WaveUty.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://nmaedajp.github.io/WaveUty.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/nmaedajp/WaveUty.jl",
    devbranch="main",
)
