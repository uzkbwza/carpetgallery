extends Node

var floor_tiles: Array[Texture2D] = [
	preload("res://Procgen/Map/assets/floor_tiles/floor_tiles1.png"),
	preload("res://Procgen/Map/assets/floor_tiles/floor_tiles2.png"),
	preload("res://Procgen/Map/assets/floor_tiles/floor_tiles3.png"),
	preload("res://Procgen/Map/assets/floor_tiles/floor_tiles4.png"),
	preload("res://Procgen/Map/assets/floor_tiles/floor_tiles5.png"),
	preload("res://Procgen/Map/assets/floor_tiles/floor_tiles6.png"),
	preload("res://Procgen/Map/assets/floor_tiles/floor_tiles7.png"),
	preload("res://Procgen/Map/assets/floor_tiles/floor_tiles8.png"),
	preload("res://Procgen/Map/assets/floor_tiles/floor_tiles9.png"),
	preload("res://Procgen/Map/assets/floor_tiles/floor_tiles10.png"),
	preload("res://Procgen/Map/assets/floor_tiles/floor_tiles11.png"),
	preload("res://Procgen/Map/assets/floor_tiles/floor_tiles12.png"),
	preload("res://Procgen/Map/assets/floor_tiles/floor_tiles13.png"),
	preload("res://Procgen/Map/assets/floor_tiles/floor_tiles14.png"),
	preload("res://Procgen/Map/assets/floor_tiles/floor_tiles15.png"),
]

var wall_tiles: Array[Texture2D] = [
	preload("res://Procgen/Map/assets/wall_tiles/wall_tiles1.png"),
	preload("res://Procgen/Map/assets/wall_tiles/wall_tiles2.png"),
	preload("res://Procgen/Map/assets/wall_tiles/wall_tiles3.png"),
	preload("res://Procgen/Map/assets/wall_tiles/wall_tiles4.png"),
	preload("res://Procgen/Map/assets/wall_tiles/wall_tiles5.png"),
	preload("res://Procgen/Map/assets/wall_tiles/wall_tiles6.png"),
	preload("res://Procgen/Map/assets/wall_tiles/wall_tiles7.png"),
	preload("res://Procgen/Map/assets/wall_tiles/wall_tiles8.png"),
	preload("res://Procgen/Map/assets/wall_tiles/wall_tiles9.png"),
	preload("res://Procgen/Map/assets/wall_tiles/wall_tiles10.png"),
	preload("res://Procgen/Map/assets/wall_tiles/wall_tiles11.png"),
	preload("res://Procgen/Map/assets/wall_tiles/wall_tiles12.png"),
	preload("res://Procgen/Map/assets/wall_tiles/wall_tiles13.png"),
	preload("res://Procgen/Map/assets/wall_tiles/wall_tiles14.png"),
	preload("res://Procgen/Map/assets/wall_tiles/wall_tiles15.png"),
	preload("res://Procgen/Map/assets/wall_tiles/wall_tiles16.png"),
	preload("res://Procgen/Map/assets/wall_tiles/wall_tiles17.png"),
	preload("res://Procgen/Map/assets/wall_tiles/wall_tiles18.png"),
	preload("res://Procgen/Map/assets/wall_tiles/wall_tiles19.png"),
	preload("res://Procgen/Map/assets/wall_tiles/wall_tiles21.png"),
	preload("res://Procgen/Map/assets/wall_tiles/wall_tiles22.png"),
	preload("res://Procgen/Map/assets/wall_tiles/wall_tiles23.png"),
	preload("res://Procgen/Map/assets/wall_tiles/wall_tiles24.png"),
]

var dungeon_wall_tiles: Dictionary[Texture2D, int] = {
	preload("res://Procgen/Map/assets/dungeon_style_wall/dungeon_wall1.png"): 100,
	#preload("res://Procgen/Map/assets/dungeon_style_wall/dungeon_wall2.png"): 1000,
	#preload("res://Procgen/Map/assets/dungeon_style_wall/dungeon_wall3.png"): 2000,
	#preload("res://Procgen/Map/assets/dungeon_style_wall/dungeon_wall4.png"): 400,
	preload("res://Procgen/Map/assets/dungeon_style_wall/dungeon_wall5.png"): 100,
	#preload("res://Procgen/Map/assets/dungeon_style_wall/dungeon_wall6.png"): 100,
	preload("res://Procgen/Map/assets/dungeon_style_wall/dungeon_wall7.png"): 50,
	preload("res://Procgen/Map/assets/dungeon_style_wall/dungeon_wall8.png"): 1500,
	preload("res://Procgen/Map/assets/dungeon_style_wall/dungeon_wall9.png"): 1500,
}

var object_tiles: Array[Texture2D] = [
	preload("res://Procgen/Object/assets/object1.png"),
	preload("res://Procgen/Object/assets/object2.png"),
	preload("res://Procgen/Object/assets/object3.png"),
	preload("res://Procgen/Object/assets/object4.png"),
	preload("res://Procgen/Object/assets/object5.png"),
	preload("res://Procgen/Object/assets/object6.png"),
	preload("res://Procgen/Object/assets/object7.png"),
	preload("res://Procgen/Object/assets/object8.png"),
	#preload("res://Procgen/Object/assets/object9.png"),
	#preload("res://Procgen/Object/assets/object10.png"),
	preload("res://Procgen/Object/assets/object11.png"),
	preload("res://Procgen/Object/assets/object12.png"),
	preload("res://Procgen/Object/assets/object13.png"),
	preload("res://Procgen/Object/assets/object14.png"),
	preload("res://Procgen/Object/assets/object15.png"),
	preload("res://Procgen/Object/assets/object16.png"),
	preload("res://Procgen/Object/assets/object17.png"),
	preload("res://Procgen/Object/assets/object18.png"),
	preload("res://Procgen/Object/assets/object19.png"),
	preload("res://Procgen/Object/assets/object20.png"),
	preload("res://Procgen/Object/assets/object21.png"),
	preload("res://Procgen/Object/assets/object22.png"),
	preload("res://Procgen/Object/assets/object23.png"),
	preload("res://Procgen/Object/assets/object24.png"),
	preload("res://Procgen/Object/assets/object25.png"),
	preload("res://Procgen/Object/assets/object26.png"),
	preload("res://Procgen/Object/assets/object27.png"),
	preload("res://Procgen/Object/assets/object28.png"),
	preload("res://Procgen/Object/assets/object29.png"),
	preload("res://Procgen/Object/assets/object30.png"),
	preload("res://Procgen/Object/assets/object31.png"),
	preload("res://Procgen/Object/assets/object32.png"),
	preload("res://Procgen/Object/assets/object33.png"),
	preload("res://Procgen/Object/assets/object34.png"),
	preload("res://Procgen/Object/assets/object35.png"),
	preload("res://Procgen/Object/assets/object36.png"),
	preload("res://Procgen/Object/assets/object37.png"),
	preload("res://Procgen/Object/assets/object38.png"),
	#preload("res://Procgen/Object/assets/object39.png"),
	#preload("res://Procgen/Object/assets/object40.png"),
	preload("res://Procgen/Object/assets/object41.png"),
	preload("res://Procgen/Object/assets/object42.png"),
	preload("res://Procgen/Object/assets/object43.png"),
	preload("res://Procgen/Object/assets/object44.png"),
	preload("res://Procgen/Object/assets/object45.png"),
	preload("res://Procgen/Object/assets/object46.png"),
	preload("res://Procgen/Object/assets/object47.png"),
	preload("res://Procgen/Object/assets/object48.png"),
	preload("res://Procgen/Object/assets/object49.png"),
	preload("res://Procgen/Object/assets/object50.png"),
	preload("res://Procgen/Object/assets/object51.png"),
	preload("res://Procgen/Object/assets/object52.png"),
	preload("res://Procgen/Object/assets/object53.png"),
	preload("res://Procgen/Object/assets/object54.png"),
	preload("res://Procgen/Object/assets/object55.png"),
	preload("res://Procgen/Object/assets/object56.png"),
	preload("res://Procgen/Object/assets/object57.png"),
	preload("res://Procgen/Object/assets/object58.png"),
	preload("res://Procgen/Object/assets/object59.png"),
	preload("res://Procgen/Object/assets/object60.png"),
	preload("res://Procgen/Object/assets/object61.png"),
	preload("res://Procgen/Object/assets/object62.png"),
]

var person_tiles: Array[Texture2D] = [
	preload("res://Procgen/Person/assets/person1.png"),
	preload("res://Procgen/Person/assets/person2.png"),
	preload("res://Procgen/Person/assets/person3.png"),
	preload("res://Procgen/Person/assets/person4.png"),
	preload("res://Procgen/Person/assets/person5.png"),
	preload("res://Procgen/Person/assets/person6.png"),
	preload("res://Procgen/Person/assets/person7.png"),
	preload("res://Procgen/Person/assets/person8.png"),
	preload("res://Procgen/Person/assets/person9.png"),
	preload("res://Procgen/Person/assets/person10.png"),
	#preload("res://Procgen/Person/assets/person11.png"),
	#preload("res://Procgen/Person/assets/person12.png"),
	preload("res://Procgen/Person/assets/person13.png"),
	preload("res://Procgen/Person/assets/person14.png"),
	preload("res://Procgen/Person/assets/person15.png"),
	preload("res://Procgen/Person/assets/person16.png"),
	preload("res://Procgen/Person/assets/person17.png"),
	preload("res://Procgen/Person/assets/person18.png"),
	preload("res://Procgen/Person/assets/person19.png"),
	preload("res://Procgen/Person/assets/person20.png"),
	preload("res://Procgen/Person/assets/person21.png"),
	preload("res://Procgen/Person/assets/person22.png"),
	preload("res://Procgen/Person/assets/person23.png"),
	preload("res://Procgen/Person/assets/person24.png"),
	preload("res://Procgen/Person/assets/person25.png"),
	preload("res://Procgen/Person/assets/person26.png"),
	preload("res://Procgen/Person/assets/person27.png"),
	preload("res://Procgen/Person/assets/person28.png"),
	preload("res://Procgen/Person/assets/person29.png"),
	preload("res://Procgen/Person/assets/person30.png"),
	preload("res://Procgen/Person/assets/person31.png"),
	preload("res://Procgen/Person/assets/person32.png"),
	preload("res://Procgen/Person/assets/person33.png"),
	preload("res://Procgen/Person/assets/person34.png"),
]
