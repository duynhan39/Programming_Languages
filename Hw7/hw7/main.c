#include "common.h"
#include "chunk.h"
#include "debug.h"
#include "vm.h"
#include <stdio.h>

int main(int argc, const char* argv[]) {
    initVM();
    Chunk chunk;
    initChunk(&chunk);

    writeChunk(&chunk, OP_CONSTANT, 123);
    writeChunk(&chunk, addConstant(&chunk, 5.0), 123);
    writeChunk(&chunk, OP_CONSTANT, 123);
    writeChunk(&chunk, addConstant(&chunk, 7.5), 123);
    writeChunk(&chunk, OP_CONSTANT, 123);
    writeChunk(&chunk, addConstant(&chunk, 0), 123);
    writeChunk(&chunk, OP_CONSTANT, 123);
    writeChunk(&chunk, addConstant(&chunk, 0), 123);
    writeChunk(&chunk, OP_CONSTANT, 123);
    writeChunk(&chunk, addConstant(&chunk, 0), 123);
    
    writeChunk(&chunk, OP_CONSTANT, 123);
    writeChunk(&chunk, addConstant(&chunk, 6), 123);
    
    writeChunk(&chunk, OP_LONG_CONSTANT, 123);
    writeLongChunk(&chunk, addConstant(&chunk, 9090), 123);
    
    writeChunk(&chunk, OP_CONSTANT, 123);
    writeChunk(&chunk, addConstant(&chunk, 2), 123);
    
    writeChunk(&chunk, OP_DIV, 123);
    writeChunk(&chunk, OP_MUL, 123);
    
    writeChunk(&chunk, OP_NEGATE, 123);
    writeChunk(&chunk, OP_SUB, 123);
    writeChunk(&chunk, OP_ADD, 123);
    
    
    printf("OP_CONSTANT %d\n", OP_CONSTANT);
    printf("OP_LONG_CONSTANT %d\n", OP_LONG_CONSTANT);
    printf("OP_ADD %d\n", OP_ADD);
    printf("OP_MUL %d\n", OP_MUL);
    printf("OP_DIV %d\n", OP_DIV);
    
    for(int i=0; i<chunk.count; i++) {
        printf("= %d\n", chunk.code[i]);
    }
    
    writeChunk(&chunk, OP_RETURN, 123);

    disassembleChunk(&chunk, "test chunk");
    printf("== Running ==\n");
    interpret(&chunk); 

    freeVM();
    freeChunk(&chunk);

    return 0;
}
