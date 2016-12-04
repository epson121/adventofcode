 buckets = [50,44,11,49,42,46,18,32,26,40,21,7,18,43,10,47,36,24,22,40]
#buckets = [1, 2, 3, 4]

can_fill = []
fill_amt = 150

$res = []
def combine active, bukets
    if bukets.length == 0
        $res << active
    else
        combine(active + [bukets[0]], bukets[1..bukets.length-1])
        combine(active, bukets[1..bukets.length-1])
    end
end

combine [], buckets
ok = []
minc = 100
minca = []
$res.each do |comb|
    if comb.inject(:+) == fill_amt
        if comb.length < minc
            minc = comb.length
            minca = [comb]
        elsif comb.length == minc
            minca << comb
        end
        # p comb
        ok << comb
    end
end


# p ok.length
p minca.length
p minc
p minca