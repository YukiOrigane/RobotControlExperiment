# RobotControlExperiment
## 基本的な実行方法
#### GUIを利用する場合
1. 本リポジトリをクローン，またはzipファイルでダウンロードして展開する．
2. MATLAB R2020a以降がインストールされたPCで，RobotControlExperimentフォルダ直下の"el_ctrl.mlapp"または"el_ctrl_PID_mlapp"をダブルクリックして実行する．

#### GUIを利用しない場合
1. 本リポジトリをクローン，またはzipファイルでダウンロードして展開する．
2. MATLAB R2020a以降がインストールされたPCで，"simulation.m"を開く．
3. MATLABのエディタータブより実行する．
4. フィールドを変更する場合は"simulation.m"の10行目付近```"field_id = '07';```の部分の番号を，fieldsフォルダ内に存在するフィールド番号に書き換える．
5. ロボットの初期位置を変更する場合は"robot.m"の2行目付近```init_state = [200; 500; 0]; % ロボットの初期状態 [ posx; posy; theta ];```の値を変更する

## 変更点

### トラック，8の字を追加
それぞれidは15と16です

### simulation.mを関数化
#### 定義
```MATLAB
function simulation(field_id, controller_func, control_param)
```
- field_id (char配列)<br>
フィールド番号です．今まで通り．
- controller_func (関数ポインタ)<br>
コントローラとして使う関数のポインタ．後述
- control_param (1*2 double配列)<br>
制御パラメータ
  - control_param[1] : 並進速度
  - control_param[2] : 回転ゲイン
#### 記述例
```MATLAB
simulation('01',@controllers.BANBAN_control, [0.5 0.1])
```
#### 参考
一応，今までと同様にも使えるはず

### サンプルコントローラの整備
+controllersフォルダ以下に入っている．
- FF_control<br>
直進成分のみが入っている．シミュレータの初期コントローラと一緒
- BANBAN_controller<br>
バンバン制御
- P_controller<br>
P制御
