extends CanvasLayer
 #This will be edited to fit my game!
# References to Labels
@onready var money_label: Label = $MarginContainer/HBoxContainer/MoneyLabel/MoneyLabel
@onready var health_label: Label = $MarginContainer/HBoxContainer/HealthPanel/HealthPanel

# Buttons & Price Labels
@onready var shopPanel: HBoxContainer = $MarginContainer/HBoxContainer/ShopPanel
@onready var Damage_upgrade_btn: Button = $MarginContainer/HBoxContainer/ShopPanel/DamageUpgrade/DamageUpgradeBtn
@onready var Damage_upgrade_price_label: Label = $MarginContainer/HBoxContainer/ShopPanel/DamageUpgrade/DamageUpgradePrice
@onready var FiringRate_upgrade_btn: Button = $MarginContainer/HBoxContainer/ShopPanel/FiringRateUpgrade/FiringRateUpgradeBtn
@onready var FiringRate_upgrade_price_label: Label = $MarginContainer/HBoxContainer/ShopPanel/FiringRateUpgrade/FiringRateUpgradePrice
@onready var ProjectilesUpgrade_btn: Button = $MarginContainer/HBoxContainer/ShopPanel/ProjectilesUpgrade/ProjectilesUpgradeBtn
@onready var ProjectilesUpgrade_price_label: Label = $MarginContainer/HBoxContainer/ShopPanel/FiringRateUpgrade/FiringRateUpgradePrice
@onready var pause_btn: Button = $BottomMargin/HBoxContainer/PauseBtn
@onready var upgrade_btn: Button = $BottomMargin/HBoxContainer/UpgradeBtn
# Turret scenes to pass on click
#@export var turret_1: PackedScene
#@export var turret_2: PackedScene


# Called when the node enters the scene tree for the first time.
func _ready() -> void: #code commented out for obvious reasons!
	shopPanel.hide() # I wish for shop to be hidden during gameplay!
	# Set the turret prices as stated in the GameManager
	#turret_1_price_label.text = "$" + str(GameManager.turret_1_price)
	#turret_2_price_label.text = "$" + str(GameManager.turret_2_price)
	# Connecting the money/health changed signals to our functions
	#GameManager.money_changed.connect(_on_money_changed)
	#GameManager.health_changed.connect(_on_health_changed)
	# Emiting our money & health changed signals
	# Using starting values from GameManager
	#GameManager.money_changed.emit(GameManager.player_money)
	#GameManager.health_changed.emit(GameManager.player_health)
	# Connecting button clicks
	#turret_1_btn.pressed.connect(_on_turret1_clicked)
	#turret_2_btn.pressed.connect(_on_turret2_clicked)
	pause_btn.pressed.connect(_on_pause_pressed)
	upgrade_btn.pressed.connect(_on_upgrade_pressed)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_money_changed(amount: float) -> void:
	money_label.text = "$ " + str(int(amount))

func _on_health_changed(amount: int) -> void:
	pass
	#health_label.text = str(amount) + " / " + str(GameManager.player_max_health)

func _on_turret1_clicked() -> void:
	print("Turret 1 Clicked")
	#GameManager.select_turret(turret_1,GameManager.turret_1_price)

func _on_turret2_clicked() -> void:
	print("Turret 2 Clicked")
	#GameManager.select_turret(turret_2,GameManager.turret_2_price)

func _on_upgrade_pressed() -> void: #More will be added here
		# Toggle pause state
	var is_paused = get_tree().paused
	get_tree().paused = !is_paused
	
	# Update button text
	if get_tree().paused:
		upgrade_btn.text = "Resume to Game"
	else:
		upgrade_btn.text = "Exit to Upgrades"

func _on_pause_pressed() -> void:
	# Toggle pause state
	var is_paused = get_tree().paused
	get_tree().paused = !is_paused
	
	# Update button text
	if get_tree().paused:
		pause_btn.text = "Resume"
	else:
		pause_btn.text = "Pause"
