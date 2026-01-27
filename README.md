# funcshional

A bash library that empowers `bash` with functional programming constructs.

## getting started

- best way to use is to integrate this library as a git submodule to your bash
  project:
  - `git submodule add https://github.com/MetaBarj0/funcshional.git [dir]/funcshional`
    where \[dir] is a directory within your repository
- include the library in the bash script of your choice using:
  - `. "[dir]/funcshional/src/funcshional.sh`
    where \[dir] is a directory within your repository where you added the
    `funcshional` repository
- pipe everything you need to get clear and elegant FP construct within your
  fancy bash project

## features

### piping functions

Done thanks to `transform_first` and `transform_last` higher order functions.
The only thing you have to keep in mind is that the function you want to be
piped must output on `stdout`, just like any command you can pipe.

#### Examples

##### Transformers, enter in the pipe world

```bash
hello() {
  echo hello
}

world() {
  echo world
}

hello |
  append ' ' |
  append world |
  append '!' |
  fold_first concat

# it will output the preferred sentence of programmers: hello world!

```

Though this academic example does not shine through its utility, it easily
demonstrates you can chain even simplest functions using the `|` operator as it
your functions were commands.

This is a new tooling you have at hand, your functions can now take inputs as
usual with arguments (`$1`, `$2`, ...) and return computed values by `echo`ing
stuff on the `stdout` when chained with `|` and a `transform`er.

##### Monadic operations, gracefully chain, fail fast and consistently

Monadic operations are at hands with simple but powerful construct:

```bash
monopole_mine() {
  m_start mine_raw_ore |
    m_then filter_first only_gold |
    m_then any |
    m_catch report_and_stop 'no gold ore!' |
    m_then transform_first melt_gold_ore |
    m_then fold_first make_gold_ingots |
    m_then any |
    m_catch report_and_stop 'not enough molten gold for an ingot' |
    m_end sell_gold_ingots
}
```

The `monopole_mine` function is rather clear using these constructs. You mine
ore and eventually, you could sell gold ingots, quite cool right?

Few things:

- start monadic operation block with `m_start` (monad start) and an operation
  that is able to output things
- chain operation on success with `m_then` (monad then) and the next operation
  taking the previous operation result as input
- handle any fail with `m_catch` (monad catch). It allows you to customize the
  behavior in case of failure, even discard any error should you need to do
  that.
- finish the monadic operation block with `m_end` (monad end) the last
  operation (here `sell_gold_ingots`)

You now have the power to write self explanatory code easy to read and
understand.

## how to use

Here is the thing about how to use `funcshional` correctly.

### fundamentals

### reference

==TODO==

## contributing

- sure you can, fork the repo, create a branch, make a PR, you know the drill!
- Oh, do not forget to run and work with the test suite: `make test` is your
  friend here.
- `make watch` is quite cool too to ensure tests are run for any file change
  either in `src` or `test` directories

## TODO list

This is a living section to keep track simply of cool stuff to add or to fix in
`funcshional`

### fixes

### new features

### enhancements / performance
