Just a quick reminder on redirection.

Say I create a file a which has only 600 permissions and was created by root.
Then I create a file b, which is owned by my current user.

I then create a folder, which is also owned by my current user.

I then do:

cp -v * ./folder/ 1> success.txt 2> failure.txt 

So, basically, I'm trying to copy all my files into my folder and, of course, I won't be able to copy a while being able to do so for file b.
Since I'm using -v (verbose) I will get a report on my actions, but since I'm redirecting the stdout and the stderr to, respectively, success.txt and failure.txt, those files will be created and my 'reports' will be written there.

Here's the printed result of this test (I've deleted the original files, but they're easily recreated as a simple exercise):

$ ll -la

total 20
drwxr-xr-x  3 opqam opqam 4096 Apr 26 18:26 ./
drwxr-xr-x 20 root  root  4096 Apr 26 18:28 ../
-rw-------  1 root  root     0 Apr 26 18:14 a
-rw-r--r--  1 opqam opqam    0 Apr 26 18:14 b
-rw-r--r--  1 opqam opqam  101 Apr 26 18:26 failure.txt
drwxr-xr-x  2 opqam opqam 4096 Apr 26 18:26 folder/
-rw-r--r--  1 opqam opqam   40 Apr 26 18:26 success.txt

$ cat success.txt 

'a' -> './folder/a'
'b' -> './folder/b'

$ cat failure.txt 

cp: cannot open 'a' for reading: Permission denied
cp: -r not specified; omitting directory 'folder'

Remember, of course, to give your user full ownership of the folder where you're doing this. Otherwise issues will arise (as an aexercise: which issues?)

Remember, as well, that we can have all output redirected to the same file, with '&>'.


--snip--
