<?php

$input = "3907621, 2895218: 3790542, 2949630
1701067, 3075142: 2275951, 3717327
3532369, 884718: 2733699, 2000000
2362427, 41763: 2999439, -958188
398408, 3688691: 2275951, 3717327
1727615, 1744968: 2733699, 2000000
2778183, 3611924: 2275951, 3717327
2452818, 2533012: 2733699, 2000000
88162, 2057063: -109096, 390805
2985370, 2315046: 2733699, 2000000
2758780, 3000106: 3279264, 2775610
3501114, 3193710: 3790542, 2949630
313171, 1016326: -109096, 390805
3997998, 3576392: 3691556, 3980872
84142, 102550: -109096, 390805
3768533, 3985372: 3691556, 3980872
2999744, 3998031: 3691556, 3980872
3380504, 2720962: 3279264, 2775610
3357940, 3730208: 3691556, 3980872
1242851, 838744: -109096, 390805
3991401, 2367688: 3790542, 2949630
3292286, 2624894: 3279264, 2775610
2194423, 3990859: 2275951, 3717327";
//
//$input = "2, 18: -2, 15
//9, 16: 10, 16
//13, 2: 15, 3
//12, 14: 10, 16
//10, 20: 10, 16
//14, 17: 10, 16
//8, 7: 2, 10
//2, 0: 2, 10
//0, 11: 2, 10
//20, 14: 25, 17
//17, 20: 21, 22
//16, 7: 15, 3
//14, 3: 15, 3
//20, 1: 15, 3";


$input = explode("\n", $input);

$data = [];
$lowestx = 9999;
$lowesty = 9999;
$hightestx = 0;
$highesty = 0;



foreach ($input as $sb) {

    $sb = explode(":", $sb);

    $sensor = explode(",", $sb[0]);
    $beacon = explode(",", $sb[1]);

    $lowestx = (intval($sensor[0]) < $lowestx) ? intval($sensor[0]) : $lowestx;
    $lowestx = (intval($beacon[0]) < $lowestx) ? intval($beacon[0]) : $lowestx;
    $lowesty = (intval($sensor[1]) < $lowesty) ? intval($sensor[1]) : $lowesty;
    $lowesty = (intval($beacon[1]) < $lowesty) ? intval($beacon[1]) : $lowesty;

    $hightestx = (intval($sensor[0]) > $hightestx) ? intval($sensor[0]) : $hightestx;
    $hightestx = (intval($beacon[0]) > $hightestx) ? intval($beacon[0]) : $hightestx;
    $highesty = (intval($sensor[1]) > $highesty) ? intval($sensor[1]) : $highesty;
    $highesty = (intval($beacon[1]) > $highesty) ? intval($beacon[1]) : $highesty;

    $dis = manhattan_distance($sensor, $beacon);

    $data[] = [
        'sensor' => $sensor,
        'beacon' => $beacon,
        'distance' => $dis
    ];

    #echo manhattan_distance($sensor, $beacon) . "\n";
}


echo $lowestx . "\n";
echo $lowesty . "\n";
echo $hightestx . "\n";
echo $highesty . "\n";

$found = false;
$no_beacon = 0;
$y = 10;
#$offset = 2000000;
$offset = 0;

//for ($i = $lowestx - $offset; $i < $hightestx + $offset; $i++) {
//    foreach ($data as $bs) {
//        if ($bs['beacon'][0] == $i && $bs['beacon'][1] == $y) {
//            $found = "B";
//            break;
//        }
//        if ($bs['sensor'][0] == $i && $bs['sensor'][1] == $y) {
//            $found = "S";
//            break;
//        }
//        if (manhattan_distance([$i, $y], $bs['sensor']) <= $bs['distance']) {
//            $found = ".";
//            break;
//        }
//    }
//
//    # no break, just count
//    if ($found && $found == ".") {
//        $no_beacon += 1;
//        #echo "No Beacon on: " . $i . "\n";
//    } else if ($found && $found == "B") {
//        #echo "Found Beacon at: " . $i . "\n";
//    }
//
//    $found = false;
//
//}

$max = 4000000;
//$max = 2000000;
$candidates = [];
$c = 1;
foreach ($data as $bs) {
    $bx = $bs['sensor'][0];
    $by = $bs['sensor'][1];
    $d = $bs['distance'];

    echo "Sensor: $c";
    $c++;

    for ($x = max(0, min($bx-$d-1, $max)); $x < max(0, min($bx+$d+1, $max)); $x++) {
        for ($y = max(0, min($by-$d-1, $max)); $y < max(0, min($by+$d+1, $max)); ) {
            $mmd = manhattan_distance([$x, $y], [$bx, $by]);
            $dd = $d+1;

            if (manhattan_distance([$x, $y], [$bx, $by]) == ($d+1)) {
                    $candidates[] = [$x, $y];
            }

            $diff1 = $mmd - $dd;
            $diff = abs($mmd-$dd);

//            if ($diff1 < 0 && $diff > 1) {
//                $y += $diff;
//            } else if ($diff1 > 0 && $diff > 1 ) {
//                $y += $diff;
//            } else {
//                $y += 1;
//            }

            if ($diff > 1) {
                $y += $diff;
            } else {
                $y+= 1;
            }

        }
    }

    foreach ($candidates as $candidate) {
        foreach ($data as $bs) {
            $sx = $bs['sensor'][0];
            $sy = $bs['sensor'][1];

            $md = manhattan_distance([$candidate[0], $candidate[1]], [$sx, $sy]);
            if ($md <= $bs['distance']) {
                $found = true;
                break;
            }
        }

        if (!$found) {
            var_dump($candidate);
            exit;
        }

        $found = false;
    }

    $candidates = [];

}

# 4000000 * 3138881 + 3364986
# sol = 12555527364986

$found = false;
foreach ($candidates as $candidate) {
    foreach ($data as $bs) {
        $sx = $bs['sensor'][0];
        $sy = $bs['sensor'][1];

//        if ($candidate[0] == 14 && $candidate[1] == 11) {
//            echo "MD: " . manhattan_distance([$x, $y], [$sx, $sy]) . "\n";
//            echo "D: " . $bs['distance'] . "\n";
//        }

//        if ($candidate[0] == 0 && $candidate[1] == 24) {
//            echo "MD: " . manhattan_distance([$x, $y], [$sx, $sy]) . "\n";
//            echo "D: " . $bs['distance'] . "\n";
//        }

        $md = manhattan_distance([$candidate[0], $candidate[1]], [$sx, $sy]);
        if ($md <= $bs['distance']) {
            $found = true;
            break;
        }
    }

    if (!$found) {
        var_dump($candidate);
        break;
    }

    $found = false;
}


exit;


$max = 20;

$map = array_fill(0, $max, array_fill(0, $max, "."));

$nox = false;
$noy = false;

#part 2
for ($x = 0; $x < ($max); $x++) {
    if ($x % 100 == 0) {
        echo "X: " . $x . "\n";
    }
    # check the perimeter - but how?
    for ($y = 0; $y < ($max); $y++) {

        foreach ($data as $bs) {
            $bx = $bs['beacon'][0];
            $by = $bs['beacon'][1];
            $sx = $bs['sensor'][0];
            $sy = $bs['sensor'][1];

            $md = manhattan_distance([$x, $y], [$sx, $sy]);
            if ($md <= $bs['distance']) {
                $found = ".";
                break;
            }
        }
        # no break, just count
        if ($found && $found == ".") {
            $no_beacon += 1;
        }

        if (!$found) {
            echo "NOT FOUND ON: (" . $x . ", " . $y . ")";
            $nox = $x;
            $noy = $y;
            break;
        }

        $found = false;
    }

    if ($nox != false) {
        break;
    }
}

if ($nox > 0) {
    $res = $x * 4000000 + $y;
    echo "\nResult: $res.";
}

#echo "No sensors found for position: (" . $i . ", " . $y . ").";

#echo "No beacons for: " . $no_beacon . " places in the row.";




function manhattan_distance($p1, $p2) {
    $x1 = intval($p1[0]);
    $x2 = intval($p2[0]);

    $y1 = intval($p1[1]);
    $y2 = intval($p2[1]);

    $distance = abs($x1-$x2) + abs($y1-$y2);

    return $distance;
}
