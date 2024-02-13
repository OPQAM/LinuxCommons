There is a default register, used when we delete, change or yank text.

Default register - ""
'a' register - "a
'b' register - "b
...

"ay$ - assign to register a the yanked text to the end of the line (copy)
"bd$ - assign to register b the deleted text to the end of the line (cut)
"zc$ - assign to register c the changed text to the end of the line (cut)
"ap - paste the contents of register a

deleted text gets pushed down a historical register stack
We can check that historical register stack, which goes from "1 to "9
with:

:registers - See the currently stored registers (we ca also use :reg)
