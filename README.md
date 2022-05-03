# COMPILER-FLEX 

# Abstract
## MK

This is a program that seeks to make a syntactic simulation of the popular game Mortal Kombat.
Flex is used to generate and define the syntactic rules, and bison is used to apply them in order to generate all the actions.

has a problem that comes from the use of `yyparse()` in bison, so it will not be able to perform a whole cycle, but it will only run a single instruction.

### sintax
```console
HIT:
	Fighter-COMBO (eg. JAX-XX)

FATALITY:
	Fighter:FATALITY-Enemy (eg. JAX:DDUUY-KABAL)

```

### datasheet
```console
HIT - X Y A B (XBOX control)

GENERAL FRIENDSHIP - BFDDX (Back Front Down Down X)
GERERAL BABALITY - DDUUY (Down Down Up Up)

JAX FATALITY - FBFA (Front Back Front A)
             - BFBDX (Back Front Back Down X)

KABAL FATALITY - BFBFA (Back Front Back Front A)
	       - DDDB (Down Down Down B) 
```

## MK2

Now for this case only flex was used to generate both the syntax and the instructions that the game was going to execute.

It has the ability to both run a live environment and validate a game history. 

### sintax 
```console
HIT:
	Fighter-COMBO (eg. SCORPION-XX)

FATALITY:
	Fighter-FATALITY-Enemy (eg. SCORPION-DDUUY-SINDEL)

```

### datasheet
```console
HIT - X Y A B (XBOX control)

GENERAL FRIENDSHIP - BFDDX (Back Front Down Down X)
GERERAL BABALITY - DDUUY (Down Down Up Up)

SCORPION FATALITY - FBFA (Front Back Front A)
             - BFBDX (Back Front Back Down X)

SINDEL FATALITY - BFBFA (Back Front Back Front A)
		- DDDB (Down Down Down B) 
```

## Nutshell

This section is a set of exercises as an approach to flex and bison, in order to use what has been learned with languages and regular expressions, automata and grammars, ...

# Requirements

- LINUX
``` console
Flex
bison
gcc
```

# USAGE

MK sections have a makefile to help with execution

## MK

- make clean - remove all .outs and program mk
- make compiler - compiles the flex and bison files, generating the .c files to be used
- make mk - compiles all the .c files creating the executable
- make run [V1=] [V2=] - runs the program.

## MK2

- make clean - remove all .outs and program mk
- make flex - compiles the flex files, generating the .c files to be used
- make mk - compiles all the .c files creating the executable
- make run [V1=] [V2=] - runs the program.
- make run-file [File=] - runs the program to validate a file

## Nutshell

these exercises are to start in flex, the execution and compilation are manual.
