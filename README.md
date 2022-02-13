# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ... run instructions
  * docker-compose up
  * application apis
    * http://localhost:3000/applications/ 
    * http://localhost:3000/applications/1?id=&application_token= ->for update & view
    * http://localhost:3000/applications?application_token=  -> for listing 
  * chat application apis
    * http://localhost:3000/applications/{application_id}/application_chats?token={application_identifier_token} -> for list
    * http://localhost:3000/applications/{application_id}/application_chats?token={application_identifier_token} -> for create
    * http://localhost:3000/applications/{application_id}/application_chats/{chat_id}?id={chat_id}&token={application_identifier_token} -> for both update & view
  * chat messages api
    * http://localhost:3000/applications/{application_id}/application_chats/{chat_id}/chat_messages?number={chat_identifier_number}&token=492icFm4xZClug -> for creating message
    * http://localhost:3000/applications/{application_id}/application_chats/{chat_id}/chat_messages?number={chat_identifier_number}&token=492icFm4xZClug -> for listing message
    * http://localhost:3000/applications/{application_id}/application_chats/{chat_id}/chat_messages/1?id={message_id}&number={chat_identifier_number}&token=492icFm4xZClug -> for update or view message
  * search api
    * http://localhost:3000/applications/{application_id}/application_chats/{chat_id}/chat_messages/search?token={application_token}&number={chat_number}&body={seachQuery} 
  
  * if you have a problem with elasticsearch please run the command 
    * sudo sysctl -w vm.max_map_count=262144
  * if sneaker don't begin you should run this command
    * sudo docker-compose exec application rake sneakers:run --trace
  * if you have a problem with starting redis
    * sudo sysctl vm.overcommit_memory=1