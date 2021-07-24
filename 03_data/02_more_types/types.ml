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

(*Type Synonyms*)
printf "%s\n" "------- Type Synonyms -------";;

type point1 = float * float;;

(*float * float*)
let p_1_3 = (1.,3.);;
let p_5_8 = (-5.67777,8.99999);;

let getx : point1 -> float = 
  fun (x,_) -> x;;

printf "X of (1.,3.): %.2f\n" (getx p_1_3);;
printf "X of (-5.67777,8.99999): %.2f\n" (getx p_5_8);;

(*---------------------------------------------------------*)
(*Algebraic Data Types*)
printf "%s\n" "------- Algebraic Data Types -------";;
type point = float * float;;
type shape =
  | Point of point
  | Circle of point * float (* center and radius*)
  | Rectangle of point * point;; (*lower-left and upper-right corners*)

let area = function
  | Point _ -> 0.0
  | Circle (_,r) -> Float.pi *. (r ** 2.0)
  | Rectangle ((x1,y1), (x2,y2)) -> 
      let w = x2 -. x1 in
      let h = y2 -. y1 in
        w *. h;;

let circle:shape = Circle((1.,2.), 5.);;
let rect:shape = Rectangle((0.,0.),(1.,1.));;

printf "Circle area: %.2f\n" (area circle);;
printf "Rectangle area: %.2f\n" (area rect);;

type string_or_int =
  | String of string
  | Int of int;;

(*Allow a type-safe approach*)
let rec sum : string_or_int list -> int = function
  | [] -> 0
  | (String str)::t -> int_of_string str + sum t
  | (Int i)::t -> i + sum t;;

printf "Sum of \"5\" and 3: %d\n" (sum [String "5"; Int 3]);;
(*---------------------------------------------------------*)

(*Catch All*)
printf "%s\n" "------- Catch All -------";;
type color = 
  | Blue
  | Red
  | Green;;

(*Instead of this*)
let color_to_string : color -> string = function
  | Blue -> "blue"
  | Red -> "red"
  | _ -> "green";;

(*Do this*)
let color_to_string : color -> string = function
  | Blue -> "blue"
  | Red -> "red"
  | Green -> "green";;
(*---------------------------------------------------------*)

(*Recursive Variants*)
printf "%s\n" "------- Recursive Variants -------";;
type intlist = 
  | Nil
  | Cons of int * intlist;; (*Cons as constructor*)

let l3 = Cons(3, Nil) (*similar to 3::[] or [3]*)
let lst = Cons(1, Cons(2, l3));; (*similar to [1;2;3]*)

let rec sum (l:intlist) : int = 
  match l with
  | Nil -> 0
  | Cons(h,t) -> h + sum t;;

printf "Sum: %d\n" (sum lst);;
(*---------------------------------------------------------*)
