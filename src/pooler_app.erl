-module(pooler_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

%% ===================================================================
%% Application callbacks
%% ===================================================================

start(_StartType, _StartArgs) ->
    case pg:start_link() of
        {ok, PGPid} -> {ok, PGPid};
        PGError -> error_logger:error_msg("fails to start PG, error: '~s'", [PGError])
    end,
    case pooler_sup:start_link() of
        {ok, Pid} -> {ok, Pid};
        Error -> 
            error_logger:error_msg("fails to start POOLER_SUP, error: '~s'", [Error]),
            {error, Error}
    end.

stop(_State) ->
    ok.
