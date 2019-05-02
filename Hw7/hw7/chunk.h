#ifndef clox_chunk_h
#define clox_chunk_h

// A dynamic byte array together with a dynamic array of constants

#include "common.h"
#include "value.h"

// opcodes understood by the VM

typedef enum {
    OP_CONSTANT,
    OP_LONG_CONSTANT,
    OP_ADD,
    OP_SUB,
    OP_MUL,
    OP_DIV,
    OP_NEGATE,
    OP_RETURN,
} OpCode;

typedef struct {
    int count;
    int capacity;
    uint8_t* code;
    int* lines;
    ValueArray constants;
} Chunk;

void initChunk(Chunk* chunk);
void freeChunk(Chunk* chunk);
void writeChunk(Chunk* chunk, uint32_t byte, int line);          // writes a byte into the chunk - store source line #
void writeLongChunk(Chunk* chunk, uint32_t byte, int line);     // writes 3 bytes into the chunk - store source line #
int  addConstant(Chunk* chunk, Value value);                    // adds a constant to the constant table and returns index

#endif
