1) When attacking an enemy that is dead, it then flashes the "you killed" message -> Re-killing it
2) If no data files are present - and you press enter, game crashes. Validate data files during load
```
`advanced_description': undefined method `dig' for nil:NilClass (NoMethodError)

        "#{description_yml.dig(room_id, 'advanced_description').blue}\\n#{directions_string.yellow}"
                          ^^^^

```
3) Missing concepts of no_enemy vs missing enemy
