2) Add missing spec for app/shop.rb - Currently at < 40%
3) Add missing spec for app/play.rb - Currently at < 75%
4) Add movement logic which requires a key to go in a certain direction (And will use the key up during this)
5) Begin to remove the remaining items from shit_to_sort_out folder
6) Do we need an `attr_writer` for gold for enemies? Do we ever need to reduce gold? (Maybe if we have a thief?)
7) Get yard documentation rate up to 80%
8) Consume the `use_message` property on Barracks Key (`v2.1`)
9) Get yard documentation rate up to 85%
10) Quest idea that `They are known for their metallurgy` be applied to the Sylvanian Ingots?
11) move missing barracks key into some form of data lookup
12) Add integration tests (Not sure if we can we feature test this using cucumber?)
13) Work out for v3 who would or should drop endurance potion (It also could be crafted?)
14) When items have been dropped. Auto-add them to players inventory if available
15) Have rspec seed a "test" dummy set of data files. These can be then "trusted" in the terms of
unit/feature tests
16) Playthrough attempt #1 - Kill all the goblins
17) Add items to have different costs in different locations
18) Completely rework Buy class and remove all comments about stuff that is hard-coded!
19) Add the first 2-4 places on the map where up and down exist
20) Add a second usable key to the codebase, and validate both key usages work (This is likely to be tricky)
21) Refactor out `Timeout.timeout` from play spec
22) Playthrough attempt #2 - Attempt to move to 2nd town
23) `Actions#equip` delegates to private method refactor and fix
24) Allow gold to be dropped and picked up (Currently just traded from hand) - Low Priority!
25) Add quest to be able to buy draz-ghun fleece from newtown
26) Begin consuming phrases that have been saved by enemies (v4)
27) Reduce rubocop offenses below 10
28) Update Simplecov to pass 98%
29) Consume the `use_message` property on Aurel Bark Key (`v3.0` - Requires Lone Ranger)
30) Add in simplecov coverage up 100%
31) Playthrough attempt #3 - Attempt to buy an item, equip it, and see the difference in attack/defense
32) Fix up dependabot
33) Fix up GHA
34) Improve gem versions
35) Look around should show enemies
36) Check goblins accuracy rating
37) After game load, prompt user to press enter
