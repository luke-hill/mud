2) Bugfix, only let people equip weapons/armors that they own
3) Bugfix, if someone doesn't own a weapon/armor, say they can't equip that weapon/armor
4) v0.1 of adventures of avaLancHe ended when you killed the Orc. Lets try re-achieve this (We never did)
5) Re-check specs again and add missing specs
6) Add movement logic which requires a key to go in a certain direction (And will use the key up during this)
7) Begin to remove the remaining items from shit_to_sort_out folder
8) Do we need an `attr_writer` for gold for enemies? Do we ever need to reduce gold? (Maybe if we have a thief?)
9) Get yard documentation rate up to 80%
10) Consume the `use_message` property on Barracks Key (`v2.1`)
11) Get yard documentation rate up to 85%
12) Quest idea that `They are known for their metallurgy` be applied to the Sylvanian Ingots?
13) move missing barracks key into some form of data lookup
14) Add integration tests (Not sure if we can we feature test this using cucumber?)
15) Work out for v3 who would or should drop endurance potion (It also could be crafted?)
16) When items have been dropped. Auto-add them to players inventory if available
17) Have rspec seed a "test" dummy set of data files. These can be then "trusted" in the terms of
unit/feature tests
18) Add items to have different costs in different locations
19) Completely rework Buy class and remove all comments about stuff that is hard-coded!
20) Add the first 2-4 places on the map where up and down exist
21) Add a second usable key to the codebase, and validate both key usages work (This is likely to be tricky)
22) Refactor out `Timeout.timeout` from play spec
23) `Actions#equip` delegates to private method refactor and fix
24) Allow gold to be dropped and picked up (Currently just traded from hand) - Low Priority!
25) Add quest to be able to buy draz-ghun fleece from newtown
26) Begin consuming phrases that have been saved by enemies (v4)
27) Reduce rubocop offenses below 10
28) Update Simplecov to pass 98%
29) Consume the `use_message` property on Aurel Bark Key (`v3.0` - Requires Lone Ranger)
30) Add in simplecov coverage up 100%
31) Fix up dependabot
32) Fix up GHA
33) Improve gem versions
34) Look around should show enemies
35) Check goblins accuracy rating