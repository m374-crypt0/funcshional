# funcshional

A bash library that empowers `bash` with functional programming constructs.

## getting started

- best way to use is to integrate this library as a git submodule to your bash
  project:
  - `git submodule add https://github.com/MetaBarj0/funcshional.git [dir]/funcshional`
    where \[dir] is a directory within your repository
  - define and expose globally the `FUNCSHIONAL_ROOT_DIR` variable to the
    `[dir]/funcshional` value to allow you to use (include) the `funcshional`
    library anywhere from the file system.
- include the library in the bash script of your choice using:
  - `. "${FUNCSHIONAL_ROOT_DIR}/src/funcshional.sh`
- pipe everything you need to get clear and elegant FP construct within your
  fancy bash project

## features

### piping functions

You can now pipe your functions togegther (just like if they were commands).
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
  lift mine_raw_ore |
    and_then filter_first only_gold |
    and_then any |
    or_else report_and_stop 'no gold ore!' |
    and_then transform_first melt_gold_ore 1 cart |
    and_then fold_first make_gold_ingots 1 kg |
    and_then any |
    or_else report_and_stop 'not enough molten gold for an ingot' |
    and_then sell_gold_ingots |
    unlift
}
```

The `monopole_mine` function is rather clear using these constructs. You mine
ore and eventually, you could sell gold ingots, quite cool right?

Few things:

- start monadic operation block with `lift` and an operation that is able to
  output things. Lifting consists in somehow `encapsulate` a computation into a
  monadic context
- chain operation on success with `and_then` and the next operation taking the
  previous operation result as input. It works only for a previously lifted
  value
- handle any fail with `or_else`. It allows you to customize the behavior in
  case of failure, even discard any error should you need to do that (for
  instance, by providing a default value).
- finish the monadic operation block with `unlift` . It somehow `decapsulate`
  all the executed computations to get the final value obtained after the
  monadic chain execution.

You now have the power to write self explanatory code easy to read and
understand.

## how to use

Here is the thing about how to use `funcshional` correctly.

### fundamentals

#### Higher Order Functions (HOF)

`funcshional` provides a bunch of higher order functions (functions taking
other function as parameter).
It means you have to reason about functions as first class citizen, not only
values.
For example `filter_first`, `fold_first` and `transform_first` are all HOF
taking a function as first argument.

##### first and last prefixes in HOF

You may have seen that all HOF are suffixed by either `_first` or `_last`.
The difference holds in the order the function's argument processing.
For instance, imagine you want to transform a string by prefixing it.
Such a transformer could be defined as:

```bash
prefix_with() {
  local stream_line="$1"
  local prefix="$2"

  echo "$prefix$stream_line"
}
```

The order of function argument is perfect for `transform_first` because the
first argument is the `stream` line that is about to be transformed.

Should you want to use a similar transformer with `transform_last`, define it
this way:

```bash
prefix_with() {
  local prefix="$1"
  local stream_line="$2"

  echo "$prefix$stream_line"
}
```

Here, the `stream` line is the last argument in the transformer.

In `funcshional`, all higher order functions have a `_first` and a `_last`
variant for maximum flexibility.

#### Stream

`funcshional` use the `stream` as data source.
Put it simply, a `stream` is just a list of strings separated by the new-line
character `\n`. Thus, each string or `line` is a stream element.

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
