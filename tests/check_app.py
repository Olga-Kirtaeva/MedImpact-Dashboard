"""Run the real Streamlit screens against an isolated test database."""
from contextlib import closing
import os
from pathlib import Path
import sqlite3
import tempfile

from streamlit.testing.v1 import AppTest


root = Path(__file__).resolve().parents[1]
with tempfile.TemporaryDirectory() as directory:
    database = Path(directory) / "ui.sqlite3"
    os.environ["MEDIMPACT_DB_PATH"] = str(database)
    app = AppTest.from_file(str(root / "streamlit_app.py"), default_timeout=30).run()

    def check(page):
        assert not app.exception, [(e.message, e.stack_trace) for e in app.exception]
        assert not app.error, [e.value for e in app.error]
        print(page + ": OK", flush=True)

    check("Start")
    assert [metric.value for metric in app.metric] == ["10", "10"]
    for page in ("Patienten", "Medikamente", "Messungen", "Analyse"):
        app.sidebar.radio[0].set_value(page).run()
        check(page)
        if page == "Messungen":
            assert len(app.dataframe[0].value) == 50
            app.multiselect[0].set_value([app.multiselect[0].options[0]]).run()
            check("Measurement filter")
        if page == "Analyse":
            # Exercise every seeded patient, including missing intake series.
            for patient in app.selectbox[0].options:
                app.selectbox[0].select(patient).run()
                check("Analysis " + patient)

    app.sidebar.radio[0].set_value("Patienten").run()
    app.text_input[0].set_value("SQLITE_TEST")
    app.number_input[0].set_value(2000)
    app.selectbox[0].set_value("F")
    app.button[0].click().run()
    check("Add patient")
    app.sidebar.radio[0].set_value("Medikamente").run()
    app.text_input[0].set_value("Test medication")
    app.text_input[1].set_value("Test brand")
    app.button[0].click().run()
    check("Add medication")
    with closing(sqlite3.connect(database)) as connection:
        assert connection.execute("SELECT COUNT(*) FROM Patient WHERE code='SQLITE_TEST'").fetchone()[0] == 1
        assert connection.execute("SELECT COUNT(*) FROM Medication WHERE name='Test medication'").fetchone()[0] == 1
        assert connection.execute("PRAGMA foreign_key_check").fetchall() == []
    app.sidebar.radio[0].set_value("Start").run()
    check("Reload preserves data")
    assert [metric.value for metric in app.metric] == ["11", "11"]
    import streamlit as st
    st.cache_resource.clear()
