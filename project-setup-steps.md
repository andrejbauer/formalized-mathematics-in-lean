# How to set up a project

A record of the steps taken to set up a project.

I am working on Mac OS, but essentially the same steps should work on Linux and Windows.

## Prerequisites

We are assuming you have:

1. Python, including Python's `pip` package manager.
2. `git` with basic working knowledge of it, and a [GitHub](https://github.com) account.
2. Visual Studio Code, or an alternative that supports Lean and LaTeX.
3. Lean 4 and in particular the `lake` utility.

If you are using MacOS I highly recommend the [Homebrew](https://brew.sh) package manager. The instructions below use it through the `brew` command.

## Steps to set up a project

Here are the steps taken to set up my own project in which I will
formalize partial combinatory algebras.

### Install `pygraphviz`

In case of complications, refer to the [official installation instructions](https://pygraphviz.github.io/documentation/stable/install.html) for `pygraphviz`.

#### MacOS

    brew install graphviz
    pip install pygraphviz

#### Linux

    sudo apt-get install graphviz graphviz-dev
    pip install pygraphviz

#### Windows

See [these instructions](https://pygraphviz.github.io/documentation/stable/install.html#windows).


### Install [`leanblueprint`](https://github.com/PatrickMassot/leanblueprint):

#### All systems

    pip install leanblueprint

Test the installation by running 

    leanblueprint --version


The version reported should be 0.0.15 or newer. If you have an older version, you might have to run
`pip install leanblueprint -U`.

### Create a Lean project

In the following instructions, replace `partial-combinatory-algebras` with the name of your project. Note that you will
use this name both for the folder and the GitHub project. (Hint: do not call it "project" or "formal math", do not use
spaces.)

Create a new Lean+mathlib project and change working directory into it:

    lake new partial-combinatory-algebras math.lean

(A folder `partial-combinatory-algebras` is created. All project files referred to can be found in this folder.)
Download a precompiled version of mathlib:

    cd partial-combinatory-algebras
    lake exe cache get

Edit the file `lakefile.lean` and set `autoImplicit` to false in the `leanOptions`. Mine looks like this (note the comma
in the `pp.unicode.fun` line):

    -- Settings applied to both builds and interactive editing
    leanOptions := #[
      ⟨`pp.unicode.fun, true⟩, -- pretty-prints `fun a ↦ b`
      ⟨`autoImplicit, false⟩
    ]

Test the project setup by building it:

    lake build

### Create a GitHub project

Create [a new GitHub project](https://github.com/new):

* use the same name as your folder name (not strictly necessary but it avoids confusion)
* the description should read something like "A Lean 4 formalization of partial combinatory algebras"
* make the project *public*
* make sure that you create an empty project without any commits:
  * do **not** add a README file (create an empty project without any commits)
  * do **not** add a `.gitignore` file
  * do **not** choose a license

Assuming you correctly set up an empty repository (if not, you will have to learn how to merge unrelated git histories,
or how to force-push), you should see instructions on “Quick setup”. Follow the “... or push an existing repository from command line”.

From the command line, in the `partial-combinatory-algebras` folder on your computer (my project link is `git@github.com:andrejbauer/partial-combinatory-algebras.git`, yours should be in the Quick setup instructions):

    git remote add origin ⟨your-project-link-here⟩
    git branch -M main

Make your first commit:

    git add --all
    git commit -m "Initial commit"

If all went well, you committed the following files:

    [main (root-commit) fd5a61e] Initial commit
     6 files changed, 118 insertions(+)
     create mode 100644 .gitignore
     create mode 100644 PartialCombinatoryAlgebras.lean
     create mode 100644 PartialCombinatoryAlgebras/Basic.lean
     create mode 100644 lake-manifest.json
     create mode 100644 lakefile.lean
     create mode 100644 lean-toolchain

If you committed a gazillion files, something went wrong and `git add --all` misfired.

Push to GitHub:

    git push -u origin main

Refresh your GitHub project page. You should see the Lean files that you have just pushed.


### Set up a project blueprint

The project blueprint will help you plan your project and monitor progress. It is a LaTeX document with “ordinary math” that lists definitions, theorems and (outlines of) proofs that need to be formalized, with links to Lean 4 code. The HTML and PDF versions of the blueprint, as well as a graph showing dependencies and formalization progress, are published online.

#### Activate GitHub pages

First, you need to activate GitHub pages. On your GitHub project page, do the following:

* Go to Settings → Pages
* Under “Build and deployment → Source” select “GitHub Actions”

#### Create a blueprint

On your computer in the project folder, run

    leanblueprint new

You will be asked a number of questions:

* Project title: something like “Partial combinatory algebras”
* Author: your full name
* Accept all defaults and answer “yes” to all suggestions about setting up documentation, pages, and continuous integration.
* Allow it to commit to the git repository.

If successful, it should tell you “You are all set 🎉”.

You will write your blueprint in `blueprint/src/content.tex`. For now, just add a test messages to see if things are working, and run

    leanblueprint all

A number of files are generated. Add them to your repository and commit. We recommend that you use VSCode to do so, but
if you prefer the command line, it goes somewhat like this:

    git add --all
    git commit -m "Create blueprint"

Now push to your repository:

    git push

The generated PDF version of the blueprint is in [`blueprint/print.pdf`](./blueprint/print.pdf).

The generated HTML version is available locally if you run

    leanblueprint serve

and visit http://localhost:8000 (`leanblueprint` suggests visiting `http://0.0.0.0:8000/` but that does seem to work on MacOS).


#### Online pages

About 10 minutes after you push files, the blueprint and documentation ought to be generated and available online. You may
follow progress under the “Actions” tab of your GitHub repository. When the job is done, you may visit your project web
page by going to “Settings → Pages” and clicking the “Visit site” button. The URL with the pages should be something
like [`https://andrejbauer.github.io/partial-combinatory-algebras/`](https://andrejbauer.github.io/partial-combinatory-algebras/).

##### What is going on?

(It is also safe to ignore this section and just hope that all happens automagically.)

The online documentation is created through [GitHub Actions](https://docs.github.com/en/actions). These are scripts that run on GitHub servers when you push files, or trigger them manually. The `leanblueprint` program sets up an action `.github/workflows/blueprint.yml` that compiles the blueprint and deploys it to the web pages. When you open this file in VSCode, it will suggest installing a GitHub Actions extension. If you do so, you will see a new icon on the left-hand side of the VSCode window (two squares connected by an L-shaped line). This is where you can inspect, run and generally control the actions. Other possible actions involve compiling your Lean files every time you push to make sure there are no errors.

### Choose a license and create the `README.md` file

As a last step of the configuration, you should set up `LICENSE.md` and `README.md` file for your project:

* Follow [these instructions](https://docs.github.com/en/communities/setting-up-your-project-for-healthy-contributions/adding-a-license-to-a-repository) to add a license to your repository. We encourage you to choose an open source license, such as the MIT license.

* Add a `README.md` file describing your project. It should contain a short description of the project, your name, and links to the web pages with the documentation and the blueprint.


## Working on the project

It is really up to you to organize work the way you like it. Experience shows that it is best to split your project into smaller parts, each of which achievable in reasonable time.

Your initial blueprint should list the overall goals, the parts of the project (perhaps organized as sections), and external references as appropriate. The initial blueprint should suffice to get your started and to keep you on track. It need not be very detailed, as it is unlikely that you are able to precisely predict the structure of your formalization. You can oscillate between formalized code and the blueprint as you make progress.

For your own sake, and to make your code usable by others, you should put plentiful documentation.


