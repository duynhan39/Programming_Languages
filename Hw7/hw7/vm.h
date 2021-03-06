#ifndef clox_vm_h
#define clox_vm_h

#include "chunk.h"
#include "value.h"
#define STACK_MAX 256

typedef struct {
    Chunk* chunk;               // program to execute
    uint8_t* ip;                // next instruction to execute (inside chunk)
    Value stack[STACK_MAX];
    Value* stackTop;
} VM;

typedef enum {
    INTERPRET_OK,
    INTERPRET_COMPILE_ERROR,
    INTERPRET_RUNTIME_ERROR
} InterpretResult;

void initVM();
void freeVM();
InterpretResult interpret(Chunk* chunk);
void push(Value value);
Value pop();

#endif
