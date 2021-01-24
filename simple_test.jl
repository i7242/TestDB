#=
Try to implement some simple SQL like queries using Julia
* the objective is do some exercise with metaprogramming
* just for test, will only support some basic query like select
=#

"""
Simple table structure, will continue add fields
* consider to removed header and type
* they can be achieved by using NamedTuple with eltype()
"""
struct Table
    title::String
    headers::Tuple{Vararg{Symbol}}
    types::Tuple{Vararg{DataType}}
    data::NamedTuple
end

"""
Initial test to use macro
* the first variable will be used as table name
* and the rests are headers
"""
macro CREATE(expr)
    table = expr.args[1]
    title = String(expr.args[1])
    headers = Tuple([eval(ex)[1] for ex in expr.args[2:end]])
    types = Tuple([eval(ex)[2] for ex in expr.args[2:end]])
    columns = Tuple([type[] for type in types])
    data = (; zip(headers, columns)...)
    esc(
        quote
            $table = Table($title, $headers, $types, $data)
        end
    )
end

"""
Usage:
* create a table of name "users"
* the headers are: "id", "name", and "type"
"""
@CREATE users, (:id, Int64), (:name, String), (:type, String)

typeof(users.data)
eltype(users.data.id)
varinfo()

#=
macro TestInputs(expr)
    println(expr)
    println(expr.head)
    println(expr.args[1])
    println(typeof(expr.args[1]))
    println(expr.args[2])
    println(typeof(expr.args[2]))
    println(expr.args[3])
    println(typeof(expr.args[3]))
    println(expr.args[3].args[2])
    println(typeof(expr.args[3].args[2]))
end

@TestInputs name, :id, (age, :type)
=#
