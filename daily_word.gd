@tool
class_name DailyWord
extends Resource

@export var daily_word: String
var daily_letters: PackedStringArray:
	get:
		return daily_word.split("")
var available_words: Array[String]
var unavailable_words: Array[String]

func _init():
	var file_available_words = FileAccess.open('res://available-words.txt', FileAccess.READ)

	while !file_available_words.eof_reached():
		available_words.append(file_available_words.get_line().to_upper())

	var file_unavailable_words = FileAccess.open('res://unavailable-words.txt', FileAccess.READ)
	
	while !file_unavailable_words.eof_reached():
		var unavailable_word = file_unavailable_words.get_line().to_upper()
		
		unavailable_words.append(unavailable_word)
		var word_index = available_words.find(unavailable_word)
		
		# remove used words
		if word_index >= 0:
			available_words.remove_at(word_index)

	daily_word = available_words[randi_range(0, available_words.size() - 1)]

func compare(word):
	var comp := []
	var results := {
		0: "",
		1: "",
		2: "",
		3: "",
		4: "",
	}
	
	if typeof(word) == TYPE_ARRAY:
		comp = word
	elif typeof(word) == TYPE_STRING:
		comp = (word as String).split("")
		
	for i in range(0,5):
		if daily_letters[i] == comp[i]:
			results[i] = GameState.TileStatus.CORRECT
		elif daily_letters.find(comp[i]) > 0:
			results[i] = GameState.TileStatus.SEMICORRECT
		else:
			results[i] = GameState.TileStatus.INCORRECT
	
	return results
