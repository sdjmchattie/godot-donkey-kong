class_name Barrel
extends CharacterBody2D

enum Type { UNSPECIFIED = 0, REGULAR, EXPLOSIVE }

const SPEED = 175.0
const TEXTURES = {
	Type.REGULAR: preload("res://assets/objects/Regular Barrel.png"),
	Type.EXPLOSIVE: preload("res://assets/objects/Explosive Barrel.png")
}

@export var type_override := Type.UNSPECIFIED
@export var direction := 1
@export var explosive_chance := 0.1
@export var tumble_chance := 0.3

var type: Type
var unfrozen_state := "Roll"

@onready var sprite = $Sprite2D as Sprite2D
@onready var anim_tree = $AnimationTree as AnimationTree
@onready var state_machine = $StateMachine as StateMachine

func _init():
	type = Type.REGULAR if randf() > explosive_chance else Type.EXPLOSIVE

	if type_override != Type.UNSPECIFIED:
		type = type_override

func _ready():
	sprite.texture = TEXTURES[type]
	anim_tree.active = true

func freeze(should_freeze: bool):
	if should_freeze:
		unfrozen_state = state_machine.state.name
		state_machine.transition_to("Freeze")
	else:
		state_machine.transition_to(unfrozen_state)

