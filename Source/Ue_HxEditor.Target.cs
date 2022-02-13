using UnrealBuildTool;
using System.Collections.Generic;

public class Ue_HxEditorTarget : TargetRules
{
	public Ue_HxEditorTarget( TargetInfo Target) : base(Target)
	{
		Type = TargetType.Editor;
		DefaultBuildSettings = BuildSettingsVersion.V2;
		ExtraModuleNames.AddRange( new string[] { "Ue_Hx" } );
	}
}
