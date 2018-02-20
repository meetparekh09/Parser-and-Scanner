hw1: lex.yy.c hw1.tab.c hw1.tab.h
	g++ hw1.tab.c lex.yy.c -lfl -o hw1

lex.yy.c: hw1.l hw1.tab.h
	flex hw1.l

hw1.tab.c hw1.tab.h: hw1.y
	bison -d hw1.y

clean:
	rm hw1.tab.c hw1.tab.h lex.yy.c