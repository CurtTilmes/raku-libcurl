use v6;

use LibCurl::HTTP :subs;

# Just GET content (will return Failure on failure):
say get 'https://httpbin.org/get?foo=42&bar=x';

# GET and decode received data as JSON:
say jget('https://httpbin.org/get?foo=42&bar=x')<args><foo>;

# POST content (query args are OK; pass form as named args)
say post 'https://httpbin.org/post?foo=42&bar=x', :some<form>, :42args;

# And if you need headers, pass them inside a positional Hash:
say post 'https://httpbin.org/post?foo=42&bar=x', %(:Some<Custom-Header>),
    :some<form>, :42args;

# Same POST as above + decode response as JSON
say jpost('https://httpbin.org/post', :some<form-arg>)<form><some>;
