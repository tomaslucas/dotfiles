# Readme

Una vez descargado el repositorio crear los enlaces simbólicos necesarios, ejemplo:

```shell
ln -nfs /Users/xxxx/dotfiles/helix /Users/xxxx/.config/helix
```

Significado de los flags utilizados con `ln`:

-f    If the target file already exists, then unlink it so that the link may occur.  (The -f option overrides any previous -i and -w options.)

-h    If the target_file or target_dir is a symbolic link, do not follow it.  This is most useful with the -f option, to replace a symlink which
           may point to a directory.

-n    Same as -h, for compatibility with other ln implementations.

-s    Create a symbolic link.
