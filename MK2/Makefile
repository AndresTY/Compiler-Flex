GCC = gcc
FLEX = flex

V1 = 100
v2 = 100

FILE = game
PROGS = mk

file = 

flex:
	$(FLEX) $(FILE).l 
mk:
	$(GCC) lex.yy.c -o $@
clean:
	$(RM) $(PROGS) *.o & clear

