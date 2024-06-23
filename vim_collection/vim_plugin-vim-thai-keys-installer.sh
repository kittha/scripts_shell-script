#!/bin/bash

mkdir ~/.vim/
mkdir ~/.vim/plugin/

cat <<EOF >~/.vim/plugin/vim-thai-keys.vim

"Copyright (c) 2012, Chakrit Wichian.
"All rights reserved.

"Redistribution and use in source and binary forms, with or without modification, are
"permitted provided that the following conditions are met:

"Redistributions of source code must retain the above copyright notice, this list of
"conditions and the following disclaimer.  Redistributions in binary form must reproduce
"the above copyright notice, this list of conditions and the following disclaimer in the
"documentation and/or other materials provided with the distribution.  Neither the name of
"Chakrit Wichian, vim-thai-keys nor the names of its contributors may be used to endorse or
"promote products derived from this software without specific prior written permission.

"THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY
"EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
"MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
"COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
"EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
"SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
"HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR
"TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
"SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

"https://github.com/chakrit/vim-thai-keys/tree/master

" Assumes kedmanee key bindings, for now.
" Pull requests welcome for more mappings ; - )

" keys that are already mapped are the keys that Vim use by default (because
" they are available in English keyboard). So we shouldn't remap it to something
" else without user's acknowledgement
" ___________________________
"                KEY MAPPINGS
" :map \- \` " already mapped
:map ๅ 1
" :map / 2 " already mapped
" :map _ 3 " already mapped
:map ภ 4
:map ถ 5
:map ุ 6
:map ึ 7
:map ค 8
:map ต 9
:map จ 0
:map ข -
:map ช =

:map \% ~
" :map \+ ! " already mapped
:map ๑ @
:map ๒ #
:map ๓ $
:map ๔ %
:map ู ^
:map ฿ &
:map ๕ *
:map ๖ \(
:map ๗ \)
:map ๘ _
:map ๙ +

:map ๆ q
:map ไ w
:map ำ e
:map พ r
:map ะ t
:map ั y
:map ี u
:map ร i
:map น o
:map ย p
:map บ [
:map ล ]
:map ฟ a
:map ห s
:map ก d
:map ด f
:map เ g
:map เเ gg
:map ้ h
:map ่ j
:map า k
:map ส l
:map ว ;
:map ง '
:map ผ z
:map ป x
:map แ c
:map อ v
:map ิ b
:map ื n
:map ท m
:map ม ,
:map ใ .
:map ฝ /

:map ๐ Q
" :map \" W "key already mapped
:map ฎ E
:map ฑ R
:map ธ T
:map ํ Y
:map ๊ U
:map ณ I
:map ฯ O
:map ญ P
:map ฐ \{
":map , \}
" :map ฅ | " no mapping found
:map ฤ A
:map ฆ S
:map ฏ D
:map โ F
:map ฌ G
:map ็ H
:map ๋ J
:map ษ K
:map ศ L
:map ซ :
" :map \. \" " key already mapped
" :map \( Z " key already mapped
" :map \) X " key already mapped
:map ฉ C
:map ฮ V
:map ฺ B
:map ์ N
" :map ? M " key already mapped
:map ฒ <
:map ฬ >
:map ฦ ?

" Scrolling relative to cursor
" For help, type :help scroll-cursor
:map ผผ zz
:map ผะ zt
:map ผิ zb

" Window commands ( CTRL-W )
" For help, type :help ^w
" Some commands can be invoked by holding Ctrl key extensively
" e.g. <c-w>v is the same as <c-w><c-v>
" so including them here is unnecessary but is possible
:map <c-w>แ <c-w>c
EOF
