3) Check all specs of each file / folder recursively and begin to fix them up (Or delay them until later)
- helpers folder
- game class
- room model
- screen utility
7) Logic for enemies talking to you
  - Add new params into seeders called `phrase1` `phrase2` e.t.c.
  - Cycle randomly through these with % chance for each to trigger (Also no trigger)
  - Add seeds during v2 at some point, with the consumption at v3
10) Bugfix, only let people equip weapons/armors that they own
11) Bugfix, if someone doesn't own a weapon/armor, say they can't equip that weapon/armor
12) v0.1 of adventures of avaLancHe ended when you killed the Orc. Lets try re-achieve this (We never did)
13) Re-check specs again and add missing specs
17) Add movement logic which requires a key to go in a certain direction (And will use the key up during this)
18) Begin to remove the remaining items from shit_to_sort_out folder
19) Open Question, do we need an `attr_writer` for gold for enemies? Do we ever need to reduce their gold? (Maybe if we create a thief class?)
20) Quest idea that `They are known for their metallurgy` be applied to the Sylvanian Ingots?
21) Add 4 stats, Str, Agility, Constitution, (Alias for Wisdom)
22) Consume the `use_message` property on Barracks Key (`v2.0`)
30) move missing barracks key into some form of data lookup
33) Add integration tests (Not sure if we can we feature test this using cucumber?)
34) Reduce rubocop offenses below 25
35) Consume the `use_message` property on Aurel Bark Key (`v3.0` - Requires Lone Ranger)
37) Work out for v3 who would or should drop endurance potion (It also could be crafted?)
38) When items have been dropped. Auto-add them to players inventory if available
39) Update Simplecov to pass 95%
40) Have rspec seed a "test" dummy set of data files. These can be then "trusted" in the terms of unit/feature tests
41) Add items to have different costs in different locations
42) Completely rework Buy class and remove all comments about stuff that is hard-coded!
43) Add the first 2-4 places on the map where up and down exist
44) Add a second usable key to the codebase, and validate both key usages work (This is likely to be tricky)
45) Refactor out `Timeout.timeout` from play spec
46) `Actions#equip` delegates to private method refactor and fix
47) Allow gold to be dropped and picked up (Currently just traded from hand) - Low Priority!
48) Add quest to be able to buy draz-ghun fleece from newtown
49) Begin consuming phrases that have been saved by enemies (v4)
