%%----------------
%% search algorithm
%%----------------
-module(aima_search).
-compile([{parse_transform, lager_transform}]).

-include("aima.hrl").

%%----------------
%% 
%%----------------
breadth_first_search(Problem = #'aima.problem'{init = Init,
                                              actions = Action,
                                              goal_test = Goal_test,
                                              path_cost = Path
                                              })->
    ok.
