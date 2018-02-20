%{
#include <iostream>
#include <cstdio>

using namespace std;

extern "C" int yylex();
extern "C" int yyparse();
extern "C" FILE *yyin;
extern int line_num;

void yyerror(const char *s);
%}

%token PRINT IF THEN GOTO INPUT LET GOSUB RETURN CLEAR LIST RUN END STRING COMMA PLUMIN MULDIV EQ LEQGEQ CR DIGIT VAR LPAREN RPAREN

%%

program: lines	{cout << "Successfull parsing of Tiny Basic program" << endl;}
		;

lines: lines line {cout << "Successfully parsed lines -> lines line" << endl;}
		| line {cout << "Successfully parsed lines -> line" << endl;}
		;

line: number statement CR {cout << "Successfully parsed line -> number statement CR" << endl;}
	| statement CR {cout << "Successfully parsed line -> statement CR" << endl;}
		;

statement:
			PRINT expr-list	{cout << "Parsed PRINT statement" << endl;}
			| IF expression LEQGEQ expression THEN statement {cout << "Parsed IF Statement" << endl;}
			| IF expression EQ expression THEN statement {cout << "Parsed IF Statement" << endl;}
			| GOTO expression {cout << "Parsed GOTO statement" << endl;}
			| INPUT var-list {cout << "Parsed INPUT Statement" << endl;}
			| LET VAR EQ expression {cout << "Parsed LET Statement" << endl;}
			| GOSUB expression {cout << "Parsed GOSUB Statement" << endl;}
			| RETURN {cout << "Parsed RETURN Statement" << endl;}
			| CLEAR {cout << "Parsed CLEAR Statement" << endl;}
			| LIST {cout << "Parsed LIST Statement" << endl;}
			| RUN {cout << "Parsed RUN Statement" << endl;}
			| END {cout << "Parsed END Statement" << endl;}
			;

expr-list:	expr-list COMMA expr-id {cout << "Parsed expr-list -> expr-list COMMA expr-id" << endl;}
			| expr-id {cout << "Parsed expr-list -> expr-id" << endl;}
			;

expr-id: STRING {cout << "Parsed expr-id -> STRING" << endl;}
		| expression {cout << "Parsed expr-id -> expression" << endl;}
		;

var-list: VAR COMMA var-list {cout << "Parsed var-list -> VAR COMMA var-list" << endl;}
		| VAR {cout << "Parsed var-list -> VAR" << endl;}
		;

expression: expression PLUMIN term {cout << "parsed expression -> expression PLUMIN term" << endl;}
		| PLUMIN term {cout << "Parsed expression -> PLUMIN term" << endl;}
		;

term: term MULDIV factor {cout << "parsed term -> term MULDIV factor" << endl;}
	| factor {cout << "Parsed term -> factor" << endl;}
	;

factor: VAR {cout << "parsed factor -> VAR" << endl;}
		| number {cout << "parsed factor -> number" << endl;}
		| LPAREN expression RPAREN {cout << "Parsed factor -> LPAREN expression RPAREN" << endl;}
		;

number: number DIGIT | DIGIT {cout << "Parsed number" << endl;}
		;

%%

int main(int n, char** f) {
	FILE *myfile;
	if(n > 1) {
		myfile = fopen(f[1], "r");
	} else {
		cout << "No input file" << endl;
		exit(-1);
	}

	if(!myfile) {
		cout << "Can't open in.snazzle!" << endl;
		return -1;
	}

	yyin = myfile;

	do {
		yyparse();
	} while(!feof(yyin));
}

void yyerror(const char *s) {
	cout << "Parse Error! Message on Line number "<< line_num << " :: " << s << endl;
	exit(-1);
}