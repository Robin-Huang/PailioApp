# PailioApp

## 開發環境
- Qt5.9.1

## 說明
此為 [appPailioRecogntion](https://github.com/Robin-Huang/appPailioRecogntion) 的更新版<br>
改用 Qml 設計的主要原因是 QtQuick 中的 QtMultimedia 支援 Android 手機的相機功能<br>

這個版本有兩個功能介面<br>
- Camera Menu (新加入)<br>
- Photo Gallery Menu<br>

Photo Gallery Menu 與 appPailioRecogntion 版本一樣是自己設計一個圖片瀏覽器介面，但解決了讀圖檔過慢的問題。<br>

-------------------------------------------
## 問題紀錄:
#### Q1. 圖片瀏覽器同時顯示4張相簿的圖片，但總是等全部的圖片讀取完才會一起顯示，這樣非常lag。<br>

A: 在Image item中有個asynchronous(異步)的功能，設定為true，圖片個別讀取完就會個別顯示，使用上會畫面會比較流暢。<br>
<pre><code>
Image{<br>
  // ...<br>
  asynchronous: true<br>
}<br>
</pre></code>

#### Q2. 直接讀原圖檔案非常大，導致讀圖的速度慢。<br>

A: 在 Image item 中有個 sourceSize 功能，可以限制載入圖片的尺寸。<br>
<pre><code>
Image{<br>
  // ...<br>
  sourceSize: QSize(width, height)<br>
}<br>
</pre></code>

#### Q3. 如何將 qml 與 c++ 結合<br>

A: 透過 signals 和 slots ，以下是範例

- cName.h<br>
<pre><code>
class cName : public QObject{
  //...
  signals:
    void send();
  public slots:
    void receive();
}
</pre></code>

- cName.cpp<br>
<pre><code>
cName::cName() : QObject(parent){
  //...
  emit send(); // c++端發出send()這個signal，呼叫qml
}
</pre></code>

- main.cpp<br>
<pre><code>
main(){
  //...
  QScopePointer<cName> name(new cName);
  //...
  engine.rootContext()->setContextProperty("name", name.data());
}
</pre></code>

- menu.qml<br>
<pre><code>
Item{
  Connections{
    target: name
    onSend: //c++端send()的呼叫
    {
      //透過send()呼叫後，欲執行的qml程式
    }
  }
  Button{
    onClicked: //按下Button後呼叫c++的函式
    {
      name.recieve(); //呼叫c++的receive()函式
    }
  }
}
</pre></code>
