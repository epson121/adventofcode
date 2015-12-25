
$WIRES = {}

def do_regular data
    if data[1].to_i.to_s == data[1]
        data[1] = data[1].to_i
        $WIRES[data[2]] = data[1]
        return true
    else
        if $WIRES[data[1]].nil?
            return false
        else
            $WIRES[data[2]] = $WIRES[data[1]]
            return true
        end
    end
end

def do_not data
    if ($WIRES[data[1]].nil?)
        return false
    end
    $WIRES[data[2]] = 65535 - $WIRES[data[1]]
    true
end

def do_and data
    if ($WIRES[data[1]].nil?)
        return false
    end
    if ($WIRES[data[2]].nil?)
        return false
    end
    $WIRES[data[3]] = $WIRES[data[1]] & $WIRES[data[2]]
    true
end

def do_or data
    if ($WIRES[data[1]].nil?)
        return false
    end
    if ($WIRES[data[2]].nil?)
        return false
    end
    $WIRES[data[3]] = $WIRES[data[1]] | $WIRES[data[2]]
    true
end

def do_lshift data
    if ($WIRES[data[1]].nil?)
        return false
    end
    $WIRES[data[3]] = $WIRES[data[1]] << data[2]
    true
end

def do_rshift data
    if ($WIRES[data[1]].nil?)
        return false
    end
    $WIRES[data[3]] = $WIRES[data[1]] >> data[2]
    true
end

#and i or
def get_data1 line, operator
    data = /(\w+)\s#{Regexp.quote(operator)}\s(\w+)\s->\s(\w+)/.match(line).to_a
end

# shifts
def get_data2 line, operator
    data = /(\w+)\s#{Regexp.quote(operator)}\s(\w+)\s->\s(\w+)/.match(line).to_a.map.with_index { |e, i| i == 2 ? e.to_i : e}
end

def get_reg line
    # data = /(.+)\s->\s(\w+)/.match(line).to_a.map.with_index { |e, i| i == 1 ? e.to_i : e }
    data = /(.+)\s->\s(\w+)/.match(line).to_a
end

# file = File.new("aov7_test.txt", "r")
# file = File.new("aoc7_input_small.txt", "r")

lines_done = []
c = 1
30.times do
    file = File.new("aoc7_input.txt", "r")
    while (line = file.gets)
        if lines_done.include? c
            c+=1
            next
        end
        if /AND/.match(line)
            data = get_data1 line, 'AND'
            if do_and data
                lines_done << c
            end
        elsif /OR/.match(line)
            data = get_data1 line, 'OR'
            if do_or data
                lines_done << c
            end
        elsif /LSHIFT/.match(line)
            data = get_data2 line, 'LSHIFT'
            if do_lshift data
              lines_done << c
            end
        elsif /RSHIFT/.match(line)
            data = get_data2 line, 'RSHIFT'
            if do_rshift data
              lines_done << c
            end
        elsif /NOT/.match(line)
            data = /NOT\s(\w+)\s->\s(\w+)/.match(line).to_a
            if do_not data
              lines_done << c
            end
        else
            data = get_reg line
            if do_regular data
                lines_done << c
            end
        end
        c += 1
    end
    p lines_done
    file.close
    c = 1
end
    p lines_done

p $WIRES
p $WIRES['a']