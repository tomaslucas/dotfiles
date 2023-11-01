# Pasos para una nueva configuración

1. El layout se puede cargar en la página:

https://config.qmk.fm/#/crkbd/rev1/LAYOUT_split_3x6_3

Si se tiene que adaptar algo se hace y se descarga el fichero json.

2. Se convierte el fichero json a keymap.c:
  Es requisito tener instalada la versión de qmk.

```shell
qmk json2c tlucas_personal.json -o keymap.c
```

3. Se compila la nueva versión para poder flashearla en el corne:
  Es requisito tener instalada la versión de qmk.

```shell
qmk compile -kb crkbd -km tlucas_personal
```

