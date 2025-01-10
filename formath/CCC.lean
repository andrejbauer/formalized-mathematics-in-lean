import Mathlib.CategoryTheory.Closed.Cartesian

/-! We demonstrate how to use Lean's syntactic cappabilites to implement the internal
    language of a cartesian closed category.
-/

open CategoryTheory
open MonoidalCategory

section InternalLangage
  open Lean

  /- We first define the custom syntax. We shall use the following syntactic categories:
    * `entry` for an entries in the typing contexts
    * `context` for typing contexts
    * `cccterm` for the terms of the internal language, called λ-terms
  -/

  /-- A context entry -/
  declare_syntax_cat entry
  syntax ident ":" term : entry

  /-- A context takes the form `x₁ : X₁, …, xₙ : Xₙ` where `xᵢ` are identifiers and `Xᵢ` objects of a category. -/
  declare_syntax_cat context
  syntax entry,* : context

  /-- The syntax of λ-terms -/
  declare_syntax_cat cccterm

  /-- a variable is a term -/
  syntax ident : cccterm

  /-- the unique (generalized) element of the terminal object -/
  syntax "tt" : cccterm

  /-- ordered pair -/
  syntax "⟨" cccterm "," cccterm "⟩" : cccterm

  /-- first projection -/
  syntax "fst" cccterm : cccterm

  /-- second projection -/
  syntax "snd" cccterm : cccterm

  /-- λ-abstraction -/
  syntax "λ " ident " : " term ", " cccterm : cccterm

  /-- Parentheses -/
  syntax "(" cccterm ")" : cccterm

  /-- morphism application -/
  syntax "$(" term ")" cccterm : cccterm

  /-- a λ-term in a context -/
  syntax context "⊢" cccterm : term

  /-- Convert a context `x₁ : X₁, …, xₙ : Xₙ` to the term `X₁ ⊗ ⋯ ⊗ Xₙ`,
      making sure that the empty context is the terminal object `𝟙_ _` and
      that `x : X` is just `X`, rather than `X ⊗ 𝟙_ 𝒞`.
  -/
  partial def prodify : TSyntax `context → MacroM Term
  | `(context| ) => `(𝟙_ _)
  | `(context| $_:ident : $A:term) => `($A)
  | `(context| $_:ident : $A:term, $Γ:entry,*) =>
    do
      let Γ ← `(context| $Γ:entry,*)
      let As ← prodify Γ
      `($A ⊗ $As)
  | _ => Macro.throwError "invalid context syntax"

  /-- Given an identifier `x` and a context `Γ`, compute the projection from `Γ` determined by `x`. -/
  partial def project (x : Name) : TSyntax `context → MacroM Term
  | `(context| ) => Macro.throwError s!"unkown identifier {x}"
  | `(context| $y:ident : $A:term) =>
      -- the only thing that can be projected is `x` by the identity morphism
      if x = y.getId then `(𝟙 $A) else Macro.throwError s!"unkown identifier {x}"
  | `(context| $y:ident : $A:term, $Γ:entry,*) =>
    if x = y.getId then
      `(ChosenFiniteProducts.fst $A _)
    else do
      let Γ ← `(context| $Γ:entry,*)
      let p ← project x Γ
      `(ChosenFiniteProducts.snd $A _ ≫ $p)
  | _ => Macro.throwError "invalid context syntax"

  /-- Conversion of the internal syntax to a (term representing) morphism -/
  macro_rules
  | `($Γ:context ⊢ $x:ident) => project x.getId Γ
  | `($Γ:context ⊢ tt) =>
    /- We could skip using `prodify` here and just return `(ChosenFiniteProducts.toUnit _)`, but the
       result is a bit too polymorphic, as `⊢ tt` would denote *any* morphihm `toUnit X`. -/
    do { let A ← prodify Γ ; `(ChosenFiniteProducts.toUnit $A) }
  | `($Γ:context ⊢ ⟨ $a:cccterm, $b:cccterm ⟩) => `(ChosenFiniteProducts.lift ($Γ:context ⊢ $a) ($Γ:context ⊢ $b))
  | `($Γ:context ⊢ fst $a:cccterm) => `(($Γ:context ⊢ $a) ≫ ChosenFiniteProducts.fst _ _)
  | `($Γ:context ⊢ snd $a:cccterm) => `(($Γ:context ⊢ $a) ≫ ChosenFiniteProducts.snd _ _)
  | `($Γ:entry,* ⊢ λ $x:ident : $A:term , $a:cccterm) => `(CartesianClosed.curry ($x:ident : $A:term, $Γ:entry,* ⊢ $a))
  | `($Γ:context ⊢ $($f:term) $a:cccterm) => `(($Γ:context ⊢ $a) ≫ $f)
  | `($Γ:context ⊢ ($a:cccterm)) => `($Γ:context ⊢ $a)

end InternalLangage

section Examples

  /- We work over a a category with (chosen) finite products. -/
  universe u v
  variable {𝒞 : Type u} [Category.{v, u} 𝒞] [fp : ChosenFiniteProducts 𝒞] [ccc : CartesianClosed 𝒞]

  open ChosenFiniteProducts

  /-- the identity map -/
  example {X : 𝒞} : X ⟶ X := x : X ⊢ x

  /-- the twist morphism -/
  example {X Y : 𝒞} : X ⊗ Y ⟶ Y ⊗ X :=
    x : X, y : Y ⊢ ⟨ y, x ⟩

  /-- the diagonal -/
  example {X : 𝒞} : X ⟶ X ⊗ X :=
  x : X ⊢ ⟨ x, x ⟩

  /-- the constant map -/
  example {X Y : 𝒞} : X ⟶ (Y ⟹ X) := x : X ⊢ λ y : Y, x

  /-- the first projection is the first projection -/
  example {X Y : 𝒞} : (p : X ⊗ Y ⊢ fst p) = (p : X ⊗ Y ⊢ $(fp.fst X Y) p) := by simp

  /-- A silly example showing that we can embed the internal language inside `$(⋯)`. Please don't do this. -/
  example {X : 𝒞} : X ⟶ X := x : X ⊢ $(y : X ⊢ y) x

  /-- identity on the terminal -/
  example : 𝟙_ 𝒞 ⟶ 𝟙_ 𝒞 := ⊢ tt

  /-- composition of morphisms -/
  example {X Y Z: 𝒞} (g : Y ⟶ Z) (f : X ⟶ Y): X ⟶ Z :=
    x : X ⊢ $(g) $(f) x

  /-- right associator -/
  def assocRight (X Y Z : 𝒞) : (X ⊗ Y) ⊗ Z ⟶ X ⊗ (Y ⊗ Z) :=
  p : (X ⊗ Y) ⊗ Z ⊢ ⟨fst (fst p), ⟨snd (fst p), snd p⟩⟩

  /-- left associator -/
  def assocLeft (X Y Z : 𝒞) : X ⊗ (Y ⊗ Z) ⟶ (X ⊗ Y) ⊗ Z :=
  p : X ⊗ (Y ⊗ Z) ⊢ ⟨⟨fst p, fst (snd p)⟩, snd (snd p)⟩

  /-- the associators are inverses -/
  example {X Y Z : 𝒞} : assocLeft X Y Z ≫ assocRight X Y Z = 𝟙 _ := by
   simp [assocLeft, assocRight]
   aesop_cat

end Examples
