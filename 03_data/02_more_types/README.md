## More Types

### Summary
1. [Variants](#variants)
  - [Recursive Variants](#recursive-variants)
  - [Parameterized Variants](#parameterized-variants)
  - [Polymorphic Variants](#polymorphic-variants)
2. [Records](#records)
  - [Recursive Records](#recursive-records)
3. [Tuples](#tuples)
4. [Type Synonyms](#type-synonyms)
5. [Algebraic Data Types](#algebraic-data-types)
6. [Catch All](#catch-all)

### Variants
- It's like an `enum` in other languages
- Each value of a variant is called _constructor_
```ocaml
printf "%s" "------- Variants -------\n";;
type month = January | February | March | April | May | June | July | August | September | October | November | December;;

let november:month = November;;

(*There's no easy way to do it*)
let int_month = function
  | January -> 1
  | February -> 2
  | March -> 3
  | April -> 4
  | May -> 5
  | June -> 6
  | July -> 7
  | August -> 8
  | September -> 9
  | October -> 10
  | November -> 11
  | December -> 12;;

printf "November is the %d° month of the year\n" (int_month november);;
```

#### Recursive Variants
- Variants may call itself inside their own body
```ocaml
type intlist = 
  | Nil
  | Cons of int * intlist;; (*Cons as constructor*)

let l3 = Cons(3, Nil) (*similar to 3::[] or [3]*)
let lst = Cons(1, Cons(2, l3));; (*similar to [1;2;3]*)

let rec sum (l:intlist) : int = 
  match l with
  | Nil -> 0
  | Cons(h,t) -> h + sum t;;

printf "Sum: %d\n" (sum lst);;
```

#### Parameterized Variants
- You can instead of define a single type you can use `'a` for a general type
  - Now `somelist` is a _type constructor_, not a _type_
```ocaml
type 'a somelist = (*This will allow to somelist accept any value, because 'a is a general type*)
  | Nil
  | Cons of 'a * 'a somelist;;

let int_list = Cons(1, Cons(2, Cons(3, Nil)));; (*Same as [1;2;3]*)
let str_list = Cons("Hello", Cons(", World!", Nil));; (*Same as ["Hello";", World!"]*)

let rec len : 'a somelist -> int = function
  | Nil -> 0
  | Cons(_, t) -> 1 + len t;;

printf "Length of int_list: %d\n" (len int_list);;
printf "Length of str_list: %d\n" (len str_list);;
```

#### Polymorphic Variants
```ocaml
type fin_or_inf = 
  | Finite of int
  | Infinity;;

let f = function
  | 0 -> Infinity
  | 1 -> Finite 1
  | n -> Finite(-n);;
(*
  But using the way above, you were forced to define a type fin_or_inf
  even though you may no use it directly in the rest of the code.
 *)
```
- To avoid that we can use _polymorphism_
  - The constructor for a polymorphic variant is the __`__ (as known as: grave accent, backtick)
- _Variants_ vs _Polymorphic Variants_
  - Polymorphic Variants don't have to declare their type or constructors
```ocaml
(*Just this is sufficient*)
let f = function
  | 0 -> `Infinity
  | 1 -> `Finite 1
  | n -> `Finite (-n);;
(*This means:
  f returns "Finite n" for n:int
  or Infinity
  *)

let print_n (n:int) =
  match f n with
  | `Infinity -> printf "Infinity\n"
  | `Finite n -> printf "Finite of value: %d\n" n;;

print_n 2;
print_n 0;
```

### Records
- I like to see `records` as structs, you have the `name` for it, and the fields, each _field_ has a name and a _type_
```ocaml
printf "%s" "------- Records -------\n";;
type employee = {
  name: string;
  age: int;
};;

let foo:employee = { name = "Foo"; age = 42 };;
let bar = { name = "Bar"; age = 67 };;
```

#### Recursive Records
- Like _variants_, records can may be recursive too using the `and` keyword
```ocaml
type node = {
  value:int;
  next:mylist
  } and
  mylist = 
  | Nil
  | Node of node;;

let foo:node = {
  value = 10;
  next = Node({
    value = 13;
    next = Nil
  })
};;
```

### Tuples
- Tuples is kinda of a _list_ but it allows you to mix the types, so in a tuple you can have _int_, _string_, _variants_, _records_, etc.
```
printf "%s" "------- Tuples -------\n";;
let t1 = (10, 70, 20);;
let t2 = ("Foo", "Bar", 6);;

let get_apples = fun t : int ->
  match t with
  | (x, y, z) -> (x + y + z);;

let concat (x, y, _) : string = sprintf "%s%s" x y;;

printf "Total amount of apples: %d\n" (get_apples t1);;
printf "Concat: %s\n" (concat t2);;
```

### Type Synonyms
- A _type sysonym_ is a new name for a existing type:
```
type point = float * float;;

(*float * float*)
let p_1_3 = (1.,3.);;
let p_5_8 = (-5.67777,8.99999);;

let getx : point -> float = 
  fun (x,_) -> x;;

printf "X of (1.,3.): %.2f\n" (getx p_1_3);;
printf "X of (-5.67777,8.99999): %.2f\n" (getx p_5_8);;
```

### Algebraic Data Types
- Using variants you can do this:
```ocaml
type point = float * float;;
type shape =
  | Point of point
  | Circle of point * float (* center and radius*)
  | Rectangle of point * point;; (*lower-left and upper-right corners*)

let area = function
  | Point _ -> 0.0
  | Circle (_,r) -> Float.pi *. (r ** 2.0)
  | Rectangle ((x1,y1), (x2,y2)) -> 
      let w = x2 -. x1 in
      let h = y2 -. y1 in
        w *. h;;

let circle:shape = Circle((1.,2.), 5.);;
let rect:shape = Rectangle((0.,0.),(1.,1.));;

printf "Circle area: %.2f\n" (area circle);;
printf "Rectangle area: %.2f\n" (area rect);;

type string_or_int =
  | String of string
  | Int of int;;

(*Allow a type-safe approach*)
let rec sum : string_or_int list -> int = function
  | [] -> 0
  | (String str)::t -> int_of_string str + sum t
  | (Int i)::t -> i + sum t;;

printf "Sum of \"5\" and 3: %d\n" (sum [String "5"; Int 3]);;
```

### Catch All
- _"Gotta catch 'em all"_, not really
- The case _"\_"_ in pattern matching, catch all cases, this is a thing that you MUST avoid using, because it lead to a buggy code
```ocaml
type color = 
  | Blue
  | Red
  | Green;;

(*Instead of this*)
let color_to_string : color -> string = function
  | Blue -> "blue"
  | Red -> "red"
  | _ -> "green";;

(*Do this*)
let color_to_string : color -> string = function
  | Blue -> "blue"
  | Red -> "red"
  | Green -> "green";;
```
