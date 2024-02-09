CC = gcc
CFLAGS= -Werror -lfl
FILENAME = traductor
FLEXFILE = analizador.lex
RUTA = "C:\TDM-GCC-64\GnuWin32\lib\libfl.a"
# part of the makefile
traductor: ${FLEXFILE}
	flex ${FLEXFILE}
	${CC} ${CFLAGS} -o $@  lex.yy.c
