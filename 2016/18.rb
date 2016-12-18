
file = File.new("18-test.txt", "r")
file = File.new("18.txt", "r")
row = "." + file.gets + "."

# rows = [row]
i = 0
safes = row.count(".") - 2
cr = row
invalid = ["^^.", "^..", ".^^", "..^"]
(399999).times do |p|
    new_row = ["."]
    1.upto(row.length-2) do |idx|
        case 
            when !invalid.include?(cr[idx-1..idx+1])
            # when cr[idx-1..idx+1].match(/(\^\^\.|\^\.\.|\.\^\^|\.\.\^)/).nil?
                new_row << "."
            else
                new_row << "^"
        end
    end
    
    safes += new_row.count(".") - 1
    new_row << "."
    cr = new_row.join("")
    # rows << new_row.join("")
    i += 1
    # if i % 10000 == 0
    #     p i
    # end

end
# rows.each {|r| p r[1..r.length-2]}
# p rows.length
p safes