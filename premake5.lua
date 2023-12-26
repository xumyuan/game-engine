workspace "game_engine"
	architecture "x64"
	startproject "Sandbox"

	configurations
	{
		"Debug",
		"Release",
		"Dist"
	}
	

outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

project "game_engine"
	location "game_engine"
	kind "SharedLib"
	language "C++"

	targetdir ("bin/"..outputdir.. "%{prj.name}")
	objdir ("bin-int/"..outputdir.. "%{prj.name}")

	files
	{
		"%{prj.name}/src/**.h",
		"%{prj.name}/src/**.cpp"
	}

	includedirs
	{
		"%{prj.name}/vendor/spdlog/include"
	}

	filter "system:windows"
		cppdialect "C++17"
		staticruntime "On"
		systemversion "10.0.22621.0"

	defines
	{
		"EG_PLATFORM_WINDOWS",
		"EG_BUILD_DLL"
	}

	postbuildcommands
	{
		("{COPY} %{cfg.buildtarget.relpath} ../bin/"..outputdir.. "/Sandbox")
	}

	filter "configurations:Debug"
		defines "EG_DEBUG"
		symbols "On"

	filter "configurations:Release"
		defines "EG_RELEASE"
		optimize "On"

	filter "configurations:Dist"
		defines "EG_DIST"
		optimize "On"

project "Sandbox"
	location "Sandbox"
	kind "ConsoleApp"
	language "C++"

	targetdir ("bin/"..outputdir.. "%{prj.name}")
	objdir ("bin-int/"..outputdir.. "%{prj.name}")

	files
	{
		"%{prj.name}/src/**.h",
		"%{prj.name}/src/**.cpp"
	}

	includedirs
	{
		"game_engine/vendor/spdlog/include",
		"game_engine/src"
	}

	links
	{
		"game_engine"
	}

	filter "system:windows"
		cppdialect "C++17"
		staticruntime "On"
		systemversion "10.0.22621.0"

	defines
	{
		"EG_PLATFORM_WINDOWS"
	}

	postbuildcommands
	{
		("{COPY} %{cfg.buildtarget.relpath} ../bin/"..outputdir.. "/Sandbox")
	}

	filter "configurations:Debug"
		defines "EG_DEBUG"
		symbols "On"

	filter "configurations:Release"
		defines "EG_RELEASE"
		optimize "On"

	filter "configurations:Dist"
		defines "EG_DIST"
		optimize "On"