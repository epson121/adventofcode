def decompressed_length(data)
    i = 0
    total = 0
    while i < data.length do
        if data[i] == '('
            i += 1
            newstring = ""
            while data[i] != ')'
                newstring += data[i]
                i += 1
            end
            length = newstring.split('x')[0].to_i
            amount = newstring.split('x')[1].to_i
            total += amount * decompressed_length(data[i+1...i+length+1])
            i += length
        else
            total += 1
        end
        i += 1
    end
    return total
end

file = File.new("09.txt", "r")
line = file.gets
p decompressed_length(line)