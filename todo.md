1) Checklist of all app subfolders
- [ ] combat
- [ ] helpers
2) Begin to remove the remaining items from shit_to_sort_out folder
3) Check all specs of each file / folder recursively and begin to fix them up (Or delay them until later)
- [ ] actions folder
- [ ] classes folder
- [ ] combat folder
- [ ] helpers folder
- armor model
- enemy model
- game class
- logger utility
- potion model
- room model
- screen utility
- version constant
- weapon model
4) Begin final review of gems, purge anything remotely left-over from rails
5) Begin first pass of rubocop config (Not fixes)
7) Logic for enemies talking to you
  - Add new params into seeders called `phrase1` `phrase2` e.t.c.
  - Cycle randomly through these with % chance for each to trigger (Also no trigger)
  - Add seeds during v2 at some point, with the consumption at v3
8) Add in logic for potion information when using them (This needs adding in the Combat / Player command mechanics)
  - Interpolate value defined in `use_message`
  - Add message if you're fully healed: `"'You feel yourself regain full strength!'"`
9) Add quest to be able to buy draz-ghun fleece from newtown
20) v0.1 of adventures of avaLancHe ended when you killed the Orc. Lets try re-achieve this (We never did)
22) Add movement logic which requires a key to go in a certain direction (And will use the key up during this)
23) Add logic for enemies to be ktp (ktp logic exists in codebase currently as a param)
24) Add movement presenter logic
- which hides certain directions
25) Open Question, do we need an `attr_writer` for gold for enemies? Do we ever need to reduce their gold? (Maybe if we create a thief class?)
26) Quest idea that `They are known for their metallurgy` be applied to the Sylvanian Ingots?
27) Add 4 stats, Str, Agility, Constitution, (Alias for Wisdom)
27) Add strength modifier (Once strength stat has been added), to attack
28) Add strength modifier (Once strength stat has been added), to defence
29) get the concept of a top levle directory where the mud folder is installed in ENV
30) move missing barracks key into some form of data lookup
31) Add Simplecov, initial aim for 20%
32) Update Simplecov to pass 50%
33) Add integration tests (Not sure if we can we feature test this using cucumber?)
34) Re-run seed files v0.1 - v1.1 (This should change little to no data)
35) Re-run seed file v2.0
36) Re-check specs again and add missing specs
37) Work out for v3 who would or should drop endurance potion (It also could be crafted?)
38) When items have been dropped. Auto-add them to players inventory if available
39) enable up and down directions. Begin to add the first 10-20 places on the map where up and down are viable
