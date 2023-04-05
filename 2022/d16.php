<?php

$input = "AA;0;DD, II, BB
BB;13;CC, AA
CC;2;DD, BB
DD;20;CC, AA, EE
EE;3;FF, DD
FF;0;EE, GG
GG;0;FF, HH
HH;22;GG
II;0;AA, JJ
JJ;21;II";


$input = explode("\n", $input);

foreach ($input as $val) {
    $data = explode(";", $val);
    $valve = $data[0];
    $flow = intval($data[1]);
    $connections = explode(",", $data[2]);

    var_dump($valve);
    var_dump($flow);
    var_dump($connections);
}


# I have made drawings lol
