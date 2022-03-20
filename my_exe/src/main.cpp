#include <fmt/core.h>
#include <my_exe/helpers.hpp>

int main() {
  fmt::print("Hello {} !", "world");

  auto some_num = some_fun();
  fmt::print("\nsome_num is: {}\n", some_num);

  return 0;
}
