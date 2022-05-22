#include <catch2/catch.hpp>
#include <my_header_lib/lib.hpp>

TEST_CASE("some_constexpr_fun") {
  STATIC_REQUIRE(some_constexpr_fun(0) == 0);
}
