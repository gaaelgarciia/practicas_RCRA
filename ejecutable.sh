#!/bin/bash


python3 decode.py yinyangKB.lp dom01.lp sol01.txt
python3 decode.py yinyangKB.lp dom02.lp sol02.txt
python3 decode.py yinyangKB.lp dom03.lp sol03.txt
python3 decode.py yinyangKB.lp dom04.lp sol04.txt
python3 decode.py yinyangKB.lp dom05.lp sol05.txt
python3 decode.py yinyangKB.lp dom06.lp sol06.txt
python3 decode.py yinyangKB.lp dom07.lp sol07.txt
python3 decode.py yinyangKB.lp dom08.lp sol08.txt
python3 decode.py yinyangKB.lp dom09.lp sol09.txt
python3 decode.py yinyangKB.lp dom10.lp sol10.txt
python3 decode.py yinyangKB.lp dom11.lp sol11.txt

echo "Comparing files..."

diff sol01.txt examples/examples/sol01.txt
diff sol02.txt examples/examples/sol02.txt
diff sol03.txt examples/examples/sol03.txt
diff sol04.txt examples/examples/sol04.txt
diff sol05.txt examples/examples/sol05.txt
diff sol06.txt examples/examples/sol06.txt
diff sol07.txt examples/examples/sol07.txt
diff sol08.txt examples/examples/sol08.txt
diff sol09.txt examples/examples/sol09.txt
diff sol10.txt examples/examples/sol10.txt
diff sol11.txt examples/examples/sol11.txt