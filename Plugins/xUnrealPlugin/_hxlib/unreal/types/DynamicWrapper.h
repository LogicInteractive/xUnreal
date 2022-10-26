#ifndef DynamicWrapper_h
#define DynamicWrapper_h

typedef struct DynamicWrapper
{
	int v_typeCode;
	const char* v_type;
	float v_float;
	int v_int;
	bool v_bool;
	const char* v_str;
	void* v_dynamic;
	
	DynamicWrapper* ref()
	{
		return this;
	}

} DynamicWrapper;

#endif