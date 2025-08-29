extends CanvasLayer

@onready var health_bar = $Control/MarginContainer/TopBar/HealthBar
@onready var mana_bar = $Control/MarginContainer/TopBar/ManaBar

func set_health(value: float, max_value: float):
	health_bar.value = value
	health_bar.max_value = max_value

func set_mana(value: float, max_value: float):
	mana_bar.value = value
	mana_bar.max_value = max_value
