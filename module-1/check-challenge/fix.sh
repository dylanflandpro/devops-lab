#!/bin/bash
#
# fix_permissions.sh - Script de correction des permissions pour webapp
# Usage: sudo ./fix_permissions.sh /chemin/vers/webapp
#

set -e

WEBAPP_DIR="${1:-./webapp}"
OWNER="trilan"
GROUP="trilan"

# Couleurs pour l'affichage
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

log_info()  { echo -e "${GREEN}[INFO]${NC} $1"; }
log_warn()  { echo -e "${YELLOW}[WARN]${NC} $1"; }
log_fix()   { echo -e "${RED}[FIX]${NC} $1"; }

if [[ ! -d "$WEBAPP_DIR" ]]; then
    echo "Erreur: Le répertoire '$WEBAPP_DIR' n'existe pas."
    echo "Usage: $0 /chemin/vers/webapp"
    exit 1
fi

log_info "Correction des permissions pour: $WEBAPP_DIR"
log_info "Propriétaire: $OWNER:$GROUP"
echo ""

# ============================================================
# 1. Propriétaire global
# ============================================================
log_info "Application du propriétaire $OWNER:$GROUP..."
chown -R "$OWNER:$GROUP" "$WEBAPP_DIR"

# ============================================================
# 2. Permissions par défaut des répertoires
# ============================================================
log_info "Correction des permissions des répertoires..."

# Répertoire racine et sous-répertoires standards: 755 (rwxr-xr-x)
find "$WEBAPP_DIR" -type d -exec chmod 755 {} \;
log_fix "Tous les répertoires -> 755"

# Répertoires spéciaux avec écriture groupe
chmod 775 "$WEBAPP_DIR"
chmod 775 "$WEBAPP_DIR/bin"
chmod 775 "$WEBAPP_DIR/config"
chmod 775 "$WEBAPP_DIR/public"
log_fix "webapp, bin, config, public -> 775"

# data et tmp: écriture pour le groupe, pas pour others
chmod 770 "$WEBAPP_DIR/data"
chmod 770 "$WEBAPP_DIR/tmp"
log_fix "data, tmp -> 770 (plus de world-writable!)"

# logs: lecture/écriture groupe
chmod 775 "$WEBAPP_DIR/logs"
log_fix "logs -> 775"

# ============================================================
# 3. Permissions des fichiers
# ============================================================
echo ""
log_info "Correction des permissions des fichiers..."

# --- Scripts exécutables (bin/*.sh) ---
chmod 750 "$WEBAPP_DIR/bin/"*.sh 2>/dev/null || true
log_fix "bin/*.sh -> 750 (exécutables, pas world-readable)"

# --- Fichiers de configuration sensibles ---
chmod 600 "$WEBAPP_DIR/config/credentials.json"
chmod 600 "$WEBAPP_DIR/config/.env"
log_fix "credentials.json, .env -> 600 (sensibles, owner only!)"

# --- Configuration normale ---
chmod 640 "$WEBAPP_DIR/config/app.conf"
log_fix "app.conf -> 640"

# --- Fichiers de données ---
chmod 660 "$WEBAPP_DIR/data/"* 2>/dev/null || true
log_fix "data/* -> 660"

# --- Fichiers de logs ---
chmod 664 "$WEBAPP_DIR/logs/"*.log 2>/dev/null || true
log_fix "logs/*.log -> 664"

# --- Fichiers publics (lecture seule) ---
chmod 644 "$WEBAPP_DIR/public/"* 2>/dev/null || true
log_fix "public/* -> 644"

# --- Dossier tmp en sticky bit ---

chmod 1770 "$WEBAPP_DIR/tmp"

# ============================================================
# 4. Résumé
# ============================================================
echo ""
log_info "============================================"
log_info "Permissions corrigées avec succès!"
log_info "============================================"
echo ""
echo "Résumé des permissions appliquées:"
echo ""
echo "  Répertoires:"
echo "    webapp/, bin/, config/, public/  -> 775 (rwxrwxr-x)"
echo "    data/, tmp/                       -> 770 (rwxrwx---)"
echo "    logs/                             -> 775 (rwxrwxr-x)"
echo ""
echo "  Fichiers:"
echo "    bin/*.sh                          -> 750 (rwxr-x---)"
echo "    config/credentials.json, .env     -> 600 (rw-------)"
echo "    config/app.conf                   -> 640 (rw-r-----)"
echo "    data/*                            -> 660 (rw-rw----)"
echo "    logs/*.log                        -> 664 (rw-rw-r--)"
echo "    public/*                          -> 644 (rw-r--r--)"
echo "    tmp/*                             -> 1770(rw-r--r-t)"
echo ""
log_warn "N'oubliez pas de vérifier que votre application"
log_warn "fonctionne correctement après ces modifications!"