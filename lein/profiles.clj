{:user {:plugins [[cider/cider-nrepl "0.22.4"]
                  [jonase/eastwood "0.3.5"]]
        :dependencies [[lein-cljfmt "0.6.4"]
                       [jonase/eastwood "0.3.5" :exclusions [org.clojure/clojure]]]
        :repl-options {:init (require 'cljfmt.core)}}}

