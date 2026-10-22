"""Create the local SQLite database once, without replacing existing data."""

import os
from pathlib import Path
import sqlite3


BASE_DIR = Path(__file__).resolve().parent
DB_PATH = Path(os.environ.get("MEDIMPACT_DB_PATH", BASE_DIR / "data/medimpact.sqlite3")).resolve()


def _execute_script(connection, script):
    """Execute statements inside the caller's transaction (including DDL)."""
    statement = ""
    for line in script.splitlines(keepends=True):
        statement += line
        if sqlite3.complete_statement(statement):
            connection.execute(statement)
            statement = ""
    if any(line.strip() and not line.lstrip().startswith("--") for line in statement.splitlines()):
        raise ValueError("Incomplete SQL statement")


def initialize_database(path=DB_PATH):
    path = Path(path)
    path.parent.mkdir(parents=True, exist_ok=True)
    connection = sqlite3.connect(path, timeout=30)
    try:
        connection.execute("PRAGMA foreign_keys = ON")
        with connection:
            connection.execute("BEGIN IMMEDIATE")
            exists = connection.execute(
                "SELECT 1 FROM sqlite_master WHERE type='table' AND name='Patient'"
            ).fetchone()
            if not exists:
                for filename in ("create_tables_sqlite.sql", "sample_data.sql"):
                    _execute_script(connection, (BASE_DIR / filename).read_text(encoding="utf-8"))
    finally:
        connection.close()
    return path
