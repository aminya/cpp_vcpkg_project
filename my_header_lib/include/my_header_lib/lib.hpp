#pragma once

#include <fmt/core.h>

inline int some_fun() {
  fmt::print("Hello {} !", "world");
  return 0;
}

constexpr int some_constexpr_fun() {
  return 0;
}