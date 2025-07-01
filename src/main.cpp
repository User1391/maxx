#include "maxxLexer.h"
#include "maxxParser.h"
#include <antlr4-runtime.h>
#include <iostream>

int main(int argc, const char *argv[]) {
  std::ifstream stream("test.mxl");
  antlr4::ANTLRInputStream input(stream);
  maxxLexer lexer(&input);
  antlr4::CommonTokenStream tokens(&lexer);
  maxxParser parser(&tokens);

  auto tree = parser.statement(); // start rule from your grammar

  std::cout << "Parsed successfully.\n";
  return 0;
}
