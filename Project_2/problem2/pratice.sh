yacc -d pratice.y
lex problem2.l
cc lex.yy.c y.tab.c -o pratice
