def perform(string, op, reverse)
    data = op.split(" ")
    p string
    p op
    case
        when op.include?("swap position")
            tmp = string[data[2].to_i]
            string[data[2].to_i] = string[data[5].to_i]
            string[data[5].to_i] = tmp
        when op.include?("swap letter")
            string.gsub!(data[2], "0")
            string.gsub!(data[5], data[2])
            string.gsub!("0", data[5])
        when op.include?("rotate left")
            idx = reverse ? -1 : 1
            string = string.split("").rotate(idx * data[2].to_i).join
        when op.include?("rotate right")
            idx = reverse ? 1 : -1
            string = string.split("").rotate(idx * data[2].to_i).join
        when op.include?("rotate based")
            idx = string.index(data[6])
            if !reverse
                idx += idx >= 4 ? 2 : 1
                rot = idx % string.length
            else
                rot = idx / 2 + (idx % 2 == 1 || idx == 0 ? 1 : 5)
            end
            sign = reverse ? 1 : -1
            string = string.split("").rotate(sign * rot).join
        when op.include?("reverse positions")
            span = data[4].to_i - data[2].to_i
            s1 = string.slice(data[2].to_i, span+1)
            s1.reverse!
            string[data[2].to_i..data[4].to_i] = s1
        when op.include?("move position")
            i1 = reverse ? 5 : 2
            i2 = reverse ? 2 : 5
            d = string.slice(data[i1].to_i)
            if (data[i2].to_i == string.length-1) or (data[i1].to_i < data[i2].to_i)
                string.insert(data[i2].to_i+1, d)
            else
                string.insert(data[i2].to_i, d)
            end
            if data[i1].to_i > data[i2].to_i
                d = string.slice!(data[i1].to_i+1)
            else
                d = string.slice!(data[i1].to_i)
            end
    end
    string
end

# password = "abcde"
password = "fbgdceah"
password = "abcdefgh"
# file = File.new("21-test.txt", "r")
file = File.new("21-reverse.txt", "r")
file = File.new("21.txt", "r")
while (op = file.gets)
    password = perform(password, op.strip, false)
end
p password