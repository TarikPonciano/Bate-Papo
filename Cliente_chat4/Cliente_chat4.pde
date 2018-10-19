
import processing.net.*; 


Client myClient;
String dataOut;
String dataIn;

String message= "O TAL DO CHORIS: ";
String inicial= "O TAL DO CHORIS: ";
String messagesReceived[] = new String[9];


 
void setup() { 
  
  size(900, 600); 
  textSize(20);
  fill(255);
  background(0);
  
  myClient = new Client(this, "127.0.0.1", 5204); 
  desenharMensagem();
  
} 
 
void draw() { 
  if (myClient.available() > 0) { 
    dataIn = myClient.readString(); 
    mensagensRecebidas(dataIn);
    println(dataIn);
  } 
  
  
} 

void keyPressed(){
    if(key==ENTER||key==BACKSPACE){
      
      if(key==ENTER){
        dataOut = message;
        myClient.write(dataOut);
        message = inicial;
        println(dataOut);
        desenharMensagem();
      }
      
      if(key==BACKSPACE){
        if (message.length()>0) {
          message=message.substring(0, message.length()-1);
          desenharMensagem();
        }
      }
    }
    else{
      if (key==CODED) {println("Coded");}
      
      else {
      message+=key;
      desenharMensagem(); 
    }
  }
}

void desenharMensagem(){
    background(0);
    fill(255);
    stroke(255);
    
    text(message,50,575);
    line (0,525,900,525);
    
    for (int i=0; i<messagesReceived.length; i++){
      if (messagesReceived[i] != null){
      text(messagesReceived[i],50,500-(i*50));
    }
  }
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
  

/*EXTRAS

  
stop()   Desconecta do servidor
active()   Retorna true se este cliente ainda estiver ativo
ip()   Retorna o endereço IP da máquina como uma string
available()   Retorna o número de bytes no buffer esperando para ser lido
clear()   Limpa o buffer
read()   Retorna um valor do buffer
...
write()   Escreve bytes, chars, ints, bytes[], Strings

*/