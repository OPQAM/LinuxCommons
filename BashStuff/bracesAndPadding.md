As we know, we can create multiple files with {}:

. touch file{1..100}.md

This creates 100 files, from file1.md to file 100.md.

But we might not really want to have this kind of file setting. Think, for example, that this will be a problem when trying to get a list of files numerically ordered.

In order to do that we need to pad this list with zeros. And one is all we need:

. touch file{01..1000}.md

This will always pad zeros to the left of our significant value.

But we can also set intervals.
Imagine we want only to set up every second value or third value:

. touch file{01..100..2}.md

So, we're padding values with 0, we're going up to file100.md and we're moving 2 numbers at a time. So, file001.md, file003.md, etc.

Without writing to disk, we can check this with echo:

. echo {1..10..3}

As an example.

We can also use letters, remembering that the capital letters come before the lower case letters:

. echo {A..z..2}

Experiment:

. touch file_{red,blue,green}_{01..100}_{a..z}.md

An alternative idea is to introduce dates. We can do that as well, and it might be useful, of course:

. touch logfile{01..100}_\($(date +%Y-%m-%d_%Hh%Mm%Ss)\).md

As an example, of course.

