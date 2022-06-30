#ifndef Transform_h
#define Transform_h

#include "Vector3.h"

typedef struct Transform
{
	Vector3 Translation;
	Vector3 Rotation;
	Vector3 Scale3D;
	
} Transform;

#endif