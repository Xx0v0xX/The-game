extends Node2D

const CHUNK_SIZE = 16
var noise = FastNoiseLite.new()

func _ready():
	noise.seed = randi()
	noise.noise_type = FastNoiseLite.TYPE_SIMPLEX
	noise.frequency = 0.02
	
	generate_world(5, 5) # gera 5x5 chunks de teste

func generate_world(width, height):
	for cx in range(width):
		for cy in range(height):
			var world_x = cx * CHUNK_SIZE
			var world_y = cy * CHUNK_SIZE
			var value = noise.get_noise_2d(world_x, world_y)
			
			var biome = get_biome(value)
			generate_chunk(cx, cy, biome)

func get_biome(value: float) -> String:
	if value < -0.3:
		return "geleira"
	elif value < 0.3:
		return "floresta"
	else:
		return "deserto"

func generate_chunk(cx, cy, biome):
	var chunk = Node2D.new()
	chunk.name = "Chunk_%d_%d" % [cx, cy]
	add_child(chunk)
	
	# só de teste: um quadrado colorido pro bioma
	var color = Color.WHITE
	if biome == "floresta":
		color = Color.GREEN
	elif biome == "deserto":
		color = Color.YELLOW
	elif biome == "geleira":
		color = Color.CYAN
	
	var rect = ColorRect.new()
	rect.color = color
	rect.size = Vector2(CHUNK_SIZE*16, CHUNK_SIZE*16) # se tile for 16px
	rect.position = Vector2(cx*CHUNK_SIZE*16, cy*CHUNK_SIZE*16)
	chunk.add_child(rect)
