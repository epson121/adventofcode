

def three_vowels string
    vowels = ['a', 'e', 'i', 'o', 'u']
    count = 0
    string.each_char do |c|
        if vowels.include? c
            count += 1
        end
    end
    count >= 3 ? true : false
end

def letter_twice_in_a_row string
    for i in 1..string.length-1
        if string[i-1] == string[i]
            return true
        end
    end
    false
end

def no_specific_strings string
    disallowed_strings = ['ab', 'cd', 'pq', 'xy']
    disallowed_strings.each do |s|
        if string.match(/#{Regexp.quote(s)}/)
            return false
        end
    end
    true
end

def pair_of_letters string
    # string.each_char.with_index do |c, i|
    for i in 0..string.length-2
        s1 = string[i..i+1]
        for ni in i+2..string.length-2
            s2 = string[ni..ni+1]
            if s1 == s2
                return true
            end
        end
    end
    false
end



def repeating_letter string
    for i in 0..string.length-3
        s1 = string[i]
        s2 = string[i+2]
        if s1 == s2
            return true
        end
    end
    false
end



# p three_vowels "ababab"
# p three_vowels "ababb"

# p letter_twice_in_a_row "ajskllasd"
# p letter_twice_in_a_row "ajsklasd"

# p no_specific_strings "aahhjsdlsdxy"
# p no_specific_strings "aahhjsdlsdxc"

p pair_of_letters "ieodomkazucvgmuy"
p pair_of_letters "qjhvhtzxzqqjkmpb"

p repeating_letter "xxyxx"
p repeating_letter "uurcxstgmygtbstg"


def is_nice string
    # nice_characteristics = [method(:three_vowels), method(:letter_twice_in_a_row), method(:no_specific_strings)]
    nice_characteristics = [method(:pair_of_letters), method(:repeating_letter)]
    return nice_characteristics.all? { |characteristic| characteristic.call(string) }
end

# p is_nice 'ugknbfddgicrmopn'
# p is_nice 'dvszwmarrgswjxmb'

file = File.new("nice_strings.txt", "r")
nice_strings = []
while (line = file.gets)
    if is_nice line
        nice_strings << line
    end
end
file.close


p nice_strings
p nice_strings.length

