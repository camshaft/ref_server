ref_server
==========

Simple gen_sever for saving reference configurations inspired by [ranch's](https://github.com/extend/ranch) [ranch_server](https://github.com/extend/ranch/blob/master/src/ranch_server.erl). This makes it really easy to build embedded OTP applications where there is a single ets table managing configuration for all of the embedded instances.

Usage
=====

```erlang
ok = application:start(ref_server),
ok = ref_server:set(my_app, my_ref, my_prop, value_123),
value123 = ref_server:get(my_app, my_ref, my_prop).
```

Tests
=====

```sh
$ make test
```
