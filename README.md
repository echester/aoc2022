# aoc2022
My tentative repo for whatever junk i create for [[aoc2022](https://adventofcode.com)]

## Day 1 - Calorie Counting
_"It's easy to be enthusiastic at this point."_

Assembling, sorting and slicing an array; classic opener for AoC.

## Day 2 - Rock Paper Scissors
_"It always starts deceptively easily. 'I can do this!' you may think, and you'll be right, for a while. How long for wholly depends on whether you have a real job, the school run, or simply - enough sleep to function properly."_

My first approach was to substitute characters for values:
```s/A/1/;
s/B/2/;
s/C/3/;
etc.
```
and use numeric comparison to increment scores. I stopped that because its unnecessary, and I failed to realise (no excuses) that rock beats scissors. Its a circle.

The better, working, solution was to realise that there are only ever 9 possible inputs, and each has a fixed score value independent of other lines. I moved the inputs into a hash, and the rest, is hashtory.
```
$t1 += $s1{$_};
```

## Day 3
