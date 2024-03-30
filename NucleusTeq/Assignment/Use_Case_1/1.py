import json
json_data = '''
{
  "name": "Python Training",
  "date": "April 19, 2024",
  "completed": true,
  "instructor": {
    "name": "XYZ",
    "website": "http://pqr.com/"
  },
  "participants": [
    {
      "name": "Participant 1",
      "email": "email1@example.com"
    },
    {
      "name": "Participant 2",
      "email": "email2@example.com"
    }
  ]
}
'''


data = json.loads(json_data)
for session in data.get('trainingSessions', []):
    print("Training Name:", session.get("name", "N/A"))

print("Training Name:", data["name"])
print("Date:", data["date"])
print("Completed:", data["completed"])
print("Instructor Name:", data["instructor"]["name"])
print("Instructor Website:", data["instructor"]["website"])
print("Participants:")
for participant in data["participants"]:
    print("- Name:", participant["name"])
    print("  Email:", participant["email"])
