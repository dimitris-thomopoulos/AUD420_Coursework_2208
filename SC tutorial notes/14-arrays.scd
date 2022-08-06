s.volume.gui;

// Create some array
a = [10, 11, 12, 13, 14, 15, 16, 17];

a.reverse; // reverse
a.scramble; // scramble
a.choose; // picks one element at random
a.size; // returns size of array
a.at(0); // retrieves item at specified position
a[0] ; // same as above
a.wrapAt(9); // retrieves item at specified position, wrapping around if > a.size
["wow", 99] ++ a; // concatenates the two arrays into a new one
a ++ \hi; // a Symbol is a single character
a ++ 'hi'; // same as above
a ++ "hi"; // a String is a collection of characters
a.add(44); // creates new array with new element at the end
a.insert(5, "wow"); // inserts "wow" at position 5, pushes other items forward (returns new array)

// evaluate this and see that none of the above operations actually changed the original array:
a;

a.put(2, "oops"); // put "oops" at index 2 (destructive; evaluate line above again to check)
a.permute(3); // permute: item in position 3 goes to position 0, and vice-versa
a.mirror; // makes it a palindrome
a.powerset; // returns all possible combinations of the array's elements


// We can do math with arrays:

[1, 2, 3, 4, 5] + 10;
[1, 2, 3, 4, 5] * 10;
([1, 2, 3, 4, 5] / 7).round(0.01); // notice the parentheses for precedence
x = 11; y = 12; // try some variables
[x, y, 9] * 100;

// but make sure you only do math with proper numbers
[1, 2, 3, 4, "oops", 11] + 10; // strange result






// Ways of creating new arrays:

// Arithmetic series
Array.series(size: 6, start: 10, step: 3);

// Geometric series (the next number in the array is calculatd by multiplying the previous number with the number declared under the 'grow' argument)
Array.geom(size: 10, start: 1, grow: -4);

// Compare the two:
Array.series(7, 100, -10); // 7 items; start at 100, step of -10
Array.geom(7, 100, 0.9); // 7 items; start at 100; multiply by 0.9 each time

// Meet the .fill method
Array.fill(10, "same");

// Compare:
Array.fill(10, rrand(1, 10));
Array.fill(10, {rrand(1, 10)}); // function is re-evaluated 10 times

// The function for the .fill method can take a default argument that is a counter.
// The argument name can be whatever you want.
Array.fill(10, {arg counter; counter * 10});

// For example, generating a list of harmonic frequencies:
Array.fill(10, {arg wow; wow+1 * 440});

// The .newClear method
a = Array.newClear(7); // creates an empty array of given size
a[3] = "wow"; // same as a.put(3, "wow")





// Exclamation mark (!)
// It is a shortcut for creating an array that contains the same item a number of times:
30!4;  //  [30, 30, 30, 30]
"hello" ! 10;

// It gives the same results as the following:
30.dup(4);
"hello".dup(10);

// or
Array.fill(4, 30);
Array.fill(10, "hello");





// Two dots syntax

// What is this?
(50..79);

// It's a shortcut to generate an array with an arithmetic series of numbers.
// The above has the same result as:
series(50, 51, 79);

// or
Array.series(30, 50, 1);

// For a step different than 1, you can do this:
(50, 53 .. 79); // step of 3

// Same result as:
series(50, 53, 79);
Array.series(10, 50, 3);






// The 'do' message
// This message/method executes some action on every item of an array

~myFreqs = Array.fill(10, {rrand(440, 880)});

// Now let's do some simple action on every item of the list:
~myFreqs.do({arg item, count; ("Item " ++ count ++ " is " ++ item ++ " Hz. Closest midinote is " ++ item.cpsmidi.round).postln});

// If you don't need the counter, just use one argument:
~myFreqs.do({arg item; {SinOsc.ar(item, 0, 0.1)}.play});
~myFreqs.do({arg item; item.squared.postln});

// Of course something as simple as the last one could be done like this:
~myFreqs.squared;



