There is a make file included with the .l and .y files which will build the parser executable file "hw1"

To build the program enter the command :-
$make

executable program takes one command argument - filename
therefore to execute the program give in the following command :-
$./hw1 sample.in

There are four input files sample.in, sample1.in, sample2.in and sample3.in.
I have tested parser on all four of them and it runs successfully. 
At the end when it reduces to start symbol it should print "Successfull parsing of Tiny Basic program".
Program is verbose where it will print each rule it reduces to on its way.