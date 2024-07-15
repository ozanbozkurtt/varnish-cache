vcl 4.0;

backend ozan {
	.host = "localhost";
	.port = "8080";
}

sub vcl_recv {
	set req.backend_hint = ozan;
        return (hash);
}

sub vcl_backend_response {
	set beresp.ttl = 1h;
}

sub vcl_deliver {
    if (obj.hits > 0) {
        set resp.http.X-Cache = "HIT";
    } else {
        set resp.http.X-Cache = "MISS";
    }
}

