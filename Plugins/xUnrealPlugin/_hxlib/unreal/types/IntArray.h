#ifndef IntArray_h
#define IntArray_h

typedef struct IntArray
{
	const void* v_ptr;
	int v_length;
	
	IntArray* ref()
	{
		return this;
	}
} IntArray;

#endif