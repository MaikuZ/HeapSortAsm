all:
	mkdir -p obj
	mkdir -p bin
	nasm src/sort.asm -felf64 -o obj/sort.o
	g++ -c src/main.cpp -o obj/main.o
	g++ obj/main.o obj/sort.o -o bin/main
	rm -rf obj
verify:
	mkdir -p test/bin/
	mkdir -p test/test_case/
	g++ -std=c++11 test/generate.cpp -o test/bin/generate 
	echo "10000\n" | ./test/bin/generate > test/test_case/test.in
	g++ test/stdsort.cpp -o test/bin/stdsort
	./test/bin/stdsort < test/test_case/test.in > test/test_case/expected.out 
	./bin/main < test/test_case/test.in > test/test_case/test.out
	diff -u "test/test_case/test.out" "test/test_case/expected.out" || exit;
.PHONY: clean
clean:
	rm -rf bin/
	rm -rf test/bin/
