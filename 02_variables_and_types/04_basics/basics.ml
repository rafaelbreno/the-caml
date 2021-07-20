(*Library to pretty print*)
open Format;;

(*Let Expression*)
printf "%s\n" "------- Let Expression -------";;
(**Let Definition**)
let inc = fun (arg:int) :int-> arg + 1;;
let inc_1 = inc 1;;
printf "inc_1 = %d\n" inc_1;;

(**Let Expression**)
(* let x = e1 in e2;; *)
let x = 42 in x + 1;;
(*unbound value to x: printf "%d" x;;*)

let x = (let x = 42 in x + 1);;
(*Now this works*)
printf "%d\n" x;;

printf "let x = 42 in x + 1: %d \n" (let x = 42 in x + 1);;

printf "let x = 42 in (fun (arg1:int) :int -> inc arg1) x : %d\n"(let x = 42 in (fun (arg1:int) :int -> inc arg1) x);;
(*---------------------------------------------------------*)

(*Scope*)
printf "%s\n" "------- Scope -------";;

(*Openining a scope*)
let _ =
  let forty = 40 in
  (*forty can be accessed here*)
  printf "%d\n" forty;;

(*forty cannot be accessed here*)
(*printf "%d" forty;;*)

(*---------------------------------------------------------*)
