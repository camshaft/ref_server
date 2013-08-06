%% @private
-module(ref_server_sup).
-behaviour(supervisor).

%% API
-export([start_link/0]).

%% supervisor.
-export([init/1]).

-define(SUPERVISOR, ?MODULE).

%% API.

-spec start_link() -> {ok, pid()}.
start_link() ->
  supervisor:start_link({local, ?SUPERVISOR}, ?MODULE, []).

%% supervisor.

init([]) ->
  ref_server = ets:new(ref_server, [
    {read_concurrency, true}, set, public, named_table]),

  Procs = [
    {ref_server, {ref_server, start_link, []},
      permanent, 5000, worker, [ref_server]}
  ],

  {ok, {{one_for_one, 10, 10}, Procs}}.
