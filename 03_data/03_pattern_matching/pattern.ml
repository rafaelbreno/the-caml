open Format;;
open String;;

(************** Let **************)
printf "%s" "------- Let -------\n";;
(*let definition*)
let langs = "OCaml,PHP,Go,Haskell";;

(*let expression*)
let dashed langs =
  let lang_list = String.split_on_char ',' langs in
  String.concat "-" lang_list;;

let dashed_lang = dashed langs;;
printf "Comma: %s\n" langs;;
printf "Dash: %s\n" dashed_lang;;


(**************************************)

(************** Options **************)
printf "%s" "------- Options -------\n";;
let rec list_max = function
  | [] -> None (*If empty*)
  | h::t -> begin (*Being a list with at least 1 item*)
    match list_max t with (*recalls itself*)
    | None -> Some h (*If t is empty it means there's only one item, so itself is the max*)
    | Some m -> Some(max h m) (*Having more than 1 item, calls *)
  end;;

let lst = [1; 2; 3; 4; 5; 6];;
let empty_lst = [];;

let print_max = function
  | None -> printf "%s\n" "There's no item" (*If the type is None*)
  | Some max_val -> printf "Max: %d\n" max_val;; (*If the type is Some, bind int option into int*)

print_max (list_max lst);;
print_max (list_max empty_lst);;

(**************************************)
