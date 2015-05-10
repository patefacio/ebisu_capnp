# Ebisu Capnp

[![Build Status](https://drone.io/github.com/patefacio/ebisu_capnp/status.png)](https://drone.io/github.com/patefacio/ebisu_capnp/latest)


# Purpose

*Early in Development*

Eventually the goal is to model *interfaces*, *structs*, *enums*, etc
using Dart to drive the *meta-model*. So, there will be a Dart
*meta-model* exposing the features of CapnPro's IDL. Then instances of
this Dart *meta-model* can be used to:

- generate the capnp IDL
- invoke capnp to generate support files
- generate higher level code making use of that generated source

