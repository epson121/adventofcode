<?php

$input = "3;4;4,8;2,10
3;4;4,19;4,11
4;4;4,18;4,9
4;4;2,14;4,15
4;3;3,18;4,8
3;3;3,9;3,7
4;3;2,14;4,11
4;4;2,12;3,15
3;4;3,12;3,17
3;4;4,19;2,14
3;3;2,20;3,18
2;4;4,15;2,20
4;4;4,5;3,7
4;4;4,17;2,13
2;4;2,20;3,15
2;4;3,19;4,8
2;3;3,8;3,20
3;4;3,16;3,14
2;3;2,14;3,8
4;4;2,18;4,20
4;4;3,14;4,15
2;4;4,18;2,11
4;3;3,11;4,7
4;4;4,12;3,8
4;3;2,7;3,8
3;3;2,11;2,19
2;3;2,14;3,20
2;4;2,16;4,12
3;3;3,6;2,16
3;3;2,13;3,12";

$input = "3;4;4,8;2,10
3;4;4,19;4,11
4;4;4,18;4,9";

//$input = "4;2;3,14;2,7
//2;3;3,8;3,12";
//
//$input = "4;2;3,14;2,7";

$input = explode("\n", $input);
$max_geods = 0;
$sum = 0;
foreach ($input as $k => $blueprint) {
    $data = explode(";", $blueprint);
    $cost['ore'] = intval($data[0]);
    $cost['clay'] = intval($data[1]);
    $dobs = explode(",", $data[2]);
    $cost['obsidian'] = [intval($dobs[0]), intval($dobs[1])];
    $dgeo = explode(",", $data[3]);
    $cost['geode'] = [intval($dgeo[0]), intval($dgeo[1])];

    $robots_owned = [
        'ore' => 1,
        'clay' => 0,
        'obsidian' => 0,
        'geode' => 0
    ];

    $inventory = [
        'ore' => 0,
        'clay' => 0,
        'obsidian' => 0,
        'geode' => 0
    ];

    $candidates = get_candidates($inventory, $cost);

    start(1, $inventory, $robots_owned, $cost, $candidates);
    echo "Blueprint " . (intval($k) + 1) . "  ";
    echo "MAX: " . $max_geods . "\n";
    $sum += ($k+1) * $max_geods;
    $max_geods = 0;
}

echo "SUM: " . $sum;
$max_minutes = 32;
function start($minute, $inventory, $robots_owned, $cost, $candidates ) {
    global $max_geods;
    if ($minute == 33) {
        return $inventory['geode'];
    }

    foreach ($candidates as $buy) {
        $buy = array_keys($buy);

        if ($minute > 22 && $buy[0] == 'ore') {
            continue;
        }
        else if ($minute > 28 && $buy[0] == 'clay') {
            continue;
        }
        else if ($minute > 30 && $buy[0] == 'obsidian') {
            continue;
        }
//
//        if ($minute > 27 && ($buy[0] != 'geode' || $buy[0] != 'wait')) {
//            continue;
//        }

        $inv = tick($inventory, $robots_owned, $buy, $cost);
        $ro = get_robots_owned($robots_owned, $buy);

//        if (abs($ro['geode'] - $max_geods) < abs($minute - 32) * $ro['geode']) {
//            continue;
//        }

        $cds = get_candidates($inv, $cost);

        $r = start($minute + 1, $inv, $ro, $cost, $cds);
        if ($r > $max_geods) {
            $max_geods = $r;
            echo $max_geods . " ";
        }
//        if ($minute == 32) {
//            if ($r > $max_geods) {
//                $max_geods = $r;
//            }
//        }
    }

    return "-";
}

function get_robots_owned($r, $buy) {
    if ($buy[0] != 'wait') {
        $r[$buy[0]] += 1;
    }
    return $r;
}
function tick($inventory, $robots_owned, $buy, $cost) {
    $inventory['ore'] += $robots_owned['ore'];
    $inventory['clay'] += $robots_owned['clay'];
    $inventory['obsidian'] += $robots_owned['obsidian'];
    $inventory['geode'] += $robots_owned['geode'];

    // purchase
    if ($buy[0] != 'wait') {
        if ($buy[0] == 'ore') {
            $inventory['ore'] -= $cost['ore'];
        } else if ($buy[0] == 'clay') {
            $inventory['ore'] -= $cost['clay'];
        } else if ($buy[0] == 'obsidian') {
            $inventory['ore'] -= $cost['obsidian'][0];
            $inventory['clay'] -= $cost['obsidian'][1];
        } else if ($buy[0] == 'geode') {
            $inventory['ore'] -= $cost['geode'][0];
            $inventory['obsidian'] -= $cost['geode'][1];
        }
    }

    return $inventory;
}

function get_candidates($inventory, $cost) {
    $candidates = [];

    if ($cost['geode'][0] <= $inventory['ore'] && $cost['geode'][1] <= $inventory['obsidian']) {
        $candidates[] = ['geode' => 1];
        return $candidates;
    }

    if (count($candidates) == 0) {
        $candidates[] = ['wait' => 0];
    }

    if ($cost['obsidian'][0] <= $inventory['ore'] && $cost['obsidian'][1] <= $inventory['clay']) {
        $candidates[] = ['obsidian' => 1];
        return $candidates;
    }

    if ($cost['clay'] <= $inventory['ore']) {
        $candidates[] = ['clay' => 1];
    }

    if ($cost['ore'] <= $inventory['ore']) {
        $candidates[] = ['ore' => 1];
    }

    return $candidates;
}
