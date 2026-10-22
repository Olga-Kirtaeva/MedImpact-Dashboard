# Original PostgreSQL setup (preserved, inactive):
# import psycopg2
# import toml
# import os
# import sys
# 
# # Configuration
# SECRETS_FILE = ".streamlit/secrets.toml"
# FILES_TO_EXECUTE = ["create_tables.sql", "sample_data.sql"]
# 
# def load_db_config():
#     """Reads database credentials from Streamlit secrets."""
#     if not os.path.exists(SECRETS_FILE):
#         print(f"❌ Error: '{SECRETS_FILE}' not found.")
#         print("Please ensure you have created the secrets.toml file with your DB credentials.")
#         sys.exit(1)
#     
#     try:
#         with open(SECRETS_FILE, "r") as f:
#             secrets = toml.load(f)
#             # Extract credentials from the [connections.postgresql] section
#             return secrets["miniproject"]
#     except KeyError:
#         print(f"❌ Error: Could not find [miniproject] section in {SECRETS_FILE}")
#         sys.exit(1)
#     except Exception as e:
#         print(f"❌ Error reading secrets file: {e}")
#         sys.exit(1)
# 
# def execute_sql_file(cursor, filename):
#     """Reads and executes a single SQL file."""
#     print(f"📄 Processing {filename}...")
#     
#     if not os.path.exists(filename):
#         print(f"   ❌ File not found: {filename}")
#         return False
# 
#     try:
#         with open(filename, "r", encoding="utf-8") as f:
#             sql_content = f.read()
#             cursor.execute(sql_content)
#             print(f"   ✅ Executed successfully.")
#             return True
#     except Exception as e:
#         print(f"   ❌ Error executing SQL: {e}")
#         return False
# 
# def main():
#     print("🚀 Starting Database Setup...\n")
#     
#     # 1. Load Config
#     config = load_db_config()
#     print(f"🔑 Loaded credentials for user '{config['username']}' on '{config['host']}'")
# 
#     # 2. Connect to DB
#     try:
#         conn = psycopg2.connect(
#             host=config["host"],
#             port=config["port"],
#             database=config["database"],
#             user=config["username"],
#             password=config["password"]
#         )
#         conn.autocommit = True # Enable autocommit to allow DROP/CREATE operations
#     except Exception as e:
#         print(f"❌ Failed to connect to database: {e}")
#         sys.exit(1)
# 
#     # 3. Execute Scripts
#     with conn.cursor() as cur:
#         for sql_file in FILES_TO_EXECUTE:
#             success = execute_sql_file(cur, sql_file)
#             if not success:
#                 print("\n❌ Aborting setup due to errors.")
#                 conn.close()
#                 sys.exit(1)
# 
#     conn.close()
#     print("\n✨ Database setup finished successfully!")
#     print("👉 You can now start your app: streamlit run streamlit_app.py")
# 
# if __name__ == "__main__":
#     main()

from local_db import initialize_database


def main():
    path = initialize_database()
    print(f"SQLite database ready: {path}")
    print("Start: python -m streamlit run streamlit_app.py")


if __name__ == "__main__":
    main()
