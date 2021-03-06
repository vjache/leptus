%% The MIT License
%%
%% Copyright (c) 2013-2014 Sina Samavati <sina.samv@gmail.com>
%%
%% Permission is hereby granted, free of charge, to any person obtaining a copy
%% of this software and associated documentation files (the "Software"), to deal
%% in the Software without restriction, including without limitation the rights
%% to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
%% copies of the Software, and to permit persons to whom the Software is
%% furnished to do so, subject to the following conditions:
%%
%% The above copyright notice and this permission notice shall be included in
%% all copies or substantial portions of the Software.
%%
%% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
%% IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
%% FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
%% AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
%% LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
%% OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
%% THE SOFTWARE.

-module(leptus_http1).

%% leptus callbacks
-export([routes/0]).
-export([allowed_methods/1]).
-export([init/3]).
-export([get/3]).
-export([terminate/4]).

routes() ->
    ["/", "/hello", "/hello/:name"].

allowed_methods("/") -> [<<"GET">>];
allowed_methods("/hello") -> [<<"GET">>];
allowed_methods("/hello/:name") -> [<<"GET">>].

init(_Route, _Req, State) ->
    {ok, State}.

get("/", _Req, State) ->
    {"index", State};
get("/hello", _Req, State) ->
    {200, <<"hello, world!">>, State};
get("/hello/:name", Req, State) ->
    Name = leptus_req:param(Req, name),
    {200, "hello, " ++ Name, State}.

terminate(_Reason, _Route, _Req, _State) ->
    ok.
