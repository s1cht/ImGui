local localBinLocation = "%{wks.location}/bin/%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}/%{prj.name}"
local localBinIntLocation = "%{wks.location}/bin-int/%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}/%{prj.name}"

if (outputBinDirectory ~= nil) then localBinLocation = outputBinDirectory .. "/%{prj.name}" end
if (outputInterDirectory ~= nil) then localBinIntLocation = outputInterDirectory .. "/%{prj.name}" end

local imgui_impl = "backends/imgui_impl_"
IMGUI_OUTPUT_DIR = localBinLocation

project "ImGui"
    kind "StaticLib"
    language "C++"
    cppdialect "C++17"
    staticruntime "off"
    exceptionhandling "off"

    targetdir (localBinLocation)
    objdir    (localBinIntLocation)

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

        --Vulkan SDK
        VULKAN_SDK .."/Include",
    }

    files
    {
        imgui_impl.. "vulkan.h",
        imgui_impl.. "vulkan.cpp",
    }

    filter "system:windows"
        systemversion "latest"
        files
        {
            imgui_impl.. "win32.h",
            imgui_impl.. "win32.cpp",
            imgui_impl.. "dx12.h",
            imgui_impl.. "dx12.cpp",
        }
    filter "system:linux"
        pic "On"
        systemversion "latest"

    filter "configurations:Debug"
        runtime "Debug"
        symbols "on"
    filter "configurations:Release"
        runtime "Release"
        optimize "on"
