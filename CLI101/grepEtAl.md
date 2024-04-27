Say, we want to ping some IP and only get the response time from it.

If we do 'ping 8.8.8.8' we'll get a lot more information than we actually want.

We can, of course, limit that output with grep and piping:

. ping -c 1 8.8.8.8 | grep 'bytes from'

We can also use a delimiter, with 'cut', and thus select exactly what we want to retrieve:

. ping -c 1 8.8.8.8 | grep 'bytes from' | cut -d = -f 4

This returns only the time part of our line, which is what we want to get

Why is this happening (man cut)?

- ping is doing a single ping request to 8.8.8.8, because we're using option c.
- grep is making sure we're restricting our stderr to a single line
- And cut is selecting '=' as the separator, not a blank space. So, the text is divided into 4 different parts, separated by equal signs. And we're requesting the fourth and last of those parts.

--snip--
