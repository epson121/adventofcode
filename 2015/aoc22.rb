# input
# Hit Points: 55
# Damage: 8


# spell             cost       Damage       heal        mana        armor       turns
# magic missile     53          4           0           0           0           0
# drain             73          2           2           0           0           0
# shield            113         0           0           0           7           6
# poison            173         3           0           0           0           3
# recharge          229         0           0           101         0           5


# 1 shield + 2 poison + 5 missile
# 52 damage + 6 hit points


spells = {
    "mm"        => {
        "name"          => "mm",
        "cost"          => 53,
        "damage"        => 4,
        "instant"       => 1
    },
    "drain"     => {
        "name"          => "drain",
        "cost"          => 73,
        "damage"        => 2,
        "instant"       => 1,
        "hp_regen"      => 2
    },
    "shield"    => {
        "name"          => "shield",
        "cost"          => 113,
        "armor"         => 7,
        "lasts"         => 6,
    },
    "poison"    => {
        "name"          => "poison",
        "cost"          => 173,
        "damage"        => 3,
        "lasts"         => 6,
    },
    "recharge"    => {
        "name"          => "recharge",
        "cost"          => 229,
        "mana_regen"     => 101,
        "lasts"         => 5,
    },
    "skip"        => {
    }
}

player = {
    "hp"            => 50,
    "armor"         => 0,
    "mana"          => 500,
    "damage"        => 0
}

boss = {
    "hp"            => 55,
    "armor"         => 0,
    "damage"        => 8
}

# part 1
# cast_spells = ["recharge", "shield", "poison", "mm", "mm", "mm", "poison", "mm", "mm", "mm", "drain"]
# part 2
# cast_spells = ["poison", "recharge", "shield", "poison", "recharge", "drain", "poison", "drain", "mm"]
active_spells = {}

turn = 1
mana_spent = 0
cast_spells.each do |spell|

    # check if hp below zero
    if player["hp"] < 0 or boss["hp"] < 0
        p "Match has ended."
        p "Player " + player["hp"].to_s + " : Boss " + boss["hp"].to_s
        p "Mana spent: " + mana_spent.to_s
        exit
    end

    # HARD MODE
    player["hp"] -= 1

    # do active spells for player turn
    active_spells.each do |aspell, val|
        boss["hp"]  -= (spells[aspell]["damage"]) ? spells[aspell]["damage"] : 0
        player["mana"] += spells[aspell]["mana_regen"] ? spells[aspell]["mana_regen"] : 0
        player["armor"] += spells[aspell]["armor"] ? spells[aspell]["armor"] : 0
        if val - 1 > 0
            active_spells[aspell] -= 1
        else
            active_spells.delete(aspell)
        end
    end

    if player["hp"] < 0 or boss["hp"] < 0
        p "Match has ended."
        p "Player " + player["hp"].to_s + " : Boss " + boss["hp"].to_s
        p "Mana spent: " + mana_spent.to_s
        exit
    end

    p "Turn " + turn.to_s + " (player attacks): "

    # check mana for new spell
    if player["mana"] - spells[spell]["cost"] > 0
        p "Player casts " + spells[spell]["name"]
        player["mana"] -= spells[spell]["cost"]
        mana_spent += spells[spell]["cost"]
        if spells[spell]["instant"]
            boss["hp"]  -= (spells[spell]["damage"] > 0) ? spells[spell]["damage"] : 0
            player["hp"] += spells[spell]["hp_regen"] ? spells[spell]["hp_regen"] : 0
        else
            active_spells[spell] = spells[spell]["lasts"]
        end
    else
        p "Player tries to cast " + spells[spell]["name"] + " but has NO MANA"
    end

    p "Player: " + player["hp"].to_s + " Boss: " + boss["hp"].to_s
    p "Player has " + player["mana"].to_s + " mana"
    p "----------------------------"
    turn += 1

    p active_spells

    if player["hp"] < 0 or boss["hp"] < 0
        p "Match has ended."
        p "Player " + player["hp"].to_s + " : Boss " + boss["hp"].to_s
        p "Mana spent: " + mana_spent.to_s
        exit
    end

    # do active spells for boss turn
    active_spells.each do |aspell, val|
        boss["hp"]  -= (spells[aspell]["damage"]) ? spells[aspell]["damage"] : 0
        player["mana"] += spells[aspell]["mana_regen"] ? spells[aspell]["mana_regen"] : 0
        player["armor"] += spells[aspell]["armor"] ? spells[aspell]["armor"] : 0
        if val - 1 > 0
            active_spells[aspell] -= 1
        else
            active_spells.delete(aspell)
        end
    end

    if player["hp"] < 0 or boss["hp"] < 0
        p "Match has ended."
        p "Player " + player["hp"].to_s + " : Boss " + boss["hp"].to_s
        p "Mana spent: " + mana_spent.to_s
        exit
    end

    # remove players points
    player["hp"] -= (boss["damage"] - player["armor"]) > 0 ? (boss["damage"] - player["armor"]) : 1

    player["armor"] = 0
    p "Turn " + turn.to_s + "(boss attacks): "
    p "Player: " + player["hp"].to_s + " Boss: " + boss["hp"].to_s
    p "Player has " + player["mana"].to_s + " mana"
    p "-------------------------------------------"
    turn += 1
end

p "Mana spent: " + mana_spent.to_s

# 953  - correct
# 1289 - correct