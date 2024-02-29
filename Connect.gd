extends Node

#Path to the msg node
@onready var message = get_parent().get_node("Node")

func _ready():
	#Register the message to lisen for
	message.Register(Message_Names.Test, funcToRun)

#Function to run when the message is called
var funcToRun = func ToRun():
	print(str("Hello from ", name))
