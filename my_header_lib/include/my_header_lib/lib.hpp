#pragma once

#include <fmt/core.h>

inline int some_fun(const int inp) {
  fmt::print("Hello {} !", "world");
  return inp;
}

constexpr int some_constexpr_fun(const int inp) {
  return inp;
}