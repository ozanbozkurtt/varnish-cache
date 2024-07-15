vcl 4.0;

import directors;

backend dummy_backend {
    .host = "127.0.0.1";
    .port = "9090";
}

acl purge {
    "localhost";
}

sub vcl_init {
    new dummy_director = directors.round_robin();
    dummy_director.add_backend(dummy_backend);
}

sub vcl_recv {
    if (req.method == "PURGE") {
        if (client.ip !~ purge) {
            return (synth(405, "Method Not Allowed"));
        }
        return (purge);
    }
    set req.backend_hint = dummy_director.backend();
    return (synth(405, "Method Not Allowed"));
}
