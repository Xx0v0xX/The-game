extends CharacterBody3D

@onready var anim: AnimatedSprite3D = $AnimatedSprite3D

signal health_changed(current, max)
signal mana_changed(current, max)

var speed: float = 4.0
var last_dir: String = "costas"

var health: int = 100
var max_health: int = 100
var mana: int = 50
var max_mana: int = 50

func _ready():
	# Assim que o player nasce, avisamos a UI sobre os valores iniciais
	emit_signal("health_changed", health, max_health)
	emit_signal("mana_changed", mana, max_mana)

func _physics_process(delta):
	var input = Vector2.ZERO

	if Input.is_action_pressed("ui_right"):
		input.x += 1
		last_dir = "direita"
	if Input.is_action_pressed("ui_left"):
		input.x -= 1
		last_dir = "esquerda"
	if Input.is_action_pressed("ui_down"):
		input.y += 1
		last_dir = "frente"
	if Input.is_action_pressed("ui_up"):
		input.y -= 1
		last_dir = "costas"

	velocity.x = input.x * speed
	velocity.z = input.y * speed
	move_and_slide()

	play_anim(input)

func play_anim(input: Vector2):
	if input == Vector2.ZERO:
		match last_dir:
			"frente": anim.play("idle_frente")
			"costas": anim.play("idle_costas")
			"direita":
				anim.flip_h = false
				anim.play("idle_direita")
			"esquerda":
				anim.flip_h = true
				anim.play("idle_direita")
	else:
		match last_dir:
			"frente": anim.play("walk_frente")
			"costas": anim.play("walk_costas")
			"direita":
				anim.flip_h = false
				anim.play("walk_direita")
			"esquerda":
				anim.flip_h = true
				anim.play("walk_direita")

# --- Funções para mudar vida/mana e avisar a UI ---
func set_health(value: int):
	health = clamp(value, 0, max_health)
	emit_signal("health_changed", health, max_health)

func set_mana(value: int):
	mana = clamp(value, 0, max_mana)
	emit_signal("mana_changed", mana, max_mana)
