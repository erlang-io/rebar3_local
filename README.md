rebar3_local
=====

A rebar plugin

Build
-----

    $ rebar3 compile

Use
---

Add the plugin to your rebar config:

    {plugins, [
        { rebar3_local, ".*", {git, "git@host:user/rebar3_local.git", {tag, "0.1.0"}}}
    ]}.

Then just call your plugin directly in an existing application:


    $ rebar3 rebar3_local
    ===> Fetching rebar3_local
    ===> Compiling rebar3_local
    <Plugin Output>
