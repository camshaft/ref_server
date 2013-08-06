-module(ref_server).
-behaviour(gen_server).

%% API.
-export([start_link/0]).
-export([get/3]).
-export([set/4]).

%% gen_server.
-export([init/1]).
-export([handle_call/3]).
-export([handle_cast/2]).
-export([handle_info/2]).
-export([terminate/2]).
-export([code_change/3]).

-define(TAB, ?MODULE).

-type app() :: atom().
-type ref() :: atom().

%% API.

%% @doc Start the syslog_pipeline_server gen_server.
-spec start_link() -> {ok, pid()}.
start_link() ->
  gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

%% @doc get the property for the app/ref pair
-spec get(app(), ref(), term()) -> term().
get(App, Ref, Property) ->
  case catch ets:lookup_element(?TAB, {Property, Ref, App}, 2) of
    {'EXIT', {badarg, _}} ->
      undefined;
    Value ->
      {ok, Value}
  end.

%% @doc set the property for the app/ref pair
-spec set(app(), ref(), term(), term()) -> term().
set(App, Ref, Property, Value) ->
  gen_server:call(?MODULE, {set, App, Ref, Property, Value}).

%% gen_server.

%% @private
init([]) ->
  {ok, undefined}.

%% @private
handle_call({set, App, Ref, Property, Value}, _, State) ->
  true = ets:insert(?TAB, {{Property, Ref, App}, Value}),
  {reply, ok, State};
handle_call(_Request, _From, State) ->
  {reply, ignore, State}.

%% @private
handle_cast(_Request, State) ->
  {noreply, State}.

%% @private
handle_info(_Info, State) ->
  {noreply, State}.

%% @private
terminate(_Reason, _State) ->
  ok.

%% @private
code_change(_OldVsn, State, _Extra) ->
  {ok, State}.
