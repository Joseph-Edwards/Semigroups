#############################################################################
##
#W  standard/bipartition.tst
#Y  Copyright (C) 2014-15                                 Attila Egri-Nagy
##                                                       James D. Mitchell
##
##  Licensing information can be found in the README file of this package.
##
#############################################################################
##
gap> START_TEST("Semigroups package: standard/bipartition.tst");
gap> LoadPackage("semigroups", false);;

#
gap> SEMIGROUPS.StartTest();

# the number of iterations, change here to get faster test
gap> N := 333;;

#T# BipartitionTest2: BASICS
gap> classes := [[1, 2, 3, -2], [4, -5], [5, -7], [6, -3, -4], [7], [-1],
> [-6]];;
gap> f := BipartitionNC(classes);
<bipartition: [ 1, 2, 3, -2 ], [ 4, -5 ], [ 5, -7 ], [ 6, -3, -4 ], [ 7 ], 
 [ -1 ], [ -6 ]>
gap> LeftProjection(f);
<bipartition: [ 1, 2, 3, -1, -2, -3 ], [ 4, -4 ], [ 5, -5 ], [ 6, -6 ], 
 [ 7 ], [ -7 ]>

#T# BipartitionTest3: different order of classes
gap> classes2 := [[-6], [1, 2, 3, -2], [4, -5], [5, -7], [6, -3, -4], [-1],
> [7]];;
gap> f = Bipartition(classes2);
true
gap> f := BipartitionNC([[1, 2, -3, -5, -6], [3, -2, -4], [4, 7],
> [5, -7, -8, -9], [6], [8, 9, -1]]);
<bipartition: [ 1, 2, -3, -5, -6 ], [ 3, -2, -4 ], [ 4, 7 ], [ 5, -7, -8, -9 ]
  , [ 6 ], [ 8, 9, -1 ]>
gap> LeftProjection(f);
<bipartition: [ 1, 2, -1, -2 ], [ 3, -3 ], [ 4, 7 ], [ 5, -5 ], [ 6 ], 
 [ 8, 9, -8, -9 ], [ -4, -7 ], [ -6 ]>

#T# BipartitionTest4: ASSOCIATIVITY
gap> l := List([1 .. 3 * N], i -> RandomBipartition(17));;
gap> triples := List([1 .. N], i -> [l[i], l[i + 1], l[i + 2]]);;
gap> ForAll(triples, x -> ((x[1] * x[2]) * x[3]) = (x[1] * (x[2] * x[3])));
true

#T# BipartitionTest5: EMBEDDING into T_n
gap> l := List([1, 2, 3, 4, 5, 15, 35, 1999], i -> RandomTransformation(i));;
gap> ForAll(l, t -> t = AsTransformation(AsBipartition(t)));
true

#T# BipartitionTest6: checking IsTransBipartitition
gap> l := List([1, 2, 3, 4, 5, 15, 35, 1999, 30101, 54321], i ->
> RandomTransformation(i));;
gap> ForAll(l, t -> IsTransBipartition(AsBipartition(t)));
true

#T# BipartitionTest7: check big size, identity, multiplication
gap> bp := RandomBipartition(7000);;
gap> bp * One(bp) = bp;
true
gap> One(bp) * bp = bp;
true

#T# BipartitionTest8: check BlocksIdempotentTester, first a few little examples
gap> l := BlocksByIntRepNC([3, 1, 2, 3, 3, 0, 0, 0]);;
gap> r := BlocksByIntRepNC([2, 1, 2, 2, 2, 0, 0]);;
gap> SEMIGROUPS.BlocksIdempotentTester(l, r);
true
gap> e := SEMIGROUPS.BlocksIdempotentCreator(l, r);
<bipartition: [ 1 ], [ 2, 3, 4 ], [ -1 ], [ -2 ], [ -3, -4 ]>
gap> IsIdempotent(e);
true

#T# BipartitionTest9: JDM is this the right behaviour?
gap> RightBlocks(e) = l;
true
gap> LeftBlocks(e) = r;
true

#T# BipartitionTest10: AsBipartition for a bipartition
gap> f := Bipartition([[1, 2, 3], [4, -1, -3], [5, 6, -4, -5],
> [-2], [-6]]);;
gap> AsBipartition(f, 8);
<bipartition: [ 1, 2, 3 ], [ 4, -1, -3 ], [ 5, 6, -4, -5 ], [ 7 ], [ 8 ], 
 [ -2 ], [ -6 ], [ -7 ], [ -8 ]>
gap> AsBipartition(f, 6);
<bipartition: [ 1, 2, 3 ], [ 4, -1, -3 ], [ 5, 6, -4, -5 ], [ -2 ], [ -6 ]>
gap> AsBipartition(f, 4);
<bipartition: [ 1, 2, 3 ], [ 4, -1, -3 ], [ -2 ], [ -4 ]>

#T# BipartitionTest11: AsPartialPerm for bipartitions
gap> S := DualSymmetricInverseMonoid(3);;
gap> Number(S, IsPartialPermBipartition);
6
gap> S := PartitionMonoid(3);;
gap> Number(S, IsPartialPermBipartition);
34
gap> Size(SymmetricInverseMonoid(3));
34
gap> S := SymmetricInverseMonoid(3);;
gap> ForAll(S, x -> AsPartialPerm(AsBipartition(x)) = x);
true
gap> elts := Filtered(PartitionMonoid(3), IsPartialPermBipartition);;
gap> ForAll(elts, x -> AsBipartition(AsPartialPerm(x), 3) = x);
true

#T# BipartitionTest12: AsPermutation for bipartitions
gap> G := SymmetricGroup(5);;
gap> ForAll(G, x -> AsPermutation(AsBipartition(x)) = x);
true
gap> G := GroupOfUnits(PartitionMonoid(3));
<bipartition group of degree 3 with 2 generators>
gap> ForAll(G, x -> AsBipartition(AsPermutation(x), 3) = x);
true

#T# BipartitionTest22: AsBlockBijection and IsomorphismBlockBijectionSemigroup
# for an inverse semigroup of partial perms
gap> S := InverseSemigroup(
> PartialPerm([1, 2, 3, 6, 8, 10], [2, 6, 7, 9, 1, 5]),
> PartialPerm([1, 2, 3, 4, 6, 7, 8, 10], [3, 8, 1, 9, 4, 10, 5, 6]));;
gap> AsBlockBijection(S.1);
<block bijection: [ 1, -2 ], [ 2, -6 ], [ 3, -7 ], 
 [ 4, 5, 7, 9, 11, -3, -4, -8, -10, -11 ], [ 6, -9 ], [ 8, -1 ], [ 10, -5 ]>

#T# BipartitionTest24: NaturalLeqBlockBijection
gap> S := DualSymmetricInverseMonoid(4);;
gap> f := Bipartition([[1, -2], [2, -1], [3, -3], [4, -4]]);;
gap> g := Bipartition([[1, 4, -3], [2, -1, -2], [3, -4]]);;
gap> NaturalLeqBlockBijection(f, g);
false
gap> NaturalLeqBlockBijection(f, f);
true
gap> NaturalLeqBlockBijection(f, g);
false
gap> NaturalLeqBlockBijection(g, f);
false
gap> NaturalLeqBlockBijection(g, g);
true
gap> f := Bipartition([[1, 4, 2, -1, -2, -3], [3, -4]]);
<block bijection: [ 1, 2, 4, -1, -2, -3 ], [ 3, -4 ]>
gap> NaturalLeqBlockBijection(f, g);
true
gap> NaturalLeqBlockBijection(g, f);
false
gap> First(Idempotents(S), e -> e * g = f);
<block bijection: [ 1, 2, -1, -2 ], [ 3, -3 ], [ 4, -4 ]>
gap> Set(Filtered(S, f -> NaturalLeqBlockBijection(f, g)));
[ <block bijection: [ 1, 2, 3, 4, -1, -2, -3, -4 ]>, 
  <block bijection: [ 1, 2, 4, -1, -2, -3 ], [ 3, -4 ]>, 
  <block bijection: [ 1, 3, 4, -3, -4 ], [ 2, -1, -2 ]>, 
  <block bijection: [ 1, 4, -3 ], [ 2, 3, -1, -2, -4 ]>, 
  <block bijection: [ 1, 4, -3 ], [ 2, -1, -2 ], [ 3, -4 ]> ]
gap> Filtered(S, f -> ForAny(Idempotents(S), e -> e * f = g));
[ <block bijection: [ 1, 4, -3 ], [ 2, -1, -2 ], [ 3, -4 ]> ]
gap> Set(Filtered(S, f -> ForAny(Idempotents(S), e -> e * g = f)));
[ <block bijection: [ 1, 2, 3, 4, -1, -2, -3, -4 ]>, 
  <block bijection: [ 1, 2, 4, -1, -2, -3 ], [ 3, -4 ]>, 
  <block bijection: [ 1, 3, 4, -3, -4 ], [ 2, -1, -2 ]>, 
  <block bijection: [ 1, 4, -3 ], [ 2, 3, -1, -2, -4 ]>, 
  <block bijection: [ 1, 4, -3 ], [ 2, -1, -2 ], [ 3, -4 ]> ]

#T# BipartitionTest25: Factorization/EvaluateWord
gap> S := DualSymmetricInverseMonoid(6);;
gap> f := S.1 * S.2 * S.3 * S.2 * S.1;
<block bijection: [ 1, 6, -4 ], [ 2, -2, -3 ], [ 3, -5 ], [ 4, -6 ], 
 [ 5, -1 ]>
gap> EvaluateWord(GeneratorsOfSemigroup(S), Factorization(S, f));
<block bijection: [ 1, 6, -4 ], [ 2, -2, -3 ], [ 3, -5 ], [ 4, -6 ], 
 [ 5, -1 ]>
gap> S := PartitionMonoid(3);;
gap> f := Bipartition([[1, -2, -3], [2, 3], [-1]]);;
gap> EvaluateWord(GeneratorsOfSemigroup(S), Factorization(S, f));
<bipartition: [ 1, -2, -3 ], [ 2, 3 ], [ -1 ]>
gap> S := Range(IsomorphismBipartitionSemigroup(SymmetricInverseMonoid(5)));
<inverse bipartition monoid of degree 5 with 3 generators>
gap> f := S.1 * S.2 * S.3 * S.2 * S.1;
<bipartition: [ 1 ], [ 2, -2 ], [ 3, -4 ], [ 4, -5 ], [ 5, -3 ], [ -1 ]>
gap> EvaluateWord(GeneratorsOfSemigroup(S), Factorization(S, f));
<bipartition: [ 1 ], [ 2, -2 ], [ 3, -4 ], [ 4, -5 ], [ 5, -3 ], [ -1 ]>
gap> S := Semigroup(
> [Bipartition([[1, 2, 3, 5, -1, -4], [4], [-2, -3], [-5]]),
>  Bipartition([[1, 2, 4], [3, 5, -1, -4], [-2, -5], [-3]]),
>  Bipartition([[1, 2], [3, -1, -3], [4, 5, -4, -5], [-2]]),
>  Bipartition([[1, 3, 4, -4], [2], [5], [-1, -2, -3], [-5]]),
>  Bipartition([[1, -3], [2, -5], [3, -1], [4, 5], [-2, -4]])]);;
gap> x := S.1 * S.2 * S.3 * S.4 * S.5;
<bipartition: [ 1, 2, 3, 5 ], [ 4 ], [ -1, -3, -5 ], [ -2, -4 ]>
gap> EvaluateWord(GeneratorsOfSemigroup(S), Factorization(S, x));
<bipartition: [ 1, 2, 3, 5 ], [ 4 ], [ -1, -3, -5 ], [ -2, -4 ]>
gap> IsInverseSemigroup(S);
false

# bipartition: PartialPermLeqBipartition 1/3
gap> x := Bipartition([[1, 2, 4, 5, -2], [3, -1, -3], [-4], [-5]]);;
gap> y := Bipartition([[1, 3, -2], [2, 4, -5], [5, -1, -4], [-3]]);;
gap> PartialPermLeqBipartition(x, y);
Error, Semigroups: PartialPermLeqBipartition: usage,
the arguments must be partial perm bipartitions,

# bipartition: PartialPermLeqBipartition 2/3
gap> x := Bipartition([[1, -4], [2, -1], [3], [4, -5], [5], [-2], [-3]]);;
gap> y := Bipartition([[1, -4], [2, -3], [3], [4], [5], [-1], [-2], [-5]]);;
gap> PartialPermLeqBipartition(x, y);
false
gap> PartialPermLeqBipartition(y, x);
true

# bipartition: PartialPermLeqBipartition 3/3
gap> x := Bipartition([[1, -4], [2, -1], [3], [4, -5], [5], [-2], [-3], [6],
> [-6]]);;
gap> y := Bipartition([[1, -4], [2, -3], [3], [4], [5], [-1], [-2], [-5]]);;
gap> PartialPermLeqBipartition(x, y);
Error, Semigroups: PartialPermLeqBipartition: usage,
the arguments must have equal degree,

# bipartition: NaturalLeqBlockBijection  1/3
gap> x := Bipartition([[1, 2, -1, -2], [3, -3]]);;
gap> y := Bipartition([[1], [2], [3, -3], [-1, -2]]);;
gap> NaturalLeqBlockBijection(x, y);
Error, Semigroups: NaturalLeqBlockBijection: usage,
the arguments must be block bijections,

# bipartition: NaturalLeqBlockBijection  2/3
gap> x := Bipartition([[1, 2, -4], [3, 4, -1, -2, -3]]);;
gap> y := Bipartition([[1, 2, -3], [3, -1, -2]]);;
gap> NaturalLeqBlockBijection(x, y);
Error, Semigroups: NaturalLeqBlockBijection: usage,
the arguments must be block bijections of equal degree,

# bipartition: NaturalLeqBlockBijection 3/3
gap> x := IdentityBipartition(10);;
gap> NaturalLeqBlockBijection(x, x);
true

# bipartition: NaturalLeqPartialPermBipartition 1/4
gap> x := Bipartition([[1, 2, 4, 5, -2], [3, -1, -3], [-4], [-5]]);;
gap> y := Bipartition([[1, 3, -2], [2, 4, -5], [5, -1, -4], [-3]]);;
gap> NaturalLeqPartialPermBipartition(x, y);
Error, Semigroups: NaturalLeqPartialPermBipartition: usage,
the arguments must be partial perm bipartitions,

# bipartition: NaturalLeqPartialPermBipartition 2/4
gap> x := Bipartition([[1, -4], [2, -1], [3], [4, -5], [5], [-2],
> [-3]]);;
gap> y := Bipartition([[1, -4], [2, -3], [3], [4], [5], [-1], [-2], [-5]]);;
gap> NaturalLeqPartialPermBipartition(x, y);
false
gap> NaturalLeqPartialPermBipartition(y, x);
false
gap> NaturalLeqPartialPermBipartition(y, y);
true

# bipartition: NaturalLeqPartialPermBipartition 3/4
gap> x := Bipartition([[1, -4], [2, -1], [3], [4, -5], [5], [-2], [-3], [6],
> [-6]]);;
gap> y := Bipartition([[1, -4], [2, -3], [3], [4], [5], [-1], [-2], [-5]]);;
gap> NaturalLeqPartialPermBipartition(x, y);
Error, Semigroups: NaturalLeqPartialPermBipartition: usage,
the arguments must have equal degree,

# bipartition: NaturalLeqPartialPermBipartition 4/4
gap> x := Bipartition([[1, -4], [2], [3, -3], [4, -1], [-2]]);;
gap> NaturalLeqPartialPermBipartition(x, x);
true

# bipartition: InverseMutable, for a non-invertible bipartition
gap> x := Bipartition([[1], [2], [3, -3], [-1, -2]]);;
gap> InverseMutable(x);
fail

# bipartition: \*, for bipartition and perm 1/2
gap> Bipartition([[1], [2], [3, -3], [-1, -2]]) * (1, 3, 2);
<bipartition: [ 1 ], [ 2 ], [ 3, -2 ], [ -1, -3 ]>

# bipartition: \*, for bipartition and perm 2/2
gap> Bipartition([[1], [2], [3, -3], [-1, -2]]) * (1, 2)(4, 5);
Error, Semigroups: * (for a bipartition and perm): usage,
the largest moved point of the perm must not be greater
than the degree of the bipartition,

# bipartition: \*, for perm and bipartition 1/2
gap> (1, 2) * Bipartition([[1], [2], [3, -3], [-1, -2]]);
<bipartition: [ 1 ], [ 2 ], [ 3, -3 ], [ -1, -2 ]>

# bipartition: \*, for perm and bipartition 2/2
gap> (1, 2, 4) * Bipartition([[1], [2], [3, -3], [-1, -2]]);
Error, Semigroups: * (for a perm and bipartition): usage,
the largest moved point of the perm must not be greater
than the degree of the bipartition,

# bipartition: \*, for bipartition and transformation 1/2
gap> Bipartition([[1, 2, -1, -2], [3, -3]]) *
> Transformation([3, 3, 2]);
<bipartition: [ 1, 2, -3 ], [ 3, -2 ], [ -1 ]>

# bipartition: \*, for bipartition and transformation 2/2
gap> Bipartition([[1, 2, -1, -2], [3, -3]]) *
> Transformation([3, 4, 2, 4]);
Error, Semigroups: * (for a bipartition and transformation): usage,
the degree of the transformation must not be greater
than the degree of the bipartition,

# bipartition: \*, for transformation and bipartition 1/2
gap> Transformation([1, 3, 2])
> * Bipartition([[1, 3], [2, -1], [-2, -3]]);
<bipartition: [ 1, 2 ], [ 3, -1 ], [ -2, -3 ]>

# bipartition: \*, for transformation and bipartition 2/2
gap> Transformation([1, 4, 4, 1]) *
> Bipartition([[1, 3], [2, -1], [-2, -3]]);
Error, Semigroups: * (for a transformation and bipartition): usage,
the degree of the transformation must not be greater
than the degree of the bipartition,

# bipartition: \*, for bipartition and partial perm 1/2
gap> Bipartition([[1, 2, -1, -2], [3, -3]]) *
> PartialPerm([1, 3, 2]);
<block bijection: [ 1, 2, -1, -3 ], [ 3, -2 ]>

# bipartition: \*, for bipartition and partial perm 2/2
gap> Bipartition([[1, 2, -1, -2], [3, -3]]) *
> PartialPerm([3, 2, 4]);
Error, Semigroups: * (for a bipartition and partial perm): usage,
the partial perm must map [1 .. 3] into
[1 .. 3],

# bipartition: \*, for partial perm and bipartition 1/2
gap> PartialPerm([1, 3, 2]) * Bipartition([[1, 3], [2, -1], [-2, -3]]);
<bipartition: [ 1, 2 ], [ 3, -1 ], [ -2, -3 ]>

# bipartition: \*, for partial perm and bipartition 2/2
gap> PartialPerm([1, 4]) * Bipartition([[1, 3], [2, -1], [-2, -3]]);
Error, Semigroups: * (for a partial perm and a bipartition): usage,
the partial perm must map [1 .. 3] into
[1 .. 3],

# bipartition: \^, for bipartition and perm 1/1
gap> Bipartition([[1, -3], [2], [3, -2], [4, -1, -4]]) ^ (1, 2, 3, 4);
<bipartition: [ 1, -1, -2 ], [ 2, -4 ], [ 3 ], [ 4, -3 ]>

# bipartition: \<, for bipartitions 1/2
gap> Bipartition([[1, 2, 3, -1, -2, -3]]) <
> Bipartition([[1, 3], [2, -1], [-2, -3]]);
true

# bipartition: \<, for bipartitions 2/2
gap> Bipartition([[1, 2, 3, -1, -2, -3], [4, -4]]) <
> Bipartition([[1, 3], [2, -1], [-2, -3]]);
true

# bipartition: PermLeftQuoBipartition, error 1/2
gap> x := Bipartition([[1, 2], [-1, -2]]);;
gap> y := Bipartition([[1, -1, -2], [2]]);;
gap> PermLeftQuoBipartition(x, y);
Error, Semigroups: PermLeftQuoBipartition: usage,
the arguments must have equal left and right blocks,

# bipartition: PermLeftQuoBipartition, result 2/2
gap> x := Bipartition([[1, 2], [-1, -2]]);;
gap> PermLeftQuoBipartition(x, x);
()

# bipartition: AsPartialPerm, error 1/1
gap> AsPartialPerm(Bipartition([[1, 2, -2], [-1]]));
Error, Semigroups: AsPartialPerm (for a bipartition):
the argument does not define a partial perm,

# bipartition: AsPermutation, error 1/1
gap> AsPermutation(Bipartition([[1, 2, -2], [-1]]));
Error, Semigroups: AsPermutation (for a bipartition):
the argument does not define a permutation,

# bipartition: AsTransformation, error 1/1
gap> AsTransformation(Star(Bipartition([[1, 2, -2], [-1]])));
Error, Semigroups: AsTransformation (for a bipartition):
the argument does not define a transformation,

# bipartition: AsBipartition, for a perm and pos int, error 1/1
gap> AsBipartition((1, 2, 3, 5), 4);
Error, Semigroups: AsBipartition (for a permutation and pos int):
the permutation <p> in the 1st argument must permute [1 .. 4],

# bipartition: AsBipartition, for a transformation and pos int, error 1/1
gap> AsBipartition(Transformation([4, 4, 4, 4]), 2);
Error, Semigroups: AsBipartition (for a transformation and pos int):
the argument must map [1 .. 2] to itself,

# bipartition: AsBipartition, for a bipartition and 0 1/1
gap> AsBipartition(Bipartition([[1, 2, -1, -2], [3, -3]]), 0);
<empty bipartition>

# bipartition: AsBlockBijection, for a partial perm and 0 1/1
gap> AsBlockBijection(PartialPerm([4, 1, 3, 2]), 0);
<empty bipartition>

# bipartition: AsBlockBijection, for a partial perm and pos int, error 1/1
gap> AsBlockBijection(PartialPerm([1, 3, 2, 4]), 1);
Error, Semigroups: AsBlockBijection (for a partial perm and pos int):
the 2nd argument must be at least the maximum of the degree and
codegree of the 1st argument,

# bipartition: IsUniformBlockBijection, for a bipartition 1/3
gap> IsUniformBlockBijection(Bipartition([[1, 2, -1, -2], [3, -3]]));
true

# bipartition: IsUniformBlockBijection, for a bipartition 2/3
gap> x := Bipartition([[1, -1], [2, 3, -2], [-3]]);;
gap> IsUniformBlockBijection(x);
false

# bipartition: IsUniformBlockBijection, for a bipartition 3/3
gap> x := Bipartition([[1, 3, -2], [2, -1, -3]]);;
gap> IsUniformBlockBijection(x);
false

# bipartition: IsDualTransBipartition, for a bipartition 1/2
gap> x := Bipartition([[1, 3, -2], [2, -1, -3]]);;
gap> IsDualTransBipartition(x);
false

# bipartition: IsDualTransBipartition, for a bipartition 2/2
gap> x := Star(AsBipartition(Transformation([2, 1, 2])));;
gap> IsDualTransBipartition(x);
true

# bipartition: RightProjection
gap> x := Bipartition([[1, 2, 4, 5, -1], [3, 6, -2], [-3, -6], [-4, -5]]);;
gap> RightProjection(x);
<bipartition: [ 1, -1 ], [ 2, -2 ], [ 3, 6 ], [ 4, 5 ], [ -3, -6 ], 
 [ -4, -5 ]>

# bipartition: Bipartition 1/3
gap> Bipartition("test");
Error, Semigroups: Bipartition: usage,
the argument <classes> must consist of duplicate-free homogeneous lists,
gap> Bipartition(["test"]);
Error, Semigroups: Bipartition: usage,
the argument <classes> must consist of duplicate-free homogeneous lists,
gap> Bipartition([[1, 2], [3, "a"]]);
Error, Semigroups: Bipartition: usage,
the argument <classes> must consist of duplicate-free homogeneous lists,
gap> Bipartition([[1, 2], [3, 3]]);
Error, Semigroups: Bipartition: usage,
the argument <classes> must consist of duplicate-free homogeneous lists,

# bipartition: Bipartition 2/3
gap> Bipartition([[1, 2], [3, E(3)]]);
Error, Semigroups: Bipartition: usage,
the argument <classes> must consist of positive and/or negative integers,


# bipartition: Bipartition 3/3
gap> Bipartition([[1, 2], [3, 4]]);
Error, Semigroups: Bipartition: usage,
the union of the argument <classes> must be [-n..-1, 1..n],

# bipartition: OneMutable, for a bipartition collection 1/1
gap> OneMutable([IdentityBipartition(2)]);
<block bijection: [ 1, -1 ], [ 2, -2 ]>

# bipartition: BipartitionByIntRep 1/5
gap> BipartitionByIntRep([1, 2, 3]);
Error, Semigroups: BipartitionByIntRep: usage,
the length of the argument <blocks> must be an even integer,

# bipartition: BipartitionByIntRep 2/5
gap> BipartitionByIntRep([1, 2, 3, "a"]);
Error, Semigroups: BipartitionByIntRep: usage,
the elements of the argument <blocks> must be positive integers,

# bipartition: BipartitionByIntRep 3/5
gap> BipartitionByIntRep([1, 2, 3, 5]);
Error, Semigroups: BipartitionByIntRep: usage,
expected 4 but found 5, in position 4

# bipartition: BipartitionByIntRep 4/5
gap> BipartitionByIntRep([1, 3, 3, 5]);
Error, Semigroups: BipartitionByIntRep: usage,
expected 2 but found 3, in position 2

# bipartition: BipartitionByIntRep 5/5
gap> BipartitionByIntRep([1, 2, 3, 1]);
<bipartition: [ 1, -2 ], [ 2 ], [ -1 ]>

# bipartition: BIPART_LAMBDA_CONJ 1/2
gap> x := Bipartition([[1, 3, -2, -3], [2, -1]]);;
gap> BIPART_LAMBDA_CONJ(x, RightOne(x));
(1,2)

# bipartition: BIPART_LAMBDA_CONJ 2/2
gap> x := Bipartition([[1, 3, -2, -3], [2, -1]]);;
gap> BIPART_LAMBDA_CONJ(LeftOne(x), x);
(1,2)

# bipartition: PrintString, for a bipartition 1/1
gap> PrintString(Bipartition([[1, 2, -1, -2], [3, -3]]));
"\>\>Bipartition(\< \>[ [ 1, 2, -1, -2 ],\< \>[ 3, -3 ] \<] )\<"

# bipartition: PrintString, for a bipartition collection 1/2
gap> PrintString([Bipartition([[1, 2, -1, -2], [3, -3]]),
> Bipartition([[1, 2, -1, -2], [3, -3]])]);
"\>[ \>\>\>Bipartition(\< \>[ [ 1, 2, -1, -2 ],\< \>[ 3, -3 ] \<] )\<,\<\n \>\
\>\>Bipartition(\< \>[ [ 1, 2, -1, -2 ],\< \>[ 3, -3 ] \<] )\< ]\<\n"

# bipartition: PrintString, for a bipartition collection 2/2
gap> S := Semigroup(Bipartition([[1, 2, -1, -2], [3, -3]]));;
gap> PrintString(S);
"\>Semigroup(\>\n\>\>[ \>\>\>Bipartition(\< \>[ [ 1, 2, -1, -2 ],\< \>[ 3, -3 \
] \<] )\< ]\<\n\<\> \<)\<\<"

# bipartition: DegreeOfBipartitionCollection, for a semigroup 1/1
gap> DegreeOfBipartitionCollection(PartitionMonoid(2));
2

# bipartition: DegreeOfBipartitionCollection, error 1/1
gap> x := Bipartition([[1, 2, -2], [-1]]);;
gap> y := Bipartition([[1, 3], [2, -1], [-2], [-3]]);;
gap> DegreeOfBipartitionCollection([x, y]);
Error, Semigroups: DegreeOfBipartitionCollection: usage,
the argument <coll> must be a collection of bipartitions of equal degree,

# bipartition: AsBipartition, for a PBR and 0, 1
gap> AsBipartition(EmptyPBR(1), 0);
<empty bipartition>

# bipartition: AsBipartition, for a PBR and pos int, 1
gap> AsBipartition(PBR([[-1], [-2]], [[], []]), 2);
Error, Semigroups: AsBipartition (for a pbr): usage,
the argument does not satisfy 'IsBipartitionPBR',

# bipartition: AsBipartition, for a PBR and pos int, 2
gap> AsBipartition(PBR(
> [[-3, 1, 3], [-1, 2], [-3, 1, 3]],
> [[-1, 2], [-2], [-3, 1, 3]]), 3);
<bipartition: [ 1, 3, -3 ], [ 2, -1 ], [ -2 ]>

# bipartition: AsBipartition, for a PBR, 1
gap> AsBipartition(PBR([[-1], [-2]], [[], []]));
Error, Semigroups: AsBipartition (for a pbr): usage,
the argument does not satisfy 'IsBipartitionPBR',

# bipartition: AsBipartition, for a PBR, 2
gap> AsBipartition(PBR(
> [[-3, 1, 3], [-1, 2], [-3, 1, 3]],
> [[-1, 2], [-2], [-3, 1, 3]]));
<bipartition: [ 1, 3, -3 ], [ 2, -1 ], [ -2 ]>

# bipartition: RandomBlockBijection, 1
gap> ForAll([1 .. 20], x -> IsBlockBijection(RandomBlockBijection(x)));
true

#
gap> Unbind(elts);
gap> Unbind(DD);
gap> Unbind(gens);
gap> Unbind(HH);
gap> Unbind(LL);
gap> Unbind(r);
gap> Unbind(inv);
gap> Unbind(triples);
gap> Unbind(D);
gap> Unbind(G);
gap> Unbind(H);
gap> Unbind(L);
gap> Unbind(N);
gap> Unbind(S);
gap> Unbind(R);
gap> Unbind(bp);
gap> Unbind(T);
gap> Unbind(e);
gap> Unbind(g);
gap> Unbind(classes2);
gap> Unbind(f);
gap> Unbind(l);
gap> Unbind(s);
gap> Unbind(classes);
gap> Unbind(iso);
gap> Unbind(x);

#E# 
gap> STOP_TEST("Semigroups package: standard/bipartition.tst");