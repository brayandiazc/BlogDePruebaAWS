# Configuración del Servidor EC2 para BlogDePruebaAWS

Este documento detalla los pasos necesarios para configurar una instancia de Amazon EC2 con las dependencias fundamentales para desplegar una aplicación Ruby on Rails 8, incluyendo la gestión de contraseñas, dependencias de PostgreSQL y la instalación de Ruby on Rails.

## 1. Conexión a la Instancia y Configuración de Contraseña `sudo`

Una vez que tu instancia EC2 esté en estado `running` y puedas conectarte vía SSH con tu archivo `.pem`, el primer paso es asegurar el acceso `sudo`.

1. **Conéctate a tu instancia EC2** usando tu cliente SSH (terminal de Linux/macOS o PuTTY en Windows):

   ```bash
   ssh -i /ruta/a/tu/clave/blogdepruebaaws-key.pem ubuntu@TU_DIRECCION_IP_PUBLICA_EC2
   ```

   _Reemplaza `/ruta/a/tu/clave/blogdepruebaaws-key.pem` con la ubicación real de tu archivo `.pem` y `TU_DIRECCION_IP_PUBLICA_EC2` con la IP pública de tu instancia._

2. **Establece una contraseña para tu usuario `ubuntu`**. Esto es crucial, ya que algunas configuraciones de AMI de EC2 pueden requerir una contraseña para usar `sudo` a pesar de iniciar sesión con una clave SSH.

   ```bash
   sudo passwd ubuntu
   ```

   - Si te pide una "Current password", y no has establecido una antes, **simplemente presiona `Enter`**.
   - Luego, te pedirá que ingreses tu **nueva contraseña** dos veces. Elige una contraseña segura y recuérdala bien.

3. **Verifica el acceso `sudo`** con la contraseña recién configurada:

   ```bash
   sudo echo "Acceso sudo verificado correctamente."
   ```

   - Cuando te pida `[sudo] password for ubuntu:`, **ingresa la contraseña que acabas de configurar** y presiona `Enter`.
   - Si ves el mensaje "Acceso sudo verificado correctamente.", estás listo para continuar.

## 2. Actualización del Sistema y Librerías Esenciales

Mantener el sistema actualizado y con las librerías base necesarias es fundamental antes de instalar software específico.

1. **Actualiza los paquetes del sistema operativo:**

   ```bash
   sudo apt update && sudo apt upgrade -y && sudo apt full-upgrade -y
   ```

   _Este comando actualiza la lista de paquetes disponibles, luego actualiza los paquetes instalados y, finalmente, realiza una actualización completa del sistema para manejar cambios de dependencias._

2. **Instala librerías cliente de PostgreSQL:**
   Aunque usaremos Amazon RDS como el servidor de base de datos, tu instancia EC2 necesitará las librerías cliente para que tu aplicación Rails se conecte a PostgreSQL.

   ```bash
   sudo apt install libpq-dev -y
   ```

   _Este paquete instala las cabeceras y librerías necesarias para compilar aplicaciones que se conectan a PostgreSQL._

## 3. Instalación de Ruby y Rails

Utilizaremos `rbenv` para gestionar las versiones de Ruby y luego instalaremos Ruby on Rails.

1. **Clona el repositorio de scripts de configuración:**
   Estos scripts contienen la automatización para instalar Ruby y otras herramientas.

   ```bash
   git clone https://github.com/brayandiazc/dev-setup-ubuntu-es.git
   ```

2. **Navega al directorio de los scripts:**

   ```bash
   cd dev-setup-ubuntu-es
   ```

3. **Otorga permisos de ejecución a los scripts:**

   ```bash
   chmod +x scripts/*.sh
   ```

4. **Ejecuta el script de instalación de Ruby (`06-instalar-ruby.sh`):**
   Este script instalará `rbenv`, `ruby-build` y la versión de Ruby que elijas (o la última estable por defecto).

   ```bash
   ./scripts/06-instalar-ruby.sh
   ```

   - **Recuerda:** Te pedirá la contraseña `sudo` al inicio.
   - Cuando el script pregunte `¿Qué versión de Ruby deseas instalar?:`, **presiona `Enter`** para instalar la última versión estable (Rails 8 requiere Ruby 3.1.0 o superior, así que la última estable será ideal).
   - El script se tomará un tiempo para compilar Ruby. Al finalizar, tu sesión SSH se recargará automáticamente.

5. **Verifica la instalación de Ruby y Bundler:**
   Después de que el script termine y tu terminal se recargue:

   ```bash
   ruby -v
   # Debería mostrar algo como: ruby 3.3.0 (2024-04-23 revision ...)

   bundler -v
   # Debería mostrar la versión de Bundler instalada
   ```

6. **Instala Ruby on Rails:**
   Finalmente, instala la gema de Rails globalmente usando Bundler (que ya fue instalado por el script de Ruby). Para Rails 8, asegúrate de instalar la versión más reciente.

   ```bash
   gem install rails
   ```

7. **Verifica la instalación de Rails:**

   ```bash
   rails -v
   # Debería mostrar algo como: Rails 8.0.0
   ```
