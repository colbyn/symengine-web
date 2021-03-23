FLAGS := -I./dependencies/x86/include -l symengine -l gmp -L./dependencies/x86/lib

./release/bin/cli: cli.c
	mkdir -p ./release/bin
	cc cli.c -o ./release/bin/cli $(FLAGS)
