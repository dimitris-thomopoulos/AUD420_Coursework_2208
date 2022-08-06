// Environment variables
~galaApples = 4;
~bloodOranges = 5;
~limes = 2;
~plantains = 1;

["Citrus", ~bloodOranges + ~limes];
["Non-citrus", ~plantains + ~galaApples];

// Local variables: valid only within the code block.
// Evaluate the block once and watch the Post window:

(
var apples = 4, oranges = 3, lemons = 8, bananas = 10;
["Citrus fruits", oranges + lemons].postln;
["Non-citrus fruits", bananas + apples].postln;
"End".postln;
)

~galaApples; // stil exists
apples; // gone