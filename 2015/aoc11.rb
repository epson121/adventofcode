def generate_next_password password
    p = password.reverse
    update = false
    p.each_with_index do |elem, i|
        if update
            if p[i] < 122
                p[i] += 1
                update = false
                break
            else
                p[i] = 97
                update = true
                next
            end
        end
        if p[i] < 122
            p[i] += 1
            break
        else
            p[i] = 97
            update = true
        end
    end
    p.reverse
end

def three_in_a_row string
    # string.each_char.with_index do |c, i|
    for i in 0..string.length-3
        s1 = string[i]
        s2 = string[i+1]
        s3 = string[i+2]
        if (s1.succ == s2 && s2.succ == s3)
            return true
        end
    end
    false
end

def no_specific_strings string
    disallowed_strings = ['i', 'o', 'l']
    disallowed_strings.each do |s|
        if string.match(/#{Regexp.quote(s)}/)
            return false
        end
    end
    true
end

def repeating_letter string
    count = 0
    used = []
    for i in 0..string.length-1
        s1 = string[i]
        s2 = string[i+1]
        if s1 == s2
            if used.include? s1
                next
            end
            used << s1
            count += 1
        end
    end
    count > 1 ? true : false
end

def is_valid password_array
    password_array.each_with_index do |e, i|
        password_array[i] = password_array[i].chr
    end
    p password_array.join
    valid_characteristics = [method(:three_in_a_row), method(:no_specific_strings), method(:repeating_letter)]
    return valid_characteristics.all? { |characteristic| characteristic.call(password_array.join) }
end

# current_password = "vzbxkgzz"
current_password = "vzbxxyzz"

current_password_array = []
current_password.each_char do |c|
    current_password_array << c.ord
end


# nice_strings = []
c = 0
while true
    current_password_array = generate_next_password current_password_array
    if is_valid current_password_array.clone
        p current_password_array
        break
    end
    # c += 1
    # if c > 100
    #     break
    # end
end