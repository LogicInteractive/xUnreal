#ifndef HaxeArray_h
#define HaxeArray_h

typedef struct HaxeArray
{
	int v_typeCode;
	const void* v_ptr;
	int v_length;
	
	HaxeArray* ref()
	{
		return this;
	}
} HaxeArray;

#endif