## High Order

## Summary
1. [What is](#what-is)
2. [Abstraction Principle](#abstraction-principle)
3. [Map](#map)
4. [More](#map)

### What is
- _High Order functions_ either take other functions as input or return other functions as output.
- The positive sides are:
  - Allows to write general, reusable code.
```ocaml
let double x = 2 * x;;

(*High order, using a function to write another function*)
let quad x = double (double x);;
```
- The [meaning](https://www.cs.cornell.edu/courses/cs3110/2019sp/textbook/hop/higher_order.html)

### Abstraction Principle
- This principle can be resumed as:
  1. Recognize a similarity
  2. Abstract them
- The same way as we have done in the example above
- Remember _pipelines_? It's an great example of a _higher order function_
```ocaml
let pipeline x f = f x;;
let (|>) = pipeline;;

let x = 5
  |> quad;; (*20*)

printf "Quad of 5: %d" x;;
```

### Map
- Map is _higher order_ function that let you _do something_ in all, and it follows the same pattern of _abstraction principle_
```ocaml
(*Add 1 to all list's items*)
let rec add1 = function
  | [] -> []
  | h::t -> (h+1)::(add1 t);;
  
let lst = [1;2;3;4];;

let lst1 = add1 lst;;

(*This is what we do to each item in add1*)
let add_f = fun x -> x+1;;

(*We can create a function called map, that applys f into every item*)
let rec map f = function
  | [] -> []
  | h::t -> (f h)::(map f t);;

let lst2 = map add_f lst;;
let lst2 = map (fun x -> x + 1) lst;;
```

### More
- I could add more examples, like:
  - Filter
  - Folds
  - Currying
  - Pipeline
  - etc.
- But those are just examples that could be inferred using the [Map](#map) and the [Abstraction Principle](#abstraction-principle)
- Feel free to look at it at: [CS Cornel Higher Order](https://www.cs.cornell.edu/courses/cs3110/2019sp/textbook/hop/intro.html)
