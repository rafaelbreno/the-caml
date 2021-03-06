(*Library for pretty print*)
open Format;;

(*list print*)
let print_list f lst = 
  let rec print_elem = function
    | [] -> ()
    | i::l -> f i ; print_string ";"; print_elem l
  in
  print_string "[";
  print_elem lst;
  print_string "]\n";;

(*Syntax*)
printf "%s\n" "------- Syntax -------";;
let l1 = [];; (*nil*)
print_list print_int l1;;

let l2 = 1::2::3::4::-1::8::[];;
print_list print_int l2;;

let l3 = [8; -1; 4; 3; 2; 1; 47];;
print_list print_int l3;;
(*---------------------------------------------------------*)

(*Accessing*)
printf "%s\n" "------- Accessing -------";;
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
(*---------------------------------------------------------*)

(*Mutating*)
printf "%s\n" "------- Mutating -------";;
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
(*---------------------------------------------------------*)

(*Pattern Matching*)
printf "%s\n" "------- Pattern Matching -------";;
let rec inc lst =
  match lst with
  | [] -> [] (*matching with [] bind to nothing*)
  | h::t -> (h+1)::(inc t);; (*
  matching with a list(h::t) bind the first
  element to h and the rest(a list) to t
  *)
(*---------------------------------------------------------*)
(*Tail Recursion*)
printf "%s\n" "------- Tail Recursion -------";;

let rec sum (l:int list) : int = 
  match l with
  | [] -> 0
  | h::t -> h + (sum t);;

let rec sum_plus_acc (acc:int) (l:int list) : int =
  match l with
  | [] -> acc (*acc stands for accumulator (I guess)*)
  | h::t -> sum_plus_acc (acc + h) t;;

(*tr stands for tail recursive*)
let sum_tr : int list -> int =
  sum_plus_acc 0;;

let l = [1;2;3;4;5;6;7;8;9;10];;

printf "Without TR: %d\n" (sum l);;
printf "With TR: %d\n" (sum_tr l);;
(*---------------------------------------------------------*)

(*More Syntax*)
printf "%s\n" "------- More Syntax -------";;

let rec sum (l:int list) = 
  match l with
  | [] -> 0
  | h::t -> h + (sum t);;

let rec sum_sugary = function
  | [] -> 0
  | h::t -> h + (sum t);;

printf "Non-sugar: %d\n" (sum l);;
printf "Sugary: %d\n" (sum_sugary l);;
(*---------------------------------------------------------*)
(*Association*)
printf "%s\n" "------- Association -------";;
let map = [ ("Brasil", 55); ("Mexico", 21) ];;

let prepend k v map = (k,v)::map;;
let rec find k = function
  | [] -> None
  | (k', v)::t -> (*here k' is just an identifier, it could be kk too. It's TOTALLY different from 'a that's a general type*)
      if k=k' 
      then Some v 
      else find k t;;

let found = find "Brasil" map;;

let print_found = function
  | None -> printf "Not found \n"
  | Some v -> printf "Key found! Value: %d\n" v;;

print_found found;;
(*---------------------------------------------------------*)
