cmake_minimum_required(VERSION 3.16)

include(FetchContent)

set(gtest_URL https://github.com/google/googletest.git)
set(gtest_TAG release-1.12.1)

set(absl_URL https://github.com/abseil/abseil-cpp.git)
set(absl_TAG 20230125.0)

set(re2_URL https://github.com/google/re2.git)
set(re2_TAG 2023-03-01)

set(proto_URL https://github.com/protocolbuffers/protobuf.git)
set(proto_TAG v22.2)

if (FUZZTEST_USE_GTEST OR FUZZTEST_TESTING)
  FetchContent_Declare(
    googletest
    GIT_REPOSITORY ${gtest_URL}
    GIT_TAG        ${gtest_TAG}
  )
endif ()

FetchContent_Declare(
  abseil-cpp
  GIT_REPOSITORY ${absl_URL}
  GIT_TAG        ${absl_TAG}
)

FetchContent_Declare(
  re2
  GIT_REPOSITORY ${re2_URL}
  GIT_TAG        ${re2_TAG}
)

if (FUZZTEST_TESTING)
  FetchContent_Declare(
    protobuf
    GIT_REPOSITORY ${proto_URL}
    GIT_TAG        ${proto_TAG}
  )
endif ()

set(ABSL_PROPAGATE_CXX_STD ON)
FetchContent_MakeAvailable(abseil-cpp)
set(RE2_BUILD_TESTING OFF CACHE BOOL "")
FetchContent_MakeAvailable(re2)

if (FUZZTEST_USE_GTEST OR FUZZTEST_TESTING)
  FetchContent_MakeAvailable(googletest)
endif()

if (FUZZTEST_TESTING)
  set(protobuf_BUILD_TESTS OFF)
  set(protobuf_INSTALL OFF)
  FetchContent_MakeAvailable(protobuf)
endif ()
