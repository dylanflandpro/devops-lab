#!/bin/bash
# audit-permissions.sh
# Audit de sécurité des permissions

TARGET_DIR="app"  # Répertoire cible, défaut = courant

echo "=== AUDIT DE PERMISSIONS : $TARGET_DIR ==="
echo ""

echo "[DANGER] Fichiers avec permissions 777 :"
find "$TARGET_DIR" -type f -perm 777

echo ""
echo "[WARNING] Fichiers world-writable :"
find "$TARGET_DIR" -type f -perm -002

echo ""
echo "[INFO] Fichiers SUID/SGID :"
# À toi de compléter
find "$TARGET_DIR" -type f -perm -4000
find "$TARGET_DIR" -type f -perm -2000

echo ""
echo "=== FIN DE L'AUDIT ==="