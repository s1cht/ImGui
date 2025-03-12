local imgui_impl = "backends/imgui_impl_"

project "ImGui"
	kind "StaticLib"
	language "C++"
    staticruntime "off"

	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

	files
	{
		"imconfig.h",
		"imgui.h",
		"imgui.cpp",
		"imgui_draw.cpp",
		"imgui_internal.h",
		"imgui_tables.cpp",
		"imgui_widgets.cpp",
		"imstb_rectpack.h",
		"imstb_textedit.h",
		"imstb_truetype.h",
		"imgui_demo.cpp"
	}

    includedirs
    {
        "./",
    }

	filter "system:windows"
		systemversion "latest"
		cppdialect "C++17"
        files
        {
            imgui_impl.. "win32.h",
            imgui_impl.. "win32.cpp",
            imgui_impl.. "dx12.h",
            imgui_impl.. "dx12.cpp",
            imgui_impl.. "dx11.h",
            imgui_impl.. "dx11.cpp",
        }

	filter "system:linux"
		pic "On"
		systemversion "latest"
		cppdialect "C++17"

	filter "configurations:Debug"
		runtime "Debug"
		symbols "on"

	filter "configurations:Release"
		runtime "Release"
		optimize "on"

    filter "configurations:Dist"
		runtime "Release"
		optimize "on"
        symbols "off"
