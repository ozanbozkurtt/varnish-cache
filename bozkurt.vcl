vcl 4.0;

backend bozkurt {
    .host = "localhost";
    .port = "8081";
}

sub vcl_recv {
    set req.backend_hint = bozkurt;
    return (hash);
}

sub vcl_backend_response {
    set beresp.ttl = 1d;
}

sub vcl_deliver {
    if (obj.hits > 0) {
        set resp.http.X-Cache = "HIT";
    } else {
        set resp.http.X-Cache = "MISS";
    }
}

