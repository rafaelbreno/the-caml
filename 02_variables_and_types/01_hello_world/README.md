## Hello World
- To create a _"hello world"_ file you need to suffix it with `.ml`, to start it, let's create a `hello_world.ml`
- Now to run it, you can just use:
  - > ocamlc -o hello_world.byte hello_world.ml
  - Being:
    - `-o` a output flag
    - `hello_world.byte` the compiled code
    - `hello_world.ml` the file that we want to compile
  - And then `./hello_world.byte`
- The program should print _"Hello, World!"_ and exit

### Ways to build your code
1. Using `ocamlc`
  - This way will generate `.byte`, `.cmi` and `.cmo` files, because you're accessing the compiler directly
2. Using `ocamlbuild`
  - This will only generate a `.byte` executable code in the root folder
  - Generates a `_build/` folder with all compiled code, so it not polutes the root folder
  - For now we'll be sticking with `ocamlbuild`
