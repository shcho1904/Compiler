#  
#  COMMIT (Compiler & Micro-architecture)
#

    CC=/usr/bin/gcc
    OPTLEVEL=0
    GCCFLAG= -c -o
    FLAG= -DSPEC_CPU -DNDEBUG  
    CCFNO= -fno-strict-aliasing
    LP= -DSPEC_CPU_LP64
    

all: main_code 
	
main_code: 
	$(CC) -c -g -o  spec.o $(FLAG)    -O$(OPTLEVEL) $(CCFNO)       $(LP)         spec.c
	$(CC) -c -g -o  blocksort.o $(FLAG)    -O$(OPTLEVEL) $(CCFNO)       $(LP)         blocksort.c
	$(CC) -c -g -o  bzip2.o $(FLAG)    -O$(OPTLEVEL) $(CCFNO)       $(LP)         bzip2.c
	$(CC) -c -g -o  bzlib.o $(FLAG)    -O$(OPTLEVEL) $(CCFNO)       $(LP)         bzlib.c
	$(CC) -c -g -o  compress.o $(FLAG)    -O$(OPTLEVEL) $(CCFNO)       $(LP)         compress.c
	$(CC) -c -g -o  crctable.o $(FLAG)    -O$(OPTLEVEL) $(CCFNO)       $(LP)         crctable.c
	$(CC) -c -g -o  decompress.o $(FLAG)    -O$(OPTLEVEL) $(CCFNO)       $(LP)         decompress.c
	$(CC) -c -g -o  huffman.o $(FLAG)    -O$(OPTLEVEL) $(CCFNO)       $(LP)         huffman.c
	$(CC) -c -g -o  randtable.o $(FLAG)    -O$(OPTLEVEL) $(CCFNO)       $(LP)         randtable.c
	$(CC)  -g -O$(OPTLEVEL) $(CCFNO)  $(LP)        spec.o blocksort.o bzip2.o bzlib.o compress.o crctable.o decompress.o huffman.o randtable.o  -o bzip2

	objdump -D bzip2 > out.dump


clean:
	rm -rf *.o bzip2
