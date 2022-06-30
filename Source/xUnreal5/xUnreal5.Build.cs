// Copyright Epic Games, Inc. All Rights Reserved.

using UnrealBuildTool;

public class xUnreal5 : ModuleRules
{
	public xUnreal5(ReadOnlyTargetRules Target) : base(Target)
	{
		PCHUsage = PCHUsageMode.UseExplicitOrSharedPCHs;
		PublicDependencyModuleNames.AddRange(new string[] { "Core", "CoreUObject", "Engine", "InputCore", "HTTP", "OpenSSL", "UMG", "Slate", "SlateCore" });
	}
}
