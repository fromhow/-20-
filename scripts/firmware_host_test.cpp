// Optional host-side logic test. NOT an Arduino build or a Wokwi test.
#include <cassert>
#include <sstream>
#include <iostream>
#include <string>
#include <iomanip>
const int A1=15,A2=16,INPUT=0,OUTPUT=1,LOW=0,HIGH=1;
int gas=100,pressure=512,pir=1,pins[32]={};
int analogRead(int p){return p==A1?gas:pressure;}
int digitalRead(int){return pir;}
void digitalWrite(int p,int v){pins[p]=v;}
void pinMode(int,int){}
void delay(unsigned long t){assert(t==5000);}
struct SerialMock {
 std::ostringstream out;
 void begin(int x){assert(x==9600);}
 template<class T> void print(T t){out<<t;}
 void print(float t,int precision){out<<std::fixed<<std::setprecision(precision)<<t;}
 template<class T> void println(T t){out<<t<<'\n';}
} Serial;
#include "../firmware/sketch.ino"
int main(){
 setup(); assert(pins[5]==HIGH&&pins[3]==LOW);
 gas=100;loop();assert(!alarm&&pins[5]==HIGH&&pins[3]==LOW);
 gas=300;loop();assert(alarm&&pins[5]==LOW&&pins[3]==HIGH);
 gas=400;loop();assert(alarm);
 gas=100;loop();assert(!alarm&&pins[5]==HIGH&&pins[3]==LOW);
 const std::string s=Serial.out.str();
 assert(s.find("EVENT n=2 type=THRESHOLD")!=std::string::npos);
 assert(s.find("EVENT n=4 type=NORMAL")!=std::string::npos);
 assert(s.find("EVENT n=3")==std::string::npos);
 assert(n==4);
 std::cout<<s;
}
