extends Node

@onready var message = get_parent().get_node("Node")

func pressed():
	message.Send(Message_Names.Test)
