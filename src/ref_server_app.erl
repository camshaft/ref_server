-module(ref_server_app).

-behaviour(application).

%% API.
-export([start/2]).
-export([stop/1]).

%% API.

start(_, _) ->
  ref_server_sup:start_link().

stop(_) ->
  ok.
