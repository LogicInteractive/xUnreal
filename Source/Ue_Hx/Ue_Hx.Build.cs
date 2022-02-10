using UnrealBuildTool;

public class Ue_Hx : ModuleRules
{
	public Ue_Hx(ReadOnlyTargetRules Target) : base(Target)
	{
		PCHUsage = PCHUsageMode.UseExplicitOrSharedPCHs;
	
		PublicDependencyModuleNames.AddRange(new string[] { "Core", "CoreUObject", "Engine", "InputCore", "Http", "OpenSSL", "UMG", "Slate", "SlateCore" });
		PrivateDependencyModuleNames.AddRange(new string[] { });

		// PublicDelayLoadDLLs.Add("$(ProjectDir)/Binaries/haxe_build/libHaxeMain.dll");
		PublicAdditionalLibraries.Add(@"$(ProjectDir)/Binaries/haxe_build/libHxUnrealMain.lib");
	}
}
