## Modules

## Summary
1. [Introduction](#introduction)
2. [Structures](#structures)
3. [Signatures](#signatures)
4. [Abstract Types](#abstract-types)
5. [Examples](#examples)
  - [Example 1](#example-1)
6. [Sharing Constraints](#sharing-constraints)
7. [Include](#include)
8. [Functor](#functor)

### Introduction
- A _module_ is like a toolbox built for a specific action, so instead of writting all the code freely inside the file(s), you may want to _abstract_ certain parts of it inside of a module.
- So, to write a _modular code_ it's needed to provide a support for:
  - __Namespaces:__ A _namespace_ provides a set of name that are grouped together(logically related) and distinction between common names; in OCaml this feature is called _structures_.
  - __Abstraction:__ An _abstraction_ hides some information while revealing other infos. It describes _relationships_ among modules; in OCaml this feature is called _signatures_.
  - __Code Reuse:__ A _moduled system_ provides us the _code reuse_, like we saw on _Abstraction Principle_ where we could use 1 function to be used by various types; in OCaml, there are features called _functors_ and _includes_ that let us reutilise the code.
- Well, I know that's kinda of a lot of information to process now, but don't be scared or overwhelmed by it, in the next topics we'll be studying each one and connection the dots.

### Structures
- _Structures_ are a sequence of definitions
- Definition:
```ocaml
module MyModule = struct
  (*definitions*)
end;;
```
- Being:
  - `MyModule` - module name by convention _must_ start with uppercase letter
  - `struct...end` - Module's scope, it means that anything defined inside the Module __can't__ be accessed unless:
    - Referring to the Module: `MyModule.definition`
    - Opening it: `open MyModule;;`
```ocaml
module ListStack = struct
  let empty = []

  let is_empty lst = (lst = [])

  (*Add item into 1st position*)
  let push x lst = x :: lst;;

  (*Get first item*)
  let peek = function
    | [] -> failwith "Empty"
    | h::_ -> h

  (*Remove the 1st item*)
  let pop = function
    | [] -> failwith "Empty"
    | _::t -> t

  let rec to_string = function
    | [] -> ""
    | h::t -> (string_of_int h) ^ ";" ^ (to_string t)
end;;

(*
  Can't access empty
  But can access ListStack.empty
  or via open
  open ListStack;;

  then you can access all definitions
  *)

let lst = [1;2;3;4;5];;

let lst_is_empty = ListStack.is_empty lst;;
printf "Is empty? %b\n" lst_is_empty;;
printf "List: %s \n" (ListStack.to_string lst);;
let after_pop = ListStack.pop lst;;
printf "List: %s \n" (ListStack.to_string after_pop);;

```
- So you can access the definitions via: `MyModule.definition`
- Inside of the Module can contain:
  - `type` definitions
  - `exception` definitions
  - `let` definitions
  - `open` statements (not seen yet)
  - other _not seen yet_ things
- You can also add some sugar to your code
```ocaml
(*Open Module inside let scope*)
let to_string2 lst = 
  let open ListStack in
  to_string lst;;
printf "List: %s \n" (to_string2 lst);;

printf "List: %s \n" (to_string2 lst);;

let lst' = ListStack.(lst |> add1 |> add1);;
printf "List: %s \n" (to_string2 lst');;
```

### Signatures
- _Signatures_ are this block of code `sig...end`, it's simply a sequence of declarations.
  - `val v : t` it means there's a value named `v` with type `t`
```ocaml
module type ModuleType = sig 
  type 'a stack
  val empty     : 'a stack
  val is_empty  : 'a stack -> bool
  val push      : 'a -> 'a stack -> 'a stack
  val peek      : 'a stack -> 'a
  val pop       : 'a stack -> 'a stack
end;;
```
- A _structure_ matches a _signature_ if the structure provides definitions for all the names specified in the _signature_
- With both matching you can define the _signature_ of a _structure_ using `:`
  - `M : S` 
    - `M` being the module name
    - `:` keyword to define the signature
    - `S` the signature
```ocaml
module type Sig = sig 
  val sum : int list -> int
end;;

module Sum : Sig = struct
  let rec sum = function
    | [] -> 0
    | h::t -> h + (sum t)
end;;

let lst = [1;2;3;4;5];;

printf "Sum: %d\n" (Sum.sum lst);;
```

### Abstract Types
- As seen before the type `'a stack` is _abstract_: the `ModuleType` module type says that there is a type name `'a stack` in any module that implements the module type, but it does not say what that type is defined to be.
- Once we add `: ModuleType` module type annotation to `ListStack`, its `'a stack` type also becomes abstract.
- _TL;DR_ All definition in `S`(signature) __must__ be in `M`(structure), but not all definitions in `M` must be in `S`
```ocaml
module type S1 = sig 
  val add   : int -> int

  val sum   : int list -> int
end;;

module type S2 = sig 
  val f     : int -> int

  val sum   : int list -> int
end;;

module M : S1 = struct
  let empty = []

  let add x = x + 1

  let rec sum = function
    | [] -> 0
    | h::t -> h + (sum t)
end;;
```
- In the example above we can do `M : S1`, but can't `M : S2` because there's no definition `let f` in `M`.

### Examples
- From _CS Cornell_

#### Example 1
- Stacks
```ocaml
module type StackExample = sig
  (* The type of a stack whose elements are type 'a *)
  type 'a stack

  (* The empty stack *)
  val empty : 'a stack

  (*Whether the stack is empty*)
  val is_empty : 'a  stack -> bool

  (* [push x s] is the stack [s] with [x] pushed on the top *)
  val push : 'a -> 'a stack -> 'a stack

  (* [peek s] is the top element of [s].
     Raises Failure if [s] is empty. *)
  val peek : 'a stack -> 'a

  (* [pop s] pops and discards the top element of [s].
     Raises Failure if [s] is empty.*)
  val pop : 'a stack -> 'a stack
end;;

module ListStackExample : StackExample = struct 
  type 'a stack = 'a list

  let empty = []

  let is_empty s = s = []

  let push x s = x :: s

  let peek = function
    | [] -> failwith "Empty"
    | h::_ -> h

  let pop = function
    | [] -> failwith "Empty"
    | _::t -> t
end;;

module ListStackVariant : StackExample = struct 
  type 'a stack = 
    | Empty
    | Entry of 'a * 'a stack

  let empty = Empty

  let is_empty s = s = Empty

  let push x s = Entry (x, s)

  let peek = function
    | Empty -> failwith "Empty"
    | Entry(h,_) -> h

  let pop = function
    | Empty -> failwith "Empty"
    | Entry(_,t) -> t
end;;
```

### Sharing Constraints
- Sometimes you want to expose the type in an implementation of a module, follow the example below:
```ocaml
(*Module type that represents values that support the usual operations from arithmetic*)
module type Arith = sig 
  type t
  val zero      : t
  val one       : t
  val (+)       : t -> t -> t
  val ( * )     : t -> t -> t
  val (~-)      : t -> t
  val to_string : t -> string
end;;

(* Outside of the module Ints, the expression Ints.(one + one) 
   is perfectly fine, but Ints.(1 + 1) is not, because t is abstract:
     outside the module no one is permitted to know that t = int
   *)
module IntsNotShared : Arith = struct 
  type t        = int
  let zero      = 0
  let one       = 1
  let (+)       = Stdlib.(+)
  let ( * )     = Stdlib.( * )
  let (~-)      = Stdlib.(~-)
  let to_string = string_of_int;;
end;;

printf "%s\n" IntsNotShared.(to_string (one + one));;

(* So now using the "Arith with type t = int" 
   it's the same as "the module Ints implements Arith and the type t is int",
   allowing external users of Ints module to use the fact that Ints.t is int*)
module IntsShared : (Arith with type t = int) = struct 
  type t        = int
  let zero      = 0
  let one       = 1
  let (+)       = Stdlib.(+)
  let ( * )     = Stdlib.( * )
  let (~-)      = Stdlib.(~-)
  let to_string = string_of_int;;
end;;

(*now we can do this*)
printf "%s\n" IntsShared.(to_string (one + (one + 1)));;
(*and this*)
printf "%s\n" IntsShared.(to_string (2 + 1));;
```

### Include
- The `include` keyword is a way to extend a module into another
```ocaml
module IntsSharedExtended = struct
  include IntsShared

  let rec fac = function
    | 0 -> 1
    | n -> n + (fac n)
end;;

printf "Fac: %d\n" IntsSharedExtended.( (one + one) |> fac );;
```
- The same thing works with both _signatures_ and _structures_.
```ocaml
module type SetExtended = sig
  (*Doing this, it made 'a t abstract, again. so no one
   outside this module gets to know that its representation type
   is actually 'a list*)
  include Set
  val of_list : 'a list -> 'a t
end;;

(*To solve it we must:*)

module ListSetImpl = struct 
  type 'a t   = 'a list
  let empty   = []
  let mem     = List.mem
  let add x s = x::s
  let elts s  = List.sort_uniq Stdlib.compare s
end;;

module ListSet : Set = ListSetImpl;;

module ListSetExtended = struct
  include ListSetImpl
  let of_list lst = lst
end;;
```

### Functor
- _Functor_ is a _"function" from structures to structures_
  - It's kinda of a function that's not interchangeable with the rest of the functions we've already seen.
- Functions from structures to structures cannot be written or used in the same way as functions from values to values.
```ocaml
(*Here's a simple signature*)
module type X = sig 
  val x : int
end;;

(*Now a simple functor example*)
(*
  Functor name: IncX
  Input name: M
  Input type: X
  Output is the structure that appears on the right-hand side of the equals sign: struct let x = M.x + 1
  Another way to think about IncX is that it's a parameterized structure.
*)
module IncX (M: X) = struct
  let x = M.x + 1
end;;

module A = struct
  let x = 0
end;;
  
(*A.x = 0*)

module B = IncX(A);;
(*B.x = 1*)
printf "B.x : %d\n" B.x;;

module C = IncX(B);;
(*C.x = 2*)
printf "C.x : %d\n" C.x;;
(*
  Each time we pass IncX a structure. When we pass it the structure bound to the name A,
  the input to IncX is struct let x = 0 end. IncX takes that input and procudes an output 
  struct let x = A.x + 1 end. Since A.x is 0, the result is let x = 1. So B is bound to struct
    let x = 1 end. And C, similarly, ends up bound to struct let x = 2 end.
 *)

(*
  A functor can return any structure it like, e.g. the structure 
  below it has a value y, but does not have any value x. In fact, 
  MakeY completely ignores its input structure
*)
module MakeY (M:X) = struct
  let y = 42
end;;
```
- __TL;DR__ you have a _structure_, the process/function that preserves that structure is called a _functor_
- More info at: [Category Theory](#https://en.wikipedia.org/wiki/Category_theory)
- Syntax:
```ocaml
(*syntax*)
module type Sig = sig 
  val x : int
end;;

module type Sig1 = sig 
  val x : int
end;;

module type Sig2 = sig 
  val x : int
end;;

module type Sig3 = sig 
  val x : int
end;;

(*Functor Syntax:
  F - module name
  M - signature name reference(that will be used inside the functor)
  S - type annotation
  *)
module F1 (M : Sig) = struct
  (*definitions*)
  let x = M.x + 1
end;;

(*Anonymous functor Syntax:
  F - Module name
  functor - keyword for functor
  M - signature reference(that will be used inside the functor)
  S - type annotation
  *)
module F2 = functor (M : Sig) -> struct 
  (*definitions*)
  let x = M.x + 1
end;;

(*Parameterize on multiple structures*)
module F3 (M1 : Sig1) (M2 : Sig2) (M3 : Sig3) = struct 
  let x = M1.x + M2.x + M3.x + 1
end;;

(*Parameterize on multiple structures with anonymous functor*)
module F4 = functor (M1 : Sig1) -> functor (M2 : Sig2) -> functor (M3 : Sig3) -> struct 
  let x = M1.x + M2.x + M3.x + 1
end;;

(*Write type annotation on the structure
  F - Module name
  functor - keyword for functor
  M1 - signature reference(that will be used inside the functor)
  S1 - type annotation
  S - struct type annotation
 *)
module F5 (M1 : Sig1) = (struct
  let x = M1.x + 1 

  (*Following this pattern of using parenthesis to annotate a type
   we can do the some on let declarations, for example:
    let x = (M1.x + 1 : int)
   *)
end : Sig);;

(*Annotate a functor definition with a type*)
(*
  F - module name
  functor ( M : S1 ) -> S - What follow is a functor type with:
    M - signature reference(that will be used inside the functor)
    S1 - type annotation
    S - Structure that type that will be returned
 *)
module F6 : functor (M : Sig1) -> Sig = 
(*
    functor ( M : S1 ) -> struct..end - What follow is an anonymous functor
      M - signature reference(that will be used inside the functor)
      S1 - type annotation
      struct..end - structure body
 *)
  functor (M : Sig1) -> struct 
    let x = M.x + 1
  end;;
```
