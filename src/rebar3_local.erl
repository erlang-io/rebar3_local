-module(rebar3_local).

-export([init/1]).

-spec init(rebar_state:t()) -> {ok, rebar_state:t()}.
init(State) ->
     {ok, rebar_state:add_resource(State, {local, rebar3_local_resource})}.
