extends Resource
class_name Interactable

@export_enum("Global:1","Gameplay:2","PickUp:3") var GameplayType: int = -1
@export_enum("Wind:1", "Armor:2") var GameplayEffect: int = -1
@export_enum("CheckPoint:1","FinishLine:2") var GlobalEffect: int = -1
@export_enum("Coin:1", "Health:2", "SpeedIncrease:3", "SpeedDecrease:4") var PickupType: int = -1
