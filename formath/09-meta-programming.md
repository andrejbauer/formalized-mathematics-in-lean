# Meta-programming

The phrase **meta-programming* refers to programming that controls the syntax or the behavior of the programming language itself, rather than the code that will eventually be run. Meta-programming facilities allow us to define new syntax, macros, tactics, and commands. In this lecture we shall put on our programming language hats and look at some introductory examples. They are taken from the book [Meta-programming in Lean 4](https://leanprover-community.github.io/lean4-metaprogramming-book/), which is also
the recommended reading material for this week.

Before we look at specific examples, we should understand the idea of **elaboration**. It is the part of Lean which converts the syntax written by the user into expression trees that the rest of the Lean compiler can work on. It's an elaborate piece of machinery that can be found in the [`Lean.Elab`](https://github.com/leanprover/lean4/tree/master/src/Lean/Elab) namespace. The elaborator has several phases, for instance for converting top-level commands and for terms. User code that extends or modifies the elaborator is called **meta-level** code.

In this lecture we shall look at some examples involving custom syntax, taken from the above book. The rest of the lecture will be devoted to discussion of class projects.

## Reading material

The book [Meta-programming in Lean 4](https://leanprover-community.github.io/lean4-metaprogramming-book/) will give you as much background as
one can get without asking questions on the [Lean Zulip](https://leanprover.zulipchat.com/). We recommend that you read:

* [Introduction](https://leanprover-community.github.io/lean4-metaprogramming-book/main/01_intro.html) -- it eplains what meta-programming is and what sort of meta-programming facilities are available in Lean 4
* [Syntax](https://leanprover-community.github.io/lean4-metaprogramming-book/main/05_syntax.html) -- for many, the first contact with meta-programming happens when they define custom mathematical notation
* [Tactics](https://leanprover-community.github.io/lean4-metaprogramming-book/main/09_tactics.html) -- one you are sufficiently familiar with Lean, you will start seeing opportunities for implementing custom tactics

0f c0ur53, 7ru3 h4ck3r5 w1ll r34d 7h3 wh0l3 b00k.