<?php
$nA = $_GET["nA"];
$nL = $_GET["nL"];
$A  = $_GET["A"];
$L  = $_GET["L"];

$nTask    = $_GET["nTask"];
$nProfile = $_GET["nProfile"];
$AttrRand = $_GET["AttrRand"];

//print_r($nA);
//print_r($nL);
//print_r($A);
//print_r($L);

$featurearray = array();

$k = 0;

for ($i = 0; $i < $nA; $i++) {
	//print($A[$i]);
	//print_r($nL[$i]);
	$featurearray[$A[$i]] = array_slice($L, $k, $nL[$i]);
	$k = $k + $nL[$i];
	//print($k);
}

if ($AttrRand == 1){
	shuffle($A);
}

$returnarray = array();

for ($i = 0; $i < $nTask; $i++) {
	for ($j = 0; $j < $nA; $j++) {
		$returnarray["F-".(string)($i + 1)."-".(string)($j + 1)] = $A[$j];
		for ($k = 0; $k < $nProfile; $k++) {
			for ($l = 0; $l < count($featurearray[$A[$j]]); $l++) {
				$temparray = $featurearray[$A[$j]];
				$returnarray["F-".(string)($i + 1)."-".(string)($k + 1)."-".(string)($j + 1)] = $temparray[array_rand($temparray)];
			}
		}
	}
}

//print_r($featurearray);
//print("<br/>");
print json_encode($returnarray);
?>