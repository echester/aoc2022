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

## Day 3 - Rucksack Reorganization
_"A nice spot of ASCII arithmetic..."_

Done in a stupid rush on a way out to the wedding of my friend Tanya. Ugly; not cleaning it up.

## Day 4 - 
_"One of those that looks so easy in part 1, that you're designing a multi-depth hash
for part 2 from the get-go just in case. Turns out it wasn't needed either."_

I woke just after the puzzle release and saw that part 1 was very simple, just comparison of numbers pairwise ripped from the input. First attempt at part 2 i stumbled by finding all the NOT overlapping camp sections, and adding the fully overlapping sections from part 1. Flipped the logic using an _unless_ instead of _if_, removed the additional 'contained' sets, and there it is. Not much scope for cleaning up or refactoring.
Oh - and its happened - regex kicks things off nicely to extract the values. I bet python does this in a cleaner way and possibly has set, subset and propersubset methods, but colour me unbothered. 

OK, no, in fairness I am tempted to make a proper library function for this. Not happening today though. But since I've mentioned it, I'll put the only possibly reusable functions I've written so far in a package and add that to the repo. Likely need it exactly a year from now.

# Day 5 -
_" "_


