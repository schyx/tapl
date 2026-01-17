#import "@preview/curryst:0.6.0": rule, prooftree, rule-set

= The Untyped Lambda Calculus

== 5.2.1

The `or` function should return `tru` if `b` is `tru` and `c` otherwise, so,

$ mono("or" = lambda b." "lambda c." "b "tru" c). $

The `not` function should flip `tru` to `fls` and vice versa, so

$ mono("not" = lambda b." "b "fls" "tru"). $

== 5.2.2

The successor function can be viewed as both $1 + n$ which is implemented, and also $n + 1$, which would be:

$ mono("scc'" = lambda n ." "lambda s ." "lambda z ." "n" "s" "(s" "z)). $

== 5.2.3

$ mono("times'" = lambda m ." "lambda n ." "lambda s ." "lambda z ." "m" "(n" "s)" "z) $

== 5.2.4

$ mono("exp" = lambda m ." "lambda n ." "n" "("times" m)" "c_1). $

== 5.2.5

$ mono("sub" = lambda m ." "lambda n ." "n" prd "m). $

== 5.2.6

It takes $O(n)$ calls of `prd`, where each call to `prd` takes a constant number of steps of evaluation.

== 5.2.7

$ mono("equal" = lambda m ." "lambda n ." and (iszro (sub m n)) (iszro (sub n m))") $

== 5.2.8

`nil` should just return the starter argument.

$ mono("nil" = lambda c ." "lambda n ." n") $

`cons` should do one more function evaluation with the new value.

$ mono("cons" = lambda h ." "lambda t ." "lambda c ." "lambda n ." c h (t c n)") $

`isnil` sets `n` to be `tru` and applying `c` to make it `fls`.

$ mono("isnil" = lambda l . "l ("lambda"h. "lambda"t. fls) tru") $

`head` will just take its first argument.

$ mono("head" = lambda l . "l tru fls") $

`tail` will perform a buildup similar to `prd`.

$ &mono("nilnil" = "pair nil nil") \
  &mono("conscons" = lambda e ." "lambda p ." pair (snd p) (cons e (snd p))") \
  &mono("tail" = lambda l ." fst (l conscons nilnil)")
$

== 5.2.9

We used a primitive `if` to prevent evaluating both branches. To not evaluate both branches, we would write 

$ &mono("g = "lambda"fct"." "lambda n ." test (iszro n) ("lambda x." "c_1") ("lambda y ." times n (fct (prd n)))") \
  &mono("factorial = fix g")
$

== 5.2.10

$ &mono("g = " lambda c n ." "lambda n ." if iszero n then "c_0" else scc (cn (pred n))") \
  &mono("churchnat = fix g")
$

== 5.2.11

$ &mono("g = "lambda s m ." "lambda l ." test (isnil l) ("lambda x ." "c_0") ("lambda x ." plus (head l) (sm (tail l))) "c_0) \
  &mono("sum = fix g")
$

== 5.3.3

We induct on the size of $mono(t)$.
- For all variable $mono(v)$, $abs(F V(mono(v))) = "size"(mono(v)) = 1$.
- If $mono(t) = mono(lambda x . t_1)$, then $abs(F V(mono(t))) lt.eq abs(F V(mono(t_1))) lt.eq "size"(mono(t_1)) lt.eq
  "size"(mono(t))$, with the second inequality due to the induction hypothesis.
- If $mono(t) = mono(t_1" "t_2)$, then $abs(F V(mono(t))) lt.eq abs(F V(mono(t_1))) + abs(F V(mono(t_2))) lt.eq
  "size"(mono(t_1)) + "size"(mono(t_2)) = "size"(mono(t))$, again with the second inequality due to the induction
  hypothesis.

== 5.3.6

=== Full-beta reduction

#let fb1 = rule(
  $mono(t_1 |-> t'_1)$,
  $mono(t_1 t_2 |-> t'_1 t_2)$,
)

#let fb2 = rule(
  $mono(t_2 |-> t'_2)$,
  $mono(t_1 t_2 |-> t_1 t'_2)$,
)

#let replace = $mono("("lambda x . t_(12)") "t_(22) -> [x -> t_(22)]t_(12))$

$ #prooftree(fb1) \ \
  #prooftree(fb2) \ \
  replace
$

=== Normal-order

#let fb2_no = rule(
  $mono(t_2 |-> t'_2)$,
  $mono(v_1 t_2 |-> v_1 t'_2)$,
)

#let reduce_inside = rule(
  $mono(t_2 |-> t'_2)$,
  $mono(lambda x . t_2 |-> lambda x . t'_2)$
)

#let eappabs = $mono("("lambda x . t_(12)") "v_2 -> [x -> v_2]t_(12))$

$ #prooftree(fb1) \ \
  #prooftree(fb2_no) \ \
  #prooftree(reduce_inside) \ \
  eappabs
$

=== Lazy evaluation

$ #prooftree(fb1) \ \
  replace
$

== 5.3.7

Free variables cannot exist outside of a function body. Thus, the added rules would be:

#let freevar = $mono(x |-> "wrong")$

#let wrongfirst = rule(
  $mono(t_1 |-> "wrong")$,
  $mono(t_1 t_2 |-> "wrong")$
)

#let wrongsecond = rule(
  $mono(t_2 |-> "wrong")$,
  $mono(t_1 t_2 |-> "wrong")$
)

$ freevar \ \
  #prooftree(wrongfirst) \ \
  #prooftree(wrongsecond)
$

== 5.3.8

I'll use $mono(=>)$ to denote the big-step relationship.

#let value = $mono(lambda x . t_1 => lambda x . t_1)$

#let application = rule(
  $mono(t_1 => lambda x . t_3)$,
  $mono(t_2 => v_2)$,
  $mono([x |-> v_2]t_3 => v_3)$,
  $mono(t_1" "t_2 => v_3)$
)

$ value \ \
  #prooftree(application)
$
