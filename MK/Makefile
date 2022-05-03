GCC = gcc
FLEX = flex
BISON = bison
V1 = 100
V2 = 100

FILE = game
PROGS = mk

compiler:
	@$(FLEX) $(FILE).l & $(BISON) -dy $(FILE).y

mk:
	@$(GCC) lex.yy.c y.tab.c -o $@

clean:
	@$(RM) $(PROGS) *.o & clear

run:
	@./$(PROGS) $(V1) $(V2)

