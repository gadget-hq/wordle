class_name Tile
extends Panel

@export var label: Label
var theme_variants := [&"TileCorrect", &"TileSemicorrect", &"TileIncorrect"]

func submit(tile_status: GameState.TileStatus):
	theme_type_variation = theme_variants[tile_status]
	animate()
	
func animate():
	var tween = get_tree().create_tween()
	pivot_offset = Vector2(size.x / 2, size.y/2)
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(self, "scale", Vector2(1.25, 1.25), 0.025)
	tween.tween_property(self, "scale", Vector2(1.1, 1.1), 0.05)
	tween.tween_property(self, "scale", Vector2(1, 1), 0.05)
