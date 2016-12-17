
file = File.new("09.txt", "r")
file = File.new("09-test.txt", "r")
# while (line = file.gets)
#     i = 0
#     str = ""
#     while i < line.length
#         if (line[i] == "(") 
#             # m = line.slice(i, 4).index(")")
#             # p line.slice(i, m-1)
#             if c = /\((.+)x(.+)\)/.match(line[i..i+8])
#                 chars = c.captures[0].to_i
#                 m = c.captures.join().length + 3
#                 n = c.captures[1].to_i
#                 str += line[i+m..i+m+chars-1] * n
#                 i += m + chars
#             end 
#             # i += 1
#         else
#             str += line[i]
#             i += 1
#         end
#     end
#     # p str.rstrip()
#     # p str.rstrip().length
# end

while (line = file.gets)
    i = 0
    sum = 0
    str = ""
    tempstr = ""
    while i < line.length
        if (line[i] == "(")
            x = line.slice(i, 10).index("x")
            r_paren = line.slice(i, 10).index(")")
            s = line[i+1, x-1]
            mult = s.to_i
            l = line.slice(i + r_paren+1, s.to_i + 1)
            j = 1
            num = ""
            while true
            end
            i += s.to_i
        else
            sum += 1
        end
        i += 1
    end
    # p sum
end
