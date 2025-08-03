extends Node

enum TileStatus { CORRECT, SEMICORRECT, INCORRECT }

var preloader = ResourcePreloader.new()

func _init():
	preloader.add_resource("daily_word", preload("res://daily_word.gd"))
