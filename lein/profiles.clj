{:user {:plugins [[cider/cider-nrepl "0.21.1"]
                  [jonase/eastwood "0.3.5"]]
        :dependencies [[cljfmt "0.5.1"]
                       [jonase/eastwood "0.3.5" :exclusions [org.clojure/clojure]]]
        :repl-options {:init (require 'cljfmt.core)}}}

