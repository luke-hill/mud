1) Weapon / Armor Models need setting up
2) Potions model needs setting up
3) Overall Item model needs setting up
```
Item model looks like

ID-Name-Type

1-Minor Healing Potion-Potion
2-Dagger-Weapon
```

4) Enemy Spec is a bit manky for the methods near the bottom, try cleanup?
5) Fix up Spec for ActivePlayer (None working yet)
7) Copy over all seed data from previous repo
8) Go through Admin Panel and validate all v0.1 - v1.1 seed files
10) Checklist of all app subfolders
- [ ] classes
- [ ] combat
- [ ] helpers
- [ ] items
- [ ] movement
- [ ] rooms
- [ ] shit_to_sort_out
11) Checklist of all top level files inside app folder
- [ ] autoloader
- [ ] game
- [ ] logger
- [ ] screen
- [ ] version
12) Complete all seeds for existing TODO items
13) Re-commit game at a safe point (v0.1), where almost nothing happens, but data is only seed generated
14) Begin final review of gems, purge anything remotely left-over from rails
15) Begin first pass of rubocop config (Not fixes)
16) Begin to code YML db model readers (For things like the attack logic)
17) Logic for enemies talking to you
  - Add new params into seeders called `phrase1` `phrase2` e.t.c.
  - Cycle randomly through these with % chance for each to trigger (Also no trigger)
  - Add seeds during v2 at some point, with the consumption at v3
18) Add in logic for potion information when using them
  - Interpolate value defined in `use_message`
  - Add message if you're fully healed: `"'You feel yourself regain full strength!'"`
