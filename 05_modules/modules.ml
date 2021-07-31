open Format;;

(************** Structures **************)
printf "%s" "------- Structures -------\n";;
module MyModule = struct
  (*definitions*)
end;;

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

  let rec add1 = function
    | [] -> []
    | h::t -> (h+1)::(add1 t)

  let rec to_string = function
    | [] -> ""
    | h::t -> (string_of_int h) ^ ";" ^ (to_string t)
end;;

(*
  Can't access empty
  But can access ListStack.empty
  *)

let lst = [1;2;3;4;5];;

let lst_is_empty = ListStack.is_empty lst;;
printf "Is empty? %b\n" lst_is_empty;;
printf "List: %s \n" (ListStack.to_string lst);;
let after_pop = ListStack.pop lst;;
printf "List: %s \n" (ListStack.to_string after_pop);;

(*Open Module inside let scope*)
let to_string2 lst = 
  let open ListStack in
  to_string lst;;

printf "List: %s \n" (to_string2 lst);;

let lst' = ListStack.(lst |> add1 |> add1);;
printf "List: %s \n" (to_string2 lst');;


(**************************************)

(************** Signatures **************)
printf "%s" "------- Signatures -------\n";;

module type ModuleType = sig 
  type 'a stack
  val empty     : 'a stack
  val is_empty  : 'a stack -> bool
  val push      : 'a -> 'a stack -> 'a stack
  val peek      : 'a stack -> 'a
  val pop       : 'a stack -> 'a stack
end;;

module type Sign = sig 
  val sum : int list -> int
end;;

module Sum : Sign = struct
  let rec sum = function
    | [] -> 0
    | h::t -> h + (sum t)
end;;

let lst = [1;2;3;4;5];;

printf "Sum: %d\n" (Sum.sum lst);;

(**************************************)

(************** Abstract Types **************)
printf "%s" "------- Abstract Types -------\n";;

let lst = [1;2;3;4;5];;

module type S1 = sig 
  val add   : int -> int

  val sum   : int list -> int
end;;

module type S2 = sig 
  val add   : int -> int

  val sum   : int list -> int
end;;

module M : S1 = struct
  let empty = []

  let add x = x + 1

  let rec sum = function
    | [] -> 0
    | h::t -> h + (sum t)
end;;

printf "Sum: %d\n" (M.sum lst);;


(**************************************)

(************** Example 1 - Stacks **************)
printf "%s" "------- Example 1 - Stacks -------\n";;

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
(**************************************)

(************** Sharing Constraints **************)
printf "%s" "------- Sharing Constraints -------\n";;

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
(**************************************)

(************** Include **************)
printf "%s" "------- Include -------\n";;

module IntsSharedExtended = struct
  include IntsShared

  let rec fac = function
    | 0 -> 1
    | n -> n + (fac n)
end;;

(** Encapsulation of Includes **)
(*Here we have Set signature*)
module type Set = sig
  type 'a t
  val empty : 'a t
  val mem   : 'a -> 'a t -> bool
  val add   : 'a -> 'a t -> 'a t
  val elts  : 'a t -> 'a list
end;;

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
(**************************************)

(************** Functor **************)
printf "%s" "------- Functor -------\n";;
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
(**************************************)
