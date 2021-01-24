#=
Try to implement some simple SQL like queries using Julia
* the objective is do some exercise with metaprogramming
* just for test, will only support some basic query like select
=#

"""
Simple table structure, will continue add fields
* will add column data type and data
"""
struct Table
    title::String
    headers::Tuple
end

"""
Initial test to use macro
* the first variable will be used as table name
* and the rests are headers
"""
macro CREATE(expr)
    table = expr.args[1]
    name = String(expr.args[1])
    headers = Tuple(expr.args[2:end])
    esc(
        quote
            $table = Table($name, $headers)
        end
    )
end

"""
Usage:
* create a table of name "users"
* the headers are: "id", "name", and "type"
"""
@CREATE users, id, name, type

varinfo()
