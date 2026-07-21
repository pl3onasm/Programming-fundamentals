$\huge\color{cadetblue}{\text{Extra practice in Dafny}}$

<br/>

This folder contains some extra exercises on program verification in Dafny. The exercises are based on material from the discontinued course *Program Correctness* at the University of Groningen. Most are taken from the [course reader](../Tutorials/Reader%20Program%20Correctness.pdf) or from old examinations.

<br/>

| ${\color{peru}\text{PC Chapter}}$ | ${\color{peru}\text{Topic}}$ |
|:---:|:---|
| 5 | [Basic proofs](Basic) |
| 6 | [Iteration proofs](Iterations) |
| 7 | [Invariants](Invariants) |
| 8 | [Searching and sorting](Searching-sorting) |
| 9 | [Two-dimensional counting](2D-counting) |
| - | [Mathematical induction](Math-Induction) |
| - | [Structural induction](Struct-Induction) |

<br/>

----------------------------------

$\huge\color{cadetblue}{\text{Note on proof styles}}$

<br/>

For selected exercises, two different Dafny solutions are provided when the additional formalization is useful, instructive, or illustrates an interesting proof technique. PC-style solutions remain the default wherever applicable, because they closely reflect the method taught in the *Program Correctness* course. The two styles serve complementary purposes. The PC-style solutions emphasize how correct programs are derived, while the formal solutions show how the complete correctness argument can be expressed and checked in Dafny.

<br/>

$\Large{\color{darkseagreen}\text{PC-Style Solutions}}$

Files whose names contain `PCStyle` follow the derivational proof method used in the *Program Correctness* [lecture notes](../Tutorials/Reader%20Program%20Correctness.pdf). In these solutions, the original mathematical specification is first transformed manually into one or more recursive specification functions, usually denoted by `F`, `S`, `U`, or a similar name. These recursive functions, the loop invariant, the loop body, and the variant function are all derived, explained, and justified in the comments using Floyd-Hoare style reasoning.

Thus, in proofs of this type, the equivalence between the recursive specification and the original mathematical specification is derived and justified manually, but is generally not formalized in Dafny. This keeps the proofs close to the lecture notes and emphasizes the derivational reasoning used to construct the program. Consequently, Dafny verifies that the implementation computes the recursive specification functions `F`, `S`, `U`, or their equivalents, but does not generally verify that these functions denote the mathematical quantity from the original problem statement, such as a cardinality, sum, product, minimum, or maximum.

These solutions can therefore be regarded as hybrid proofs: the correctness of the imperative implementation with respect to the recursive specification is machine-verified, while the derivation of that recursive specification from the original mathematical specification is checked manually through the annotated calculations and arguments.

The proof structure is therefore typically:

```text
original mathematical specification
        ↓ manually derived and justified
recursive specification
        ↓ machine-verified
imperative implementation
```

<br/>

$\Large{\color{darkseagreen}\text{Formal Solutions}}$

Files whose names contain `Formal` formalize the correctness argument end to end. These solutions formally represent the original mathematical specification using Dafny sets, sequences, cardinalities, recursively defined sums and products, or other suitable mathematical structures. Auxiliary lemmas then formally verify the mathematical transformations on which the algorithm relies. Thus, when recursive sums, products, or other intermediate specifications are introduced, their connection with the original mathematical specification is also checked by Dafny. The loop invariant may be stated directly in terms of the formalized specification, or it may be expressed in terms of an intermediate recursive specification, provided that the equivalence between the two is also machine-verified.

The proof structure is therefore typically:

```text
original formalized specification
        ↓ machine-verified
imperative implementation
```

Alternatively, an intermediate recursive specification may still be used, provided that its equivalence with the original specification is also machine-verified:

```text
original formalized specification
        ↓ machine-verified
recursive specification
        ↓ machine-verified
imperative implementation
```

Note that the formal solutions are not machine-generated. Their specifications, recursive functions, invariants, variants, auxiliary lemmas, and overall proof structure are designed by the author. Dafny then verifies that the resulting correctness argument is logically valid.

<br/>

*< in progress >*