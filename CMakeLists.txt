cmake_minimum_required(VERSION 3.16)

project(ft_hangouts VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Quick)
find_package(Qt6 6.4 REQUIRED COMPONENTS Quick Sensors Xml)

qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(appft_hangouts
    main.cpp
)

qt_add_qml_module(appft_hangouts
    URI ft_hangouts
    VERSION 1.0
    QML_FILES Main.qml
    RESOURCES 42_Logo.png
)
# Define the path to the Android resource directory
set_property(TARGET appft_hangouts PROPERTY ANDROID_PACKAGE_SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/android)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appft_hangouts PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appft_hangouts
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appft_hangouts
    PRIVATE Qt6::Quick
)

include(GNUInstallDirs)
install(TARGETS appft_hangouts
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
