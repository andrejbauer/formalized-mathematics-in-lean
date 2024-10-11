# Type theory

The working mathematician is familiar with the set-theoretic foundation of mathematics. However, Lean and many other proof assistants use a different formalism known as **type theory**. This is because type theory is quite close to how mathematics is *actually* done, and because type theory can be used simultaneously as a programming language and a foundation of mathematics.

In this lecture we shall review the basics of type theory, starting from the idea that we are "just reformulating" set theory. While this gives a coherent view of what type theory is about (namely sets), one should keep in mind that it is not the only possible coherent view. A notable alternative is [homotopy type theory](https://homotopytypetheory.org).

Traditional axiomatizations of set theory, for instance the [Zermelo-Fraenkel set theory](https://en.wikipedia.org/wiki/Zermelo–Fraenkel_set_theory), are based on first-order logic and describe sets in terms of existence axioms. Type theory is closer to algebra, because it describes what sets are in terms of **constructions**, **operations** and **equations**.  Let us demonstrate the method by presenting binary products in this way.

### Binary product

We begin by postulating that there is a construction called **binary product** and written using $\times$:

$$\frac{\vdash A\ \mathrm{type} \qquad \vdash B\ \mathrm{type}}{\vdash A \times B\ \mathrm{type}}$$

This is an **inference rule**, which is read as follows: "If a type $A$ is given and a type $B$ is given, then a type $A \times B$ can be constructed." Above the line we have two **premises** and below it a **conclusion**.
We are purposely saying "$A \times B$ is constructed", rather than "$A \times B$ is a type", to emphasize that the rule instructs us on how to make something, rather than claim that something is the case.
The reason for writing $\vdash$ will become clear shortly, think of it as a visual cue for the time being.

The next step is to describe how the elements of $A \times B$ are *constructed* and *destructed*. This is done by introducing primitive operations and equations explaining how they interact.

In the present case there is one constructor, called **pairing**:

$$\frac{\vdash a : A \qquad \vdash b : B}{\vdash (a, b) : A \times B}$$

Read the rule is: if an element $a$ of type $A$ is given, and an element $b$ of type $B$ is given, then an element $(a, b)$ of type $A \times B$ can be constructed.

There are two *destructors*, called **projections*:

$$\frac{\vdash e : A \times B}{\vdash \pi_1(e) : A}
\qquad
\frac{\vdash e : A \times B}{\vdash pi_2(e) : B}
$$

Hopefully by now you know how to read the above rules.
Finally, there are equations which explain how constructors and destructors interact:

\begin{align*}
\pi_1 (a, b) &= a \\
\pi_2 (a, b) &= b \\
(\pi_1(e), \pi_2(e)) &= e
\end{align*}

It turns out that the above formulation of binary products corresponds to the standard category-theoretic notion of binary products (the correspondence can be made technically exact, but we shall not do so here).

### Binary sum

### Dependent products

### Dependent sum

### Natural numbers

### The unit and the empty set

### Universes

### Booleans

## Logic via sets

### Propositions as sub-singletons

#### Truncation

### Disjunction vs. decision

### Abstract and concrete existence


### Equality

## Further resources

A far more complete introduction to type theory can be found in

* Egbert Rijke, [Introduction to homotopy type theory](https://arxiv.org/abs/2212.11082), Chapters 1–4

And if you would like to see how a "real-world" type theory is defined, have a look at:

* Mario Carneiro, [Type theory of Lean](https://ucilnica.fmf.uni-lj.si/mod/url/view.php?id=70491)



