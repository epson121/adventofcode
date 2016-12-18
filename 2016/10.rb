
Bots = {}

file = File.new("09-test.txt", "r")
file = File.new("09.txt", "r")

commands = []

while (line = file.gets)
    if line.include?('value')
        data = line.split(" ")
        (Bots["bot_" + data[5]] ||= []).push(data[1].to_i)
    else
        commands << line
    end
end

while commands.length > 0
    commands.each do |command|

        data = command.split(" ")
        giver = "bot_" + data[1]
        r1 = data[5] + "_" + data[6]
        r2 = data[10] + "_" + data[11]

        if Bots[giver] == nil or Bots[giver] == [] or Bots[giver].length != 2
            next
        end

        sorted = Bots[giver].sort!
        low, high = sorted

        if [low, high] == [17, 61]
            p giver
        end

        (Bots[r1] ||= []).push(low)
        (Bots[r2] ||= []).push(high)
        Bots[giver] = []

        commands.delete(command)
    end
end

p Bots["output_0"][0] * Bots["output_1"][0] * Bots["output_2"][0]