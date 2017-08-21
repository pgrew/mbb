# PSVM in Chapel

Chapel port of [Parallel SVM (PSVM)](https://code.google.com/archive/p/psvm/).

Implementation described in more detail [here](http://www.csee.ogi.edu/~zak/cs506-pslc/parallelSVM1.pdf).

## Prerequisites

- [Chapel](https://github.com/chapel-lang/chapel)
- A dataset (see `../../datasets/README.md`)

## Build

```bash
make SvmTrain
make SvmPredict
```

## Train

```bash
./SvmTrain --dataFile=../../datasets/splice.t
```

## Predict

```bash
./SvmPredict --dataFile=../../datasets/splice
```
