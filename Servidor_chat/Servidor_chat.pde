
import processing.net.*;

Server myServer;
String dataOut;
String dataIn;
String login;
String message ="Servidor:";
String messagesReceived[] = new String[9];


void setup() {
  
  size(900, 600);
  textSize(20);
  fill(255);
  background(0);
  
  myServer = new Server(this, 5204); 
  desenharMensagem();
}

void draw() {
  
  Client thisClient = myServer.available();
  if (thisClient !=null)
  {
    dataIn = thisClient.readString();
    if (dataIn != null) {
      mensagensRecebidas(dataIn);
      println(dataIn);
      myServer.write(dataIn);
  }
  }
}
void keyPressed(){
    if(key==ENTER||key==BACKSPACE){
      
      if(key==ENTER){
        dataOut = message;
        myServer.write(dataOut);
        message = "Servidor: ";
        println(dataOut);
        desenharMensagem();
        mensagensRecebidas(dataOut);
      }
      
      if(key==BACKSPACE){
        if (message.length()>0) {
          message=message.substring(0, message.length()-1);
          desenharMensagem();
        }
      }
    }
    else{
      if (key==CODED)
      { println("Coded");}
      else{
      message+=key;
      desenharMensagem();}
    }
}

void desenharMensagem(){
    background(0);
    fill(255);
    text(message,50,575);
    stroke(255);
    line (0,525,900,525);
    for (int i=0; i<messagesReceived.length; i++){
      if (messagesReceived[i] != null){
      text(messagesReceived[i],50,500-(i*50));
    }
  }
}

void serverEvent(Server someServer, Client someClient) {
  println("New Client");
}

void mensagensRecebidas(String mensagem){
 
  for (int i=9; i>0; i--){
    int x = i-1;
    if(messagesReceived[x] != null){
      messagesReceived[i] = messagesReceived[x];
  }
}
messagesReceived[0] = mensagem;
desenharMensagem();
}
  




/* MÉTODOS EXTRAS CLASSE SERVER:
  
 - disconnect()   se Desconecta de um cliente em especifico passado como parâmetro.
 - active()   Retorna true se o server ainda ta ativo(Serve pra testar).
 - available()   Returns the next client in line with a new message.
 - stop()   Desconecta todos os clients e para o funcionamento do server.
 - write()   Escreve dados para todos os clientes conectados
*/