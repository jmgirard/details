# Details Extension For Quarto

_TODO_: Add a short description of your extension.

## Installing

```bash
quarto add jmgirard/details
```

This will install the extension under the `_extensions` subdirectory.
If you're using version control, you will want to check in this directory.

## Using

`{{{< dtext "This is the collapsed text." >}}}`

`{{{< dtext "This is the collapsed text." summary="Hint" >}}}`

````md
{{{< dopen summary="Answer Key" >}}}

**Here is some markdown**

```{{r}}
# And here is an R code chunk
plot(iris$Sepal.Length, iris$Sepal.Width)
```

{{{< dclose >}}}
````

## Example

Here is a demo for the details extension: [index.html](https://jmgirard.github.io/honeypot).
