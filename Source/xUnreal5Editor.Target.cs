using UnrealBuildTool;
using System.Collections.Generic;

public class xUnreal5EditorTarget : TargetRules
{
	public xUnreal5EditorTarget( TargetInfo Target) : base(Target)
	{
		Type = TargetType.Editor;
		DefaultBuildSettings = BuildSettingsVersion.V2;
		ExtraModuleNames.AddRange( new string[] { "xUnreal5" } );
	}
}
