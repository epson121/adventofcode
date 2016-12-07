
file = File.new("07-test.txt", "r")
file = File.new("07.txt", "r")

# check if string is abba formatted
def is_abba?(a)
    0.upto(a.length) do |index|
        if (a[index+3] == nil)
            next
        else
            if (a[index] == a[index+3] && a[index+1] == a[index+2] && a[index] != a[index+1])
                return true
            end
        end
    end
    return false
end

# get array of aba values from string
def get_abas(a)
    abas = []
    0.upto(a.length) do |index|
        if (a[index+2] == nil)
            next
        else
            if (a[index] == a[index+2] && a[index] != a[index+1])
                abas << a[index] + a[index+1] + a[index+2]
            end
        end
    end
    return abas
end

c = 0
b = 0
should = []
should_not = []
while (line = file.gets)
    str = ""
    # split to should and should not
    # be in a certain format (aba | abba)
    line.each_char do |char|
        if (char == "\n")
            next
        end
        if (char == "[")
            should << str
            str = ""
        elsif (char == "]")
            should_not << str
            str = ""
        else
            str += char
        end
    end
    should << str
    
    # compare them
    # count
    # profit
    s = false
    n = false

    aba1 = []
    should.each do |w|
        #  part 1
        # if is_abba?(w)
        #     s = true
        #     break
        # end
        aba1 << get_abas(w)
    end
    aba2 = []
    should_not.each do |w|
        # part 1
        # if is_abba?(w)
        #     n = true
        #     break
        # end
        aba2 << get_abas(w)
    end
    # if s and !n
    #     c += 1
    # end

    aba1.flatten.each do |a|
        aba2.flatten.each do |b|
            if a[0] == b[1] && b[0] == a[1]
                c = 1
            end
        end
    end
    b += c
    c = 0
    should = []
    should_not = []
    str = ""
end
p b
