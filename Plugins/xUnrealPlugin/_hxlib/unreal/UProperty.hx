package unreal;

/*
Property Specifiers
When declaring properties, Property Specifiers can be added to the declaration to control how the property behaves with various aspects of the Engine and Editor.
*/

enum UProperty
{
	AdvancedDisplay;						// The property will be placed in the advanced (dropdown) section of any panel where it appears.
	AssetRegistrySearchable;				// The AssetRegistrySearchable Specifier indicates that this property and its value will be automatically added to the Asset Registry for any Asset class instances containing this as a member variable. It is not legal to use on struct properties or parameters.
	BlueprintAssignable;					// Usable with Multicast Delegates only. Exposes the property for assigning in Blueprints.
	BlueprintAuthorityOnly;					// This property must be a Multicast Delegate. In Blueprints, it will only accept events tagged with BlueprintAuthorityOnly.
	BlueprintCallable;						// Multicast Delegates only. Property should be exposed for calling in Blueprint code.
	BlueprintGetter;//=GetterFunctionName	// This property specifies a custom accessor function. If this property isn't also tagged with BlueprintSetter or BlueprintReadWrite, then it is implicitly BlueprintReadOnly.
	BlueprintReadOnly;						// This property can be read by Blueprints, but not modified. This Specifier is incompatible with the BlueprintReadWrite Specifier.
	BlueprintReadWrite;						// This property can be read or written from a Blueprint. This Specifier is incompatible with the BlueprintReadOnly Specifier.
	BlueprintSetter;//=SetterFunctionName	// This property has a custom mutator function, and is implicitly tagged with BlueprintReadWrite. Note that the mutator function must be named and part of the same class.
	Category;//="TopCategory|SubCategory.." // Specifies the category of the property when displayed in Blueprint editing tools. Define nested categories using the | operator.
	Config;									// This property will be made configurable. The current value can be saved to the .ini file associated with the class and will be loaded when created. Cannot be given a value in default properties. Implies BlueprintReadOnly.
	DuplicateTransient;						// Indicates that the property's value should be reset to the class default value during any type of duplication (copy/paste, binary duplication, etc.).
	EditAnywhere;							// Indicates that this property can be edited by property windows, on archetypes and instances. This Specifier is incompatible with any of the the "Visible" Specifiers.
	EditDefaultsOnly;						// Indicates that this property can be edited by property windows, but only on archetypes. This Specifier is incompatible with any of the "Visible" Specifiers.
	EditFixedSize;							// Only useful for dynamic arrays. This will prevent the user from changing the length of an array via the Unreal Editor property window.
	EditInline;								// Allows the user to edit the properties of the Object referenced by this property within Unreal Editor's property inspector (only useful for Object references, including arrays of Object reference).
	EditInstanceOnly;						// Indicates that this property can be edited by property windows, but only on instances, not on archetypes. This Specifier is incompatible with any of the "Visible" Specifiers.
	Export;									// Only useful for Object properties (or arrays of Objects). Indicates that the Object assigned to this property should be exported in its entirety as a subobject block when the Object is copied (such as for copy/paste operations), as opposed to just outputting the Object reference itself.
	GlobalConfig;							// Works just like Config except that you cannot override it in a subclass. Cannot be given a value in default properties. Implies BlueprintReadOnly.
	Instanced;								// Object (UCLASS) properties only. When an instance of this class is created, it will be given a unique copy of the Object assigned to this property in defaults. Used for instancing subobjects defined in class default properties. Implies EditInline and Export.
	Interp;									// Indicates that the value can be driven over time by a Track in Sequencer.
	Localized;								// The value of this property will have a localized value defined. Mostly used for strings. Implies ReadOnly.
	Native;									// Property is native: C++ code is responsible for serializing it and exposing to Garbage Collection.
	NoClear;								// Prevents this Object reference from being set to none from the editor. Hides clear (and browse) button in the editor.
	NoExport;								// Only useful for native classes. This property should not be included in the auto-generated class declaration.
	NonPIEDuplicateTransient;				// The property will be reset to the default value during duplication, except if it's being duplicated for a Play In Editor (PIE) session.
	NonTransactional;						// Indicates that changes to this property's value will not be included in the editor's undo/redo history.
	NotReplicated;							// Skip replication. This only applies to struct members and parameters in service request functions.
	Replicated;								// The property should be replicated over the network.
	ReplicatedUsing;//=FunctionName			// The ReplicatedUsing Specifier specifies a callback function which is executed when the property is updated over the network.
	RepRetry;								// Only useful for struct properties. Retry replication of this property if it fails to be fully sent (for example, Object references not yet available to serialize over the network). For simple references, this is the default, but for structs, this is often undesirable due to the bandwidth cost, so it is disabled unless this flag is specified.
	SaveGame;								// This Specifier is a simple way to include fields explicitly for a checkpoint/save system at the property level. The flag should be set on all fields that are intended to be part of a saved game, and then a proxy archiver can be used to read/write it.
	SerializeText;							// Native property should be serialized as text (ImportText, ExportText).
	SkipSerialization;						// This property will not be serialized, but can still be exported to a text format (such as for copy/paste operations).
	SimpleDisplay;							// Visible or editable properties appear in the Details panel and are visible without opening the "Advanced" section.
	TextExportTransient;					// This property will not be exported to a text format (so it cannot, for example, be used in copy/paste operations).
	Transient;								// Property is transient, meaning it will not be saved or loaded. Properties tagged this way will be zero-filled at load time.
	VisibleAnywhere;						// Indicates that this property is visible in all property windows, but cannot be edited. This Specifier is incompatible with the "Edit" Specifiers.
	VisibleDefaultsOnly;					// Indicates that this property is only visible in property windows for archetypes, and cannot be edited. This Specifier is incompatible with any of the "Edit" Specifiers.
	VisibleInstanceOnly;					// Indicates that this property is only visible in property windows for instances, not for archetypes, and cannot be edited. This Specifier is incompatible with any of the "Edit" Specifiers.

}


/*
Metadata Specifiers
When declaring classes, interfaces, structs, enums, enum values, functions, or properties, you can add Metadata Specifiers to control how they interact with various aspects of the engine and editor. Each type of data structure or member has its own list of Metadata Specifiers.
Metadata only exists in the editor; do not write game logic that accesses metadata.
*/

enum UPropertyMeta
{
	AllowAbstract;//="true/false";			// Used for Subclass and SoftClass properties. Indicates whether abstract Class types should be shown in the Class picker.
	AllowedClasses;//="Class1, Class2, .."	// Used for FSoftObjectPath properties. Comma delimited list that indicates the Class type(s) of assets to be displayed in the Asset picker.
	AllowPreserveRatio;						// Used for FVector properties. It causes a ratio lock to be added when displaying this property in details panels.
	ArrayClamp;//="ArrayProperty"			// Used for integer properties. Clamps the valid values that can be entered in the UI to be between 0 and the length of the array property named.
	AssetBundles;							// Used for SoftObjectPtr or SoftObjectPath properties. List of Bundle names used inside Primary Data Assets to specify which Bundles this reference is part of.
	BlueprintBaseOnly;						// Used for Subclass and SoftClass properties. Indicates whether only Blueprint Classes should be shown in the Class picker.
	BlueprintCompilerGeneratedDefaults;		// Property defaults are generated by the Blueprint compiler and will not be copied when the CopyPropertiesForUnrelatedObjects function is called post-compile.
	ClampMin;//="N"							// Used for float and integer properties. Specifies the minimum value N that may be entered for the property.
	ClampMax;//="N"							// Used for float and integer properties. Specifies the maximum value N that may be entered for the property.
	ConfigHierarchyEditable;				// This property is serialized to a config (.ini) file, and can be set anywhere in the config hierarchy.
	ContentDir;								// Used by FDirectoryPath properties. Indicates that the path will be picked using the Slate-style directory picker inside the Content folder.
	DisplayAfter;//="PropertyName"			// This property will show up in the Blueprint Editor immediately after the property named PropertyName, regardless of its order in source code, as long as both properties are in the same category. If multiple properties have the same DisplayAfter value and the same DisplayPriority value, they will appear after the named property in the order in which they are declared in the header file.
	DisplayName;//="Property Name"			// The name to display for this property, instead of the code-generated name.
	DisplayPriority;//="N"					// If two properties feature the same DisplayAfter value, or are in the same category and do not have the DisplayAfter Meta Tag, this property will determine their sorting order. The highest-priority value is 1, meaning that a property with a DisplayPriority value of 1 will appear above a property with a DisplayProirity value of 2. If multiple properties have the same DisplayAfter value, they will appear in the order in which they are declared in the header file.
	DisplayThumbnail;//="true"				// Indicates that the property is an Asset type and it should display the thumbnail of the selected Asset.
	EditCondition;//="BooleanPropertyName"	// Names a boolean property that is used to indicate whether editing of this property is disabled. Putting "!" before the property name inverts the test. The EditCondition meta tag is no longer limited to a single boolean property. It is now evaluated using a full-fledged expression parser, meaning you can include a full C++ expression.
	EditFixedOrder;							// Keeps the elements of an array from being reordered by dragging.
	ExactClass;//="true"					// Used for FSoftObjectPath properties in conjunction with AllowedClasses. Indicates whether only the exact Classes specified in AllowedClasses can be used, or if subclasses are also valid.
	ExposeFunctionCategories;// ="Category1, Category2, .." //Specifies a list of categories whose functions should be exposed when building a function list in the Blueprint Editor.
	ExposeOnSpawn;//="true"					// Specifies whether the property should be exposed on a Spawn Actor node for this Class type.
	FilePathFilter;//="FileType"			// Used by FFilePath properties. Indicates the path filter to display in the file picker. Common values include "uasset" and "umap", but these are not the only possible values.
	GetByRef;								// Makes the "Get" Blueprint Node for this property return a const reference to the property instead of a copy of its value. Only usable with Sparse Class Data, and only when NoGetter is not present.
	HideAlphaChannel;						// Used for FColor and FLinearColor properties. Indicates that the Alpha property should be hidden when displaying the property widget in the details.
	HideViewOptions;						// Used for Subclass and SoftClass properties. Hides the ability to change view options in the Class picker.
	InlineEditConditionToggle;				// Signifies that the boolean property is only displayed inline as an edit condition toggle in other properties, and should not be shown on its own row.
	LongPackageName;						// Used by FDirectoryPath properties. Converts the path to a long package name.
	MakeEditWidget;							// Used for Transform or Rotator properties, or Arrays of Transforms or Rotators. Indicates that the property should be exposed in the viewport as a movable widget.
	NoGetter;								// Causes Blueprint generation not to generate a "get" Node for this property. Only usable with Sparse Class Data.
}
