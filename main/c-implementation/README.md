# Verilog Output Simulation (C implementation)

A [c-implementation](../../main/c-implementation) was added as well to simulate 1,000 bitstreams that will be output by both the `Generator.v` and the `XORShifter.v` modules.
To run it:
1. Inside the [c-implementation](../../main/c-implementation) folder
2. Run
```bash
$ make clean
$ make
$ ./generator
```
This will output two files: `test.txt` and `test02.txt`, with the outputs of `Generator.v` and the `XORShifter.v`, respectively.

![Run example](https://raw.githubusercontent.com/pontazaricardo/pseudo-random-number-generator_verilog/main/gifs/c-implementation_gif/c-implementation.gif)

If you want to generate more than 1,000 bitstreams, in the `generator.c` file, modify the limit in the cycle:

```c
int main() {
    ...
    for(int i=0;i<1000;i++){ // <=== Change here
        ...
    }
    ...
}
```
