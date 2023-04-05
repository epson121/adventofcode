<?php

$cycles = "noop
noop
noop
addx 4
addx 1
addx 5
addx 1
addx 5
noop
addx -1
addx -6
addx 11
noop
noop
noop
noop
addx 6
addx 5
noop
noop
noop
addx -30
addx 34
addx 2
addx -39
noop
addx 5
addx 2
addx 19
addx -18
addx 2
addx 5
addx 2
addx 3
noop
addx 2
addx 3
noop
addx 2
addx 3
noop
addx 2
addx 3
noop
addx 2
addx -15
addx -22
noop
noop
addx 5
addx 2
noop
noop
addx 14
addx -11
addx 5
addx 2
addx 3
noop
addx 2
addx -16
addx 17
addx 2
addx 5
addx 2
addx -6
addx -25
addx 35
addx 1
addx -36
addx 1
addx 22
addx -19
addx 5
addx 2
noop
noop
addx 5
noop
noop
noop
addx 1
addx 4
noop
noop
noop
addx 5
noop
addx 1
addx 2
addx 3
addx 4
addx -34
addx 21
addx -24
addx 2
addx 5
addx 7
addx -6
addx 2
addx 30
addx -23
addx 10
addx -9
addx 2
addx 2
addx 5
addx -12
addx 13
addx 2
addx 5
addx 2
addx -12
addx -24
addx -1
noop
addx 3
addx 3
addx 1
addx 5
addx 21
addx -16
noop
addx 19
addx -18
addx 2
addx 5
addx 2
addx 3
noop
addx 3
addx -1
addx 1
addx 2
addx -18
addx 1
noop";

//$cycles = "addx 15
//addx -11
//addx 6
//addx -3
//addx 5
//addx -1
//addx -8
//addx 13
//addx 4
//noop
//addx -1
//addx 5
//addx -1
//addx 5
//addx -1
//addx 5
//addx -1
//addx 5
//addx -1
//addx -35
//addx 1
//addx 24
//addx -19
//addx 1
//addx 16
//addx -11
//noop
//noop
//addx 21
//addx -15
//noop
//noop
//addx -3
//addx 9
//addx 1
//addx -3
//addx 8
//addx 1
//addx 5
//noop
//noop
//noop
//noop
//noop
//addx -36
//noop
//addx 1
//addx 7
//noop
//noop
//noop
//addx 2
//addx 6
//noop
//noop
//noop
//noop
//noop
//addx 1
//noop
//noop
//addx 7
//addx 1
//noop
//addx -13
//addx 13
//addx 7
//noop
//addx 1
//addx -33
//noop
//noop
//noop
//addx 2
//noop
//noop
//noop
//addx 8
//noop
//addx -1
//addx 2
//addx 1
//noop
//addx 17
//addx -9
//addx 1
//addx 1
//addx -3
//addx 11
//noop
//noop
//addx 1
//noop
//addx 1
//noop
//noop
//addx -13
//addx -19
//addx 1
//addx 3
//addx 26
//addx -30
//addx 12
//addx -1
//addx 3
//addx 1
//noop
//noop
//noop
//addx -9
//addx 18
//addx 1
//addx 2
//noop
//noop
//addx 9
//noop
//noop
//noop
//addx -1
//addx 2
//addx -37
//addx 1
//addx 3
//noop
//addx 15
//addx -21
//addx 22
//addx -6
//addx 1
//noop
//addx 2
//addx 1
//noop
//addx -10
//noop
//noop
//addx 20
//addx 1
//addx 2
//addx 2
//addx -6
//addx -11
//noop
//noop
//noop";

//$cycles = "noop
//addx 3
//addx -5
//addx 1
//noop
//noop
//addx 1
//addx 1";

$cycles = explode("\n", $cycles);

$x = 1;

$strengths = 0;
$special_cycles = [20, 60, 100, 140, 180, 220, 260];

$toAdd = [0];
$c = 1;
$draw = [];
foreach ($cycles as $cycle) {

//    echo "C: " . $c . "\n";
//    echo "X: " . $x . "\n";

    echo "X - C: " . ($x - ($c%40)) . "\n";
    $row = floor($c/40);

    if (in_array($c, $special_cycles)) {
        $strengths += $x * $c;
    }

    if (abs(($c%40)-$x) <= 1) {
        $draw[] = $c;
    }

    preg_match("/([a-z]*)\s?(-?\d*)$/", $cycle, $matches);
    if ($matches[0] && $matches[1] == "noop") {
        // do nothing
    }

    if ($matches[0] && $matches[1] == "addx") {

        $c++;

        echo "X - C: " . ($x - ($c%40)) . "\n";



        if (in_array($c, $special_cycles)) {
            $strengths += $x * $c;
        }

        $x += intval($matches[2]);

        if (abs(($c%40)-$x) <= 1) {
            $draw[] = $c;
        }

    }


    $c++;
}

var_dump($draw);


for ($i = 1; $i < 7; $i++) {
    for ($j = 1; $j < 41; $j++) {
        $c = 40 * ($i - 1) + $j;
        if (in_array($c, $draw)) {
            echo " # ";
        } else {
            echo " . ";
        }
    }
    echo "\n";
}


//if (in_array($c, $special_cycles)) {
//    $strengths += $x * $c;
//}
//$x += array_shift($toAdd);

var_dump($strengths);
//echo $x;
