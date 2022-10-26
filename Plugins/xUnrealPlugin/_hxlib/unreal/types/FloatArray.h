#ifndef FloatArray_h
#define FloatArray_h

typedef struct FloatArray
{
	const void* v_ptr;
	int v_length;
	
	FloatArray* ref()
	{
		return this;
	}
} FloatArray;

#endif