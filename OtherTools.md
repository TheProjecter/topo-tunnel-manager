# Comparison to Meerkat #

http://codesorcery.net/meerkat

Meerkat is [no longer maintained](http://codesorcery.net/2012/09/06/sunset).

Meerkat has a more polished interface, Bonjour integration, and can start a tunnel when a specific associated applications runs.

In Meerkat, each menu item is associated with a single forwarded port. In Topo, each menu item can be associated with multiple forwarded ports.

In Meerkat, the forwarded ports are defined in Meerkat but typically used in ~/.ssh/config. In Topo, they are both defined and used in ~/.ssh/config. Thus, one has to balance the friendly interface of Meerkat with the disconnect between definition and use.

Topo has a command-line

# Comparison to Mole #

https://github.com/calmh/mole#readme

Topo is less capable, but also less complicated.

Topo has a script interface, although it would probably be possible to wrap Mole in something similar.