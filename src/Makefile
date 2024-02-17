CC := x86_64-w64-mingw32-gcc
OUTPUT_DIR := ../out/

all: clean make
.PHONY: all

clean:
	rm -rf $(OUTPUT_DIR)

make:
	mkdir -p $(OUTPUT_DIR)
	$(CC) gvr-700.c -o $(OUTPUT_DIR)/GVR700.exe