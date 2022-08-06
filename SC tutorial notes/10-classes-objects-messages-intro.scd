[1, 2, 3, "wow"].reverse;
"hello".dup(4);
3.1415.round(0.1);  // note that the first dot is the decimal case of 3.1415
100.rand; // evaluate this line several times
100.0.rand.round(0.01).dup(4); // Chaining messages is fun

// Receiver notation & functional notation (ways of writing)

dup(20); // receiver notation
dup(5, 20); // same thing in functional notation

3.1415.round(0.1); // receiver notation
round(3.1415, 0.1); // functional notation

// generally: Receiver.message(argument) <=> message(Receiver, argument)

// excercise: rewrite the following statement using functional notation only:
100.0.rand.round(0.01).dup(4);

// answer:
dup(round(rand(100.0), 0.01), 4);