package unreal;

/*
Keywords used when declaring UClasses to specify how the class behaves with various aspects of the Engine and Editor.

Metadata Specifiers
When declaring classes, Class Specifiers can be added to the declaration to control how the class behaves with various aspects of the Engine and Editor.
*/

enum UClassProperties
{
	Abstract;							// The Abstract Specifier declares the class as an "abstract base class", preventing the user from adding Actors of this class to Levels. This is useful for classes which are not meaningful on their own. For example, the ATriggerBase base class is abstract, while the ATriggerBox subclass is not abstract and can be placed in a Level.
	AdvancedClassDisplay;				// The AdvancedClassDisplay Specifier forces all properties of the class to show only in the advanced sections of any details panel where they appear. To override this on an individual property, use the SimpleDisplay specifier on that property.
	AutoCollapseCategories;//=(Category1, Category2, ...) //The AutoCollapseCategories Specifier negates the effects, for the listed categories, of the AutoExpandCategories Specifier on a parent class.
	AutoExpandCategories;//=(Category1, Category2, ...) // Specifies one or more categories that should be automatically expanded in the Unreal Editor Property window for Objects of this class. To auto-expand variables declared with no category, use the name of the class which declares the variable.
	Blueprintable;						// Exposes this class as an acceptable base class for creating Blueprints. The default is NotBlueprintable, unless inherited otherwise. This Specifier is inherited by subclasses.
	BlueprintType;						// Exposes this class as a type that can be used for variables in Blueprints.
	ClassGroup;//=GroupName				// Indicates that Unreal Editor's Actor Browser should include this class and any subclass of this class within the specified GroupName when Group View is enabled in the Actor Browser.
	CollapseCategories;					// Indicates that properties of this class should not be grouped in categories in Unreal Editor Property windows. This Specifier is propagated to child classes, and can be overridden by the DontCollapseCategories Specifier.
	Config;//=ConfigName;					//Indicates that this class is allowed to store data in a configuration file (.ini). If there are any class properties declared with the config or globalconfig Specifiers, this Specifier causes those properties to be stored in the named configuration file. This Specifier is propagated to all child classes and cannot be negated, but child classes can change the config file by re-declaring the config Specifier and providing a different ConfigName. Common ConfigName values are "Engine", "Editor", "Input", and "Game".
	Const;								// All properties and functions in this class are const and are exported as const. This Specifier is inherited by subclasses.
	ConversionRoot;						// A root convert limits a subclass to only be able to convert to child classes of the first root class going up the hierarchy.
	CustomConstructor;					// Prevents automatic generation of the constructor declaration.
	DefaultToInstanced;					// All instances of this class are considered "instanced". Instanced classes (components) are duplicated upon construction. This Specifier is inherited by subclasses.
	DependsOn;//=(ClassName1, ClassName2, ...) //All classes listed will be compiled before this class. The class names provided must indicate classes in the same (or a previous) package. Multiple dependency classes can be identified using a single DependsOn line delimited by commas, or can be specified using a separate DependsOn line for each class. This is important when a class uses a struct or enum declared in another class, as the compiler only knows what is in the classes it has already compiled.
	Deprecated;							// This class is deprecated and Objects of this class will not be saved when serializing. This Specifier is inherited by subclasses.
	DontAutoCollapseCategories;//=(Category, Category, ...) //Negates the AutoCollapseCategories Specifier for the listed categories inherited from a parent class.
	DontCollapseCategories;				// Negates a CollapseCatogories Specifier inherited from a base class.
	EditInlineNew;						// Indicates that Objects of this class can be created from the Unreal Editor Property window, as opposed to being referenced from an existing Asset. The default behavior is that only references to existing Objects may be assigned through the Property window). This Specifier is propagated to all child classes; child classes can override this with the NotEditInlineNew Specifier.
	HideCategories;//=(Category1, Category2, ...) // Lists one or more categories that should be hidden from the user entirely. To hide properties declared with no category, use the name of the class which declares the variable. This Specifier is propagated to child classes.
	HideDropdown;						// Prevents this class from showing up in property window combo boxes.
	HideFunctions;//=(Category1, Category2, ...) // Hides all functions in the specified category from the user entirely.
	// HideFunctions;//=FunctionName		// Hides the named functions from the user entirely.
	Intrinsic;							// This indicates that the class was declared directly in C++, and has no boilerplate generated by Unreal Header Tool. Do not use this Specifier on new classes.
	MinimalAPI;							// Causes only the class's type information to be exported for use by other modules. The class can be cast to, but the functions of the class cannot be called (with the exception of inline methods). This improves compile times by not exporting everything for classes that do not need all of their functions accessible in other modules.
	NoExport;							// Indicates that this class's declaration should not be included in the automatically-generated C++ header file by the header generator. The C++ class declaration must be defined manually in a separate header file. Only valid for native classes. Do not use this for new classes.
	NonTransient;						// Negates a Transient Specifier inherited from a base class.
	NotBlueprintable;					// Specifies that this class is not an acceptable base class for creating Blueprints. This is the default and is inherited by subclasses.
	NotPlaceable;						// Negates a Placeable Specifier inherited from a base class. Indicates that Objects of this class may not be placed into a Level, UI scene, or Blueprint in the Editor.
	PerObjectConfig;					// Configuration information for this class will be stored per Object, where each object has a section in the .ini file named after the Object in the format [ObjectName ClassName]. This Specifier is propagated to child classes.
	Placeable;							// Indicates that this class can be created in the Editor and placed into a level, UI scene, or Blueprint (depending on the class type). This flag is propagated to all child classes; child classes can override this flag using the NotPlaceable Specifier.
	ShowCategories;//=(Category1, Category2, ...) // Negates a HideCategories Specifier (inherited from a base class) for the listed categories.
	ShowFunctions;//=(Category1, Category2, ...) //Shows all functions within the listed categories in a property viewer.
	// ShowFunctions;//=FunctionName		// Shows the named function in a property viewer.
	Transient;							// Objects belonging to this class will never be saved to disk. This is useful in conjunction with certain kinds of native classes which are non-persistent by nature, such as players or windows. This Specifier is propagated to child classes, but can be overridden by the NonTransient Specifier.
	Within;//=OuterClassName			// Objects of this class cannot exist outside of an instance of an OuterClassName Object. This means that creating an Object of this class requires that an instance of OuterClassName is provided as its Outer Object.
}


/*
Metadata Specifiers
When declaring classes, interfaces, structs, enums, enum values, functions, or properties, you can add Metadata Specifiers to control how they interact with various aspects of the engine and editor. Each type of data structure or member has its own list of Metadata Specifiers.

Metadata only exists in the editor; do not write game logic that accesses metadata.
Classes can use the following Metatag Specifiers:

*/

enum UClassPropertyMetadataSpecifiers
{
	BlueprintSpawnableComponent;		// If present, the component Class can be spawned by a Blueprint.
	BlueprintThreadSafe;				// Only valid on Blueprint function libraries. This specifier marks the functions in this class as callable on non-game threads in animation Blueprints.
	ChildCannotTick;					// Used for Actor and Component classes. If the native class cannot tick, Blueprint-generated classes based this Actor or Component can never tick, even if bCanBlueprintsTickByDefault is true.
	ChildCanTick;						// Used for Actor and Component classes. If the native class cannot tick, Blueprint-generated classes based this Actor or Component can have the bCanEverTick flag overridden, even if bCanBlueprintsTickByDefault is false.
	DeprecatedNode;						// For behavior tree nodes, indicates that the class is deprecated and will display a warning when compiled.
	DeprecationMessage;//="Message Text";	// Deprecated classes with this metadata will include this text with the standard deprecation warning that Blueprint Scripts generate during compilation.
	DisplayName;//="Blueprint Node Name" // The name of this node in a Blueprint Script will be replaced with the value provided here, instead of the code-generated name.
	DontUseGenericSpawnObject;			// Do not spawn an Object of the class using Generic Create Object node in Blueprint Scripts; this specifier applies only to Blueprint-type classes that are neither Actors nor Actor Components.
	ExposedAsyncProxy;					// Expose a proxy Object of this class in Async Task nodes.
	IgnoreCategoryKeywordsInSubclasses;	// Used to make the first subclass of a class ignore all inherited ShowCategories and HideCategories Specifiers.
	IsBlueprintBase;//="true/false"		// States that this class is (or is not) an acceptable base class for creating Blueprints, similar to the Blueprintable or 'NotBlueprintable` Specifiers.
	KismetHideOverrides;//="Event1, Event2, .." // List of Blueprint events that are not allowed to be overridden.
	ProhibitedInterfaces;//="Interface1, Interface2, .." // Lists Interfaces that are not compatible with the class.
	RestrictedToClasses;//="Class1, Class2, .." // Blueprint function library classes can use this to restrict usage to the classes named in the list.
	ShortToolTip;//="Short tooltip"		// A short tooltip that is used in some contexts where the full tooltip might be overwhelming, such as the Parent Class Picker dialog.
	ShowWorldContextPin;				// Indicates that Blueprint nodes placed in graphs owned by this class must show their World context pins, even if they are normally hidden, because Objects of this class cannot be used as World context.
	UsesHierarchy;						// Indicates the class uses hierarchical data. Used to instantiate hierarchical editing features in Details panels.
	ToolTip;//="Hand-written tooltip"	// Overrides the automatically generated tooltip from code comments.
}
