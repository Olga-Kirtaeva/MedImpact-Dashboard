from contextlib import closing
import sqlite3
import tempfile
import unittest
from pathlib import Path
from unittest.mock import patch

import local_db


class LocalDatabaseTests(unittest.TestCase):
    def test_seed_and_repeated_setup_preserve_user_data(self):
        with tempfile.TemporaryDirectory() as directory:
            path = Path(directory) / "test.sqlite3"
            local_db.initialize_database(path)
            with closing(sqlite3.connect(path)) as connection, connection:
                self.assertEqual(connection.execute("SELECT COUNT(*) FROM Patient").fetchone()[0], 10)
                self.assertEqual(connection.execute("SELECT COUNT(*) FROM Measurement").fetchone()[0], 128)
                self.assertEqual(connection.execute("PRAGMA foreign_key_check").fetchall(), [])
                connection.execute("INSERT INTO Patient(code,birth_year,sex) VALUES ('TEST',2000,'D')")
            local_db.initialize_database(path)
            with closing(sqlite3.connect(path)) as connection, connection:
                self.assertEqual(connection.execute("SELECT COUNT(*) FROM Patient").fetchone()[0], 11)

    def test_failed_seed_rolls_back_schema_and_data(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            (root / "create_tables_sqlite.sql").write_text("CREATE TABLE Patient (id INTEGER PRIMARY KEY);\n")
            (root / "sample_data.sql").write_text("INSERT INTO Missing VALUES (1);\n")
            path = root / "test.sqlite3"
            with patch.object(local_db, "BASE_DIR", root):
                with self.assertRaises(sqlite3.OperationalError):
                    local_db.initialize_database(path)
            with closing(sqlite3.connect(path)) as connection, connection:
                self.assertEqual(connection.execute("SELECT name FROM sqlite_master WHERE type='table'").fetchall(), [])


if __name__ == "__main__":
    unittest.main()
