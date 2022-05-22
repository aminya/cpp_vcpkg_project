#include <catch2/catch.hpp>
#include <my_header_lib/lib.hpp>

TEST_CASE("some_fun") {
  REQUIRE(some_fun(0) == 0);
  REQUIRE(some_fun(1) == 1);
}
