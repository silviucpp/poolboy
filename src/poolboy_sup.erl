%% Poolboy - A hunky Erlang worker pool factory

-module(poolboy_sup).
-behaviour(supervisor).

-export([start_link/3, init/1]).

start_link(Mod, ShutdownWait, Args) ->
    supervisor:start_link(?MODULE, {Mod, ShutdownWait, Args}).

init({Mod, ShutdownWait, Args}) ->
    {ok, {{simple_one_for_one, 0, 1},
          [{Mod, {Mod, start_link, [Args]},
            temporary, ShutdownWait, worker, [Mod]}]}}.
