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

## Day 4 - Camp Cleanup
_"One of those that looks so easy in part 1, that you're designing a multi-depth hash
for part 2 from the get-go just in case. Turns out it wasn't needed either."_

I woke just after the puzzle release and saw that part 1 was very simple, just comparison of numbers pairwise ripped from the input. First attempt at part 2 i stumbled by finding all the NOT overlapping camp sections, and adding the fully overlapping sections from part 1. Flipped the logic using an _unless_ instead of _if_, removed the additional 'contained' sets, and there it is. Not much scope for cleaning up or refactoring.
Oh - and its happened - regex kicks things off nicely to extract the values. I bet python does this in a cleaner way and possibly has set, subset and propersubset methods, but colour me unbothered. 

OK, no, in fairness I am tempted to make a proper library function for this. Not happening today though. But since I've mentioned it, I'll put the only possibly reusable functions I've written so far in a package and add that to the repo. Likely need it exactly a year from now.

## Day 5 - Supply Stacks
_"Surely this is the first turning point..."_

I looked at this and thought Towers of Hanoi, and then thought 2 things - first: i can never remember how of Towers of Hanoi is supposed to work, and second: this isn't quite like that anyway. What this _is_, is just a list of lists, and we can push, pop and shift our way through them. The key is to look at the input vertically from the outset, which means mapping stuff into lists vertically while reading the input file horizontally. When we're done with all the moving around, we can just see what's on top.

The core of the work is just these 2 lines: pick up a crate, drop a crate.

```
my $movingCrate = shift @{$stacks[$from]};
unshift $stacks[$to]->@*, $movingCrate;
```		

## Day 6 - Tuning Trouble

_"Far too many ways to skin this particular elf-cat. Very much the
making of a mountain outfrom a molehill."_

I half-started 4 different ways of testing whether a string had any repeated characters before actually finishing any of them, and any of them would have been fine. I think the worrying about part 2 drives towards a generic and elegant solution to part 1, which can be a waste of time. Certainly was today.

- uniquified hash
- splitting to array and pop-then-test
- flexible match or smart match
- simple regex

Here's the cruncher:
```
my $count = () = $s =~ /\Q$c/g;
```
which i've dropped into a new package function called `countCharDupes()`.

## Day 7 - No Space Left On Device

not yet looked :-o

## Day 8 - Treetop Tree House

_"Well that was embarrassing... going to have to add comments in to stop this kind of fiasco next year..."_

I overthought this for multiple hours alongside normal work. The issue really was
that the description was correct and made sense, but left some room for different
interpretations of which trees were visible. A few more example cases would have nailed that early on. 
The outside-in visibility was straightforward and fast because i did an inelegant thing: replace visible trees by a visibility marker `v`, then count how many `v` I have at the end. This took moments. Then the day happened.
Then i came back to part 2 and started taking out my many conditions around previous height, previous tree, angle back to the treehouse, _et al._ and once it was grossly simple, it worked. I'd like to say 'lesson learned,' but that'd be a fib.
Because I did it in perl, and because i did it in an ugly-loopy way, there's no code interest here whatsoever, other than the usefulness of the perl way to deepcopy a 2D array, which is (slightly modded from code for readibility):

```
my @deep_copy_of_trees = map { [@$_] } @trees;
```
Bosh.

## Day 9 - Rope Bridge

_"... because throwing away part 1 was the right thing to do... "_

I started part 1 to asleep, too naïve, and did something fast that worked. For part 1.
Then the horrors hidden in part 2 clobbered me and I had to leave the thing alone all day (because real work). I took the logic in part 1 and started building functions that did the same thing. 
Instead of a tail following a head (only), i had a knot following a knot, and that took too long to get working (>1 hour :-o). Anyway, once that was done, it was a small step to make an array of N knots, and there it was. 
I've kept part 1 code here and separate so you can see how simplistic it was.
Retrospectively, I've commented everything in part 2, because sometimes that's helpful to others, or to really explain it to yourself and spot improvements.
There's an obvious improvement here: I was obsessed with arrays of ropes, each of which is an array of knots. We only need 1 rope, so a `map { }` would have been a good way forwards. Fact is - i'm not very confident using `map`. That's probably the thing I should learn before we get any more multidimensional horrors further into the jungle.
My favourite perl-ish things today were -
the so-called _spaceship operator_ `<=>`: here used to implement the sign() function:
```
shift() <=> 0
```
and also the postfix form of foreach, which I use to create the initial rope as a stack of knots:
```
push @rope, [0,0] foreach (0 .. shift() - 1);

```

## Day 10 - Cathode-Ray Tube

_"the ringing of horrendous, cracked bells of memory
as they bash against the broken screen of inscrutible,
inferior, infuriating, elvish technology"_

Part 1 of this was straightforward, though i made a false start by thinking the cycles overlapped (inputs lines = cycles). I was dealing with that by pushing values to a fifo and getting them out to accumulate into X a cycle later. Totally not relevant.

Part 2 has a bug still in it, but the output was legible enough. The first column of the CRT is shifted, and the first/last pixels seem broken. I am too tired to figure out why. This was good enough.

```
##....##.####.###..###..####.####..##..#
..#....#.#....#..#.#..#.#....#....#..#.#
..#....#.###..#..#.#..#.###..###..#....#
##.....#.#....###..###..#....#....#....#
.#..#..#.#....#.#..#....#....#....#..#.#
..#..##..####.#..#.#....####.#.....##...
```

## Day 11 - Monkey in the Middle


## Day 12 - Hill Climbing Algorithm

_"One of several unwritten rules of AdventOfCode is: 
there shall always come a day when the elves want you to have 
to look up how to code the Dijkstra algorithm. 
The sooner you learn this rule, if not the algorithm itself
(as. if.), the less disappointed you'll be
when that day comes. Regardless, you will still not
manage to properly package it and comment it ready for
next year. Loser."_

This is also the first problem that takes long enough to solve 
that it's interesting to know how long; timer added at the end.


## Day 13 - Distress Signal

## Day 14 - Regolith Reservoir

_"Sometimes even things that look simple and complete will try to lull you into a false  sense of security with their compelling and superficial visage. What they're really
doing is lulling you into the corner with a whisky. I came back to this a day later, with a prod from the community, to realise my $maxdepth thinking was faulty. All good now."_


Here's the line that fixed my previous mania wherein too much of my sand fell into the abyss...
```
$maxdepth = max($v1y, $v2y, $maxdepth);
```
... I'd previously only updated $maxdepth for vertical rock. Plum. So that was part 1 fixed, and part 2 is a surprisingly straightforward tweak. Which means tomorrow is going to be a serious headmess, because that's how AdventOfCode rolls. Dangit.

## Day 15 - Beacon Exclusion Zone

_"Per the prophency from Day 14, this day exponentially sucked."_


## Day 16 - 

_"Its that inflexion point near half-way in terms of gold stars; that uneasy twinge
that the rate at which you're falling behind is higher than the rate at which you ought to have done laundry and bought nourishment. Maybe the priorities were screwed up from the start. Maybe you can't plan. Maybe there are too many work related deadlines
festering in the corner of your mind, begging for time and attention. Its also damn
cold and sitting still coding is horrible. Ice inside the window again today."_


## Day 18 - Boiling Boulders

## Day 20 - Grove Positioning System

This was an unnervingly straightforward test. A linked list, or a simulation of one, without the need to actual manage links. 

## Day 21 - Monkey Math

_"For the first time in a long time, I see how to do this straight away."_

Part 1 pretty easy - repeated replacement of strings by values, and when only values remain, eval the expression, and keep going until the root monkey.
Part 2 however, remains a mystery.

The core is just two hashes, one which keeps calculated values, one which keeps expressions that still need sorting out. Both are indexed on monkey names.
```
# store relations
if (/(\D{4}):(\D{4}.+\D{4})/) { $rels{$1} = $2; }
# store values
elsif (/(\D{4}):([+-]?\d+)/) { $vals{$1} = $2; }
```

## Day 22 - 
