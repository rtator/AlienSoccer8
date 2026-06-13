extends Node

var peer = WebSocketMultiplayerPeer.new()
var rtc_peer : WebRTCMultiplayerPeer = WebRTCMultiplayerPeer.new() 

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
var id = 0
var lobbyValue = ""
var hostId : int

var world_load = preload("res://soccer_world.tscn")
#var player_load = preload("res://multiplayer_char.tscn")
var player_load = preload("res://basicAlien.tscn")

func _ready():
	multiplayer.connected_to_server.connect(RTCServerConnected)
	multiplayer.peer_connected.connect(RTCPeerConnected)
	multiplayer.peer_disconnected.connect(RTCPeerDisconnected)

func RTCServerConnected():
	print("rtc server connected")

func RTCPeerConnected(testing):
	start_game()
	print("rtc peer connected " + str(id))

func RTCPeerDisconnected(testing):
	print("rtc peer disconnected " + str(id))

func connect_to_server(ip):
	peer.create_client("ws://66.241.125.100:8080")
	print("started client")

func _on_start_client_pressed():
	connect_to_server("")

func _on_button_pressed():
	start_game.rpc()
	pass

@rpc("any_peer")
func start_game():
	print("unique id is " + str(multiplayer.get_unique_id()) + ". host id is " + str(hostId))
	%MultiplayerSpawner.set_multiplayer_authority(hostId)
	
	%Control.hide()
	
	if multiplayer.get_unique_id() == hostId:
		var world = world_load.instantiate()
		world.set_authority(hostId)
		%World.add_child(world)
		
		
		for p in WebrtcManager.Players:
			#print(player_load.resource_path)
			#%MultiplayerSpawner.add_spawnable_scene("res://basicAlien.tscn")
			var player = player_load.instantiate()
			player.name = str(int(p))
			player.online = true
			%World.add_child(player, true)


func _on_multiplayer_spawner_spawned(node):
	print(str("online" in node))
	if "online" in node:
		node.online = true
	if node.has_method("set_authority"):
		node.set_authority(hostId)


func _process(delta):
	peer.poll()
	if peer.get_available_packet_count() > 0:
		var packet = peer.get_packet()
		if packet != null:
			var data_string = packet.get_string_from_utf8()
			var data = JSON.parse_string(data_string)
			print(data)
			if data.message == Messages.id:
				id = data.id
				connected(id)
			
			if data.message == Messages.userConnected:
				createPeer(data.id)
			
			if data.message == Messages.lobby:
				WebrtcManager.Players = JSON.parse_string(data.players)
				lobbyValue = data.lobbyValue
				%TextEdit.text = str(lobbyValue)
				hostId = data.host
			
			if data.message == Messages.candidate:
				if rtc_peer.has_peer(data.orgPeer):
					print("got candidate: " + str(data.orgPeer) + ". my id is " + str(id))
					rtc_peer.get_peer(data.orgPeer).connection.add_ice_candidate(data.mid, round(data.index), data.sdp)
				
			if data.message == Messages.offer:
				if rtc_peer.has_peer(data.orgPeer):
					rtc_peer.get_peer(data.orgPeer).connection.set_remote_description("offer", data.data)
			
			if data.message == Messages.answer:
				if rtc_peer.has_peer(data.orgPeer):
					rtc_peer.get_peer(data.orgPeer).connection.set_remote_description("answer", data.data)

func connected(id):
	rtc_peer.create_mesh(id)
	multiplayer.multiplayer_peer = rtc_peer

func createPeer(id):
	if id != self.id:
		var peer : WebRTCPeerConnection = WebRTCPeerConnection.new()
		peer.initialize({
			"iceServers" : [{"urls" : ["stun:stun.l.google.com:19302"]}],
		})
		print("binding id " + str(id) + ". my id is " + str(self.id))
		
		peer.session_description_created.connect(self.offer_created.bind(id))
		peer.ice_candidate_created.connect(self.ice_candidate_created.bind(id))
		
		rtc_peer.add_peer(peer, id)
		
		if id < rtc_peer.get_unique_id():
			peer.create_offer()

func offer_created(type, data, id):
	if not rtc_peer.has_peer(id):
		print("return")
		return
	
	print("no return")
	rtc_peer.get_peer(id).connection.set_local_description(type, data)
	
	if type == "offer":
		send_offer(id, data)
	else:
		send_answer(id, data)

func send_offer(id, data):
	var message = {
		"peer" : id,
		"orgPeer" : self.id,
		"message" : Messages.offer,
		"data" : data,
		"lobby" : lobbyValue
	}
	peer.put_packet(JSON.stringify(message).to_utf8_buffer())

func send_answer(id, data):
	var message = {
		"peer" : id,
		"orgPeer" : self.id,
		"message" : Messages.answer,
		"data" : data,
		"lobby" : lobbyValue
	}
	peer.put_packet(JSON.stringify(message).to_utf8_buffer())

func ice_candidate_created(mid_name, index_name, sdp_name, id):
	var message = {
		"peer" : id,
		"orgPeer" : self.id,
		"message" : Messages.candidate,
		"mid" : mid_name,
		"index" : index_name,
		"sdp" : sdp_name,
		"lobby" : lobbyValue
	}
	peer.put_packet(JSON.stringify(message).to_utf8_buffer())	

func _on_join_lobby_pressed():
	var message = {
		"id" : id,
		"message" : Messages.lobby,
		"name" : "",
		"lobbyValue" : %TextEdit.text
	}
	peer.put_packet(JSON.stringify(message).to_utf8_buffer())
