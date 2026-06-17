"""Generate mock-api/db.json for the Curae telehealth demo.

All imagery is REAL:
  - people  -> https://randomuser.me/api/portraits/{men|women}/{n}.jpg
  - medical -> https://images.unsplash.com/photo-... (verified IDs)

Run:  python mock-api/generate_db.py
"""
import json
import os
from datetime import date, timedelta

HERE = os.path.dirname(os.path.abspath(__file__))

# --- verified real Unsplash photo IDs (HTTP 200) ----------------------------
UNSPLASH = [
    "1576091160550-2173dba999ef",  # doctor / stethoscope
    "1505751172876-fa1923c5c528",  # clinician
    "1579684385127-1ef15d508118",  # medical team
    "1538108149393-fbbd81895907",  # pharmacy
    "1532938911079-1b06ac7ceec7",  # lab
    "1559757148-5c350d0d3c56",     # wellness
    "1584036561566-baf8f5f1b144",  # heart health
    "1612349317150-e413f6a5b16d",  # nutrition
    "1581595220892-b0739db3ba8c",  # exercise
    "1571772996211-2f02c9727629",  # mental health
    "1576765608535-5f04d1e3f289",  # sleep
    "1607619056574-7b8d3ee536b2",  # hydration
    "1607962837359-5e7e89f86776",  # clinic interior
    "1551076805-e1869033e561",     # stethoscope desk
    "1593510987185-1ec2256148a3",  # vaccination
    "1588776814546-1ffcf47267a5",  # consultation
    "1631217868264-e5b90bb7e133",  # telemedicine
    "1666214280557-f1b5022eb634",  # checkup
    "1559839734-2b71ea197ec2",     # care
    "1622253692010-333f2da6031d",  # doctor portrait
]


def img(i, w=1000):
    return f"https://images.unsplash.com/photo-{UNSPLASH[i % len(UNSPLASH)]}?w={w}&q=80&auto=format&fit=crop"


def portrait(gender, n):
    folder = "men" if gender == "male" else "women"
    return f"https://randomuser.me/api/portraits/{folder}/{n}.jpg"


# --- specialties ------------------------------------------------------------
SPECIALTIES = [
    ("spec_cardio", "Cardiology", "favorite"),
    ("spec_derma", "Dermatology", "spa"),
    ("spec_neuro", "Neurology", "psychology"),
    ("spec_pedia", "Pediatrics", "child_care"),
    ("spec_ortho", "Orthopedics", "accessibility_new"),
    ("spec_gp", "General Practice", "medical_services"),
    ("spec_dental", "Dentistry", "sentiment_satisfied"),
    ("spec_ophtha", "Ophthalmology", "visibility"),
]

# --- doctors ----------------------------------------------------------------
FIRST_M = ["Carlos", "Miguel", "Andrés", "Diego", "Javier", "Luis", "Tomás",
           "Daniel", "Sergio", "Mateo", "James", "David", "Omar", "Rafael", "Hugo"]
FIRST_F = ["Ana", "Sofía", "Valentina", "Camila", "Lucía", "Isabel", "Mariana",
           "Elena", "Paula", "Carmen", "Emily", "Sara", "Daniela", "Renata", "Noa"]
LAST = ["Reyes", "García", "Hernández", "Martínez", "López", "Torres", "Ramírez",
        "Flores", "Rivera", "Morales", "Cruz", "Ortega", "Vega", "Castro", "Núñez",
        "Mendoza", "Romero", "Silva", "Navarro", "Campos"]
LANGS = [["English", "Spanish"], ["Spanish"], ["English", "Spanish", "Portuguese"],
         ["English"], ["Spanish", "French"]]

BIOS = {
    "Cardiology": "Board-certified cardiologist focused on preventive heart care, hypertension and arrhythmia management.",
    "Dermatology": "Dermatologist specialising in acne, eczema and skin-cancer screening for all ages.",
    "Neurology": "Neurologist treating migraine, epilepsy and movement disorders with an evidence-based approach.",
    "Pediatrics": "Paediatrician dedicated to child wellness, vaccinations and developmental check-ups.",
    "Orthopedics": "Orthopedic surgeon focused on sports injuries, joint pain and minimally-invasive procedures.",
    "General Practice": "Family physician providing primary care, chronic-disease management and annual physicals.",
    "Dentistry": "General dentist offering preventive care, restorations and cosmetic dentistry.",
    "Ophthalmology": "Ophthalmologist treating vision correction, cataracts and routine eye examinations.",
}


def build_doctors():
    docs = []
    used_m, used_f = set(), set()
    for i in range(30):
        spec = SPECIALTIES[i % len(SPECIALTIES)]
        gender = "female" if i % 2 == 0 else "male"
        if gender == "male":
            n = 1 + (i * 7 + 3) % 98
            while n in used_m:
                n = (n % 98) + 1
            used_m.add(n)
            first = FIRST_M[i % len(FIRST_M)]
        else:
            n = 1 + (i * 5 + 11) % 98
            while n in used_f:
                n = (n % 98) + 1
            used_f.add(n)
            first = FIRST_F[i % len(FIRST_F)]
        last = LAST[i % len(LAST)]
        rating = round(3.9 + ((i * 13) % 11) / 10.0, 1)
        rating = min(rating, 5.0)
        docs.append({
            "id": f"doc_{i+1:03d}",
            "name": f"Dr. {first} {last}",
            "specialtyId": spec[0],
            "specialty": spec[1],
            "photo": portrait("male" if gender == "male" else "female", n),
            "gender": gender,
            "rating": rating,
            "reviewCount": 24 + (i * 17) % 200,
            "experienceYears": 4 + (i * 3) % 26,
            "fee": 35 + (i % 8) * 10,
            "currency": "USD",
            "languages": LANGS[i % len(LANGS)],
            "location": ["Mexico City", "Guadalajara", "Monterrey", "Online"][i % 4],
            "about": BIOS[spec[1]],
            "bio": BIOS[spec[1]],
        })
    return docs


REVIEW_TEXT = [
    "Very attentive and explained everything clearly.",
    "Short wait time and a thorough consultation.",
    "Caring and professional — highly recommend.",
    "Listened to all my concerns. Great experience.",
    "Knowledgeable and made me feel comfortable.",
    "Helpful follow-up and clear instructions.",
]
REVIEWERS = [("Laura M.", "female", 12), ("Pedro G.", "male", 22),
             ("Sofía R.", "female", 34), ("Andrés V.", "male", 48),
             ("Marta L.", "female", 56), ("Tomás H.", "male", 67)]


def build_reviews(doctors):
    reviews = []
    rid = 1
    for d in doctors:
        for k in range(3):
            r = REVIEWERS[(rid + k) % len(REVIEWERS)]
            reviews.append({
                "id": f"rev_{rid:04d}",
                "doctorId": d["id"],
                "user": r[0],
                "avatar": portrait(r[1], r[2]),
                "rating": 4 + (rid + k) % 2,
                "comment": REVIEW_TEXT[(rid + k) % len(REVIEW_TEXT)],
                "date": (date.today() - timedelta(days=7 * (k + 1) + rid % 30)).isoformat(),
            })
            rid += 1
    return reviews


SLOT_TIMES = ["09:00", "09:30", "10:00", "10:30", "11:00", "14:00",
              "14:30", "15:00", "15:30", "16:00", "16:30", "17:00"]


def build_slots(doctors, days=14):
    """Static fallback availability (server.js regenerates fresh dates at runtime)."""
    out = []
    sid = 1
    today = date.today()
    for d in doctors:
        seed = int(d["id"].split("_")[1])
        for offset in range(1, days + 1):
            day = today + timedelta(days=offset)
            if day.weekday() == 6:  # closed Sundays
                continue
            # deterministic subset of times per doctor/day
            picked = [t for j, t in enumerate(SLOT_TIMES) if (seed + offset + j) % 3 != 0]
            if not picked:
                continue
            out.append({
                "id": f"slot_{sid:05d}",
                "doctorId": d["id"],
                "date": day.isoformat(),
                "slots": picked,
            })
            sid += 1
    return out


ARTICLES = [
    ("5 Habits for a Healthier Heart", "Simple daily routines that support cardiovascular wellness.", 6),
    ("Understanding Seasonal Allergies", "Why they happen and gentle ways to feel better.", 5),
    ("The Basics of Better Sleep", "Build a wind-down routine for more restful nights.", 10),
    ("Staying Hydrated Through the Day", "How much water you really need and easy reminders.", 11),
    ("Move More: Everyday Exercise", "Low-impact ways to add movement to a busy schedule.", 8),
    ("Nutrition Made Simple", "Balanced plates without complicated diets.", 7),
    ("Caring for Your Mental Wellbeing", "Small practices to manage everyday stress.", 9),
    ("When to See a Doctor", "General guidance on common symptoms and check-ups.", 17),
]


def build_articles():
    arts = []
    for i, (title, excerpt, imgidx) in enumerate(ARTICLES):
        body = (
            f"{excerpt}\n\n"
            "This article is part of the Curae wellness library. The information here is "
            "general and educational in nature.\n\n"
            "Small, consistent changes tend to matter more than dramatic ones. Pick one idea "
            "from this article and try it for a week, then build from there.\n\n"
            "Demo content — this is not medical advice. For anything specific to your health, "
            "please consult a qualified healthcare professional."
        )
        arts.append({
            "id": f"art_{i+1:03d}",
            "title": title,
            "excerpt": excerpt,
            "image": img(imgidx),
            "body": body,
            "author": "Curae Health Team",
            "date": (date.today() - timedelta(days=i * 4 + 1)).isoformat(),
            "readMinutes": 3 + i % 4,
        })
    return arts


def build_user():
    return {
        "id": "user_1",
        "name": "Alex Morgan",
        "email": "alex@curae.app",
        "password": "password",  # mock only; never returned by the API
        "phone": "+52 55 1234 5678",
        "avatar": portrait("male", 75),
        "dob": "1990-04-12",
        "gender": "male",
        "bloodType": "O+",
        "insuranceProvider": "Curae Care Plus",
        "insuranceNumber": "CRA-2291-8847",
        "memberSince": "2023-02-01",
    }


def build_family():
    return [
        {"id": "fam_1", "name": "Sofia Morgan", "relation": "Spouse", "dob": "1992-08-21",
         "gender": "female", "avatar": portrait("female", 68), "bloodType": "A+"},
        {"id": "fam_2", "name": "Mateo Morgan", "relation": "Son", "dob": "2016-11-05",
         "gender": "male", "avatar": portrait("male", 53), "bloodType": "O+"},
        {"id": "fam_3", "name": "Elena Morgan", "relation": "Mother", "dob": "1962-01-30",
         "gender": "female", "avatar": portrait("female", 71), "bloodType": "B+"},
    ]


def build_records():
    def series(base, step, unit, name, n=8):
        readings = []
        for k in range(n):
            day = date.today() - timedelta(days=(n - 1 - k) * 14)
            val = base + ((k * step) % 7) - 3
            readings.append({"date": day.isoformat(), "value": round(val, 1)})
        return {"type": name, "unit": unit, "readings": readings}

    vitals = [
        series(72, 2, "bpm", "Heart Rate"),
        series(120, 3, "mmHg", "Blood Pressure (Systolic)"),
        series(98, 1, "%", "SpO2"),
        series(70, 1, "kg", "Weight"),
    ]
    labs = [
        {"id": "lab_1", "name": "Complete Blood Count", "date": (date.today() - timedelta(days=20)).isoformat(),
         "status": "Normal", "summary": "All values within reference range.", "ordering": "Dr. Ana Reyes"},
        {"id": "lab_2", "name": "Lipid Panel", "date": (date.today() - timedelta(days=20)).isoformat(),
         "status": "Borderline", "summary": "LDL slightly elevated; lifestyle review suggested.", "ordering": "Dr. Ana Reyes"},
        {"id": "lab_3", "name": "HbA1c", "date": (date.today() - timedelta(days=55)).isoformat(),
         "status": "Normal", "summary": "5.4% — within healthy range.", "ordering": "Dr. Luis Torres"},
        {"id": "lab_4", "name": "Vitamin D", "date": (date.today() - timedelta(days=90)).isoformat(),
         "status": "Low", "summary": "Supplementation discussed.", "ordering": "Dr. Luis Torres"},
    ]
    prescriptions = [
        {"id": "rx_1", "medication": "Atorvastatin", "dosage": "10 mg", "frequency": "Once daily",
         "doctor": "Dr. Ana Reyes", "date": (date.today() - timedelta(days=18)).isoformat(), "active": True},
        {"id": "rx_2", "medication": "Vitamin D3", "dosage": "2000 IU", "frequency": "Once daily",
         "doctor": "Dr. Luis Torres", "date": (date.today() - timedelta(days=88)).isoformat(), "active": True},
        {"id": "rx_3", "medication": "Amoxicillin", "dosage": "500 mg", "frequency": "3x daily for 7 days",
         "doctor": "Dr. Miguel García", "date": (date.today() - timedelta(days=130)).isoformat(), "active": False},
    ]
    return {"vitals": vitals, "labs": labs, "prescriptions": prescriptions}


def build_appointments(doctors):
    d0, d1 = doctors[0], doctors[5]
    return [
        {"id": "appt_1", "doctorId": d0["id"], "doctorName": d0["name"],
         "doctorPhoto": d0["photo"], "specialty": d0["specialty"],
         "patientId": "user_1", "patientName": "Alex Morgan",
         "date": (date.today() + timedelta(days=2)).isoformat(), "slot": "10:00",
         "type": "video", "reason": "Routine check-up", "status": "upcoming",
         "fee": d0["fee"], "currency": d0["currency"],
         "createdAt": (date.today() - timedelta(days=1)).isoformat()},
        {"id": "appt_2", "doctorId": d1["id"], "doctorName": d1["name"],
         "doctorPhoto": d1["photo"], "specialty": d1["specialty"],
         "patientId": "fam_2", "patientName": "Mateo Morgan",
         "date": (date.today() - timedelta(days=12)).isoformat(), "slot": "15:30",
         "type": "in_person", "reason": "Fever and cough", "status": "completed",
         "fee": d1["fee"], "currency": d1["currency"],
         "createdAt": (date.today() - timedelta(days=18)).isoformat()},
    ]


def build_notifications(doctors):
    base = [
        ("Appointment confirmed", f"Your video consult with {doctors[0]['name']} is confirmed.", False, 0),
        ("Reminder", f"Upcoming appointment with {doctors[0]['name']} in 2 days.", False, 0),
        ("Lab results ready", "Your Lipid Panel results are now available in Health Records.", False, 1),
        ("New article", "Read: 5 Habits for a Healthier Heart.", True, 2),
        ("Prescription updated", "Dr. Ana Reyes added a new prescription.", True, 4),
        ("Welcome to Curae", "Browse doctors and book your first appointment.", True, 10),
    ]
    out = []
    for i, (title, body, read, ago) in enumerate(base):
        out.append({
            "id": f"notif_{i+1}",
            "title": title,
            "body": body,
            "read": read,
            "type": ["appointment", "reminder", "lab", "article", "prescription", "system"][i % 6],
            "date": (date.today() - timedelta(days=ago)).isoformat(),
        })
    return out


def main():
    doctors = build_doctors()
    db = {
        "users": [build_user()],
        "specialties": [{"id": s[0], "name": s[1], "icon": s[2]} for s in SPECIALTIES],
        "doctors": doctors,
        "reviews": build_reviews(doctors),
        "slots": build_slots(doctors),
        "appointments": build_appointments(doctors),
        "records": build_records(),
        "family-members": build_family(),
        "articles": build_articles(),
        "notifications": build_notifications(doctors),
    }
    path = os.path.join(HERE, "db.json")
    with open(path, "w", encoding="utf-8") as f:
        json.dump(db, f, indent=2, ensure_ascii=False)
    print(f"wrote {path}")
    print(f"  doctors={len(db['doctors'])} reviews={len(db['reviews'])} "
          f"slots={len(db['slots'])} articles={len(db['articles'])} "
          f"notifications={len(db['notifications'])}")


if __name__ == "__main__":
    main()
