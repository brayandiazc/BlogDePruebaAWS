# Configuración Inicial en AWS: Usuario IAM

Antes de configurar **S3**, **EC2** y **RDS**, es crucial que creemos un **usuario IAM** (Identity and Access Management) específico para este proyecto.

## ¿Por qué necesitamos un usuario IAM?

Aunque podrías usar las credenciales de tu cuenta raíz de AWS, **no es una buena práctica de seguridad**. Un usuario IAM te permite:

- **Principio de mínimo privilegio:** Asignar solo los permisos necesarios para las tareas que realizará tu aplicación o tú al gestionarla.
- **Auditoría:** Rastrear fácilmente quién hizo qué en tu cuenta de AWS.
- **Seguridad:** Reducir el riesgo si las credenciales se ven comprometidas, ya que el acceso estará limitado.

### Pasos para Crear un Usuario IAM

Aquí te indico cómo crear el usuario IAM en la consola de AWS:

1. **Inicia sesión en la Consola de AWS:**

   - Ve a la consola de administración de AWS ([https://aws.amazon.com/console/](https://aws.amazon.com/console/)) e inicia sesión con tu cuenta raíz o un usuario con permisos administrativos.

2. **Navega a IAM:**

   - En la barra de búsqueda superior, escribe **"IAM"** y selecciona el servicio **"IAM"**.

3. **Crea un Nuevo Usuario:**

   - En el panel de navegación de la izquierda, haz clic en **"Users"** (Usuarios).
   - Haz clic en el botón azul **"Create user"** (Crear usuario).

4. **Define los Detalles del Usuario:**

   - **User name:** Ingresa un nombre para tu usuario, por ejemplo: `blogdeprueba-user`.
   - Selecciona la casilla **"Provide user access to the AWS Management Console"**.
     - **I want to create an IAM user**: Deja esta opción seleccionada.
     - **Console password:** Elige **"Custom password"** y crea una contraseña segura. Guárdala en un gestor de contraseñas.
     - **Users must create a new password at next sign-in**: Desmarca esta opción para simplificar la gestión por ahora.
   - Haz clic en **"Next"**.

5. **Configura los Permisos:**

   - En la sección **"Set permissions"**, selecciona **"Attach policies directly"**.
   - En el cuadro de búsqueda, busca y selecciona las siguientes políticas administradas por AWS:
     - `AmazonS3FullAccess`: Para configurar S3.
     - `AmazonEC2FullAccess`: Para configurar y gestionar la instancia EC2.
     - `AmazonRDSFullAccess`: Para configurar y gestionar la base de datos RDS.
   - Haz clic en **"Next"**.

6. **Revisa y Crea el Usuario:**
   - Revisa que el nombre de usuario y las políticas de permisos sean correctos.
   - Haz clic en el botón **"Create user"**.

## 7. ¡Paso Crítico! Generar y Guardar las Claves de Acceso

Una vez creado el usuario, serás devuelto a la lista de usuarios. Ahora necesitas generar las claves de acceso para el uso programático (por ejemplo, para la AWS CLI o un SDK).

1. **Selecciona el Usuario Creado:**

   - En la lista de usuarios de IAM, haz clic en el nombre del usuario que acabas de crear (ej. `blogdeprueba-user`).

2. **Ve a la Pestaña de Credenciales:**

   - Dentro del resumen del usuario, haz clic en la pestaña **"Security credentials"**.

3. **Genera las Claves de Acceso:**

   - Desplázate hacia abajo hasta la sección **"Access keys"**.
   - Haz clic en el botón **"Create access key"**.

4. **Define el Caso de Uso:**

   - AWS te preguntará para qué usarás la clave. Selecciona **"Command Line Interface (CLI)"**.
   - Marca la casilla de confirmación: "I understand the above recommendation and want to proceed to create an access key."
   - Haz clic en **"Next"**.

5. **Añade una Etiqueta (Opcional pero Recomendado):**
   - En "Description tag value", puedes escribir una nota para recordar para qué es esta clave, por ejemplo: `Clave para CLI en mi Mac`.
   - Haz clic en **"Create access key"**.

## 8. Recupera y Almacena tus Credenciales 🔑

Esta es tu **única oportunidad** para ver y guardar el `Secret Access Key`. Si cierras esta ventana sin guardarlo, tendrás que generar un nuevo par de claves.

En la pantalla final verás lo siguiente:

- **Access key ID:** Es público y funciona como un nombre de usuario. Lo verás directamente.
- **Secret access key:** Es confidencial y funciona como una contraseña. Debes hacer clic en **"Show"** para revelarlo.

### Acciones Inmediatas:

1. **Copia ambas claves:** Copia el **`Access Key ID`** y el **`Secret Access Key`**.
2. **Guárdalas de forma segura:** El lugar ideal es un **gestor de contraseñas** (como Bitwarden, 1Password, etc.).
3. **Descarga el archivo `.csv`:** Como respaldo, haz clic en el botón **"Download .csv file"**. Guarda este archivo en un lugar seguro y privado.

> **⚠️ Advertencia de Seguridad:** **NUNCA** guardes estas claves en tu código fuente, no las compartas públicamente ni las subas a un repositorio de Git. Si se filtran, cualquiera podría usar tu cuenta de AWS y generar costos.

### ¿Para qué usaremos estas claves?

Estas credenciales son la forma en que tu máquina se identificará de forma segura con AWS. Las necesitarás para:

- **Configurar la AWS CLI:** La herramienta de línea de comandos para gestionar tus servicios.
- **Usar los SDK de AWS:** Si tu aplicación (ej. en Node.js, Python, etc.) necesita interactuar con S3, lo hará usando estas claves.
