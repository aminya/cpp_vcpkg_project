#include <catch2/catch.hpp>
#include <my_lib/lib.hpp>

TEST_CASE("some_fun") {
  REQUIRE(some_fun() == 0);
}
