1) Pressing enter on game load crashes
```
`advanced_description': undefined method `dig' for nil:NilClass (NoMethodError)

        "#{description_yml.dig(room_id, 'advanced_description').blue}\\n#{directions_string.yellow}"
                          ^^^^

```
2) First ktp goblin isn't ktp
3) Killing an enemy crashes the game
4) Can attack "No Enemy"
5) When attacking an enemy that is dead, it then flashes the "you killed" message
6) When you are killed the game crashes
7) Require barracks key to get into orc room