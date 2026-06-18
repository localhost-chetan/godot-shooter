# AGENT.md

## Project Overview
* This project is a 2D top-down game built in the Godot 4 engine. 
* The game features a character that can move, shoot lasers, and throw grenades. 
* The world includes enemies, static obstacles, transition zones, interactive loot containers, and dynamic items. 


## File and Naming Conventions
* Node classes and custom class names strictly utilize PascalCase (e.g., `Sprite2D`, `LevelParent`). 
* File names, variables, and functions strictly utilize snake_case (e.g., `player.tscn`, `update_laser_text`). 


## Scene Architecture and Inheritance
* The project relies heavily on scene and script inheritance to prevent code duplication. 
* A base parent scene (`level.tscn`) contains the core logic for the game loop, such as capturing projectile signals and managing UI updates. 
* Specific level scenes (like `outside.tscn` and `inside.tscn`) inherit from the base `level.tscn` scene. 
* The script attached to the base level uses `class_name LevelParent` to expose its functions. 
* Child level scripts explicitly extend `LevelParent`. 
* Loot containers utilize this same pattern: a base `item_container.tscn` is extended by `crate.tscn` and `toilet.tscn`. 


## State Management (Globals)
* Global state is managed via an AutoLoad script named `globals.gd` (registered with the node name `Globals`). 
* This singleton stores crucial gameplay variables: `laser_amount`, `grenade_amount`, and `health`. 
* The script uses property setters (via the `set` function) to automatically emit a `stat_change` signal whenever these variable values are updated. 
* The User Interface listens directly to the `stat_change` signal to dynamically update the HUD. 
* The `Globals` script also continuously tracks `player_position` (Vector2) so enemy AI can accurately target the player. 


## Input Map Actions
* `left`, `right`, `up`, `down`: Mapped to keyboard arrows and WASD for Vector2 top-down movement. 
* `primary_action`: Mapped to the Left Mouse Button and Spacebar to trigger laser firing. 
* `secondary_action`: Mapped to the Right Mouse Button and Ctrl to trigger grenade throwing. 


## Physics Layers and Masks Configuration
* **Layer 1 (Player)**: Reserved exclusively for the player's `CharacterBody2D`. 
* **Layer 2 (Enemies)**: Reserved for enemy entities like Drones and Scouts. 
* **Layer 3 (Objects)**: Reserved for static objects and environmental interactables (crates, beds, walls, lamps). 
* **Layer 4 (Projectiles)**: Reserved for the player's lasers (`Area2D`) and grenades (`RigidBody2D`). 
* **Layer 5 (Items and Zones)**: Reserved for level transition gates, health pick-ups, and ammo pick-ups. 


## Node Groups
* `Container`: Applied to interactive loot objects (crates, toilets). 
* `Entity`: Applied to objects with a `hit()` method that can take damage (player, enemies) to simplify area-of-effect calculations for explosions. 
* `Scouts`: Applied to Scout enemies to globally connect their laser firing signals to the parent level script. 


## GDScript Best Practices
* Use the `$` shorthand to fetch nodes instead of `get_node()` to ensure concise code. 
* Use the `@onready` keyword for node references to ensure the scene tree is fully loaded before the variable is accessed. 
* Always use `call_deferred()` when modifying the scene tree (e.g., adding item instances) during physics callbacks like `_on_body_entered` to prevent physics engine errors. 
* Use `Tween` objects (via `create_tween()`) to animate simple properties, such as camera zooming or UI transparency fading. 
* Use `AnimationPlayer` nodes for complex, sequenced visual events, such as grenade explosions or flashing UI elements. 
* Use custom signals extensively (e.g., `player_entered_gate`, `laser`) to decouple components and pass data between instanced scenes and their parent scripts.
