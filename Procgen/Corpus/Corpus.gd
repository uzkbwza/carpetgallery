extends Node

var corpus_resource: CorpusResource = preload("res://Procgen/Corpus/CorpusResource.tres")

var corpus_markovs: Dictionary[String, MarkovChainGenerator]

func _ready():
	#for corpus in corpus_resource.dialogue_corpora:
		#var markov = MarkovChainGenerator.new(1, true)
		#markov.process_corpus(corpus.lines)
		#corpus_markovs[corpus.name] = markov
	#
	#var rng = BetterRng.new()
	#for i in range(5):
		#for dialogue in generate_room_dialogues(rng, 5):
			#print(dialogue)
		#print("")
	pass

func random_dialogue_corpus(rng: BetterRng) -> DialogueCorpus:
	return rng.choose(corpus_resource.dialogue_corpora)

func random_theme_corpus(rng: BetterRng) -> DialogueCorpus:
	return rng.choose(corpus_resource.theme_corpora)

func process_dialogue(dialogue: String, theme_corpus: DialogueCorpus, rng: BetterRng) -> String:
	var re = RegEx.new()
	var text = dialogue
	re.compile("theme")
	while re.search(text):
		text = re.sub(dialogue, rng.choose(theme_corpus.lines))
	re.compile("THEME")
	while re.search(text):
		text = re.sub(dialogue, rng.choose(theme_corpus.lines).to_upper())
	return text

func generate_dialogue(rng: BetterRng, theme_corpus: DialogueCorpus, dialogue_corpus: DialogueCorpus) -> String:
	var markov := corpus_markovs[dialogue_corpus.name]
	return process_dialogue(markov.generate(rng), theme_corpus, rng)

func generate_room_dialogues(rng: BetterRng, count: int, theme_corpus: DialogueCorpus=null, dialogue_corpus: DialogueCorpus=null) -> PackedStringArray:
	var arr = PackedStringArray()
	if theme_corpus == null:
		theme_corpus = random_theme_corpus(rng)
	if dialogue_corpus == null:
		dialogue_corpus = random_dialogue_corpus(rng)
	for i in range(count):
		arr.append(generate_dialogue(rng, theme_corpus, dialogue_corpus))
		pass
	return arr
