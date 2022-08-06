// if / else
if(100 > 50, { "very true".postln }, { "very false".postln });

// case
(
~num = -2;

case
{~num == 0} {"WOW".postln}
{~num == 1} {"ONE!".postln}
{~num < 0} {"negative number!".postln}
{true} {"last case scenario".postln};
)