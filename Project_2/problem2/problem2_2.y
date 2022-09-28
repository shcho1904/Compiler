%{
#include <stdio.h>
#include <string.h>
extern FILE* yyin;
extern int yylineno;
extern int yychar;
char* file_name;

int yywrap()
{
	return 1;
}

void main(argc, argv)
int argc;
char **argv;
{
	++argv, --argc;
	if(argc>0)
		yyin = fopen(argv[0], "r");
	else
		yyin = stdin;
	file_name = argv[0];
	yyparse();
}

void yyerror(char * str)
{
	fprintf(stderr, "%s:%d: error: %s \'%c\' token\n",
 file_name, yylineno, str, yychar);
}

%}

%token DEFINE INCLUDE INT VOID IF FOR ASSIGN_OP INC_OP ADD_OP MUL_OP LOGIC_OP REL_OP

%union
{
	int number;
	char *string;
}

%token <number> NUM
%token <string> ID
%left ASSIGN_OP 

%%
	start: Define Function
	;

	Define : DEFINE ID NUM
	{printf("define statement matched\n");}
	;

	Type : INT|VOID
	;
	
	Function : VOID ID '(' ArgList ')' CompoundStmt
	{printf("function %s define matched\n", $2);}
	;
	
	ArgList: ArgList ',' Arg
	| Arg
	;
	
	Arg : Type ArgVar
	;

	ArgVar: ID|ArrayUsing
	
	Parenthesis : Parenthesis '[' Calc ']'
	| Parenthesis '[' ']'
	| '[' Calc ']'
	| '[' ']'
	;
	
	ArrayUsing : ID Parenthesis
	;

	Declaration : Type DecList ';'
	{printf("declaration statement matched\n");}
	;

	DecList: DecList ',' ID
	| ID
	;


	Assignment: Assign_Var ASSIGN_OP Calc ';'
	{printf("assignment statement matched\n");}
	|
	error ';' {yyerrok;}
	;
	

	Calc : Var
	| Var ADD_OP Calc
	| Var MUL_OP Calc
	;

	Assign_Var: ID|ArrayUsing 

	CompoundStmt: '{' StmtList '}'
	;
	StmtList: StmtList Stmt
	|
	;
	Stmt: ForStmt
	| Declaration
	| IfStmt
	| Assignment
	| ';'
	;

	ForStmt: FOR '(' For_Expr ';' For_Expr ';' For_Expr ')' CompoundStmt
	{printf("for statement matched\n");}
	;

	Var: ID|NUM|ArrayUsing
	;
	
	Expr : Assignment
	| Var REL_OP Var
	| ID INC_OP
	| Expr LOGIC_OP Expr
	;
	
	For_Expr: For_Assign
	| Var REL_OP Var
	| ID INC_OP
	;

	For_Assign: Assign_Var ASSIGN_OP Calc
	;

	IfStmt : IF '(' Expr ')'
	{printf("if statement matched\n");}
	;
%%
