name=foo.txt
case "$name" in
*.log)
echo log
;;
foo.txt|bar.txt)
echo hit
;;
*)
echo other
;;
esac
case z in
foo)
echo no
;;
esac
echo after