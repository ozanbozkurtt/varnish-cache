vcl 4.0;

backend fake {
        .host = "0:0";
}

sub vcl_recv {
    if (req.method == "GET" && req.http.host == "ozan.com") {
        return (vcl(label-ozan));
    } else if (req.method == "PURGE") {
        return (vcl(label-purge));
    } else if (req.method == "GET" && req.http.host == "bozkurt.com") {
        return (vcl(label-bozkurt));
    } else {
        return (synth(404));
    }
}

