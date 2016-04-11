(* This file is generated by Why3's Coq driver *)
(* Beware! Only edit allowed sections below    *)
Require Import BuiltIn.
Require BuiltIn.
Require HighOrd.
Require set.Set.

Axiom t : Type.
Parameter t_WhyType : WhyType t.
Existing Instance t_WhyType.

Parameter comprehension: forall {a:Type} {a_WT:WhyType a}, (a -> bool) ->
  (set.Set.set a).

Axiom comprehension_def : forall {a:Type} {a_WT:WhyType a}, forall (p:(a ->
  bool)), forall (x:a), (set.Set.mem x (comprehension p)) <-> ((p x) = true).

Parameter fc: forall {a:Type} {a_WT:WhyType a}, (a -> bool) -> (set.Set.set
  a) -> (a -> bool).

Axiom fc_def : forall {a:Type} {a_WT:WhyType a}, forall (p:(a -> bool))
  (u:(set.Set.set a)) (x:a), (((fc p u) x) = true) <-> (((p x) = true) /\
  (set.Set.mem x u)).

(* Why3 assumption *)
Definition filter {a:Type} {a_WT:WhyType a} (p:(a -> bool)) (u:(set.Set.set
  a)): (set.Set.set a) := (comprehension (fc p u)).

Parameter fc1: forall {a:Type} {a_WT:WhyType a} {b:Type} {b_WT:WhyType b},
  (a -> b) -> (set.Set.set a) -> (b -> bool).

Axiom fc_def1 : forall {a:Type} {a_WT:WhyType a} {b:Type} {b_WT:WhyType b},
  forall (f:(a -> b)) (u:(set.Set.set a)) (y:b), (((fc1 f u) y) = true) <->
  exists x:a, (set.Set.mem x u) /\ (y = (f x)).

(* Why3 assumption *)
Definition map {a:Type} {a_WT:WhyType a} {b:Type} {b_WT:WhyType b} (f:(a ->
  b)) (u:(set.Set.set a)): (set.Set.set b) := (comprehension (fc1 f u)).

Axiom map_def : forall {a:Type} {a_WT:WhyType a} {b:Type} {b_WT:WhyType b},
  forall (f:(a -> b)) (u:(set.Set.set a)), forall (x:a), (set.Set.mem x u) ->
  (set.Set.mem (f x) (map f u)).

Parameter fc2: (set.Set.set (set.Set.set t)) -> (t -> bool).

Axiom fc_def2 : forall (fam:(set.Set.set (set.Set.set t))) (x:t), (((fc2 fam)
  x) = true) <-> forall (y:(set.Set.set t)), (set.Set.mem y fam) ->
  (set.Set.mem x y).

(* Why3 assumption *)
Definition intersect (fam:(set.Set.set (set.Set.set t))): (set.Set.set t) :=
  (comprehension (fc2 fam)).

Parameter f: (set.Set.set t) -> (set.Set.set t).

Axiom f_is_monotonic : forall (x:(set.Set.set t)) (y:(set.Set.set t)),
  (set.Set.subset x y) -> (set.Set.subset (f x) (f y)).

(* Why3 goal *)
Theorem intersect_common_subset : forall (fam:(set.Set.set (set.Set.set t))),
  forall (x:(set.Set.set t)), (set.Set.mem x fam) -> (set.Set.subset
  (intersect fam) x).
intros fam x h1.
unfold set.Set.subset.
intros.
unfold intersect in H.
rewrite comprehension_def in H.
rewrite fc_def2 in H.
apply H.
exact h1.
Qed.
