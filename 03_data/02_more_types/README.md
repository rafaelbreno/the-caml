## More Types

### Summary
1. [Variants](#variants)
2. [Records](#records)
3. [Tuples](#tuples)

### Variants
- It's like an `enum` in other languages
- Each value of a variant is called _constructor_
```ocaml
printf "%s" "------- Variants -------\n";;
type month = January | February | March | April | May | June | July | August | September | October | November | December;;

let november:month = November;;

(*There's no easy way to do it*)
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
```

### Records
- I like to see `records` as structs, you have the `name` for it, and the fields, each _field_ has a name and a _type_
```ocaml
printf "%s" "------- Records -------\n";;
type employee = {
  name: string;
  age: int;
};;

let foo:employee = { name = "Foo"; age = 42 };;
let bar = { name = "Bar"; age = 67 };;
```

### Tuples
- Tuples is kinda of a _list_ but it allows you to mix the types, so in a tuple you can have _int_, _string_, _variants_, _records_, etc.
```
printf "%s" "------- Tuples -------\n";;
let t1 = (10, 70, 20);;
let t2 = ("Foo", "Bar", 6);;

let get_apples = fun t : int ->
  match t with
  | (x, y, z) -> (x + y + z);;

let concat (x, y, _) : string = sprintf "%s%s" x y;;

printf "Total amount of apples: %d\n" (get_apples t1);;
printf "Concat: %s\n" (concat t2);;
```
