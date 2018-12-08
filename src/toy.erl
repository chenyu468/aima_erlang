-module(toy).
-compile([{parse_transform, lager_transform}]).

-export([init/1,next_steps/1,goal_test/1]).

-include("aima.hrl").
%%---------------
%% 玩具空间的状态
%% 每个元素：boolean类型，表示是否有垃圾,true有垃圾，false没有垃圾
%%---------------
-record('aima.toy.space',{block_list, %% block的空间
                          current_location %% 当前位置
                         }).

%%---------------
%% 可能采取的行动
%%---------------
-define(C_AIMA_TOY_ACTION_LEFT,left).
-define(C_AIMA_TOY_ACTION_RIGHT,right).
-define(C_AIMA_TOY_ACTION_SUCK,suck).



%%---------------
%% public api
%%---------------
init(List)->
    ok = check_state(List),
    #'aima.toy.space'{block_list = List}.

%%--------------
%% 可以使用的行为
%% 1、left
%% 2、right
%% 3、suck
%%--------------
next_steps(State = #'aima.toy.space'{block_list = Block_list,
                             current_location = Current_location
                            })->
    Left_step = case Current_location == 0 of
                    true->
                        undefined;
                    false ->
                        {?C_AIMA_TOY_ACTION_LEFT,State#'aima.toy.space'{current_location = Current_location - 1}}
                end,
    Right_step =case Current_location == length(Block_list) -1  of
                    true ->
                        undefined;
                    false ->
                        {?C_AIMA_TOY_ACTION_RIGHT,State#'aima.toy.space'{current_location = Current_location + 1}}
                end,    
    Black_list_new = lists:keyplace(Current_location,{Current_location,false}),
    Suck_step = State#'aima.toy.space'{block_list = Black_list_new},
    love_misc:filter_undefined([Left_step,Right_step,Suck_step]).

goal_test(State = #'aima.toy.space'{block_list = Block_list})->
    lists:any(fun({_,Is_dusty})->
                      Is_dusty
                          end,Block_list).

             
%%---------------
%% private api
%%---------------
check_state(List)->
    lists:map(fun(X) when is_boolean(X) ->
                      ok;
                 (_) ->
                      throw(?MSG_AIMA_TOY_STATE_ERROR)
              end,List).
