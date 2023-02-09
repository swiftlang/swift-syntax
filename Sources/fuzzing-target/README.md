# `SwiftParser`’s `fuzzing-target`

`fuzzing-target` is an entry point to fuzz `SwiftParser` using `libFuzzer`.

To run it, compile the package using an open source toolchain using

```
/path/to/snapshot.xctoolchain/usr/bin/swift build -Xswiftc -sanitize=fuzzer --product fuzzing-target
```

Then create a directory of Swift files that you would like to use as initial seed inputs for fuzzing and run the fuzzer using

```
.build/debug/fuzzing-target /path/to/seed/inputs
``` 

As the fuzzer finds new interesting inputs, i.e. inputs that cover new code paths, it will store them in the directory you passed.
