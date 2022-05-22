#include <fmt/format.h>
#include <iterator>
#include <utility>
#include <my_header_lib/lib.hpp>

// Fuzzer that attempts to invoke undefined behavior for signed integer overflow
// cppcheck-suppress unusedFunction symbolName=LLVMFuzzerTestOneInput
extern "C" int LLVMFuzzerTestOneInput(const uint8_t *Data, size_t Size) {
  fmt::print("Value sum: {}, len{}\n", some_fun(Data, Size), Size);
  return 0;
}
