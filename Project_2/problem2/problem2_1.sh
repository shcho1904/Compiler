yacc -d problem2_2.y
lex problem2.l
cc lex.yy.c y.tab.c -o problem2_2
