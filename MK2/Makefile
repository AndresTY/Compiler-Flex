GCC = gcc
FLEX = flex

V1 = 100
V2 = 100

FILE = game
PROGS = mk

file = 

flex:
	@$(FLEX) $(FILE).l 
mk:
	@$(GCC) lex.yy.c -o $@
clean:
	@$(RM) $(PROGS) *.o & clear

run:
	@./$(PROGS) $(V1) $(V2)

run-file: $(file)
	@./$(PROGS) $(V1) $(V2) < $(file)
	

