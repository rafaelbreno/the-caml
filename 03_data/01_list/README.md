## List

## Summary
1. [Syntax](#syntax)
2. [Accessing](#accessing)
3. [Mutating](#mutating)
4. [Pattern Matching](#pattern-matching)

### Syntax
- List can be defined as:
  - `let l = []`
  - `let l = e1::e2` - The last item MUST be a list(even a _nil_ `[]`)
  - `let l = [e1; e2; ...; en]`
- To print it, I found this function:
```ocaml
let print_list f lst = 
  let rec print_elem = function
    | [] -> ()
    | i::l -> f i ; print_string ";"; print_elem l
  in
  print_string "[";
  print_elem lst;
  print_string "]\n";;
```
- If you don't undestand it, it's fine, we'll see more about those in the following items
- It prints the first value of the list `i`, and recall the function to the remaining elements `l`
```ocaml
let l1 = [];; (*nil*)
print_list print_int l1;;

let l2 = 1::2::3::4::-1::8::[];;
print_list print_int l2;;

let l3 = [8; -1; 4; 3; 2; 1];;
print_list print_int l3;;
```

### Accessing
- To access te elements, we'll something called _pattern matching_
```ocaml
let rec sum lst :int =
  match lst with
  | [] -> 0 (*if match with empty list return 0*)
  | h::t -> h + sum t;; (*
    if match with h::t being
    h(head) the first element
    t(tail) the remaining elements of lst
    it sums h with sum t
  *)

(*In another idiom*)
let rec sum_xs xs = (*xs reading ex-uhs*)
  match xs with
  | [] -> 0
  | x::xs' -> x + sum xs';; (*xs' reading ex-uhs prime*)

(*Length of a list*)
let rec len lst =
  match lst with
  | [] -> 0
  | _::t -> 1 + len t;; (*
  note that because we won't need h 
  we can replace it with underscore
  *)

(*append two lists*)
let rec append lst1 lst2 = 
  match lst1 with
  | [] -> lst2
  | h::t -> h::(append t lst2);;

let lst = [8; -1; 4; 3; 2; 1];;
let sum_res = sum lst;;
printf "%d = sum of " sum_res;;
print_list print_int lst;;

let len_lst = len lst;;
printf "%d = len of " len_lst;;
print_list print_int lst;;

let lst1 = [1;2;3];;
let lst2 = [4;5;6];;

printf "%s" "appending [1;2;3] and [4;5;6] with append: ";;
let lst1_lst2 = append lst1 lst2;;
print_list print_int lst1_lst2;;

printf "%s" "appending [1;2;3] and [4;5;6] with @: ";;
let lst1_lst2 = lst1 @ lst2;;
print_list print_int lst1_lst2;;
```

### Mutating
- Lists are immutable, so when the list is "mutated" it really is creating another list
  - Another thing, immutability is something present on FP
```ocaml
let rec inc lst =
  match lst with
  | [] -> [] (*matching with nil list return nil*)
  | h::t -> (h+1)::(inc t);; (*
  matching with a list
  get the head, increment it and
  then append it to a another inc 
  with the tail(remaining elements)
  *)

let lst = [1; 0; -1; 8; 19; 41];;
let lst_inc = inc lst;;
print_list print_int lst;;
print_list print_int lst_inc;;
```

### Pattern Matching
- Syntax:
```ocaml
match e with (*e being a expression*)
| p1 -> e1 (*the first bar (|) is optional, the rest is obligatory*)
| p2 -> e2 (*p being a pattern*)
| p3 -> e3 (*each one is called branch or pattern match*)
| ...
| pn -> en
```
- For each pattern:
  - A variable _CANNOT_ appear twice in the same pattern, e.g `x::x` (x being a variable name)
- It involves two inter-related tasks:
  - determining whether a pattern matches a value 
    - whether a pattern and value have the same shape
  - determining what parts of the value should be associated with which variable names in the pattern
    - Determine the _variable bindings_ introduced by the pattern

```ocaml
(* THIS IS NOT A PRATICAL PATTERN MATCHING*)
let example lst =
  match lst with
  | [] -> [] (* [] matches with [] and produces no binds*)
  | _ -> [] (* _ matches ANY VALUE and produces no binds *)
  | h::t -> (h+1)::t ;; (*h::t matches with lst and produce binds(h and t)*)
```

- Again, looking at:
```ocaml
let example v =
  match v with
  | p1 -> e1 
  | p2 -> e2 
  | p3 -> e3 
  | ...
  | pn -> en
```
- Evalute `e` to a value `v`
- Match `v` against : `p1`, `p2`, ..., `pn`
- If anything matches, raise a _exception_ `Match_Failure`
  - we'll learn how to handle exceptions and what they're in the future
