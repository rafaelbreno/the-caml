## Pattern Matching
- Mostly notations

### Summary
1. [Let](#let)
  - [Dynamic Semantics](#dynamic-semantics)
  - [Static Semantics](#static-semantics)
  - [Let Definitions](#let-definitions)
2. [With Functions](#with-functions)
3. [Advanced Patterns](#advanced-patterns)
  - [References](#references)
4. [Options](#options)

### Let

#### Dynamic Semantics
- Dictionary:
  - p - pattern
  - en - expression _n_ (n being 1..n)
  - vn - value _n_ (n being 1..n)
- Looking at `let p = e1 in e2`
  1. Evalute `e1` to value `v1`
  2. Match `v1` against `p`.
    - If match: Produces a set _b_ of bindings
    - If does not: Raise an exception _Match_failure_(but like I said, we're going to see exceptions later)
  3. Substitute _b_ in `e2`, yielding a new expression `e2'`
  4. Evalute `e2'` to value `v2`
  5. The result of it is `v2`

#### Static semantics
- Dictionary:
  - en - expression _n_ (n being 1..n)
  - tn - type _n_ (n being 1...n)
  - xn - variables _n_ (n being 1..n)
- If:
  - `e1:t1`
  - the pattern variables in _p_ are x1..xn
  - `e2:t2` under the assumptions that for all `i` in _1..n_ it holds that `x1:ti`
- Then:
  - `(let p = e1 in e2) : t2`

#### Let Definitions
- Dictionary:
  - p - pattern
  - e - expression
- Understood as: _let expression whoose body has not yet been given_
- `let p = e`

```ocaml
printf "%s" "------- Let -------\n";;
(*let definition*)
let langs = "OCaml,PHP,Go,Haskell";;

(*let expression*)
let dashed langs =
  let lang_list = String.split_on_char ',' langs in
  String.concat "-" lang_list;;

let dashed_lang = dashed langs;;
printf "Comma: %s\n" langs;;
printf "Dash: %s\n" dashed_lang;;
```

### With Functions
- Dictionary:
  - p - pattern
  - en - expression _n_ (n being 1..n)
  - f / fun - function 
```ocaml
let f p1 ... pn = e1 in e2   (* function as part of let expression *)
let f p1 ... pn = e          (* function definition at toplevel *)
fun p1 ... pn -> e           (* anonymous function *)
```

### Advanced Patterns
- `p1 | ... | pn`: an "or" pattern; matching against it succeeds if a match succeeds against any of the individual patterns pi, which are tried in order from left to right. All the patterns must bind the same variables.
- `(p : t)`: a pattern with an explicit type annotation.
- `c`: here, `c` means any constant, such as integer literals, string literals, and booleans.
- `'ch1'..'ch2'`: here, ch means a character literal. For example, 'A'..'Z' matches any uppercase letter.
- `p when e`: matches p but only if e evaluates to true.

#### References
- [Pattern Form](https://ocaml.org/manual/patterns.html)
- [Examples](https://www.cs.cornell.edu/courses/cs3110/2019sp/textbook/data/pattern_matching_examples.html)

### Options
- Let's look at this case, you have a function `int_max` that returns the maximum value of a list
  - If the list is empty, what would you return? Returning `0` doesn't make sense
- To solve this issue there's something called an _option_
  - If have a value to return: Simply using `Some`
  - If not: `None`
```ocaml
let rec list_max = function
  | [] -> None (*If empty*)
  | h::t -> begin (*Being a list with at least 1 item*)
    match list_max t with (*recalls itself*)
    | None -> Some h (*If t is empty it means there's only one item, so itself is the max*)
    | Some m -> Some(max h m) (*Having more than 1 item, calls *)
  end;;

let lst = [1; 2; 3; 4; 5; 6];;
let empty_lst = [];;

let print_max = function
  | None -> printf "%s\n" "There's no item" (*If the type is None*)
  | Some max_val -> printf "Max: %d\n" max_val;; (*If the type is Some, bind int option into int*)

print_max (list_max lst);;
print_max (list_max empty_lst);;
```
- [Begin End block](https://ocaml.org/learn/tutorials/if_statements_loops_and_recursion.html#Using-begin-end)
