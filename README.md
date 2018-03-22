## Client

#### Install Elm

1. Download and install Node.js.
2. Download elm: `npm i -g elm`

#### Start the server

From the project root, change to the `client` directory.

    make serve

## Server

#### Install Go
1. Download Go from [the official site].
2. Set `$GOROOT` to the installation path.
3. If the installation path isn't in `$PATH`, add it.
4. Choose your workspace.  If it is different from `$HOME/go`, set `$GOPATH` to it (see [GOPATH instructions]).

If you're experiencing problems, consult the [installation instructions].

#### Install Goa

    go get -u github.com/goadesign/goa/...

#### Install the demo

    go get github.com/btoll/elm-remotepager-demo

#### Start the server

From the project root, change to the `server` directory.

    make serve

## License

[the official site]: https://golang.org/dl/
[GOPATH instructions]: https://github.com/golang/go/wiki/SettingGOPATH
[installation instructions]: https://golang.org/doc/install
[GPLv3](COPYING)

