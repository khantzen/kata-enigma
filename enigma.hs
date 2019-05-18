import Test.Hspec
import Data.Char

type Letter  = Char
type Order   = Int
type Message = String
type Rotor   = String


enigma_encode :: Message -> Order -> [Rotor] -> Message
enigma_encode message n rotors  = transpose (inc_caesar message n) rotors
    where
        transpose :: Message -> [Rotor] -> Message
        transpose message []        = message
        transpose message rotor_arr = transpose (rotor_transpose message (head rotor_arr))  (tail rotor_arr)

inc_caesar :: Message -> Order -> Message
inc_caesar "" _           = ""
inc_caesar message order  =  [caesar (head message) order] ++ inc_caesar (tail message) (order + 1)

caesar :: Letter -> Order -> Letter
caesar ' '    _      = ' '
caesar letter order  = chr ((alphabet_position letter + order) `mod` (26) + ord 'A')

rotor_transpose :: Message -> Rotor -> Message
rotor_transpose "" _          = ""
rotor_transpose message rotor = [ transpose ( head message ) ] ++ rotor_transpose (tail message) rotor
    where
        transpose ::  Letter -> Letter
        transpose ' '    = ' '
        transpose letter = rotor!!alphabet_position(letter)


alphabet_position :: Letter -> Int
alphabet_position letter = ord(letter) - ord 'A'


main = hspec $ do

    describe "Classical Caesar Cypher" $ do
        it "Cesar on a letter should be transposed" $ do
            caesar 'A' 5 `shouldBe` 'F'
            caesar 'B' 3 `shouldBe` 'E'

        it "Caesar on a letter at the edge of the world" $do
            caesar 'Y' 7   `shouldBe` 'F'
            caesar 'A' 752 `shouldBe` 'Y'

        it "Caesar on a space should return a space" $do
            caesar ' ' 548 `shouldBe` ' '

    describe "Incremental Caesar Cypher" $ do
        it "Incremental Caesar on a string should transpose" $ do
            inc_caesar "ABC" 1 `shouldBe` "BDF"
            inc_caesar "DEF" 2 `shouldBe` "FHJ"

        it "Incremental Caesar on HELLO WORLD" $ do
            inc_caesar "HELLO WORLD" 2 `shouldBe` "JHPQU EXBWP"

    describe "Rotor transposition" $ do
        it "Identity rotor transposition" $ do
            rotor_transpose "ABCD" "ABCDEFGHIJKLMNOPQRSTUVWXYZ" `shouldBe` "ABCD"

        it "Message should be transposed using rotor" $ do
            rotor_transpose "ABCD" "ZJLXOATWVSYHIBCDPFMKQNURGE" `shouldBe` "ZJLX"
            rotor_transpose "XYZA" "ZJLXOATWVSYHIBCDPFMKQNURGE" `shouldBe` "RGEZ"

        it "Message containing space should be transposed using rotor" $ do
            rotor_transpose "AB CD" "ENQVRFWIUOZJCADTGXPKHMYLSB" `shouldBe` "EN QV"

    describe "Enigma" $ do
        it "Enigme should encode specific message" $ do
            rotor_transpose "JHPQU EXBWP" "FSBGODPZMNUIXWCYREJTHLQVAK" `shouldBe` "NZYRH OVSQY"
            rotor_transpose "NZYRH OVSQY" "NWFZKYCIBQRXGSVAHEOTJUPMDL" `shouldBe` "SLDEI VUOHD"
            rotor_transpose "SLDEI VUOHD" "ENQVRFWIUOZJCADTGXPKHMYLSB" `shouldBe` "PJVRU MHDIV"

            enigma_encode "HELLO WORLD" 2 ["FSBGODPZMNUIXWCYREJTHLQVAK", "NWFZKYCIBQRXGSVAHEOTJUPMDL", "ENQVRFWIUOZJCADTGXPKHMYLSB"]
             `shouldBe`  "PJVRU MHDIV"

