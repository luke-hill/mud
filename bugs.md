1) Pressing enter on game load crashes
```
`advanced_description': undefined method `dig' for nil:NilClass (NoMethodError)

        "#{description_yml.dig(room_id, 'advanced_description').blue}\\n#{directions_string.yellow}"
                          ^^^^

```
2) When attacking an enemy that is dead, it then flashes the "you killed" message -> Re-killing it
3) When you are killed the game crashes
4) If no data files are present, game crashes. Validate data files during load
