#pragma once

#include <fmt/core.h>

[[nodiscard]] inline int some_fun() {
  fmt::print("Hello {} !", "world");
  return 0;
}

[[nodiscard]] constexpr int some_constexpr_fun() {
  return 0;
}
