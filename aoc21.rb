# boss
# Hit Points: 104
# Damage: 8
# Armor: 1
# -----------
# not 93, not 91, not 87
# correct 78
# Longsword    40     7       0
# Damage +1    25     1       0
# Leather      13     0       1

# 10  0
# 9   1
# 8   2
# 7   3
# 6   4
# -------
# 2   8
# 3   7
# 4   6
# 5   5
# --------------------
# 104 99 94 89
# 100 95 90 85

s1 = 104
s2 = 100
while s1 > 0 do
    s1 -= 6
    s2 -= 6
    p "Robot: " + s1.to_s
    p "Player: " + s2.to_s
    p "------------"
end


# most
# 148
# Damage +3   100     3       0
# Dagger        8     4       0
# Defense +3   80     0       3