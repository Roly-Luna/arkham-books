-- Add public profile fields for the reader community
-- Safe to run more than once on an existing PostgreSQL database

BEGIN;

ALTER TABLE usuario ADD COLUMN IF NOT EXISTS biografia TEXT;
ALTER TABLE usuario ADD COLUMN IF NOT EXISTS avatar_url TEXT;
ALTER TABLE usuario ADD COLUMN IF NOT EXISTS fecha_registro TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE usuario ADD COLUMN IF NOT EXISTS perfil_publico BOOLEAN NOT NULL DEFAULT TRUE;

CREATE INDEX IF NOT EXISTS idx_producto_titulo ON producto(titulo);
CREATE INDEX IF NOT EXISTS idx_pedido_usuario_fecha ON pedido(id_usuario, fecha_compra DESC);
CREATE INDEX IF NOT EXISTS idx_detalle_producto ON detalle_pedido(id_producto);

COMMIT;
