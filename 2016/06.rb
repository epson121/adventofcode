
file = File.new("06-test.txt", "r")
file = File.new("06.txt", "r")

chars = []
while (line = file.gets)
    msg = line.split("")
    msg.each_with_index do |v, k|
        if chars[k]
            chars[k] << v
        else
            chars[k] = [v]
        end
    end
end

res1 = ""
res2 = ""
chars.each do |st|
    k = st.group_by{ |c| c }.map {|k, v| [k, v.length]}.sort_by {|k,v| v}.reverse
    #part 1
    res1 += k.first[0]
    res2 += k.last[0]
end

p res1
p res2
