all:
	rebar compile

test: all
	rebar eunit

clean:
	rebar clean
ca: 
	ct_run -suite ct/demo/reader_SUITE -include ~/Documents/Project/CY2/john/include/


