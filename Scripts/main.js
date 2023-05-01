var langserver = null;

exports.activate = function() {
    // Do work when the extension is activated
    langserver = new OCamlLanguageServer();
}

exports.deactivate = function() {
    // Clean up state before the extension is deactivated
    if (langserver) {
        langserver.deactivate();
        langserver = null;
    }
}


class OCamlLanguageServer {
    constructor() {
        // Observe the configuration setting for the server’s location, and restart the server on change
        // nova.config.observe("novalatex.path-server", function(path) {
        //     this.start(path);
        // }, this);
        console.log("Starting OCaml Language Server...");
        this.start();
    }

    deactivate() {
        this.stop();
    }

    start(path) {
        if (this.languageClient) {
            this.languageClient.stop();
            nova.subscriptions.remove(this.languageClient);
        }

        // Create the client
        var serverOptions = {
            path: "/usr/bin/env",
            args: [
                path?.trim() || "ocamllsp"
            ]
        };
        var clientOptions = {
            // The set of document syntaxes for which the server is valid
            syntaxes: ["ocaml"]
        };
        var client = new LanguageClient("ocaml.server", "OCaml Language Server", serverOptions, clientOptions);

        try {
            // Start the client
            client.start();

            // Add the client to the subscriptions to be cleaned up
            nova.subscriptions.add(client);
            this.languageClient = client;
        }
        catch (err) {
            // If the .start() method throws, it’s likely because the path to the language server is invalid
            if (nova.inDevMode()) {
                console.error(err);
            }
        }
    }

    stop() {
        if (this.languageClient) {
            this.languageClient.stop();
            nova.subscriptions.remove(this.languageClient);
            this.languageClient = null;
        }
    }
}
