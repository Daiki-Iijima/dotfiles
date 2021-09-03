#InstallKeybdHook 
#UseHook

;; Alt + j i l k ＝ ←↑→↓
!h::Send,{Left}
!j::Send,{Down}
!k::Send,{Up}
!l::Send,{Right}

;; Ctrl + m = Ennter
^m::Send,{Enter}

;; Ctrl + h = バックスペース
^h::Send,{Backspace}

;; Ctrl + f = 右矢印 Ctrl + b = 左矢印
^f::Send,{Right}
^b::Send,{Left}

;; ~をつけるとキー入力を残したままコマンドを追加できる
;; Ctrl + cでIMEを切る
~Esc::Send,{vk1Dsc07B}
~^c::Send,{vk1Dsc07B}