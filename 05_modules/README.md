## Modules

## Summary
1. [Introduction](#introduction)
2. [Structures](#structures)
3. [Signatures](#signatures)
4. [Abstract Types](#abstract-types)

### Introduction
- A _module_ is like a toolbox built for a specific action, so instead of writting all the code freely inside the file(s), you may want to _abstract_ certain parts of it inside of a module.
- So, to write a _modular code_ it's needed to provide a support for:
  - __Namespaces:__ A _namespace_ provides a set of name that are grouped together(logically related) and distinction between common names; in OCaml this feature is called _structures_.
  - __Abstraction:__ An _abstraction_ hides some information while revealing other infos. It describes _relationships_ among modules; in OCaml this feature is called _signatures_.
  - __Code Reuse:__ A _moduled system_ provides us the _code reuse_, like we saw on _Abstraction Principle_ where we could use 1 function to be used by various types; in OCaml, there are features called _functors_ and _includes_ that let us reutilise the code.
- Well, I know that's kinda of a lot of information to process now, but don't be scared or overwhelmed by it, in the next topics we'll be studying each one and connection the dots.

### Structures
- _Structures_ are a sequence of definitions
- Definition:
```ocaml
module MyModule = struct
  (*definitions*)
end;;
```
- Being:
  - `MyModule` - module name by convention _must_ start with uppercase letter
  - `struct...end` - Module's scope, it means that anything defined inside the Module __can't__ be accessed unless:
    - Referring to the Module: `MyModule.definition`
    - Opening it: `open MyModule;;`
```ocaml
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

  let rec to_string = function
    | [] -> ""
    | h::t -> (string_of_int h) ^ ";" ^ (to_string t)
end;;

(*
  Can't access empty
  But can access ListStack.empty
  or via open
  open ListStack;;

  then you can access all definitions
  *)

let lst = [1;2;3;4;5];;

let lst_is_empty = ListStack.is_empty lst;;
printf "Is empty? %b\n" lst_is_empty;;
printf "List: %s \n" (ListStack.to_string lst);;
let after_pop = ListStack.pop lst;;
printf "List: %s \n" (ListStack.to_string after_pop);;

```
- So you can access the definitions via: `MyModule.definition`
- Inside of the Module can contain:
  - `type` definitions
  - `exception` definitions
  - `let` definitions
  - `open` statements (not seen yet)
  - other _not seen yet_ things
- You can also add some sugar to your code
```ocaml
(*Open Module inside let scope*)
let to_string2 lst = 
  let open ListStack in
  to_string lst;;
printf "List: %s \n" (to_string2 lst);;

printf "List: %s \n" (to_string2 lst);;

let lst' = ListStack.(lst |> add1 |> add1);;
printf "List: %s \n" (to_string2 lst');;
```

### Signatures
- _Signatures_ are this block of code `sig...end`, it's simply a sequence of declarations.
  - `val v : t` it means there's a value named `v` with type `t`
```ocaml
module type ModuleType = sig 
  type 'a stack
  val empty     : 'a stack
  val is_empty  : 'a stack -> bool
  val push      : 'a -> 'a stack -> 'a stack
  val peek      : 'a stack -> 'a
  val pop       : 'a stack -> 'a stack
end;;
```
- A _structure_ matches a _signature_ if the structure provides definitions for all the names specified in the _signature_
- With both matching you can define the _signature_ of a _structure_ using `:`
  - `M : S` 
    - `M` being the module name
    - `:` keyword to define the signature
    - `S` the signature
```ocaml
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
```

### Abstract Types
- As seen before the type `'a stack` is _abstract_: the `ModuleType` module type says that there is a type name `'a stack` in any module that implements the module type, but it does not say what that type is defined to be.
- Once we add `: ModuleType` module type annotation to `ListStack`, 
