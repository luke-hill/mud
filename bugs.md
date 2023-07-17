1) When attacking an enemy that is dead, it then flashes the "you killed" message -> Re-killing it
2) If no data files are present - and you press enter, game crashes. Validate data files during load
```
`advanced_description': undefined method `dig' for nil:NilClass (NoMethodError)

        "#{description_yml.dig(room_id, 'advanced_description').blue}\\n#{directions_string.yellow}"
                          ^^^^

```
3) Missing concepts of no_enemy vs missing enemy
4) Typing `u` or `d` as a command crashes the game. Did you mean up/down?
5) Bandit in corner of forest path should be ktp!
6) Wolf in forest path should be ktp!
