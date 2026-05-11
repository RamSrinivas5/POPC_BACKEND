def build_ppc_prompt(patient, survey, section_scores, answers, question):
    # Group answers by section
    section_answers = {}
    for ans in answers:
        section_answers.setdefault(ans.section_name, []).append(
            f"- {ans.question}: {ans.selected_option} (Score {ans.score})"
        )

    formatted_sections = ""
    for section, qa_list in section_answers.items():
        formatted_sections += f"\n### {section}\n"
        formatted_sections += "\n".join(qa_list)
        formatted_sections += "\n"

    return f"""
You are a highly specialized medical assistant providing clinical decision support for Postoperative Pulmonary Complications (PPC).

### INSTRUCTIONS:
1. Analyze the provided patient record and survey data specifically for the patient: {patient.name}.
2. Provide a concise, professional, and strictly evidence-based answer to the doctor's question.
3. If the question is about patient data (like BMI, age, or specific survey answers), strictly use the data provided below.
4. Do NOT speculate or hallucinate. Use only the context provided.
5. Keep the response professional and limited to about 4-6 lines unless more detail is absolutely necessary.
6. Refer to the patient by their name: {patient.name}.

---
### PATIENT PROFILE
- **Name:** {patient.name}
- **Age:** {patient.age}
- **Gender:** {patient.gender}
- **BMI Details:** {patient.bmi} (Weight: {patient.weight}kg, Height: {patient.height}cm)

### PPC ASSESSMENT SUMMARY
- **Total Score:** {survey.total_score}/85
- **Risk Level:** {survey.risk_level}

#### SECTIONAL SCORES
{chr(10).join(f"- {s.section_name}: {s.score}" for s in section_scores)}

### DETAILED QUESTIONNAIRE RESPONSES
{formatted_sections}

---
### DOCTOR'S QUERY
{question}

### FINAL RESPONSE (START HERE):
"""
