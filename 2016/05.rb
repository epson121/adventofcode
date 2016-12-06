require 'digest'

input = "abc"
input = "ffykfhsq"


i = 1
password = [-1, -1, -1, -1, -1, -1, -1, -1]
vals = ["0", "1", "2", "3", "4", "5", "6", "7"]
c = 0
while c < 8
    i += 1
    md5 = Digest::MD5.new
    sum = md5.update(input + i.to_s)
    if sum.hexdigest.slice(0, 5) == "00000"
        p sum.hexdigest
        val = sum.hexdigest[6]
        pos = sum.hexdigest[5]
        p pos
        p val
        if vals.include?(pos) and password[pos.to_i] == -1
            password[pos.to_i] = val
            c += 1
            p password
        end
    end
end
p password.join("")