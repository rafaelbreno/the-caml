(*Using format to pretty-print things *)
open Format;;

(* Hello World Function *)
printf "%s\n" "------- Hello World -------";;
let hello = print_endline "Hello, World!";;
hello;;

(*---------------------------------------------------------*)

(* Factorial recursive function *)
printf "%s\n"  "------- Recursive Function -------";;

let rec fac n = 
  if n=0 
  then 1 
  else n * fac (n-1);;

(* Declaring a variable result*)
let fac_2 = fac(2);;

(* printing the result *)
printf "%d\n" fac_2;;

(*---------------------------------------------------------*)
printf "%s\n" "------- Typed Function -------";;

(* Power of x to y function *)
let rec pow (x:int) (y:int) : int = 
  if y=0 then 1
  else x * pow x (y-1);;

let pow_2_2 = pow(2)(2);;

printf "%d\n" pow_2_2;;

(*---------------------------------------------------------*)

printf "%s\n" "------- and Keyword -------";;
(* And Keyword *)
let rec pow_2 (x:int) : int = 
  x * x
and pow_3 (x:int) : int =
  x * x * x;;

(* pow_3 will inherit the `rec` from pow_2 *)

let pow_2_2 = pow_2 2;;
let pow_2_3 = pow_3 3;;

printf "%d\n" pow_2_2;;
printf "%d\n" pow_2_3;;

(*---------------------------------------------------------*)
printf "%s\n" "------- Anonymous Function -------";;

(*Anonymous function*)

(* Option 1 - Normal declaration*)
let inc (n:int) : int = n + 1;;
(* Option 2 - Anonymous function*)
let inc = fun x -> x+1;;
(* Option 3 - Typed Anonymous function*)
let inc = fun (x:int) :int -> x+1 ;;

(*---------------------------------------------------------*)

printf "%s\n" "------- Pipeline -------";;
(*Pipeline*)
let inc = fun (x:int) :int -> x+1 ;;
let square = fun (x:int) : int -> x*x;;

let five_inc_square = square (inc 5);;
printf "%d\n" five_inc_square;;

let five_inc_square = 5
  |> inc (*inc receives 5 and return 6*)
  |> square (*square receives 6 from inc and return 36*);;

printf "%d\n" five_inc_square;;

(*Writing functions inside the pipeline*)
let five_inc_square = 5
  |> fun (n:int) :int -> n+1 (*inc receives 5 and return 6*)
  |> fun (n:int) :int -> n*n (*square receives 6 from inc and return 36*);;

printf "%d\n" five_inc_square;;

(*---------------------------------------------------------*)
printf "%s\n" "------- Labeled Arguments -------";;

(*Labeled arguments*)
let sum ~arg1:n1 ~arg2:n2 = n1+n2;;

let sum_4_8 = sum ~arg1:4 ~arg2:8;;
printf "%d\n" sum_4_8;;

printf "%s\n" "------- Typed Labeled Arguments -------";;
(*Typed labeled arguments*)
let rec pow ~base:(b:int) ~expoent:(e:int) : int = 
  if e=0 then 1
  else b * pow ~base:b ~expoent:(e-1);;

let pow_2_4 = pow ~base:2 ~expoent:4;;
printf "%d\n" pow_2_4;;

(*Optional Arguments*)
printf "%s\n" "------- Optinal Arguments -------";;

let sum = fun ~arg1:(n1:int) ?arg2:(n2=0) ->
  n1 + n2;;

let sum_2_4 = sum ~arg1:2 ~arg2:4;;

printf "%d\n" sum_2_4;;

let rec pow_sum = fun ~base:(b:int) ~expoent:(e:int) ?add:(n1=0) :int ->
  if e=0 then 1
  else 
    n1 + (b * pow_sum ~base:b ~expoent:(e-1) ?add:(Some 0));;

let pow_2_4_sum_4 = pow_sum ~base:2 ~expoent:4 ?add:(Some 4);;

printf "%d\n" pow_2_4_sum_4;;

(*---------------------------------------------------------*)

printf "%s\n" "------- Partial Function -------";;
(*Partial Application*)

(*Normal add function*)
let add = fun (n1:int) (n2:int) :int -> 
  n1 + n2;;

let add_2_7 = add 2 7;;
printf "%d\n" add_2_7;;

(*Partial add function*)
let addx (partial_arg:int) = fun (arg:int) :int ->
  partial_arg+arg;;

let add7 = add 7;;
let add7_2 = add7 2;;

printf "%d\n" add7_2;;

(** Function associativity **)
printf "%s\n" "------- Function Associativity -------";;
let add = fun (arg1:int) (arg2:int) :int -> arg1 + arg2;;
let add_7_2 = add 7 2;;

printf "%d\n" add_7_2;;
(*both are equal*)
let add = fun (arg1:int) -> (fun (arg2:int) :int -> arg1 + arg2);;
let add_7_2 = add 7 2;;
printf "%d\n" add_7_2;;

(*---------------------------------------------------------*)
printf "%s\n" "------- Operator as Function -------";;
let equal (arg1:int) (arg2:int) = (=) arg1 arg2 ;;

let equal_2_2 = equal 2 2;;
let equal_2_3 = equal 2 3;;

printf "%b\n" equal_2_3;;
printf "%b\n" equal_2_2;;
