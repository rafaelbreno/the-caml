open Format;;

(************** What is **************)
printf "%s" "------- What is -------\n";;
let double x = 2 * x;;

(*High order, using a function to write another function*)
let quad x = double (double x);;

(**************************************)

(************** Abstraction Principle **************)
printf "%s" "------- Abstraction Principle -------\n";;

let pipeline x f = f x;;
let (|>) = pipeline;;

let x = 5
  |> quad;; (*20*)

printf "Quad of 5: %d\n" x;;
(**************************************)

(************** Map **************)
printf "%s" "------- Map -------\n";;

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
