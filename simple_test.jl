# Prepare data structure for database & query

#=
    Simple table structure, will continue add fields
=#
struct Table
    title::String
end

#=
    Initial test to use macro
=#
macro CREATE(input::Symbol)
    name = String(input)
    esc(
        quote
            $input = Table($name)
        end
    )
end

@CREATE lololo

varinfo()
