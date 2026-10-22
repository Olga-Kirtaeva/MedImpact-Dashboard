# app_simple.py - Einfache Streamlit App für Studenten
from time import sleep
import streamlit as st
import pandas as pd
from PIL import Image
from matplotlib import pyplot as plt
from contextlib import closing
from sqlalchemy import create_engine, event
from sqlalchemy.pool import NullPool
from local_db import BASE_DIR, DB_PATH, initialize_database


# Original PostgreSQL connection (preserved, inactive):
# def get_engine():
#     host = st.secrets["miniproject"]["host"],
#     dbname = st.secrets["miniproject"]["database"],
#     user = st.secrets["miniproject"]["username"],
#     password = st.secrets["miniproject"]["password"],
#     port = st.secrets["miniproject"]["port"]
#     return create_engine(f"postgresql+psycopg2://{user[0]}:{password[0]}@{host[0]}:{port}/{dbname[0]}")
# 
# def get_db():
#     return engine.raw_connection()
# 

@st.cache_resource
def get_engine():
    initialize_database()
    engine = create_engine(f"sqlite:///{DB_PATH.as_posix()}", poolclass=NullPool)

    @event.listens_for(engine, "connect")
    def enable_foreign_keys(connection, _):
        connection.execute("PRAGMA foreign_keys = ON")

    return engine


# App Start
st.set_page_config(page_title="MedImpact", page_icon="🏥")

st.title("🏥 MedImpact Dashboard")
st.write("App für Medikamentenanalyse")

# Navigation
menu = st.sidebar.radio("Menü",
                        ["Start", "Patienten", "Medikamente", "Messungen", "Analyse"])

# Startseite
if menu == "Start":
    st.header("Willkommen!")
    st.write("""
    Diese App hilft bei der Analyse von Medikamentenwirkungen.

    **Funktionen:**
    - Patienten anzeigen/hinzufügen
    - Medikamente verwalten
    - Messwerte erfassen
    - Analysen
    """)

    engine = get_engine()
    if engine:
        try:
            with engine.connect() as conn:
                col1, col2 = st.columns(2)
                with col1:
                    patients = pd.read_sql("SELECT COUNT(*) FROM Patient", conn)
                    st.metric("Patienten", patients.iloc[0, 0])
                with col2:
                    meds = pd.read_sql("SELECT COUNT(*) FROM Medication", conn)
                    st.metric("Medikamente", meds.iloc[0, 0])
        except:
            st.info("Keine Daten vorhanden")
        finally:
            pass

# Patienten
elif menu == "Patienten":
    st.header("👤 Patienten")

    tab1, tab2 = st.tabs(["Liste", "Neu"])

    with tab1:
        engine = get_engine()
        if engine:
            try:
                with engine.connect() as conn:
                    df = pd.read_sql("SELECT code, birth_year, sex FROM Patient", conn)
                    if not df.empty:
                        st.dataframe(df)
                    else:
                        st.info("Keine Patienten")
            except Exception as e:
                st.error(f"Fehler: {e}")
            finally:
                pass

    with tab2:
        with st.form("neu_patient"):
            code = st.text_input("Code (z.B. MUELLEA)")
            birth_year = st.number_input("Geburtsjahr", 1900, 2025)
            sex = st.selectbox("Geschlecht", ["M", "F"])

            if st.form_submit_button("Speichern"):
                if code:
                    engine = get_engine()
                    if engine:
                        try:
                            with closing(engine.raw_connection()) as conn:
                                cursor = conn.cursor()
                                cursor.execute(
                                    # PostgreSQL: "INSERT INTO Patient (code, birth_year, sex) VALUES (%s, %s, %s)",
                                    "INSERT INTO Patient (code, birth_year, sex) VALUES (?, ?, ?)",
                                    (code, birth_year, sex)
                                )
                                conn.commit()
                                st.success(f"Patient {code} gespeichert!")
                                sleep(1)
                        except Exception as e:
                            st.error(f"Fehler: {e}")
                        finally:
                            st.rerun()
                else:
                    st.warning("Code eingeben!")

# Medikamente
elif menu == "Medikamente":
    st.header("💊 Medikamente")

    tab1, tab2 = st.tabs(["Liste", "Neu"])

    with tab1:
        engine = get_engine()
        if engine:
            try:
                with engine.connect() as conn:
                    df = pd.read_sql("SELECT name, trade_name, dosage_form FROM Medication", conn)
                    if not df.empty:
                        st.dataframe(df)
                    else:
                        st.info("Keine Medikamente")
            except:
                st.error("Fehler")
            finally:
                pass

    with tab2:
        with st.form("neu_med"):
            name = st.text_input("Wirkstoff")
            trade_name = st.text_input("Handelsname")
            form = st.selectbox("Form", ["Tablette", "Kapsel", "Saft"])

            if st.form_submit_button("Speichern"):
                if name:
                    engine = get_engine()
                    if engine:
                        try:
                            with closing(engine.raw_connection()) as conn:
                                cursor = conn.cursor()
                                cursor.execute(
                                    # PostgreSQL: "INSERT INTO Medication (name, trade_name, dosage_form) VALUES (%s, %s, %s)",
                                    "INSERT INTO Medication (name, trade_name, dosage_form) VALUES (?, ?, ?)",
                                    (name, trade_name, form)
                                )
                                conn.commit()
                                st.success(f"Medikament {name} gespeichert!")
                                sleep(1)
                        except Exception as e:
                            st.error(f"Fehler: {e}")
                        finally:
                            st.rerun()
                else:
                    st.warning("Wirkstoff eingeben!")

# Messungen
elif menu == "Messungen":
    st.header("📊 Messungen")

    engine = get_engine()
    if engine:
        try:
            with engine.connect() as conn:
                # Erweiterte Abfrage mit allen Messwerten
                query = """
                SELECT 
                    p.code as "Patient",
                    CASE m.measurement_type
                        WHEN 'Temperature' THEN '🌡️ Temperatur'
                        WHEN 'BloodPressureSystolic' THEN '🩸 Blutdruck sys'
                        WHEN 'BloodPressureDiastolic' THEN '🩸 Blutdruck dia'
                        WHEN 'Glucose' THEN '🧪 Blutzucker'
                        ELSE m.measurement_type
                    END as "Messart",

                    CASE m.measurement_type
                        -- PostgreSQL: WHEN 'Temperature' THEN (SELECT value::text || ' °C' FROM Temperature WHERE measurement_id = m.measurement_id)
                        WHEN 'Temperature' THEN (SELECT CAST(value AS TEXT) || ' °C' FROM Temperature WHERE measurement_id = m.measurement_id)
                        -- PostgreSQL: WHEN 'Glucose' THEN (SELECT value::text || ' mg/dL' FROM Glucose WHERE measurement_id = m.measurement_id)
                        WHEN 'Glucose' THEN (SELECT CAST(value AS TEXT) || ' mg/dL' FROM Glucose WHERE measurement_id = m.measurement_id)
                        -- PostgreSQL: WHEN 'BloodPressureSystolic' THEN (SELECT value::text || ' mmHg' FROM BloodPressureSystolic WHERE measurement_id = m.measurement_id)
                        WHEN 'BloodPressureSystolic' THEN (SELECT CAST(value AS TEXT) || ' mmHg' FROM BloodPressureSystolic WHERE measurement_id = m.measurement_id)
                        -- PostgreSQL: WHEN 'BloodPressureDiastolic' THEN (SELECT value::text || ' mmHg' FROM BloodPressureDiastolic WHERE measurement_id = m.measurement_id)
                        WHEN 'BloodPressureDiastolic' THEN (SELECT CAST(value AS TEXT) || ' mmHg' FROM BloodPressureDiastolic WHERE measurement_id = m.measurement_id)
                        ELSE 'Kein Wert'
                    END as "Wert",

                md.measured_datetime as "Zeitpunkt",
                COALESCE(md.context, '-') as "Kontext"

                FROM Measured md
                JOIN Patient p ON md.patient_id = p.patient_id
                JOIN Measurement m ON md.measurement_id = m.measurement_id
                ORDER BY md.measured_datetime DESC
                LIMIT 50
                """

                df = pd.read_sql(query, conn)
                if not df.empty:
                    st.dataframe(df)

                # Statistik anzeigen
                st.subheader("📈 Übersicht")
                col1, col2, col3 = st.columns(3)
                with col1:
                    st.metric("Anzahl Messungen", len(df))
                with col2:
                    unique_types = df['Messart'].nunique()
                    st.metric("Verschiedene Messarten", unique_types)
                with col3:
                    unique_patients = df['Patient'].nunique()
                    st.metric("Verschiedene Patienten", unique_patients)

                # Filter nach Messart
                st.subheader("🔍 Filter")
                messart_filter = st.multiselect(
                    "Nach Messart filtern",
                    df['Messart'].unique().tolist()
                )

                if messart_filter:
                    filtered_df = df[df['Messart'].isin(messart_filter)]
                    st.write(f"**Gefilterte Messungen ({len(filtered_df)}):**")
                    st.dataframe(filtered_df)
                else:
                    st.info("Keine Messungen vorhanden")

        except Exception as e:
            st.error(f"Fehler: {e}")
        finally:
            pass
# Analyse
elif menu == "Analyse":
    st.header("🔍 Patientenanalyse")

    engine = get_engine()
    if engine:
        try:
            with engine.connect() as conn:
                # Patienten laden
                patients = pd.read_sql("SELECT patient_id, code FROM Patient", conn)

                if not patients.empty:
                    # Patienten auswählen
                    patient_id = st.selectbox(
                        "Patient wählen",
                        patients['patient_id'],
                        format_func=lambda x: patients[patients['patient_id'] == x]['code'].iloc[0]
                    )

                    patient_code = patients[patients['patient_id'] == patient_id]['code'].iloc[0]

                    st.write(f"**Patient:** {patient_code}")

                    # 1. Einnahmen holen
                    query_intakes = """
                    SELECT m.name, mi.datetime, mi.dose 
                    FROM MedicationIntake mi
                    JOIN Medication m ON mi.medication_id = m.medication_id
                    -- PostgreSQL: WHERE mi.patient_id = %s
                    WHERE mi.patient_id = ?
                    ORDER BY mi.datetime
                    """

                    intakes = pd.read_sql(query_intakes, conn, params=(int(patient_id),), parse_dates=["datetime"])

                    # 2. Messungen holen
                    query_measurements = """
                    SELECT 
                        ms.measurement_type,
                        CASE ms.measurement_type
                            WHEN 'Temperature' THEN (SELECT value FROM Temperature WHERE measurement_id = ms.measurement_id)
                            WHEN 'Glucose' THEN (SELECT value FROM Glucose WHERE measurement_id = ms.measurement_id)
                            WHEN 'BloodPressureSystolic' THEN (SELECT value FROM BloodPressureSystolic WHERE measurement_id = ms.measurement_id)
                            WHEN 'BloodPressureDiastolic' THEN (SELECT value FROM BloodPressureDiastolic WHERE measurement_id = ms.measurement_id)
                        END as value,
                        md.measured_datetime
                    FROM Measured md
                    JOIN Measurement ms ON md.measurement_id = ms.measurement_id
                    -- PostgreSQL: WHERE md.patient_id = %s
                    WHERE md.patient_id = ?
                    ORDER BY md.measured_datetime
                    """

                    measurements = pd.read_sql(query_measurements, conn, params=(int(patient_id),), parse_dates=["measured_datetime"])

                    # Einfache Diagramme
                    if not measurements.empty or not intakes.empty:
                        # Einfacher Plot
                        fig, ax = plt.subplots(figsize=(12, 6))

                        # Farben für Messarten
                        colors = {
                            'Temperature': 'red',
                            'Glucose': 'green',
                            'BloodPressureSystolic': 'purple',
                            'BloodPressureDiastolic': 'blue',
                        }

                        # Messungen plotten
                        for measurement_type in measurements['measurement_type'].unique():
                            subset = measurements[measurements['measurement_type'] == measurement_type]
                            if not subset.empty and pd.notna(subset['value']).any():
                                ax.scatter(
                                    subset['measured_datetime'],
                                    subset['value'],
                                    label=measurement_type,
                                    color=colors.get(measurement_type, 'gray'),
                                    s=50,
                                    alpha=0.7
                                )

                        # Einnahmen als vertikale Linien
                        if not intakes.empty:
                            for _, row in intakes.iterrows():
                                ax.axvline(x=row['datetime'], color='red', linestyle='--', alpha=0.5)
                                # Medikamentennamen neben der Linie
                                ax.text(
                                    row['datetime'],
                                    ax.get_ylim()[1] * 0.95,
                                    row['name'],
                                    rotation=90,
                                    verticalalignment='top',
                                    fontsize=8
                                )

                        ax.set_xlabel('Zeitpunkt')
                        ax.set_ylabel('Messwert')
                        ax.set_title(f'Messungen und Medikamenteneinnahmen für {patient_code}')
                        ax.legend()
                        ax.grid(True, alpha=0.3)
                        plt.xticks(rotation=45)
                        plt.tight_layout()

                        st.pyplot(fig)
                        plt.close(fig)

                        # Daten tabellarisch anzeigen
                        col1, col2 = st.columns(2)

                        with col1:
                            st.write("**💊 Einnahmen:**")
                            if not intakes.empty:
                                st.dataframe(intakes.head(20))
                            else:
                                st.write("Keine Einnahmen")



                    else:
                        st.info("Keine Daten für diesen Patienten")

                else:
                    st.info("Keine Patienten vorhanden")

        except Exception as e:
            st.error(f"Fehler: {str(e)[:100]}")
        finally:
            pass
# Footer
st.sidebar.markdown("---")


img = Image.open(BASE_DIR / "ZAW-ZHAW.png")

container = st.sidebar.container(border=True, horizontal=True, horizontal_alignment="right", width="stretch")
container.markdown("# :orange[<div style='font-size: 2.1em;text-align: top;'>MID</div>]", unsafe_allow_html=True)
container.markdown(""":orange[
                        Medication  
                        Impact  
                        Dashboard
                        ]""")
st.sidebar.markdown("<br>", unsafe_allow_html=True)
st.sidebar.image(
    img,
    width="content"
)
st.sidebar.markdown("Olga Kirtaeva")
