#ifndef StringArray_h
#define StringArray_h

typedef struct StringArray
{
	const void* v_ptr;
	int v_length;
	
	StringArray* ref()
	{
		return this;
	}
} StringArray;

#endif