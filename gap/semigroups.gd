##
## semigroups.gd
## Version 3.1.1
## Mon Jun  9 17:02:20 BST 2008
##

###########################################################################
##
##	<#GAPDoc Label="SingularSemigroup">
##	<ManSection>
##	<Func Name="SingularSemigroup" Arg="n"/>
##	<Description>
##	creates the semigroup of singular transformations of degree <C>n</C>. That 
##	is, the semigroup of all transformations of the <C>n</C>-element set <C>
##	{1,2,...,n}</C> that are non-invertible.  <P/>
##
##	This semigroup is known to be regular, idempotent generated (satisfies 
##	<Ref Prop="IsSemiBand"/>), and has size <C>n^n-n!</C>.<P/>
##	
##	The generators used here are the idempotents of rank <C>n-1</C>, so there 
##	are <C>n(n-1)</C> generators in total.
##	<Example>
##  gap&gt; S:=SingularSemigroup(6);
##  &lt;semigroup with 30 generators&gt;
##  gap&gt; Size(S);
##  45936
##  gap&gt; IsRegularSemigroup(S);
##  true
##  gap&gt; IsSemiBand(S);
##  true
##	</Example> <!-- semigroups.tst -->
##	</Description>
##	</ManSection>
##	<#/GAPDoc>

DeclareGlobalFunction("SingularSemigroup");

###########################################################################
##
##	<#GAPDoc Label="OrderPreservingSemigroup">
##	<ManSection>
##	<Oper Name="OrderPreservingSemigroup" Arg="n"/>
##	<Description>
##	returns the semigroup of order preserving transformations of the <C>n</C>-
##	element set <C>{1,2,...,n}</C>. That is, the mappings <C>f</C> such that 
##	<C>i</C> is at most <C>j</C> implies <C>f(i)</C> is at most  <C>f(j)</C> for 
##	all <C>i,j</C> in <C>{1,2,...,n}</C>.  <P/>
##
##	This semigroup is known to be regular, idempotent generated (satisfies 
##	<Ref Prop="IsSemiBand"/>), and has size <C>Binomial(2*n-1, n-1)</C>.
##
##	The generators and relations used here are those specified by Aizenstat as 
##	given in <Cite Key="arthur1"/> and <Cite Key="gomes1"/>.
##	That is, <C>OrderPreservingSemigroup(n)</C> has the <C>2n-2</C> idempotent 
##	generators
##	<Log>
##	u_2:=Transformation([2,2,3,..,n]), u_3:=Transformation([1,3,3,..,n]), ...
##	v_n-2:=Transformation([1,2,2,...,n]), v_n-3:=Transformation
##	([1,2,3,3,...,n]), ...
##	</Log>
##	and the presentation obtained using <Ref Attr="IsomorphismFpMonoid"/> has 
##	relations 
##	<Log>
##  v_n−i u_i = u_i v_n−i+1 (i=2,..., n−1)
##  u_n−i v_i = v_i u_n−i+1 (i=2,...,n−1),
##  v_n−i u_i = u_i (i=1,...,n−1),
##  u_n−i v_i = v_i (i=1,...,n−1),
##  u_i v_j = v_j u_i (i,j=1,...,n−1; not j=n-i, n-i+1),
##  u_1 u_2 u_1 = u_1 u_2,
##  v_1 v_2 v_1 = v_1 v_2. 
##  </Log><P/><Br/>
##
##	<Example>
##  gap&gt; S:=OrderPreservingSemigroup(5);
##  &lt;monoid with 8 generators&gt;
##  gap&gt; IsSemiBand(S);
##  true
##  gap&gt; IsRegularSemigroup(S);
##  true
##  gap&gt; Size(S)=Binomial(2*5-1, 5-1);
##  true
##	</Example>
##	</Description>
##	</ManSection>
##	<#/GAPDoc>

DeclareOperation("OrderPreservingSemigroup", [IsPosInt]);

################

DeclareCategory("IsZeroSemigroupElt", IsMultiplicativeElementWithZero);

DeclareRepresentation("IsZeroSemigroupEltRep", IsPositionalObjectRep, 1);

DeclareAttribute("ZeroSemigroupFamily", IsFamily);

DeclareAttribute("ZeroSemigroupDefaultType", IsFamily);

###########################################################################
##
##	<#GAPDoc Label="ZeroSemigroup">
##	<ManSection>
##	<Oper Name="ZeroSemigroup" Arg="n"/>
##	<Description>
##	returns the <E>zero semigroup</E> <C>S</C> of order <C>n</C>. That is, the 
##	unique semigroup up to isomorphism of order <C>n</C> such that there exists 
##	an element <C>0</C> in <C>S</C> such that <C>xy=0</C> for all <C>x,y</C> in 
##	<C>S</C>.<P/>
##
##	A zero semigroup is generated by its nonzero elements, has trivial Green's 
##	relations, and is not regular. 
##
##	<Example>
##  gap&gt; S:=ZeroSemigroup(10);
##  &lt;zero semigroup with 10 elements&gt;
##  gap&gt; Size(S);
##  10
##  gap&gt; GeneratorsOfSemigroup(S);
##  [ z1, z2, z3, z4, z5, z6, z7, z8, z9 ]
##  gap&gt; Idempotents(S);
##  [ 0 ]
##  gap&gt; IsZeroSemigroup(S);
##  true
##  gap&gt; GreensRClasses(S);
##  [ {0}, {z1}, {z2}, {z3}, {z4}, {z5}, {z6}, {z7}, {z8}, {z9} ]
##	</Example> <!-- semigroups.tst -->
##	</Description>
##	</ManSection>
##	<#/GAPDoc>

DeclareOperation("ZeroSemigroup", [IsPosInt]);

###########################################################################
##
##	<#GAPDoc Label="ZeroSemigroupElt">
##	<ManSection>
##	<Oper Name="ZeroSemigroupElt" Arg="n"/>
##	<Description>
##	returns the zero semigroup element <C>zn</C> where <C>n</C> is a positive 
##	integer and <C>z0</C> is the multiplicative zero.<P/>
##
##	The zero semigroup element <C>zn</C> belongs to every zero semigroup with 
##	degree at least <C>n</C>.
##
##	<Example>
##  gap&gt; ZeroSemigroupElt(0);
##  0
##  gap&gt; ZeroSemigroupElt(4);
##  z4
##	</Example> <!-- semigroups.tst -->
##	</Description>
##	</ManSection>
##	<#/GAPDoc>

DeclareOperation("ZeroSemigroupElt", [IsInt]);

################

DeclareCategory("IsZeroGroupElt", IsMultiplicativeElementWithOne and IsAssociativeElement and IsMultiplicativeElementWithZero and IsMultiplicativeElementWithInverse);

DeclareRepresentation("IsZeroGroupEltRep", IsPositionalObjectRep, 1);

DeclareAttribute("ZeroGroupFamily", IsFamily);

DeclareAttribute("ZeroGroupDefaultType", IsFamily);

###########################################################################
##
##	<#GAPDoc Label="ZeroGroup">
##	<ManSection>
##	<Oper Name="ZeroGroup" Arg="G"/>
##	<Description>
##	returns the monoid obtained by adjoining a zero element to <C>G</C>. That 
##	is, the monoid <C>S</C> obtained by adjoining a zero element <C>0</C> to 
##	<C>G</C> with <C>g0=0g=0</C> for all <C>g</C> in <C>S</C>.
##	<Example>
##  gap&gt; S:=ZeroGroup(CyclicGroup(10));
##  &lt;zero group with 3 generators&gt;
##  gap&gt; IsRegularSemigroup(S);
##  true
##  gap&gt; Elements(S);
##  [ 0, &lt;identity&gt; of ..., f1, f2, f1*f2, f2^2, f1*f2^2, f2^3, f1*f2^3, f2^4, 
##    f1*f2^4 ]
##  gap&gt; GreensRClasses(S);
##  [ {&lt;adjoined zero&gt;}, {ZeroGroup(&lt;identity&gt; of ...)} ]
##	</Example> <!-- semigroups.tst -->
##	</Description>
##	</ManSection>
##	<#/GAPDoc>

DeclareOperation("ZeroGroup", [IsGroup]);

###########################################################################
##
##	<#GAPDoc Label="ZeroGroupElt">
##	<ManSection>
##	<Oper Name="ZeroGroupElt" Arg="g"/>
##	<Description>
##	returns the zero group element corresponding to the group element <C>g</C>. 
##	The function <C>ZeroGroupElt</C> is only used to create an object in the 
##	correct category during the creation of a zero group using 
##	<Ref Oper="ZeroGroup"/>.
##	<Example>
##  gap&gt; ZeroGroupElt(Random(DihedralGroup(10)));;
##  gap&gt; IsZeroGroupElt(last);
##  true
##	</Example>
##	</Description>
##	</ManSection>
##	<#/GAPDoc>

DeclareOperation("ZeroGroupElt", [IsMultiplicativeElement and IsAssociativeElement and IsMultiplicativeElementWithOne and IsMultiplicativeElementWithInverse]);

###########################################################################
##
##	<#GAPDoc Label="UnderlyingGroupOfZG">
##	<ManSection>
##	<Attr Name="UnderlyingGroupOfZG" Arg="ZG"/>
##	<Description>
##	returns the group from which the zero group <C>ZG</C> was constructed.  
##	<Example>
##  gap&gt; G:=DihedralGroup(10);;
##  gap&gt; S:=ZeroGroup(G);;
##  gap&gt; UnderlyingGroupOfZG(S)=G;
##  true
##	</Example> <!-- semigroups.tst -->
##	</Description>
##	</ManSection>
##	<#/GAPDoc>

DeclareAttribute("UnderlyingGroupOfZG", IsZeroGroup );

###########################################################################
##
##	<#GAPDoc Label="UnderlyingGroupEltOfZGElt">
##	<ManSection>
##	<Attr Name="UnderlyingGroupEltOfZGElt" Arg="g"/>
##	<Description>
##	returns the group element from which the zero group element <C>g</C> was 
##	constructed.
##	<Example>
##  gap&gt; G:=DihedralGroup(10);;
##  gap&gt; S:=ZeroGroup(G);;
##  gap&gt; Elements(S);
##  [ 0, &lt;identity&gt; of ..., f1, f2, f1*f2, f2^2, f1*f2^2, f2^3, f1*f2^3, f2^4, 
##    f1*f2^4 ]
##  gap&gt; x:=last[5];
##  f1*f2
##  gap&gt; UnderlyingGroupEltOfZGElt(x);
##  f1*f2
##	</Example> <!-- semigroups.tst -->
##	</Description>
##	</ManSection>
##	<#/GAPDoc>

DeclareAttribute("UnderlyingGroupEltOfZGElt", IsZeroGroupElt);

###########################################################################
##
##	<#GAPDoc Label="RandomSemigroup">
##	<ManSection>
##	<Func Name="RandomSemigroup" Arg="m, n"/>
##	<Description>
##	returns a random transformation semigroup of degree <C>n</C> with <C>m</C> 
##	generators.
##	<Example>
##  gap&gt; S:=RandomSemigroup(5,5);
##  &lt;semigroup with 5 generators&gt;
##	</Example>
##	</Description>
##	</ManSection>
##	<#/GAPDoc>

DeclareGlobalFunction("RandomSemigroup");

###########################################################################
##
##	<#GAPDoc Label="RandomMonoid">
##	<ManSection>
##	<Func Name="RandomMonoid" Arg="m, n"/>
##	<Description>
##	returns a random transformation monoid of degree <C>n</C> with <C>m</C> 
##	generators.
##	<Example>
##  gap&gt; S:=RandomMonoid(5,5);
##  &lt;semigroup with 5 generators&gt;
##	</Example>
##	</Description>
##	</ManSection>
##	<#/GAPDoc>

DeclareGlobalFunction("RandomMonoid");

###########################################################################
##
##	<#GAPDoc Label="RandomReesMatrixSemigroup">
##	<ManSection>
##	<Func Name="RandomReesMatrixSemigroup" Arg="i, j, deg"/>
##	<Description>
##	returns a random Rees matrix semigroup with an <C>i</C> by <C>j</C> sandwich 
##	matrix over a permutation group with maximum degree <C>deg</C>. 
##	<Example>
##  gap&gt; S:=RandomReesMatrixSemigroup(4,5,5);
##  Rees Matrix Semigroup over Group([ (1,5,3,4), (1,3,4,2,5) ])
##  [ [ (), (), (), (), () ], 
##  [ (), (1,3,5)(2,4), (1,3,5)(2,4), (1,5,3), (1,5,3) ], 
##  [ (), (1,3,5), (1,5,3)(2,4), (), (1,5,3) ], 
##  [ (), (), (1,3,5)(2,4), (2,4), (2,4) ] ]
##	</Example>
##	</Description>
##	</ManSection>
##	<#/GAPDoc>

DeclareGlobalFunction("RandomReesMatrixSemigroup");

###########################################################################
##
##	<#GAPDoc Label="RandomReesZeroMatrixSemigroup">
##	<ManSection>
##	<Func Name="RandomReesZeroMatrixSemigroup" Arg="i, j, deg"/>
##	<Description>
##	returns a random Rees <C>0</C>-matrix semigroup with an <C>i</C> by <C>j</C> 
##	sandwich matrix over a permutation group with maximum degree <C>deg</C>. 
##
##	<Example>
##  gap&gt; S:=RandomReesZeroMatrixSemigroup(2,3,2);
##  Rees Zero Matrix Semigroup over &lt;zero group with 2 generators&gt;
##  gap&gt; SandwichMatrixOfReesZeroMatrixSemigroup(S);
##  [ [ 0, (), 0 ], [ 0, 0, 0 ] ]
##	</Example>
##	</Description>
##	</ManSection>
##	<#/GAPDoc>

DeclareGlobalFunction("RandomReesZeroMatrixSemigroup");

###########################################################################
##
#F	ReesMatrixSemigroupElementNC(R, i, a, lambda)
##
##	a no check version of the library function of the same name.
##

DeclareGlobalFunction("ReesMatrixSemigroupElementNC");
DeclareGlobalFunction("ReesZeroMatrixSemigroupElementNC");

###########################################################################
##
##	<#GAPDoc Label="KiselmanSemigroup">
##	<ManSection>
##	<Oper Name="KiselmanSemigroup" Arg="n"/>
##	<Description>
##	returns the Kiselman semigroup with <C>n</C> generators. That is, the 
##	semigroup defined in <!--<Cite Key="mazorchuk"/>--> with the presentation
##	<Display>
##	&lt;a_1, a_2, ... , a_n | a_i^2=a_i (i=1,...n) a_ia_ja_i=a_ja_ia_j=a_ja_i 
##	(1&lt;=i&lt; j&lt;=n)&gt;.
##	</Display>
##	<Example>
##  gap&gt; S:=KiselmanSemigroup(3);
##  &lt;fp monoid on the generators [ m1, m2, m3 ]&gt;
##  gap&gt; Elements(S);
##  [ &lt;identity ...&gt;, m1, m2, m3, m1*m2, m1*m3, m2*m1, m2*m3, m3*m1, m3*m2, 
##    m1*m2*m3, m1*m3*m2, m2*m1*m3, m2*m3*m1, m3*m1*m2, m3*m2*m1, m2*m1*m3*m2, 
##    m2*m3*m1*m2 ]
##  gap&gt; Idempotents(S);
##  [ 1, m1, m2*m1, m3*m2*m1, m3*m1, m2, m3*m2, m3 ]
##  gap&gt; SetInfoLevel(InfoAutos, 0);
##  gap&gt; AutomorphismGroup(Range(IsomorphismTransformationSemigroup(S)));
##  &lt;group of size 1 with 1 generators&gt;
##  </Example>
##	</Description>
##	</ManSection>
##	<#/GAPDoc>

DeclareOperation("KiselmanSemigroup", [IsPosInt]);

###########################################################################
##
##	<#GAPDoc Label="FullMatrixSemigroup">
##	<ManSection><Heading>FullMatrixSemigroup &amp; GeneralLinearSemigroup
##	</Heading>
##	<Oper Name="FullMatrixSemigroup" Arg="d, q"/>
##	<Oper Name="GeneralLinearSemigroup" Arg="d, q"/>
##	<Description>
##	these two functions are synonyms for each other. They both return the full 
##	matrix semigroup, or if you prefer the general linear semigroup, of all 
##	<C>d</C> by <C>d</C> matrices with entries over the field with <C>q</C> 
##	elements.  This semigroup has <C>q^(d^2)</C> elements. 
##	<Example>
##  gap&gt; FullMatrixSemigroup(3,4);
##  &lt;3x3 full matrix semigroup over GF(2^2)&gt;
##  gap&gt; Size(last);
##  262144
##  </Example>
##	</Description>
##	</ManSection>
##	<#/GAPDoc>

DeclareOperation("FullMatrixSemigroup", [IsPosInt, IsPosInt]);
DeclareOperation("GeneralLinearSemigroup", [IsPosInt, IsPosInt]);

###########################################################################
##
##	<#GAPDoc Label="IsFullMatrixSemigroup">
##	<ManSection><Heading>IsFullMatrixSemigroup &amp; IsGeneralLinearSemigroup
##	</Heading>
##	<Prop Name="IsFullMatrixSemigroup" Arg="S"/>
##	<Prop Name="IsGeneralLinearSemigroup" Arg="S"/>
##	<Description>
##	these two functions are synonyms for each other. They both return 
##	<C>true</C> if the semigroup <C>S</C> was created using either of the 
##	commands <Ref Oper="FullMatrixSemigroup"/> or 
##	<Ref Oper="GeneralLinearSemigroup"/> and <C>false</C> otherwise. 
##	<Example>
##  gap&gt; S:=RandomSemigroup(4,4);
##  &lt;semigroup with 4 generators&gt;
##  gap&gt; IsFullMatrixSemigroup(S);
##  false
##  gap&gt; S:=GeneralLinearSemigroup(3,3);
##  &lt;3x3 full matrix semigroup over GF(3)&gt;
##  gap&gt; IsFullMatrixSemigroup(S);
##  true
##  </Example>
##	</Description>
##	</ManSection>
##	<#/GAPDoc>

DeclareProperty("IsFullMatrixSemigroup", IsMonoid);
DeclareSynonymAttr("IsGeneralLinearSemigroup", IsFullMatrixSemigroup);
