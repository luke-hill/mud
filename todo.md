1) Checklist of all app subfolders
- [ ] helpers
2) Begin to remove the remaining items from shit_to_sort_out folder
3) Check all specs of each file / folder recursively and begin to fix them up (Or delay them until later)
- [ ] combat folder
- [ ] helpers folder
- game class
- logger utility
- room model
- screen utility
4) Add strength modifier (Once strength stat has been added), to attack
6) Re-run seed file v2.0
7) Logic for enemies talking to you
  - Add new params into seeders called `phrase1` `phrase2` e.t.c.
  - Cycle randomly through these with % chance for each to trigger (Also no trigger)
  - Add seeds during v2 at some point, with the consumption at v3
8) Add in logic for potion information when using them (This needs adding in the Combat / Player command mechanics)
  - Interpolate value defined in `use_message`
  - Add message if you're fully healed: `"'You feel yourself regain full strength!'"`
9) Add quest to be able to buy draz-ghun fleece from newtown
10) Reduce rubocop offenses below 75
12) v0.1 of adventures of avaLancHe ended when you killed the Orc. Lets try re-achieve this (We never did)
13) Re-check specs again and add missing specs
14) Reduce rubocop offenses below 50
20) Update Simplecov to pass 80%
21) Allow gold to be dropped and picked up (Currently just traded from hand) - Low Priority!
22) Add movement logic which requires a key to go in a certain direction (And will use the key up during this)
23) Add logic for enemies to be ktp (ktp logic exists in codebase currently as a param)
25) Open Question, do we need an `attr_writer` for gold for enemies? Do we ever need to reduce their gold? (Maybe if we create a thief class?)
26) Quest idea that `They are known for their metallurgy` be applied to the Sylvanian Ingots?
27) Add 4 stats, Str, Agility, Constitution, (Alias for Wisdom)
28) Add strength modifier (Once strength stat has been added), to defense
30) move missing barracks key into some form of data lookup
33) Add integration tests (Not sure if we can we feature test this using cucumber?)
37) Work out for v3 who would or should drop endurance potion (It also could be crafted?)
38) When items have been dropped. Auto-add them to players inventory if available
40) Have rspec seed a "test" dummy set of data files. These can be then "trusted" in the terms of unit/feature tests
41) Add items to have different costs in different locations
42) Completely rework Buy class and remove all comments about stuff that is hard-coded!
43) Add the first 2-4 places on the map where up and down exist