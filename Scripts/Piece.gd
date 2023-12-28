extends Sprite
class_name Piece

onready var controller:Control = $"Control"
onready var tw:Tween = $"Tween"
onready var death_particle:CPUParticles2D = $"DeathParticle"

export var piece_index:int

export var move_pattern_path:NodePath
var move_pattern:MovePattern

var pos:Vector2 = Vector2(0, 0)
var dead:bool = false

var t:float = 0
var shake_level:float = 0
var shake_damp:float = 0.85
var shake_amt:float = TAU/16

signal died
signal setted

func _ready():
	move_pattern = get_node(move_pattern_path)
	death_particle.texture = texture
	controller.connect("set_down", Globals.gm, "clear_grid_display")
	controller.connect("mouse_exited", Globals.gm, "clear_grid_display")

func pos_animate(v:Vector2):
	tw.interpolate_property(self, "position", 
		position, v,
		Globals.tween_speed, Tween.TRANS_EXPO, Tween.EASE_OUT)
	tw.start()

func _process(delta):
	t += delta
	z_index = 5 if controller.focused else 0
	if controller.holding:
		hold_position()
		show_vacant()
	else:
		rest_position()
	shake_level*=shake_damp
	rotation = shake_level*sin(t*30)

func hold_position():
	pos_animate(Globals.gm.get_mouse_position())

func rest_position():
	pos_animate(Globals.gm.grid_to_world(pos))

func death():
	dead = true
	controller.controllable = false
	self_modulate.a = 0
	controller.mouse_filter = Control.MOUSE_FILTER_IGNORE
	death_particle.emitting = true
	emit_signal("died")
	yield(get_tree().create_timer(1.0), "timeout")
	visible = false # it seems that the first frame of queue free, 
	queue_free() #    self_modulate is set back to default?

func _on_Control_set_down():
	var dest:Vector2 = world_to_grid()
	if dest in move_pattern.can_move_to(pos):
		if dest in Globals.gm.all_pieces_pos():
			Globals.gm.piece_at(dest).death()
			pos = dest
			emit_signal("setted")
			$"FXset".play()
		else:
			set_on_vacant_spot(dest)
	show_vacant()

func set_on_vacant_spot(dest:Vector2):
	pass

func _on_Control_mouse_entered():
	show_vacant()
	$"FXfocused".play()

func spots_allowed():
	return Globals.gm.all_pieces_pos()

func show_vacant():
	Globals.gm.grid_display_vacant(move_pattern.can_move_to(pos), 
	spots_allowed(),
	world_to_grid())

func world_to_grid():
	return Globals.gm.world_to_grid(position)


func _on_Control_picked_up():
	shake_level = (-1 if randf()<0.5 else 1)*shake_amt
	$"FXpicked".play()
