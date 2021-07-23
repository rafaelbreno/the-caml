open Format;;

(************** Variants **************)
printf "%s" "------- Variants -------\n";;
type month = January | February | March | April | May | June | July | August | September | October | November | December;;

let november:month = November;;

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

(**************************************)

(************** Records **************)
printf "%s" "------- Records -------\n";;
type employee = {
  name: string;
  age: int;
};;

let foo:employee = { name = "Foo"; age = 42 };;
let bar = { name = "Bar"; age = 67 };;

let get_name  = fun (emp:employee) : string -> 
  match emp with
  | {name;age} -> name;;
printf "Foo age: %d\n" foo.age;;
printf "Foo name: %s\n" (get_name foo);;

let get_age = function
  | {name;age} -> age;;
printf "Bar age: %d\n" (get_age bar);;
printf "Bar name: %s\n" bar.name;;
(**************************************)

(************** Tuples **************)
printf "%s" "------- Tuples -------\n";;
let t1 = (10, 70, 20);;
let t2 = ("Foo", "Bar", 6);;

let get_apples = fun t : int ->
  match t with
  | (x, y, z) -> (x + y + z);;

let concat (x, y, _) : string = sprintf "%s%s" x y;;

printf "Total amount of apples: %d\n" (get_apples t1);;
printf "Concat: %s\n" (concat t2);;
(**************************************)
