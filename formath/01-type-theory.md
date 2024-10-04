# Type theory

The working mathematician is familiar with the set-theoretic foundation of mathematics. However, Lean and many other proof assistants use a different formalism known as **type theory**. This is because type theory is closer to how mathematics is *actually* done than set theory, and because type theory can be used simultaneously as a programming language and a foundation of mathematics.

In this lecture we shall review the basics of type theory, starting from the idea that we are "just reformulating" set theory. While this is the case, the resulting formalism has a much wider scope than just classical set theory (but this is not something that we will dwell into here).

Set theory emphasizes basic concepts such as elementhood, subsets, unions, intersections, powerset, unordered pairs, functions as functional relations, etc. We are going to choose a different set of primitives, as follows.

## Types

*For the remainder of this lecture, we shall use the words **set** and **type** as synonyms.*

We shall also write $e : A$ instead of $e \in A$ to indicate that $e$ is an element of $A$. (There are subtle formal differences between $e : A$ and $e \in A$, but it is too early to discuss them.)

## Families

A **family** of sets is a map $A : I \to \mathsf{Set}$, where the set $I$ is called an **indexing set** and $\mathsf{Set}$ is the class of all sets. As we are taking types to be synonymous with sets, we shall refer to these also as **type families** and write $\mathsf{Type}$ for the class of all types (sets), which leads to the notation $A : I \to \mathsf{Type}$.

Quote often a type family is not given explicitly as a map, but rather as a type that depends on one or more parameters. For example, in a mathematical text we might read:

> Let $n \in \mathbb{N}$ be a natural number. For any vector $\vec{x} \in \mathbb{R}^n$ we can find ...

Here $n$ is a parameter of type $\mathbb{N}$ and $\mathbb{R}^n$ a type that *depends* on $n$. We call it a **dependent type**. As a family, it is the map $\mathbb{R}^{-} : \mathbb{N} \to \mathsf{Type}$ which assigns to each $n \in \mathbb{N}$ the type $\mathbb{R}^n$.

Dependent types are all-present in mathematical practice, and we shall use them extensively.

## Basic constructions

We shall follow a method for describing basic constructions that is closer to algebra than classical set theory.

The axioms of set theory emphasize *existence* of certain sets, for example the powerset axiom says:

> For every set $A$ there exists a sets $P$ such that, for all $B$, $B \in P \Leftrightarrow B \subseteq A$.

The algebraic approach would instead postulate that there is a *powerset operation* $\mathcal{P}$ which takes a set $A$ and gives another set $\mathcal{P}(A)$, and a *subset-forming operation* which takes a set $A$ and a predicate $\phi(x)$, with $x$ ranging over $A$, and produces an element $\{x \in A \mid \phi(x)\}$ of $\mathcal{P}(A)$. After that, we would also need to give some *equations* that describe how these operations act.

### Binary product

### Binary sum

### Dependent products

### Dependent sum

### Natural numbers

### The unit and the empty set

### Booleans

## Logic via sets

### Propositions as sub-singletons

#### Truncation

### Disjunction vs. decision

### Abstract and concrete existence


### Equality

## Reading material

* Egbert Rijke, [Introduction to homotopy type theory](https://arxiv.org/abs/2212.11082), Chapters 1–4
* Mario Carneiro, [Type theory of Lean](https://ucilnica.fmf.uni-lj.si/mod/url/view.php?id=70491)



