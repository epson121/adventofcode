<?php

$monkeys = "0:
  99, 67, 92, 61, 83, 64, 98
  old * 17
  3
  4
  2

1:
  78, 74, 88, 89, 50
  old * 11
  5
  3
  5

Monkey 2:
  98, 91
  old + 4
  2
  6
  4

Monkey 3:
  59, 72, 94, 91, 79, 88, 94, 51
  old * old
  13
  0
  5

Monkey 4:
  95, 72, 78
  old + 7
  11
  7
  6

Monkey 5:
  76
  old + 8
  17
  0
  2

Monkey 6:
  69, 60, 53, 89, 71, 88
  old + 5
  19
  7
  1

Monkey 7:
  72, 54, 63, 80
  old + 3
  7
  1
  3";

//$monkeys = "0:
//  79, 98
//  old * 19
//  23
//  2
//  3
//
//1:
//  54, 65, 75, 74
//  old + 6
//  19
//  2
//  0
//
//2:
//  79, 60, 97
//  old * old
//  13
//  1
//  3
//
//3:
//  74
//  old + 3
//  17
//  0
//  1";

$monkeys = explode("\n\n", $monkeys);

$monks = [];

foreach ($monkeys as $monkey) {
    preg_match("((\d+):\s\s\s((\d+,?\s)+)\s\s(.*)\s\s\s(\d*)\s\s(\d*)\s(\d*)\s\s\s(\d*))" ,$monkey, $matches);
    $items = explode(",", $matches[2]);
    $cleaned = [];
    foreach ($items as $item) {
        $cleaned[] = intval(trim($item));
    }
    $monks[] = [
        'number' => trim($matches[1]),
        'items' => $cleaned,
        'formula' => trim($matches[4]),
        'test' => intval(trim($matches[5])),
        'throw_1' => intval(trim($matches[7])),
        'throw_2' => intval(trim($matches[8])),
        'count' => 0
    ];
}

$i = 0;
while($i < 10000) {
    echo "ROUND " . $i."!\n";
//    echo "#################";
//    foreach ($monks as $c => $monk) {
//        var_dump($monk['items']);
//    }
    $j = 0;
    while ($j < count($monks)) {
        $items = $monks[$j]['items'];
        while(true) {
            $res = 1;
            $item = array_shift($monks[$j]['items']);
            var_dump($item);
            if (!$item) {
                break;
            }
            $monks[$j]['count'] += 1;
            $formula = str_replace("old", $item, $monks[$j]['formula']);
            eval('$res =' . $formula . ";");

            $res = $res%9699690;
//            print "WORRY 2: " . $res . "\n";
            if ($res % $monks[$j]['test'] == 0) {
//                echo "Throw to Monkey " . $monk['throw_1'] . "\n";
                array_push($monks[$monks[$j]['throw_1']]['items'], $res);
            } else {
//                echo "Throw to Monkey " . $monk['throw_2'] . "\n";
                array_push($monks[$monks[$j]['throw_2']]['items'], $res);
            }
        }

        $monks[$j]['items'] = [];
        $j++;
    }

//    $canShrink = can_shrink($monks);
//
//    if ($canShrink) {
//        echo "SHRINKING: " . "\n";
//        $k = 0; $m = 0;
//        while ($k < count($monks)) {
//            echo "K " .  $k . "\n";
//            $its = $monks[$k]['items'];
//            if (count($its) > 0) {
//                echo "K " .  $k . "\n";
//                echo "M " .  $m . "\n";
//                while ($m < count($its)) {
//                    $monks[$k][$m] %= 96577;
//                    $m++;
//                }
//            }
//           $k++;
//            $m = 0;
//        }
//        foreach ($monks as $c => $monk) {
//            $items = $monk['items'];
//            foreach ($items as $i => $item) {
//                $monks[$c][$i] = $item % 96577;
//            }
//        }
//    }

//    foreach ($monks as $monk) {
//        var_dump($monk['items']);
//    }

    $i++;
}

function can_shrink($arr) {
    foreach ($arr as $c => $monk) {
        $items = $monk['items'];
        foreach ($items as $item) {
            if ($item < 96577) {
                return false;
            }
        }
    }
    return true;
}

$counts = [];
foreach ($monks as $c => $monk) {
    $counts[] = $monk['count'];
}


var_dump($counts);
rsort($counts);
var_dump($counts);

echo "\n" . $counts[0] * $counts[1];
