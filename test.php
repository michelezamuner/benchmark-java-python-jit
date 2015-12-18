<?php
function currentTimeMillis()
{
  return (int)round(microtime(true) * 1000);
}

define('MOD', 1000000);
define('TOT', MOD * 10);
define('START', currentTimeMillis());

$current = 0;

for ($i = 0; $i < TOT; $i++) {
  if ($i % MOD === 0) {
    $newcurrent = (currentTimeMillis() - START) / 1000;
    if (isset($argv[1])) echo ($newcurrent - $current) . PHP_EOL;
    $current = $newcurrent;
  }
}

echo PHP_EOL;

define('END', currentTimeMillis());

echo 'Elapsed: ' . (END - START) . PHP_EOL;
