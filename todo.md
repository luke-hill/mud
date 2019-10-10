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
6) `Location.create(area: 'Dusty Path')` TO FIX `in db/locations.rb`
7) Copy over all seed data from previous repo
8) Go through Admin Panel and validate all v0.1 - v1.1 seed files
9) Refactor admin panel to have a single class that takes a file location of the private yml
10) Checklist of all app subfolders
- [ ] classes
- [ ] combat
- [ ] helpers
- [ ] items
- [ ] movement
- [ ] player
- [ ] rooms
- [ ] shit_to_sort_out
- [ ] world
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
