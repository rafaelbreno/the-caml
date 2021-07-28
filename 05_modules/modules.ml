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
  val pop : 'a stack -> '
end;;


(**************************************)

(**************  **************)
printf "%s" "-------  -------\n";;
(**************************************)

(**************  **************)
printf "%s" "-------  -------\n";;
(**************************************)

(**************  **************)
printf "%s" "-------  -------\n";;
(**************************************)
