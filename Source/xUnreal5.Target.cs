using UnrealBuildTool;
using System.Collections.Generic;

public class xUnreal5Target : TargetRules
{
	public xUnreal5Target( TargetInfo Target) : base(Target)
	{
		Type = TargetType.Game;
		DefaultBuildSettings = BuildSettingsVersion.V2;
		ExtraModuleNames.AddRange( new string[] { "xUnreal5" } );
	}
}
