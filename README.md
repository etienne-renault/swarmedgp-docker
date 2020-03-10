# Description

This repository contains all instructions required to build the docker
containing all tools and models required to replay the whole benchmark
of the paper entitled: "Improving Swarming Using Genetic Algorithms".

It contains:
     - a forked version of Spot 2.3
     - Divine 2.4 first patched by LTSmin Team, then by us for the
       purpose of this paper
     - The LTSmin tool and Sylvan library
     - a directory models, that contains all models used for
       experiments

# How to replay build this docker ?

Simply run the following commands:
```
make build-image
make run-image
```

Note that under MacOS the root privileges are not required for sunning
the first command.