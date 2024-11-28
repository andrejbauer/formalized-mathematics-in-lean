# Inductive types

## The idea

In mathematics and computer science we often construct objects as follows:

1. Start with some *basic* objects.
2. Build *new* objects from previously constructed ones using *primitive constructors*.

The most familiar example is the natural numbers.

:::{admonition} Natural numbers
1. Basic object: zero
2. Constructor: successor
:::

Another one is lists.

:::{admonition} Lists
1. Basic object: empty list `[]`
2. Constructor: `x :: ℓ` where `x` is an element and `ℓ` is a list 
:::

We may have more than one constructor.

:::{admonition} 2-3 trees

1. Basic object: empty tree
2. Constructors:
    * given 2-3-trees `t₁` and `t₂`, construct a tree `node₂(t₁, t₂)`
    * given 2-3-trees `t₁`, `t₂`, `t₃`, construct a tree `node₃(t₁, t₂, t₃)`
:::

But what do we mean when we say that these constructions are “inductive“? Saying something like “only finite objects can be generated this way” is *false* when the constructors may take an infinite number of arguments (we shall see one such example below), and saying “those and only those objects which can be generated using the above constructors" does not explain anything. Before answering the question, let us observe that the examples above are all trees, and generalize them to a common construction.

## Well-founded trees

A general form of an inductive constructions is as follows:

1. There is a set $A$ of **node kinds**.
2. For each node kind $a \in A$ there is a set $B(a)$, the **branching** of $a$.

(You may have expected a set of basic objects, but those are a special kind of the above, as witnessed by examples below.)
We call such a set $A$ with a family $B : A \to \mathsf{Set}$ a **signature**.
The set of well-founded trees $W(A,B)$ generated by a given signature has elements constructed inductively as follows:

1. Given any $a \in A$ and $f : B(a) \to W(A,B)$, we mau form the tree $\mathsf{tree}(a, t) \in W(A,B)$.

:::{admonition} Natural numbers

1. The node kinds: $A = \{z, s\}$.
2. Branching:
    * $B(z) = \emptyset$
    * $B(s) = \set{\star\}$

Indeed, zero $0$ may be construed as a leaf, i.e., a tree without subtrees (hence $B(z) = \emptyset$), while a successor $\succ(n)$ may be construed as a tree whose only subtree is $n$. The set $W(A,B)$ is generated as follows:

* $0 = \mathsf{tree}(z, O)$, where $O : \emptyset \to W(A,B)$ is the empty map,
* $1 = \mathsf{tree}(s, (\star \mapsto 0))$
* $2 = \mathsf{tree}(s, (\star \mapsto \mathsf{tree}(s, (\star \mapsto 0))))$
* and so on

:::

:::{admonition} Lists

Fix a set $X$ of elements.

1. The node kinds: $A = \{e\} + X$.
2. Branching:
    * $B(\mathrm{inl}(e)) = \emptyset$
    * $B(\mathrm{inr}(x)) = \set{\star\}$

Can you relate this to the usual definition of trees?
:::

As an exercise, figure out how to present 2-3-trees in this fashion as an exercise.

Such trees are called **well-founded** because every path in a tree is finite.

:::{warning} Countably-branching trees

It is *not* true that every well-founded tree is finite! Consider the inductively generated set $T$ **countably-branching trees*:

1. The empty tree: $\mathsf{empty} \in T$
2. Given a sequence $t : \mathbb{N} \to T$, we have $\mathtt{tree}(t) \in T$.

:::

**Exercise:** give an example of an infinite countably-branching tree.


### What does “inductive mean?

We would like to express the idea that an inductively generated set of well-founded trees is **generated** by its constructors. This idea can be formulated in terms of it having a *universal property* in a suitable category-theoretic sense.

:::{admonition} Polynomial functor

Given a signature $(A,B)$, define the **polynomial functor** $P_{A,B} : \mathsf{Set} \to \mathsf{Set}$ by
$$P_{A,B}(X) = \sum_{a \in A} X^{B(a)}.$$

:::

Exercise: define the functorial action of $P_{A,B}$ on a morphism $f : X \to Y$.)
The functor $P$ captures the idea of “one step” in the process that generates all well-founded trees.

:::{admonition} $P_{A,B}$-algebra

Given a signature $(A,B)$, a **$P_{A,B}$-algebra** $(X, h)$ is a set $X$ with a map $h : P_{A,B} \to X$.

:::

:::{admonition} Well-founded trees as the initial $P_{A,B}$-algebra

Given a signature $(A, B)$, the **well-founded $(A,B)$-trees** are the initial algebra $(W(A,B), h_{A,B})$ for the polynomial functor $P_{A,B}$.
That is, its universal property is: given any set $P_{A,B}$-algebra $(X, h)$, there is a unique map $r : W(A,B) \to X$ such that
$h \circ P_{A,B}(r) = r \circ h_{A,B}$.

:::

**Exercise:** Unravel the above definition and universal property in the case of natural numbers. What principle does the universal property encode?


## Inductive types

In type theory we follow the same idea as in category theory, but phrase the universal property of an inductive type in terms of an **induction principle**. Lean generates such induction principles automatically. We shall look at some examples during the lecture.

Let us also mention that inductive definitions have a much wider scope than just well-founded trees. They can be used to define propositional connectives, as well as many relation. Again, we are going to look at some examples interactively in the lecture.

## Reading material

This week's reading material comes from [Theorem proving in Lean 4](https://leanprover.github.io/theorem_proving_in_lean4/title_page.html):

* [7. Inductive types](https://leanprover.github.io/theorem_proving_in_lean4/inductive_types.html)
* [8. Induction and recursion](https://leanprover.github.io/theorem_proving_in_lean4/induction_and_recursion.html)

## Homework

At this point you should know what your class project is and you should have created the initial project with a blueprint.
**Work on your project.**

## Video and class notes

* **Video:** [MAT-FORMATH-2024-11-22 Inductive types](https://youtu.be/L5z6Vu9hXsg?si=Hbqro1o0GR9R5zJU)
* **Notes:** [MAT-FORMATH-2024/MAT-FORMATH-2024-11-22-inductive-types](https://www.andrej.com/zapiski/MAT-FORMATH-2024/MAT-FORMATH-2024-11-22-inductive-types/)