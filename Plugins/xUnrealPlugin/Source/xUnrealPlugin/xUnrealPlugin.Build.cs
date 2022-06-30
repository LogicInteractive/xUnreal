// Copyright Epic Games, Inc. All Rights Reserved.

using UnrealBuildTool;

public class xUnrealPlugin : ModuleRules
{
	public xUnrealPlugin(ReadOnlyTargetRules Target) : base(Target)
	{
		PCHUsage = ModuleRules.PCHUsageMode.UseExplicitOrSharedPCHs;
		PublicDependencyModuleNames.AddRange(new string[] { "Core", "CoreUObject", "Engine", "InputCore", "HTTP", "OpenSSL", "UMG", "Slate", "SlateCore" });
		PrivateDependencyModuleNames.AddRange(new string[] { });
		PublicAdditionalLibraries.Add(@"$(PluginDir)/Binaries/haxe_build/libXUnrealMain.lib");
	}
}
