
def caesar_cipher(string, shift = 1)
  alphabet   = Array('a'..'z')
  encrypter  = Hash[alphabet.zip(alphabet.rotate(shift))]
  string.chars.map { |c| encrypter.fetch(c, " ") }
end

# file = File.new("04-test.txt", "r")
file = File.new("04.txt", "r")
sum = 0
while (line = file.gets)
    room = line.split("-").map{|e| e.strip}
    room_string = room[0..room.length-2].join.split("").group_by{ |c| c }.map {|k, v| [k, v.length]}.sort_by {|k,v| v}.reverse.group_by{|k, v| v}.map {|k, v| v.sort_by{|k,v|k}}.flatten
    room_string -= [1, 2, 3, 4, 5, 6, 7, 8, 9]
    room_string = room_string.join("")
    cs = room[-1].match(/(^.*)\[(.*)\]/i).captures
    number = cs[0].to_i
    checksum = cs[1]
    if checksum == room_string.slice(0, checksum.length)
        str =  caesar_cipher(line, number).join
        if str.index("obj") != nil
            p str
            p number
        end
    end
end