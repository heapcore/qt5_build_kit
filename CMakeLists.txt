cmake_minimum_required(VERSION 3.16)

project(qt5_build_kit LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

find_package(Qt5 REQUIRED COMPONENTS Widgets)

add_executable(calculator_demo
    examples/calculator/main.cpp
    examples/calculator/button.cpp
    examples/calculator/button.h
    examples/calculator/calculator.cpp
    examples/calculator/calculator.h
)
target_link_libraries(calculator_demo PRIVATE Qt5::Widgets)

add_executable(lineedits_demo
    examples/lineedits/main.cpp
    examples/lineedits/lineedits.cpp
    examples/lineedits/lineedits.h
)
target_link_libraries(lineedits_demo PRIVATE Qt5::Widgets)

add_executable(dragdroprobot_demo
    examples/dragdroprobot/main.cpp
    examples/dragdroprobot/coloritem.cpp
    examples/dragdroprobot/coloritem.h
    examples/dragdroprobot/robot.cpp
    examples/dragdroprobot/robot.h
)
target_link_libraries(dragdroprobot_demo PRIVATE Qt5::Widgets)
