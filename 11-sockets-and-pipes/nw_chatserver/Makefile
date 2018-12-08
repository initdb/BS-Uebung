all: nw_chat_server nw_chat_client

nw_chat_server: nw_chat_server.c
	gcc -o nw_chat_server -pthread nw_chat_server.c

nw_chat_client: nw_chat_client.c
	gcc -o nw_chat_client -pthread nw_chat_client.c

#pipes_chat_server: pipes_chat_server.c
#	gcc -o pipes_chat_server -pthread pipes_chat_server.c

#pipes_chat_client: pipes_chat_client.c
#	gcc -o pipes_chat_client -pthread pipes_chat_client.c


