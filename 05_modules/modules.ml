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

printf "Sum: %d" (Sum.sum lst);;

(**************************************)

(************** Abstract Types **************)
printf "%s" "------- Abstract Types -------\n";;
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

(**************  **************)
printf "%s" "-------  -------\n";;
(**************************************)
