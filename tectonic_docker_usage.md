¡La prueba de `tectonic` en Docker fue exitosa!

El comando `docker exec tectonic-container poetry run tectonic -c /app/tectonic.ini -p /app/.ssh/id_rsa.pub /app/examples/password_cracking.yml list` se ejecutó correctamente y produjo el siguiente resultado:

```
Getting Cyber Range status...
┌─────────────────────────────────────────────┬────┬───────────┐
│                     Name                    │ IP │   Status  │
├─────────────────────────────────────────────┼────┼───────────┤
│ monstersinc-passwordcracking2024-1-attacker │ -  │ NOT FOUND │
│  monstersinc-passwordcracking2024-1-victim  │ -  │ NOT FOUND │
└─────────────────────────────────────────────┴────┴───────────┘
```

Esto confirma que:
1.  **La configuración de Docker es correcta**: El contenedor se construye, se ejecuta y mantiene vivo como se espera.
2.  **El CLI de `tectonic` funciona correctamente**: La aplicación Python se ejecuta dentro del contenedor, lee los archivos de configuración y procesa los comandos.
3.  **Los requisitos de configuración de `tectonic` se satisfacen**: Los archivos de configuración (`tectonic.ini`) y la clave pública SSH se están utilizando correctamente.
4.  **El estado "NOT FOUND" es normal**: Este mensaje indica que el laboratorio `password_cracking.yml` aún no ha sido desplegado, lo cual es el comportamiento esperado para un laboratorio recién inicializado.

**Cómo puedes usar `tectonic` en el contenedor de Docker:**

1.  **Iniciar el contenedor**:
    Si no está corriendo, inicia el contenedor en segundo plano con:
    ```bash
    docker run -d --name tectonic-container \
      -v "$(pwd)":/app \
      -v /var/run/docker.sock:/var/run/docker.sock \
      tectonic-app
    ```
    (Nota: Se asumirá que tienes un par de claves SSH en `./.ssh/id_rsa.pub` en tu máquina anfitriona, ya que `tectonic` requiere una).

2.  **Ejecutar comandos `tectonic`**:
    Para ejecutar cualquier comando de `tectonic` (por ejemplo, `list`, `deploy`, `destroy`), utiliza `docker exec`. Asegúrate de proporcionar el archivo de configuración (`-c /app/tectonic.ini`) y la ruta a tu clave pública SSH (`-p /app/.ssh/id_rsa.pub`), así como el archivo de edición del laboratorio:
    ```bash
    docker exec tectonic-container poetry run tectonic -c /app/tectonic.ini -p /app/.ssh/id_rsa.pub /app/examples/password_cracking.yml <TU_COMANDO_AQUI>
    ```
    Por ejemplo, para ver la ayuda general:
    ```bash
    docker exec tectonic-container poetry run tectonic --help
    ```

3.  **Detener y eliminar el contenedor** (cuando hayas terminado):
    Cuando termines de usar el contenedor, puedes detenerlo y eliminarlo con los siguientes comandos:
    ```bash
    docker stop tectonic-container
    docker rm tectonic-container
    ```

Espero que esta configuración te sea útil para tus pruebas.
