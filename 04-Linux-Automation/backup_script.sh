#!/bin/bash
# =====================================================
# Automated Backup Script for Oracle Payment DB
# Author: Sara
# =====================================================
set -euo pipefail

# CONFIGURATION
BACKUP_DIR="${BACKUP_DIR:-$HOME/backups}"
DATE=$(date +%Y-%m-%d_%H-%M-%S)
LOG_FILE="$BACKUP_DIR/backup_log_$DATE.log"
ORACLE_USER="PAYMENT_USER"
ORACLE_PASS="${ORACLE_PASS:?Set ORACLE_PASS first: export ORACLE_PASS=...}"
ORACLE_SERVICE="//localhost:1521/orclpdb.localdomain"

# Oracle environment (adjust to your install path)
export ORACLE_HOME="${ORACLE_HOME:-/u01/app/oracle/product/19.3.0/dbhome_1}"
export PATH="$ORACLE_HOME/bin:$PATH"

# Create the backup directory
mkdir -p "$BACKUP_DIR" || { echo "Cannot create $BACKUP_DIR"; exit 1; }
[ -w "$BACKUP_DIR" ] || { echo "$BACKUP_DIR is not writable by $(whoami)"; exit 1; }
command -v sqlplus >/dev/null || { echo "sqlplus not found in PATH"; exit 1; }

# Log start
echo "Backup started at: $(date)" > "$LOG_FILE"

# Any failure after this point is logged
trap 'echo "Backup FAILED at: $(date)" | tee -a "$LOG_FILE"' ERR

# Export Banks table
sqlplus -s "$ORACLE_USER/$ORACLE_PASS@$ORACLE_SERVICE" <<EOF >> "$LOG_FILE"
WHENEVER SQLERROR EXIT SQL.SQLCODE
WHENEVER OSERROR EXIT FAILURE
SET HEADING OFF
SET FEEDBACK OFF
SET PAGESIZE 0
SET LINESIZE 200
SET TRIMSPOOL ON
SPOOL $BACKUP_DIR/banks_$DATE.csv
SELECT Bank_ID || ',' || Bank_Name || ',' || Status FROM Banks;
SPOOL OFF
EXIT;
EOF

# Export Terminals table
sqlplus -s "$ORACLE_USER/$ORACLE_PASS@$ORACLE_SERVICE" <<EOF >> "$LOG_FILE"
WHENEVER SQLERROR EXIT SQL.SQLCODE
WHENEVER OSERROR EXIT FAILURE
SET HEADING OFF
SET FEEDBACK OFF
SET PAGESIZE 0
SET LINESIZE 200
SET TRIMSPOOL ON
SPOOL $BACKUP_DIR/terminals_$DATE.csv
SELECT Terminal_ID || ',' || Bank_ID || ',' || Location || ',' || Status FROM Terminals;
SPOOL OFF
EXIT;
EOF

# Verify the exports exist and are not empty
for f in "banks_$DATE.csv" "terminals_$DATE.csv"; do
  [ -s "$BACKUP_DIR/$f" ] || { echo "Export failed or empty: $f" | tee -a "$LOG_FILE"; exit 1; }
done

# Compress
tar -czf "$BACKUP_DIR/payment_backup_$DATE.tar.gz" -C "$BACKUP_DIR" \
    "banks_$DATE.csv" "terminals_$DATE.csv"

# Clean up raw CSV files (only reached if tar succeeded)
rm -f "$BACKUP_DIR/banks_$DATE.csv" "$BACKUP_DIR/terminals_$DATE.csv"

# Log completion
echo "Backup completed at: $(date)" >> "$LOG_FILE"
echo "Archive: payment_backup_$DATE.tar.gz" >> "$LOG_FILE"

# Clean up old backups (older than 7 days)
find "$BACKUP_DIR" -name "payment_backup_*.tar.gz" -mtime +7 -delete
find "$BACKUP_DIR" -name "backup_log_*.log" -mtime +7 -delete

echo "Backup OK. Log: $LOG_FILE"
