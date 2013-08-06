-module(ref_server_test).

-include_lib ("eunit/include/eunit.hrl").

basic_test() ->
  application:start(ref_server),

  App = ref_server,
  Ref = ?MODULE,
  Property = basic_test,
  Value = <<"hello world">>,

  ?assertEqual(undefined, ref_server:get(App, Ref, Property)),

  ?assertEqual(ok, ref_server:set(App, Ref, Property, <<"hello world">>)),

  ?assertEqual({ok, Value}, ref_server:get(App, Ref, Property)).
