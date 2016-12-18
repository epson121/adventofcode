
file = File.new("18-test.txt", "r")
file = File.new("18.txt", "r")
row = "." + file.gets + "."

i = 0
safes = row.count(".") - 2
cr = row
invalid = ["^^.", "^..", ".^^", "..^"]
(399999).times do |p|
    new_row = ["."]
    1.upto(row.length-2) do |idx|
        case 
            when !invalid.include?(cr[idx-1..idx+1])
                new_row << "."
            else
                new_row << "^"
        end
    end
    
    safes += new_row.count(".") - 1
    new_row << "."
    cr = new_row.join("")
    i += 1

end
p safes