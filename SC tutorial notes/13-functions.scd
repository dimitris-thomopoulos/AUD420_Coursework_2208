f = {arg a, b; ["a plus b", a+b, "a times b", a*b].postln}; // define function
f.value(3, 7); // now you can give any two numbers as arguments to the function
f.value(10, 14);

// Compare:
~sillyRand = rrand(0, 10); // not a function
~sillyRand.value; // evaluate several times
~sillyRand2 = {rrand(0, 10)}; // a function
~sillyRand2.value; // evaluate several times;


// Use this function to decide how to spend your Summer days
(
~whatToDo = {
	var today, dayName, actions;
				today = Date.getDate.dayOfWeek;
				dayName =
				case
				{today==0} {"Sunday"}
				{today==1} {"Monday"}
				{today==2} {"Tuesday"}
				{today==3} {"Wednesday"}
				{today==4} {"Thursday"}
				{today==5} {"Friday"}
				{today==6} {"Saturday"};
				actions = ["boomerang throwing", "arm wrestling", "stair climbing", "playing chess", "underwater hockey", "pea shooting", "a nap marathon"];
				 "Ah, " ++ dayName ++ "...! " ++ "What a good day for " ++ actions.choose;
};
)

// Run it in the morning
~whatToDo.value;

/*
TIP: Another common notation to declare arguments at the beginning of a Function is: f =
{|a, b| a + b}. This is equivalent to f = {arg a, b; a + b}
*/