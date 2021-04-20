add_executable(TestingCode
    main.cpp
)

add_dependencies(TestingCode
    cpp_compatibility
)

target_link_libraries(TestingCode
    PRIVATE cpp_compatibility
)
