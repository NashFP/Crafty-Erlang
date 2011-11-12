#!/usr/local/bin/escript


main([]) ->
    io:format("Usage: ~s <spooky install dir>~n", [escript:script_name()]);
main([SpookyDir]) ->
    %% Add spooky and its dependencies to the code path.
    true = code:add_path(SpookyDir ++ "/ebin"),
    Deps = filelib:wildcard(SpookyDir ++ "/deps/*/ebin"),
    ok = code:add_paths(Deps),
    %% Add this script's dir to the code path.
    true = code:add_path(filename:dirname(filename:absname(escript:script_name()))),

    %% Compile our modules, just to be safe.
    c:c(bowling_game),
    c:c(bowling_store),
    c:c(bowling_web),

    spooky:start_link(bowling_web),
    io:format("Started spooky~n"),

    io:get_line("Return to exit..."),
    spooky:stop().

