## Functions

## Summary
1. [Declaring a Function](#declaring-a-function)
2. [Function Params](#function-params)
3. [Typed Function Params](#typed-function-params)
4. [and keyword](#and-keyword)
5. [Anonymous function](#anonymous-function)
6. [Pipeline](#pipeline)
7. [Polymorphic function](#polymorphic-function)
8. [Arguments](#arguments)
  1. [Labeled Arguments](#labeled-arguments)
  2. [Typed Labeled Arguments](#typed-labeled-arguments)
  3. [Optional Arguments](#optional-arguments)
9. [Partial Application](#partial-application)
  1. [Function Associativity](#function-associativity)
10. [Operator as Function](#operator-as-function)

## Declaring a Function
- "Normal" function can be declared as:
```ocaml
let f = ...
```
- Being:
  - `f` the function name
  - `...` the function body

- Recursive function can be declared as:
```ocaml
let rec f = ...
```
- Being:
  - `rec` the recursive declaration
  - `f` the function name
  - `...` the function body

## Function Params
- The params can be defined after the function name
```ocaml
let fac n =
  if n=0 
  then 1 
  else n * fac (n-1);;
```
- Being:
  - `rec` the recursive declaration
  - `f` the function name
  - `n` a parameter
  - `...` the function body

## Typed Function Params
- The params can be type following the structure `(n : T)`, being
  - `n` param name
  - `T` param type
- It can be applied to function returned value:
```ocaml
let rec pow (x:int) (y:int) : int = 
  if y=0 then 1
  else x * pow x (y-1);;

let pow_2_2 = pow(2)(2);;

print_int pow_2_2;;
```
- Being `: int` the returned function value type

## and keyword
- The `and` keyword allows to declare multiple functions, and each will inherit the first one(if is `rec` or not)
```ocaml
(* And Keyword *)
let rec pow_2 (x:int) : int = 
  x * x
and pow_3 (x:int) : int =
  x * x * x;;

(* pow_3 will inherit the `rec` from pow_2 *)

let pow_2_2 = pow_2 2;;
let pow_2_3 = pow_3 3;;

print_int pow_2_2;;
print_endline "";;
print_int pow_2_3;;
print_endline "";;
```

## Anonymous function
- To declare a anonymous function you can follow the structure: `let f = fun (n:T) (r:T) -> ...`
  - `f` - The function name
  - `fun` - Key word to define that it's a function
  - `(n:T)` - Param `n` of type `T`
  - `(r:T)` - Returned value of type `T`
  - `->` - Keyword to separate arguments from function body
  - `...` - The function body
```ocaml
(* Option 1 - Normal declaration*)
let inc (n:int) : int = n + 1;;
(* Option 2 - Anonymous function*)
let inc = fun x -> x+1;;
(* Option 3 - Typed Anonymous function*)
let inc = fun (x:int) :int -> x+1 ;;
```
- _Anonymous functions_ can also be called _Lambda expressions_

## Pipeline
- There's as infix `|>`, it's almost as there's a pipeline sending values from _left to right_
```ocaml
(*Pipeline*)
let inc = fun (x:int) :int -> x+1 ;;
let square = fun (x:int) : int -> x*x;;

let five_inc_square = square (inc 5);;
print_int five_inc_square;;
print_endline "";;

let five_inc_square = 5
  |> inc (*inc receives 5 and return 6*)
  |> square (*square receives 6 from inc and return 36*);;

print_int five_inc_square;;
print_endline "";;

(*Writing functions inside the pipeline*)
let five_inc_square = 5
  |> fun (n:int) :int -> n+1 (*inc receives 5 and return 6*)
  |> fun (n:int) :int -> n*n (*square receives 6 from inc and return 36*);;

print_int five_inc_square;;
print_endline "";;
```

## Polymorphic function
- __Exclaimer!__ to run this examples you need to use: _utop(terminal pkg)_ or _[Try OCaml](https://try.ocamlpro.com/)_
- There's a function called _identity function_
- > let id x = x
- Declaring it on `utop`, it should show: `id : 'a -> 'a  = <fun>`
- Being:
  - `'a` a _type variable_, it stands for a unknown type. To spot one you can look for the single quote(`'`)
- Applying the function to any value, it shows:
  - `id 42;;` -> `- : int = 42`
  - `id true;;` -> `- : bool = true`
  - `id "hello";;` -> `- : string = "hello"`
- That's why it's called a _polymorphic function_, because you can apply it to any type

## Arguments
### Labeled Arguments
- When declaring a function you can label the arguments, so when using the function you know what is going to be used
- Following the structure: `f ~arg1:n1 = ...`
- Being:
  - `f` - Function name
  - `~` - Identifier to a named argument
  - `arg1` - The argument label
  - `:` - Separator
  - `n1` - The argument itself that will be referred inside the function
  - `...` - Function body
```ocaml
(*Labeled arguments*)
let sum ~arg1:n1 ~arg2:n2 = n1+n2;;
```
### Typed Labeled Arguments
- The argument can be typed too: `f ~arg1:(n1:T) = ...`
  - `f` - Function name
  - `~` - Identifier to a labeled argument
  - `arg1` - The argument label
  - `:` - Separator
  - `n1` - The argument itself that will be referred inside the function
  - `T` - The argument type
  - `...` - Function body
```ocaml
(*Typed labeled arguments*)
let rec pow ~base:(b:int) ~expoent:(e:int) : int = 
  if e=0 then 1
  else b * pow ~base:b ~expoent:(e-1);;
```

### Optional Labeled Arguments
- When defining the arguments, you can also declare if it is optional with: `?arg1:(n1=0)`
  - `?` - Identifier to optional argument
  - `arg1` - Argument label
  - `:` - Separator
  - `n1` - The argument itself that will be referred inside the function
  - `0` - The argument default value

```ocaml
let sum = fun ~arg1:(n1:int) ?arg2:(n2=8) ->
  n1 + n2;;

let sum_2_4 = sum ~arg1:2 ~arg2:4;;
print_int sum_2_4;;
print_endline "";;

let sum_2_4 = sum ~arg1:2 ~arg2:4;;

print_int sum_2_4;;
print_endline "";;
```

### Partial Application
- This is when you _partially_ apply a function
- Following a template: `let addx (partial_arg:int) = fun (arg:int) :int -> partial_arg + arg`
  - `addx` - Function name
  - `partial_arg:int` - Partial argument of type `int`
  - `fun` - Function identifier
  - `arg:int` - Argument of type `int`
  - The rest, you know the drill
- So when you do something: `let add5 = addx 5`
  - The `partial_arg` will assume the value of `5`
  - `add5` will be: `add5: int -> int = <fun>`
  - Means that add5 is a function that receives a int and returns a int
```ocaml
let addx (partial_arg:int) = fun (arg:int) :int ->
  partial_arg+arg;;

let add7 = add 7;;
let add7_2 = add7 2;;

print_int add7_2;;
print_endline "";;
```

#### Function Associativity
- Just a little theory: _"Every OCaml function takes exacly one argument"_
- Why?
- Because:
  - This: `let add (arg1:int) (arg2:int) :int = arg1 + arg2`
  - Is equal to: `let add (arg1:int) (arg2:int) :int = fun (arg1:int) :int -> (fun (arg2:int) :int -> arg1 + arg2)`
  - And this goes to infinity

### Operator as Function
- You can declasse something called _preffix operator_
- `let op = (operator) arg:T`
  - `op` - Function name
  - `operator` - the operator
  - `args:T` - the arg with type `T`
```ocaml
```
