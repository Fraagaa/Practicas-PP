let rec fib n =
  if n <= 1 then n
  else fib (n-1) + fib (n-2)
;;

let per_area r =
  let pi = 2. *. asin 1. in
  (2. *. pi *. r, pi *. r *. r)
;;

let per_area =
  let pi = 2. *. asin 1. in
  function r -> (2. *. pi *. r)
;;

(* dados dos enteros devuelve el conciente *)
let rec quo x y = (* x >= 0, y > 0 *)
  if x < y then 0
  else 1 + quo (x-y) y
;;

(* dados dos enteros devuelve el resto *)
let rec rem x y =
  if x < y then x
  else rem (x-y) y
;;


(*
let rec div x y =
  if x < y then (0, x)
  else
    let p = div (x-y) y in 
    (1+fst)
*)

let rec div x y =
  if x < y then (0, x)
  else
    let (q, r) = div (x-y) y in
    (1 + q, r)
;;

(* FALTAN ALGUNAS COSAS DE LA CLASE DEL 07/10 *)


let rec fib n = (* n >= 1 *)
  if n <= 2 then 1
  else fib (n-1) + fib (n-2);;
  
let crono f x =
  let t = Sys.time () in
  let _ = f x in
  Sys.time () -. t;;

(* CLASE DEL 14/10 *)

(* Operaciones con Listas https://ocaml.org/manual/5.2/api/List.html *)

let l = ['a';'e';'i';'o';'u'];;

List.hd l;; (* Devuelve 'a' *)

List.tl l;; (* Devuelve ['e'; 'i'; 'o'; 'u'] *)

List.rev l;; (* Devuelve ['u'; 'o'; 'i'; 'e'; 'a'] *)

let rec lenght l =
  if l = [] then 0
  else 1 + List.length (List.tl l) 
  (* Con cada ejecución se acumula un 1 + (llamada recursiva) *)
  (* Con un array lo suficientemente larga podría agotarse el stack *)
;;

(* TRANQUILIDAD :/ *)

List.map abs [1;-2;3];; (* Se aplica la función en cada elemento de la lista *) (* [1; 2; 3] *)

(* Sumarle a cada elemento 1 *)
let suma x y = x + y;;
let suma' (x,y) = x + y;;

List.map (suma 1) [1;2;3];;
List.map (function n -> suma' (1,n)) [1;2;3];;

(* Multiplicar cada elemento por 2 *)
List.map (( * ) 2) [1;2;3];;

(* Que elemento lo cumplen *)
List.filter ((<) 0) [1;-2;3];; (* [1;3] *)

List.exists ((<) 0) [1;2;3];; (* True *)
List.exists ((<) 0) [-1;2;3];; (* False *)

List.for_all ((<) 0) [1;2;3];; (* True *)

(* El primero que encuentra lo devuelve *)
List.find ((<) 0) [-1;2;3];; (* 2 *)
List.find ((<) 0) [-1;-2;-3];; (* Exception: Not_found *)

(* ¿Es miembro? *)
List.mem 2 [1;2;3];; (* True *)

(* Longitud *)
List.length [1;2;3;4];; (* 4 *)

(* Creación de listas *)
List.init 10 abs;; (* [0; 1; 2; 3; 4; 5; 6; 7; 8; 9] *)

let l2 = List.init 50_000_000 abs;; 

List.hd (List.rev l2);; (* 49999999 *)

List.length l2;; (* 50000000 *)

lenght l2;; (* Stack Overflow *)

List.init 26 (function n -> char_of_int (65+n));; (* El abecedario completo *)

(* CLASES DEL 15/10 *)

let rec last l =
  if List.tl l = [] then List.hd l
  else last (List.tl l)
;;

let rec last l =
  if List.length l = 1 then List.hd l
  else last (List.tl l)
;;

(*
<e1> : t
<e2> : t list
-------------------
<e1>::<e2> : t list
*)

(* Constructor de listas *)

3 :: 7 :: 9 :: [];; (* [3; 7; 9] *)

let hd = function
  [] -> 2/0 
| h::_ -> h
;;

let hd = function h::t -> h;;

let hd = function h::_ -> h;;

let hd (h::_) = h;;

let hd = function
  [] -> raise (Failure "hd")
| h::_ -> h
;;

(* CREAR UNA VERSIÓN TERMINAL DE LA SIGUIENTE FUNCIÓN *)

let rec lenght = function
  [] -> 0 
| _::t -> 1 + lenght t
;;


(* Existe el elemento x en la lista l *)
(*              mem x l;;             *)

let rec mem x = function
  [] -> false
| h::t -> x = h || mem x t
(* Esto es lo mismo que escribir lo siguente *)
(* | l -> x = List.hd l || mem x (List.tl l) *)
;;

(* mem 3 [1;2;3]      1::2::3::[] *)
(* mem 3 [2;3]           2::3::[] *)
(* mem 3 [3]                3::[] *) (* x = h TRUE*)

(* mem 3 [4;5;6]      4::5::6::[] *)
(* mem 3 [5;6]           5::6::[] *)
(* mem 3 [6]                6::[] *)
(* mem 3 [1;2;3]      1::2::3::[] *)
(* mem 3 [2;3]           2::3::[] *)
(* mem 3 []                    [] *) (* [] -> FALSE *)


(* REIMPLEMENTAMOS List.find *)

let rec find p = function
  [] -> raise Not_found
| h::t -> if p h then h else find p t
;;

(* REIMPLEMENTAMOS List.filter *)

let rec filter p = function
  [] -> []
| h::t -> 
  if p h then h :: filter p t
  else filter p t
;;


(* Clase del 21/10 *)

(* Reimplementación de lenght *)

let rec aux = function
  (n,[]) -> n
| (n, _::t) -> aux(n+1,t)
;;

let lenght l =
  aux (0,l)
;;

let lenght l =
  let rec aux = function
    (n,[]) -> n
  | (n, _::t) -> aux(n+1,t)
  in 
    aux (0,l)
;;


let rec append = function
    [] -> (function  l -> l)
  | h::t -> (function l -> h :: append t l)
;;

let rec append l1 l2 =
  match l1 with
  [] -> l2
  | h::t -> h :: append t l2
;;

(* CLASE 22/10 *)

let compare_lengs l1 l2 =
  compare (List.length l1) (List.length l2)
;;


let rec compare_lengs = function
  [] -> (function [] -> 0
                | _  -> -1)
| _::t1 -> (function [] -> 1
                | _::t2 -> compare_lengs t1 t2)
;;
let rec compare_lengs l1 l2 =
  match (l1, l2) with
    ([], []) -> 0
  | ([], _) -> -1
  | (_, []) -> 1
  | (_::t1, _::t2) -> compare_lengs t1 t2
;;

let rec fact = function
    0 -> 1
  | n -> n * fact (n-1)
;;

(* Versión terminal del factorial *)

(* El acumulador n va guardando los valores de las multiplicaciones *)
(*
aux 0 1
aux 1 1
aux 2 2
aux 3 6
aux 4 24
aux 5 120
120
*)
let fact n =
  let rec aux acc = function
    0 -> acc
  | i -> aux (i*acc) (i-1)
  in
    aux 1 n
;;

(* El único defecto de la función anterior es que en cada repetición se redefine aux *)
(* Si el compilador no es lo suficientemente inteligente *)


(*Esta función es parcialmente incorrecta *)
let fact n =
  let rec aux i fi =
    if i = n then fi
    else aux (i+1) ((i+1)*fi)
  in
    aux 0 1
;;

List.fold_left (+) 0 [1;2;3;4;5] (* 15 *)

let lenght l =
  List.fold_left (function a -> function _ -> a+1) 0 l
;;

let rec fold_left a = function
  [] -> a
| h::t -> fold_left f (f a h) t
;;

let rev l =
  List.fold_left (function a -> function x -> x::a) [] l
;;

(* Dado una lista devolver el máximo *)
(* lmax / también existe la función max en ocaml *)
(* soltar error cuando se envie una lista vacía *)


(* CLASES 28/10 *)

let rec lmax = function
  h::[] -> h
| h::t ->
      if h >= lmax t then h else lmax t
;;

let rec lmax = function
  h::[] -> h
| h::t -> max h (lmax t)
;;

let lmax (h::t) =
  let rec aux m = function
    [] -> m
    | h::t -> aux (max h m) t
  in
    aux h t
;;

let rec lmax = function
  h::[] -> h
| h1::h2::t -> lmax (max h1 h2::t)
;;

let rec append l1 l2 =
  match l1 with
    [] -> l2
  | h::t -> h :: append t l2
;;

let rec rev_append l1 l2 =
  match l1 with
    [] -> l2
  | h::t -> rev_append t (h::l2)
;;

let append' l1 l2 =
  List.rev_append (List.rev l1) l2
;;

let rev l =
  List.rev_append l []
;;

let rev l =
  List.fold_left 
    (function a -> function x -> x::a) [] l
;;

(* ESTA ES LA UTILIDAD DE FUN *)
let rev l =
  List.fold_left 
    (fun a x -> x::a) [] l
;;


(* MUY MALA IMPLEMENTACIÓN DE REV LIST*)
let rec rev = function
    [] -> []
  | h::t -> (rev t) @ [h]
;;

(*
rev [1;2;3;4]
(rev [2;3;4]) @ [1]
(rev [3;4] @ [2]) @ [1]
((rev [4] @ [3]) @ [2]) @ [1]
(((rev [] @ [4]) @ [3]) @ [2]) @ [1]
((([] @ [4]) @ [3]) @ [2]) @ [1]
(([4] @ [3]) @ [2]) @ [1]
([4;3] @ [2]) @ [1]
[4;3;2] @ [1]
[4;3;2;1]
*)

let rec for_all p = function
    [] -> true
  | h::t -> p h && for_all p t
;;

let for_all p l =
  List.fold_left (fun a x -> p x && a) true l
;;
