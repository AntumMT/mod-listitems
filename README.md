## List Items Chat Command

### Description:

A mod for [Luanti] (formerly Minetest) that adds a command for listing registered items, entities, &
nodes.

![screenshot](screenshot.png)

### Usage:

Chat Commands:
```
/list type [options] [string1] [string2] ...
- Lists registered items or entities available in the game.
- type: List type (e.g. "items", "entities", etc.).
- options: Switches to control output behavior.
    - -v: Display description (if available) after object name.
    - -s: Use shallow search (don't search in descriptions).
- string[1,2] ...: String parameter(s) to filter output.
    - Without any string parameters, all objects registered in game are listed.
    - With string parameters, only objects matching any of the strings will be listed.
```

Settings:
```
listitems.bullet_list
- Displays items in a bulleted list.
- type: boolean
- default: true

listitems.enable_singleword
- Registers "/list<type>" commands (e.g. "/listitems", "/listentities", etc.).
- type: boolean
- default: true
```

### Licensing:

- [MIT](LICENSE.txt)

### Requirements:

- Luanti minimum version: 5.0
- Dependencies: none
- Optional depends:
    - [![mobs_redo](https://content.luanti.org/packages/TenPlus1/mobs/shields/title/)](https://content.luanti.org/packages/TenPlus1/mobs/) *(adds "list mobs" chat command)*
- Privileges: none

### Links:

- [![ContentDB](https://content.luanti.org/packages/AntumDeluge/listitems/shields/title/)][ContentDB]
- [Forum](https://forum.luanti.org/viewtopic.php?t=18049)
- Git repos:
    - [Codeberg](https://codeberg.org/AntumLuanti/mod-listitems)
    - [GitHub](https://github.com/AntumMT/mod-listitems)
    - [GitLab](https://gitlab.com/AntumMT/mod-listitems)
- [API Documentation](https://antummt.github.io/mod-listitems/docs/)
- [Changelog](changelog.txt)
- [TODO](TODO.txt)


[Luanti]: https://www.luanti.org/
