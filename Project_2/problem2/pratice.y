%{
#include <stdio.h>
#include <string.h>
void yyerror(const char *str)
{
	fprintf(stderr, "error: %s\n",str);
}

int yywrap()
{
	return 1;
}
main(){
	yyparse();
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

%%
	Start: Define Function
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
	;
	
	Parenthesis: Parenthesis '[' ID ']'
	| Parenthesis '[' ']'
	|'[' ']'
	|'[' ID ']'
	;	
	ArrayUsing : ID Parenthesis
	;

	Declaration: Type DecList ';'
	{printf("declaration statement matched\n");}
	;

	DecList: DecList ',' ID
	| ID
	;

	Assignment: Assign_Var ASSIGN_OP Calc
	{printf("assignment statement matched\n");}
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
	
	IfStmt : IF '(' Expr ')' Stmt
	{printf("if statement matched\n");}
	;
%%

