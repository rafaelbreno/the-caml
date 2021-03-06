## Basics

### Summary
1. [Let Expression](#let-expression)
2. [Scope](#scope)

### Let Expression
- Until now we've been using _let definition_
  - For example: `let inc = fun (arg:int) :int-> arg + 1`
  - This defines a function called `inc`
- Now as expression
  - `let arg = 5 in x + 1`
  - If you try to print it: `printf "%d" arg;;`, will receive the following error: _"unbound value arg"_
  - Because it's a expression, not a value itself
  - To store it would need to do something like: `let x = (let x = 5 in x + 1)`
- Any definition is almost an expression
  - `let x = 5` is `let x = 5 in`
- The _"partition"_ of a _let expression_ is `let x = e1 in e2`, where:
  - `x` is the _identifier_
  - `e1` is the _binding expression_ because it's bound to `x`
  - `e2` is the _body expression_ because that's the body of code in which the _binding_ will be in scope
```ocaml
let inc = fun (arg:int) :int-> arg + 1;;
let inc_1 = inc 1;;
printf "inc_1 = %d\n" inc_1;;

(**Let Expression**)
(* let x = e1 in e2;; *)
let x = 42 in x + 1;;
(*unbound value to x: printf "%d" x;;*)

let x = (let x = 42 in x + 1);;
(*Now this works*)
printf "%d\n" x;;

printf "let x = 42 in x + 1: %d \n" (let x = 42 in x + 1);;

printf "let x = 42 in (fun (arg1:int) :int -> inc arg1) x : %d\n"(let x = 42 in (fun (arg1:int) :int -> inc arg1) x);;
```

### Scope
- Is where a _"definide thing"_(functions, expression, etc) can be accessed or not, or in other words:
  - _"Let bindings are in effect only in the block of code in which they occur."_
```
(*Openining a scope*)
let _ =
  let forty = 40 in
  (*forty can be accessed here*)
  printf "%d\n" forty;;

(*forty cannot be accessed here*)
(*printf "%d" forty;;*)
```

### Main Function
- There's no main, just a function that you define and then at the end of the script you call it
```
let rec counter (from:int) (until:int) =
  if from<until then begin
    printf "counter: %d\n" from;
    counter (from + 1) until;
  end;;

(*Main Function*)
let main () =
  printf "%s\n" "Begin main function";
  counter 1 10;
  printf "%s\n" "End main function";
;;

(*Calling at the of the file*)
main ();;
```ocaml
