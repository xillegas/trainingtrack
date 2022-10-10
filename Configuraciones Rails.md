# Configurar Rails mediante WSL
Esta es una guía rápida que menciona las cosas necesarias que deben estar para que todo funcione, no es infalible, en caso de que algo no aplique favor investigar las posibles soluciones. Este documento puede parecer más una especie de bitácora de instalación de RAILS en una laptop con Windows 11, espero que pueda servir de utilidad en el futuro.

## Instalar WSL 🐧
En Windows 11 funciona el siguiente comando.
> `wsl --install`

En otros sistemas recomiendo investigar cómo instalar el **Windows Subsystem for Linux (WSL 2)**

## Instalar Ubuntu en el WSL
Buscar directamente en la tienda Microsoft Store, la aplicación "Ubuntu" así mismo, sin más detalles en el nombre. Luego colocar un nombre de usuario y un password para el sistema.

En caso de alguna duda o problema consultar la correspondiente configuración de [Le Wagon](https://github.com/lewagon/setup/blob/master/windows.md), donde aparecen recomendaciones adicionales, como por ejemplo convertir el terminal de ubuntu en el terminal predeterminado de Windows, cosa que no hice porque no siempre usaré eso.

## Herramientas del terminal
Actualizar el Ubuntu:
> `code --install-extension rebornix.ruby`

Instalar los siguientes programas y extensiones:
> `sudo apt install -y curl git imagemagick jq unzip vim zsh`

### Instalar el CLI de Github
```bash
sudo apt remove -y gitsome # gh command can conflict with gitsome if already installed
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
sudo apt update
sudo apt install -y gh
```
Chequear con `gh --version`
### Oh my Zsh!
```bash
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```
## Navegador Predeterminado
Google Chrome por supuesto.
```bash
ls /mnt/c/Program\ Files\ \(x86\)/Google/Chrome/Application/chrome.exe
```
If you get an error like ls: cannot access... Run the following command

> ``echo "export BROWSER='\"/mnt/c/Program Files/Google/Chrome/Application/chrome.exe\"'" >> ~/.zshrc``

Else run:

> ```echo "export BROWSER='\"/mnt/c/Program Files (x86)/Google/Chrome/Application/chrome.exe\"'" >> ~/.zshrc```

Validamos si responde "Browser defined 👌":
> `[ -z "$BROWSER" ] && echo "ERROR: please define a BROWSER environment variable ⚠️" || echo "Browser defined 👌"`

Reiniciamos el terminal
> `exec zsh`

## Configurar el Github CLI
Esta parte es sencilla, correr:

```bash
  gh auth login -s 'user:email' -w
  ```
Se harán varias preguntas, el propósito es configurar github, que se sincronice la cuenta con la computadora, algo así como iniciar sesión y así poder gestionar repositorios que tengamos en github.

Esta configuración incluye todo el tema del protocolo **SSH**, el cual suele ser una ~~ladilla~~ cosa difícil de configurar. Lo recomendable (al menos esta vez) es usar este protocolo, generar nuevas llaves ssh y no poner ninguna passphrase.

Verificar que todo esté Ok ✅ con `gh auth status`

## Dotfiles (Standard configuration)
No se muy bien qué hace esta parte, si alguien desea saberlo puede consultarlo en [lewagon/dotfiles](https://github.com/lewagon/dotfiles) donde aparecen los detalles de esta configuración de *Le Wagon*, la hice porque creo probable que algo falle si no la realizo, alguna subrutina o shortcut de rails pueda faltar o qué se yo.

```bash
export GITHUB_USERNAME=`gh api user | jq -r '.login'`
echo $GITHUB_USERNAME
```

se debería ver el usuario de github, luego hacemos fork de la configuración

```bash
mkdir -p ~/code/$GITHUB_USERNAME && cd $_
gh repo fork lewagon/dotfiles --clone
```
iniciamos la instalación de los dotfiles

```bash
cd ~/code/$GITHUB_USERNAME/dotfiles
zsh install.sh
```
Vemos los emails registrados en github. Sobre esta parte recuerdo haber tenido que colocar en la configuración de Github, en la web, mi correo personal como principal y borrado el correo institucional de mi universidad. Aunque creo que esta parte tiene que ver con la sincronización de las actividades del bootcamp solamente.
```bash
gh api user/emails | jq -r '.[].email'
```
luego instalamos el git, esto nos pedirá nombre y correo, colocamos el principal de github.
```bash
 cd ~/code/$GITHUB_USERNAME/dotfiles && zsh git_setup.sh
```
reiniciamos la terminal

```bash
exec zsh
```

### Passphrase de SSH
En caso de usar passphrase abrir `code ~/.zshrc` y verificar que el agente ssh esté en este archivo
```
plugins=(gitfast last-working-dir common-aliases zsh-syntax-highlighting history-substring-search pyenv ssh-agent)
```

## Ruby 🔻
Primero instalamos rbenv para ello borramos cualquier version previa.
```bash
rvm implode && sudo rm -rf ~/.rvm
# If you got "zsh: command not found: rvm", carry on.
# It means `rvm` is not on your computer, that's what we want!
rm -rf ~/.rbenv
```
Luego instalamos rbenv
```bash
sudo apt install -y build-essential tklib zlib1g-dev libssl-dev libffi-dev libxml2 libxml2-dev libxslt1-dev libreadline-dev
```
```bash
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
```
```bash
git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
```
De nuevo, reiniciamos con: `exec zsh` e instalamos ruby
> `rbenv install 3.1.2`

> `rbenv global 3.1.2`

> `exec zsh`

Verificamos la versión
> `ruby -v`

Instalamos gemas 💎💎
> `gem install colored faker http pry-byebug rake rails rest-client rspec rubocop-performance sqlite3`

## Node.js
Según Le Wagon:
> *Node.js is a JavaScript runtime to execute JavaScript code in the terminal. Let's install it with nvm, a version manager for Node.js.*

```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | zsh
exec zsh
nvm -v
#instalar node
nvm install 16.15.1
node -v
nvm cache clear
```
## Yarn
Un administrador de paquetes de javascript
```bash
npm install --global yarn
exec zsh
yarn -v
```
## Base de datos
Sqlite o PostgreSQL
### Sqlite:
> `sudo apt-get install sqlite3 libsqlite3-dev`

> `sqlite3 -version`

### PostgreSQL
```bash
sudo apt install -y postgresql postgresql-contrib libpq-dev build-essential
sudo /etc/init.d/postgresql start
sudo -u postgres psql --command "CREATE ROLE \"`whoami`\" LOGIN createdb superuser;"
# Hacer que Postgre se inicie al abrir terminal
sudo echo "`whoami` ALL=NOPASSWD:/etc/init.d/postgresql start" | sudo tee /etc/sudoers.d/postgresql
sudo chmod 440 /etc/sudoers.d/postgresql
echo "sudo /etc/init.d/postgresql start" >> ~/.zshrc
```
## Configuración adicional
Ok, en el dolor de cabeza de instalar todo esto sufrí un colapso al ver que seguía fallando el `rails s`, los problemas que tuve fueron los siguientes

- Formato de endline CRLF y LF
- Sincronización con la Base de Datos
- Permisos de escritura y ejecución en el repositorio del proyecto (carpeta en Windows)
- Autoría de la carpeta y subcarpetas del proyecto

### Endline
Tuve el error siguiente:
```
env: ruby\r: No such file or directory
```
Esa \r era parte de un end of line de windows que en ubuntu no se lee así, para resolver hice lo siguiente
> `sudo apt install dos2unix`

> `git config --global core.autocrlf input`

> `find ./ -type f -exec dos2unix {} \;`

En la solución recomendaban borrar la carpeta node_modules con `rm -rf node_modules` pero eso no funcionaba, la borré en Windows y mucho después de solucionar otros problemas, lo importante es hacer `yarn install` luego de borrarse node_modules. [$^{1}$](https://stackoverflow.com/questions/29073826/env-ruby-r-no-such-file-or-directory)

### Base de datos
Lo recomendable es hacer que postgre siempre se inicialize al iniciar un nuevo terminal, así no hay que reiniciarlo a cada rato.

También estar atento al archivo database.yml, al final me funcionó así:
```yml
default: &default
  adapter: postgresql
  encoding: unicode
  # For details on connection pooling, see Rails configuration guide
  # https://guides.rubyonrails.org/configuring.html#database-pooling
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
  # host: db
  # username: postgres
  # password: password
  # pool: 5
```
Las últimas cuatro líneas recuerdo que fueron configuración para Docker, por eso están comentadas.

Por supuesto conviene recordar que hay que crear la base de datos con ``rails db:create`` y fue acá donde empezaron los problemas siguientes.

### Permisos de Escritura, ejecución y Autoria
Al parecer Ubuntu WSL no tenía permisos completos, hice varias cosas para que todo funcionara, el orden no lo recuerdo, trataré de explicar lo que hice y espero que pueda servirme de ayuda si llego a sufrir nuevamente.

#### El problema
> Rails Error: Unable to access log file. Please ensure that /home.../log/development.log exists and is chmod 0664

Este problema se refiere a que no puede escribir porque no tiene permisos de escritura, para conocer los permisos, de archivos y carpetas en un directorio usar:
```bash
ls -lha
```
Luego de varias investigaciones di con que el disco C:/ estaba montado sin permisos suficientes y recomendaban
```bash
sudo umount /mnt/c
```
```bash
sudo mount -t drvfs C: /mnt/c -o metadata,uid=1000,gid=1000,umask=22,fmask=111
```
Pero no fue suficiente, acá se me ocurrió un paño de agua tibia, borrar development.log y crearlo con ``touch development.log``, funcionó y rails s iniciaba.

Varios problemas de permisos me seguían sucediendo, en diferentes carpetas del proyecto, creo que ya funcionaba "rails db:create" y los siguientes comandos para base de datos, pero aunque funcionasen seguían ocurriendo errores de escritura en carpetas app y tmp, incluso después de correr "rails s" fallaban cosas, este era el cuento de nunca acabar.

Para hacer el cuento más corto al final usé dos comandos importantes había que correrlos, **chown** y **chmod**.

Chown es para cambiar la propiedad o dueño de la carpeta y chmod para cambiar los permisos, no recuerdo el orden en el que pude correrlos, todo esto fue sangre sudor y lágrimas, por el historial al parecer esto fue lo que sirvió

En la carpeta padre del proyecto:
> `chmod -R 777 ./trainingtrack`

El 777 se supone que es para dar todos los permisos. El flag -R tiene que ver con todas las subcarpetas, creo que usa un metodo de recursividad para recorrerlas y por eso la R.

Se que luego de correr eso, los errores cambiaron. Entonces hice esto (que no se si hizo algo)

> `chmod -R +w ~/.rbenv`

Luego en la carpeta del proyecto:
> `chmod -R +w ./tmp`

Y por último:
> `sudo chown -R xillegas tmp`

Todo funciona de maravillas 🌈🦄
