Simplified Enigma
-----------------

This script is a simple implementation of Enigma Encryption

Here is how it works starting with input "AAA"

First apply a Caesar shift using an incrementing number, if starting number is 4, then we have:

A + 4         = E
A + 4 + 1     = F
A + 4 + 1 + 1 = G

So our output will be "EFG"

Now EFG is passed through first ROTOR such as "ABCDEFGHIJKLMNOPQRSTUVWXYZ" --> "BDFHJLCPRTXVZNYEIWGAKMUSQO" and become "JLC".

Then "JLC" is passed through 2 more rotors to get final value.

"AJDKSIRUXBLHWTMCQGZNPYFVOE" "JLC" becomes "BHD".
"EKMFLGDQVZNTOWYHXUSPAIBRCJ" "BHD" becomes "KQF".

So "AAA" through enigma encryption will output "KQF"

Source : https://www.codingame.com/training/easy/encryptiondecryption-of-enigma-machine
