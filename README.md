# Lavalink en Railway — Con soporte YouTube

## Imagen Docker a usar en Railway

```
ghcr.io/lavalink-devs/lavalink:latest
```

## Pasos para configurar en Railway

### 1. Crear nuevo servicio en Railway
- Ve a [railway.app](https://railway.app)
- Crea un nuevo proyecto o abre el existente
- Agrega un nuevo servicio → **Deploy from Docker Image**
- Imagen: `ghcr.io/lavalink-devs/lavalink:latest`

### 2. Subir el application.yml
Railway necesita que el archivo `application.yml` esté disponible para Lavalink.
Tienes dos opciones:

**Opción A — Variable de entorno (recomendada para Railway):**
No uses el archivo directamente. En su lugar, configura estas variables de entorno en Railway:

| Variable | Valor |
|----------|-------|
| `SERVER_PORT` | `2333` |
| `LAVALINK_SERVER_PASSWORD` | `migajeros123` |
| `LAVALINK_PLUGINS_0_DEPENDENCY` | `dev.lavalink.youtube:youtube-plugin:1.11.4` |
| `LAVALINK_PLUGINS_0_SNAPSHOT` | `false` |
| `PLUGINS_YOUTUBE_ENABLED` | `true` |
| `PLUGINS_YOUTUBE_ALLOWSEARCH` | `true` |
| `PLUGINS_YOUTUBE_CLIENTS_0` | `MUSIC` |
| `PLUGINS_YOUTUBE_CLIENTS_1` | `ANDROID_TESTSUITE` |
| `PLUGINS_YOUTUBE_CLIENTS_2` | `WEB` |

**Opción B — Repositorio propio con el application.yml:**
Crea un repositorio con solo el `application.yml` y usa un Dockerfile simple.

### 3. Exponer el puerto
- En Railway → Settings del servicio → **Networking**
- Expón el puerto `2333`
- Railway te dará una URL pública tipo: `tu-servicio.up.railway.app`

### 4. Actualizar tu bot (manager.ts)
Con tu nodo Railway funcionando, en `src/music/manager.ts` el nodo railway-backup
ya apunta a las variables de entorno correctas:

```typescript
const railwayHost = process.env.LAVALINK_HOST ?? "lavalink-production-cda1.up.railway.app";
const railwayPort = parseInt(process.env.LAVALINK_PORT ?? "443");
const railwayPass = process.env.LAVALINK_PASSWORD ?? "migajeros123";
```

Solo asegúrate de que `LAVALINK_HOST` apunte a tu nuevo nodo Railway.

## Por qué YouTube necesita el plugin

Lavalink v4 removió el soporte nativo de YouTube por problemas de términos de servicio.
Ahora se usa el plugin `youtube-source` que mantiene compatibilidad usando múltiples
clientes de YouTube (MUSIC, ANDROID_TESTSUITE, WEB, etc.) para evitar bloqueos.

## Verificar que funciona

Una vez desplegado, prueba con curl:
```bash
curl -H "Authorization: migajeros123" https://TU-SERVICIO.up.railway.app/version
```

Debe responder con la versión de Lavalink.
