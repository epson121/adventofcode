
initial = "10000"
initial = "10111011111001111"

size = 20
size = 272
size = 35651584

def dragonize(data)
    copy = data.reverse.gsub("1", "a").gsub("0", "1").gsub("a", "0")
    data + "0" + copy
end

def get_checksum(data)
    i = 0
    cs = []
    while i < data.length - 1
        if data[i] == data[i+1]
            cs << "1"
        else
            cs << "0"
        end
        i += 2
    end
    cs.join("")
end

data = initial

prev = ""
while data.length < size
    data = dragonize(data)
end

data = data.slice(0, size)

checksum = ""
while checksum.length % 2 == 0
    if checksum == ""
        checksum = get_checksum(data)
    else
        checksum = get_checksum(checksum)
    end
end
p checksum