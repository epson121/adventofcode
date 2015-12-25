# Sprinkles: capacity 5, durability -1, flavor 0, texture 0, calories 5
# PeanutButter: capacity -1, durability 3, flavor 0, texture 0, calories 1
# Frosting: capacity 0, durability -1, flavor 4, texture 0, calories 6
# Sugar: capacity -1, durability 0, flavor 0, texture 2, calories 8

$ingredients = ["Sprinkles", "PeanutButter", "Frosting", "Sugar"]
$ingredients_count = {"Sprinkles" => 100, "PeanutButter" => 0, "Frosting" => 0, "Sugar" => 0}
$vals = {
    "Sprinkles" => {
        "capacity"    => 5,
        "durability"  => -1,
        "flavor"      => 0,
        "texture"     => 0,
        "calories"    => 5
    },
    "PeanutButter" => {
        "capacity"    => -1,
        "durability"  => 3,
        "flavor"      => 0,
        "texture"     => 0,
        "calories"    => 1
    },
    "Frosting" => {
        "capacity"    => 0,
        "durability"  => -1,
        "flavor"      => 4,
        "texture"     => 0,
        "calories"    => 6
    },
    "Sugar" => {
        "capacity"    => -1,
        "durability"  => 0,
        "flavor"      => 0,
        "texture"     => 2,
        "calories"    => 8
    }
}

a = [100, 0]

a1 = 1.step(100, 1).to_a
a2 = 1.step(100, 1).to_a
a3 = 1.step(100, 1).to_a
a4 = 1.step(100, 1).to_a

fours = []
threes = []

# all four - 0
a1.each do |a1|
    a2.each do |a2|
        a3.each do |a3|
            a4.each do |a4|
                if a1 + a2 + a3 + a4 == 100
                    fours << [a1, a2, a3, a4]
                end
            end
        end
    end
end

# a1.each do |a1|
#     a2.each do |a2|
#         a3.each do |a3|
#             if a1 + a2 + a3 == 100
#                 threes << [a1, a2, a3]
#             end
#         end
#     end
# end

# twos = []

# a1.each do |a1|
#     a2.each do |a2|
#         if a1 + a2 == 100
#             twos << [a1, a2]
#         end
#     end
# end

$maxprod = 0
$maxcomb = 0
def get_sum comb, vals, indices
    cap = 0
    dur = 0
    flav = 0
    tex = 0
    cals = 0
    vals.each.with_index do |(k, v), index|
        # if indices.include? index
            cap     += comb[index] * v["capacity"]
            dur     += comb[index] * v["durability"]
            flav    += comb[index] * v["flavor"]
            tex     += comb[index] * v["texture"]
            cals    += comb[index] * v["calories"]
        # end
    end
    p [cap, dur, flav, tex]
    cap = cap < 0 ? 0 : cap
    dur = dur < 0 ? 0 : dur
    flav = flav < 0 ? 0 : flav
    tex = tex < 0 ? 0 : tex
    if cals != 500
        return 0
    end
    prod = cap * dur * flav * tex
    return prod
end

# p fours[0]
# p get_sum fours[0]
# p fours[1]
# p get_sum fours[1]
# p fours[2]
# p get_sum fours[2]

# fours.each do |comb|
#     p comb
# end

a = 0
fours.each do |comb|
    p comb
    p = get_sum comb, $vals, [0, 1, 2, 3]
    if p > a
        a = p
    end
end

p a