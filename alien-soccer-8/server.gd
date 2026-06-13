extends Node

var peer = WebSocketMultiplayerPeer.new()

enum Messages {
	id,
	join,
	userConnected,
	userDisconnected,
	lobby,
	candidate,
	offer,
	answer,
	checkIn,
}

@export var host_port = 8080

var users = {}
var lobbies = {}

var letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ" 

func start_server():
	peer.create_server(host_port)
	print("started server")

func join_lobby(user):
	if user.lobbyValue == "":
		user.lobbyValue = generate_rand_str()
		print(user.lobbyValue)
		lobbies[user.lobbyValue] = Lobby.new(user.id)
	
	var player = lobbies[user.lobbyValue].add_player(user.id, user.name)
	
	for p in lobbies[user.lobbyValue].Players:
		
		var data = {
			"message" : Messages.userConnected,
			"id" : user.id
		}
		send_to_player(p, data)
		
		var data2 = {
			"message" : Messages.userConnected,
			"id" : p
		}
		send_to_player(user.id, data2)
		
		var lobbyInfo = {
			"message" : Messages.lobby,
			"players" : JSON.stringify(lobbies[user.lobbyValue].Players),
			"host" : lobbies[user.lobbyValue].HostId,
			"lobbyValue" : user.lobbyValue,
		}
		send_to_player(p, lobbyInfo)
		
	
	var data = {
		"message" : Messages.userConnected,
		"id" : user.id,
		"host" : lobbies[user.lobbyValue].HostId,
		"player" : lobbies[user.lobbyValue].Players[user.id],
		"lobbyValue" : user.lobbyValue,
	}
	send_to_player(user.id, data)

func send_to_player(user_id, data):
	peer.get_peer(user_id).put_packet(JSON.stringify(data).to_utf8_buffer())

func generate_rand_str():
	var result = ""
	for i in range(32):
		var randomIndex = randi() % letters.length()
		result += letters[randomIndex]
	return result


func _on_start_server_pressed():
	start_server()

func _process(delta):
	peer.poll()
	if peer.get_available_packet_count() > 0:
		var packet = peer.get_packet()
		if packet != null:
			var data_string = packet.get_string_from_utf8()
			var data = JSON.parse_string(data_string)
			print(data) 
			
			if data.message == Messages.lobby:
				join_lobby(data)
			
			if data.message == Messages.offer or data.message == Messages.answer or data.message == Messages.candidate:
				print("src id is " + str(data.orgPeer))
				send_to_player(data.peer, data)

func _ready():
	if OS.has_environment("server") or OS.has_environment("FLY_PROCESS_GROUP"):
		print("hosting on" + str(host_port))
		peer.create_server(host_port)
	
	peer.connect("peer_connected", peer_connected)
	peer.connect("peer_disconnected", peer_disconnected)

func peer_connected(id):
	print("peer connected " + str(id))
	users[id] = {
		"id" : id,
		"message" : Messages.id
	}
	peer.get_peer(id).put_packet(JSON.stringify(users[id]).to_utf8_buffer())

func peer_disconnected():
	pass

func _on_button_2_pressed():
	var message = {
		"message" : Messages.id,
		"data" : "test"
	}
	var message_bytes = JSON.stringify(message).to_utf8_buffer()
	peer.put_packet(message_bytes)
