extends CanvasLayer
 #This will be edited to fit my game!
#Margins
@onready var topMargin: MarginContainer = $TopMargin
@onready var middletopmargin: MarginContainer = $MiddleBottomMargin
@onready var middlebottommargin: MarginContainer = $MiddleTopMargin
@onready var bottomMargin: MarginContainer = $BottomMargin
# References to Labels
@onready var money_label: Label = $TopMargin/HBoxContainer/MoneyLabel/MoneyLabel
@onready var health_label: Label = $TopMargin/HBoxContainer/HealthPanel/HealthPanel
# Starting Menu
@onready var gunnerShip_btn: Button = $MiddleBottomMargin/HBoxContainer/ShipOptions_container/GunnerShip_btn
@onready var bomberShip_btn: Button = $MiddleBottomMargin/HBoxContainer/ShipOptions_container/BomberShip_btn
@onready var rocketShip_btn: Button = $MiddleBottomMargin/HBoxContainer/ShipOptions_container/RocketShip_btn
# Buttons & Price Labels
@onready var health_Pack_btn: Button = $TopMargin/HBoxContainer/ShopPanel/HealthPackPanel/HealthPackBtn
@onready var health_Pack_price_label: Label = $TopMargin/HBoxContainer/ShopPanel/HealthPackPanel/HealthPackPriceLabel
@onready var Damage_upgrade_btn: Button = $TopMargin/HBoxContainer/ShopPanel/DamageUpgrade/DamageUpgradeBtn
@onready var Damage_upgrade_price_label: Label = $TopMargin/HBoxContainer/ShopPanel/DamageUpgrade/DamageUpgradePrice
@onready var FiringRate_upgrade_btn: Button = $TopMargin/HBoxContainer/ShopPanel/FiringRateUpgrade/FiringRateUpgradeBtn
@onready var FiringRate_upgrade_price_label: Label = $TopMargin/HBoxContainer/ShopPanel/FiringRateUpgrade/FiringRateUpgradePrice
@onready var ProjectilesUpgrade_btn: Button = $TopMargin/HBoxContainer/ShopPanel/ProjectilesUpgrade/ProjectilesUpgradeBtn
@onready var ProjectilesUpgrade_price_label: Label = $TopMargin/HBoxContainer/ShopPanel/FiringRateUpgrade/FiringRateUpgradePrice
# Pause and upgrade button
@onready var pause_btn: Button = $BottomMargin/HBoxContainer/PauseBtn
@onready var upgrade_btn: Button = $BottomMargin/HBoxContainer/UpgradeBtn
# Hboxcontainers
@onready var shopPanel: HBoxContainer = $TopMargin/HBoxContainer/ShopPanel


# Called when the node enters the scene tree for the first time.
func _ready() -> void: #code commented out for obvious reasons!
	pause_btn.pressed.connect(_on_pause_pressed)
	upgrade_btn.pressed.connect(_on_upgrade_pressed)
	_game_start()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_money_changed(amount: float) -> void:
	money_label.text = "$ " + str(int(amount))

func _on_health_changed(amount: int) -> void:
	pass
	#health_label.text = str(amount) + " / " + str(GameManager.player_max_health)


func _on_upgrade_pressed() -> void: #More will be added here
		# Toggle pause state
	var is_paused = get_tree().paused
	get_tree().paused = !is_paused
	
	# Update button text
	if get_tree().paused:
		upgrade_btn.text = "Resume to Game"
		shopPanel.show()
	else:
		shopPanel.hide()
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

func _game_setup_game() -> void:
	topMargin.hide()
	bottomMargin.hide()

func _game_start() -> void:
	middlebottommargin.hide()
	middletopmargin.hide()
	shopPanel.hide()
	topMargin.show()
	bottomMargin.show()
	
