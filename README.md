# PailioApp

## 開發環境
- Qt5.9.1

## 說明
此為[appPailioRecogntion](https://github.com/Robin-Huang/appPailioRecogntion)的更新版<br>
改用Qml設計的主要原因是QtQuick中的QtMultimedia支援Android手機的相機功能<br>

因此這個版本有兩個功能介面<br>
- Camera Menu<br>
- Photo Gallery Menu<br>

Photo Gallery Menu與appPailioRecogntion版本一樣是自己設計一個圖片瀏覽器介面，但解決了讀圖檔過慢的問題。<br>

-------------------------------------------
## 問題紀錄:
Q1. 圖片瀏覽器同時顯示4張相簿的圖片，但總是等全部的圖片讀取完才會一起顯示，這樣非常lag。<br>

A: 在Image item中有個asynchronous(異步)的功能，設定為true，圖片個別讀取完就會個別顯示，使用上會畫面會比較流暢。<br>

>Image{<br>
>>// ...<br>
>>asynchronous: true<br>
>}<br>

Q2. 直接讀原圖檔案非常大，導致讀圖的速度慢。<br>

A: 在Image item中有個sourceSize功能，可以限制載入圖片的尺寸。
