# Configuración de Amazon RDS para PostgreSQL

Aquí te guiaré paso a paso para crear tu instancia de base de datos PostgreSQL en RDS.

## 1. Iniciar el Proceso de Creación de Instancias de RDS

1. **Inicia sesión en la Consola de AWS** con tu usuario IAM (o tu usuario raíz si sigues usando ese).
2. En la barra de búsqueda, escribe **"RDS"** y selecciona el servicio.
3. En el panel de navegación izquierdo, haz clic en **"Databases"** (Bases de datos).
4. Haz clic en el botón naranja **"Create database"** (Crear base de datos).

## 2. Configurar los Detalles de la Base de Datos

Vamos a elegir las opciones que mejor se adapten a nuestro proyecto de práctica.

- **Choose a database creation method:**

  - Selecciona **"Standard Create"**. Esto te da más control sobre las opciones.

- **Engine options:**

  - **Engine type:** Selecciona **"PostgreSQL"**.
  - **Engine version:** Elige la última versión estable compatible con Rails 8, por ejemplo, **`PostgreSQL 16.x`** o la versión más reciente disponible que te ofrezca la consola.

- **Templates:**

  - Para este proyecto de práctica, selecciona **"Free tier"**. Esto asegurará que te mantengas dentro de los límites del nivel gratuito de AWS si tu cuenta es nueva.

- **Settings:**

  - **DB instance identifier:** Dale un nombre único a tu instancia de base de datos, por ejemplo: `blogdepruebaaws-db`.
  - **Master username:** Introduce un nombre de usuario para tu base de datos. Por ejemplo: `postgres`.
  - **Master password:** Introduce una **contraseña segura y compleja** para tu usuario `postgres`, por ejemplo `postgres-p455w0rd` **¡Guarda esta contraseña en un lugar muy seguro!** La necesitarás para configurar tu aplicación Rails.
  - **Confirm password:** Vuelve a escribir la contraseña.

- **DB instance size:**

  - Para el nivel gratuito, verás opciones como **`db.t2.micro`** o **`db.t3.micro`**. Selecciona la que esté disponible en el nivel gratuito.

- **Storage:**

  - **Storage type:** Deja **"General Purpose (SSD)"** (gp2 o gp3).
  - **Allocated storage:** Para el nivel gratuito, es probable que la opción predeterminada sea **20 GiB**. Esto es suficiente para tu proyecto.
  - **Enable storage autoscaling:** Puedes desmarcarlo para mantener los costos bajo control en un proyecto de práctica, pero para un entorno real, es útil activarlo.

- **Connectivity:**

  - **VPC:** Deja la **VPC predeterminada** de tu cuenta (es la más común para iniciar).
  - **Subnet group:** Deja el grupo de subredes predeterminado.
  - **Public access:** Selecciona **"Yes"**. Esto es **crucial** para que tu instancia EC2 (y tú, desde tu máquina local para pruebas si lo deseas) pueda conectarse a la base de datos de RDS.
  - **VPC security group (firewall):**
    - Selecciona **"Create new"**.
    - **New VPC security group name:** `blogdepruebaaws-rds-sg`.
    - **Inbound rules (reglas de entrada):**
      - Por defecto, RDS creará una regla para permitir el tráfico PostgreSQL (puerto 5432).
      - Es **altamente recomendable** restringir el acceso a tu IP de EC2 o al grupo de seguridad de tu EC2. Por ahora, para simplificar y si estás en un entorno de práctica, puedes dejar que añada tu IP actual. Sin embargo, lo **ideal** es que en el grupo de seguridad del RDS, permitas el tráfico desde el **Grupo de Seguridad de tu instancia EC2** (el que creaste para EC2, por ejemplo, `blogdepruebaaws-sg`).
        - Si puedes, borra la regla de "My IP" si se crea y añade una nueva regla:
          - **Type:** `PostgreSQL` (Puerto 5432)
          - **Source:** Selecciona el grupo de seguridad de tu EC2. Busca el nombre (`blogdepruebaaws-sg`) o el ID del Security Group que creaste para tu instancia EC2. Esto es lo más seguro y recomendado para permitir la comunicación solo entre tu EC2 y RDS.

- **Database authentication:**

  - Deja **"Password authentication"**.

- **Additional configuration:**

  - **Initial database name:** Puedes dejarlo en blanco o darle un nombre a tu base de datos principal, por ejemplo: `blogdeprueba_production`.

- **Backup:**

  - **Backup retention period:** Puedes dejarlo en `7 days` o reducirlo si quieres ahorrar un poco de espacio en el nivel gratuito.

- **Monitoring:**

  - Deja las opciones por defecto.

- **Log exports:**

  - Deja las opciones por defecto.

- **Maintenance:**

  - Deja las opciones por defecto.

- **Deletion protection:**
  - Para un proyecto de práctica, te recomiendo **desactivar "Enable deletion protection"** (Desactivar protección de eliminación). Esto te permitirá eliminar la instancia de RDS fácilmente cuando termines para evitar cargos inesperados. Para un entorno de producción, ¡siempre actívala!

## 3. Crear la Base de Datos

1. Revisa todos los detalles de configuración en el resumen lateral.
2. Haz clic en **"Create database"**.

La creación de la instancia de RDS puede tardar varios minutos (10-20 minutos). Verás el estado como `creating` y luego `available`.

## 4. Obtener el Endpoint de RDS

Una vez que tu instancia de RDS esté en estado **`available`**:

1. En la lista de bases de datos, haz clic en el **nombre de tu nueva instancia de RDS** (`blogdepruebaaws-db`).
2. En la sección **"Connectivity & security"**, busca el **"Endpoint"** (punto final). Será una URL como `blogdepruebaaws-db.xxxxxxxxx.us-east-1.rds.amazonaws.com`.
3. **Copia este Endpoint.** Esta será la dirección del servidor de tu base de datos para tu aplicación Rails.
