extends Panel

@export var tile_rows: Array[TileRow]
@export var target_word: DailyWord
var current_guess := []
var current_row_index: int = 0
var current_tile: Tile:
	get:
		var row = tile_rows[current_row_index]
		return row.tiles[min(current_guess.size(), 4)]
var previous_tile: Tile:
	get:
		var row = tile_rows[current_row_index]
		return row.tiles[max(current_guess.size() - 1, 0)]
		
func _init():
	target_word = GameState.preloader.get_resource("daily_word").new()

func _unhandled_key_input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed:
		# handle non-modifier keys
		if event.get_modifiers_mask() == 0:
			# ignore repeating keys
			# handle letter input
			if not event.echo:
				# guess input
				if event.keycode >= KEY_A and event.keycode <= KEY_Z:
					current_tile.animate()
					handle_guess_input(event.as_text())
				# submit guess
				elif event.keycode == KEY_ENTER:
					submit_guess()
			# allow repeating for backspace
			
			if event.keycode == KEY_BACKSPACE:
				handle_erase_input(event.as_text())

func handle_guess_input(key: String):
	if current_guess.size() <= 4:
		current_tile.label.text = key
		current_guess.append(key)
	
func submit_guess():
	if current_guess.size() == 5:
		var results = target_word.compare(current_guess)
		var current_tiles := tile_rows[current_row_index].tiles
		
		for i in range(0,5):
			current_tiles[i].submit(results[i])
		
		current_row_index += 1
		current_guess = []
	
func handle_erase_input(key: String):
	if current_guess.size() > 0:
		previous_tile.label.text = ""
		current_guess.pop_back()
